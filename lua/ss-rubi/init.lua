--------------------------------------------------------------------------------
--- module
--------------------------------------------------------------------------------
local M = {}

M.config = {
    useHWVerticalBar = false,

    autoComplete = {
        enable = false,

        api = {
            url = "https://api.excelapi.org/language/kanji2kana",
            contentQuery = "text",
            otherQuery = { {} },
        },
    },
}

--------------------------------------------------------------------------------
--- functions
--------------------------------------------------------------------------------

local curl = require("plenary.curl")

local function escape_gsub_replacement(str)
    return (str:gsub("%%", "%%%%"))
end

local function kanji2kana(text)
    local api = M.config.autoComplete.api
    local query = {}
    query[api.contentQuery] = text

    for _, v in ipairs(api.otherQuery or {}) do
        if v.key then
            query[v.key] = v.value or ""
        end
    end

    local ok, res = pcall(curl.get, api.url, {
        query = query,
        timeout = 5000,
    })
    if not ok or not res or res.status ~= 200 then
        vim.notify("Failed to get kanji2kana", vim.log.levels.ERROR)
        return "R"
    end
    return vim.trim(res.body or "")
end

local function get_visual_text()
    vim.cmd('normal! gv"zy')

    return vim.fn.getreg("z")
end

local function move_back_one()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_win_set_cursor(0, { row, math.max(col - 1, 0) })
end

local function insert_at(text, row, col)
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { text })
end

local function insert_at_cursor(text)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    insert_at(text, row, col)
end

local function replace_visual(text)
    local mode = vim.fn.visualmode()

    if mode == "v" then
        vim.cmd('normal! gv"_d')
        insert_at_cursor(text)
        return true
    else
        vim.notify("V-Line/V-Block is not supported", vim.log.levels.ERROR)
        return false
    end
end

local function build_rubi(base, target, ruby)
    target = escape_gsub_replacement(target or "")
    ruby = escape_gsub_replacement(ruby or "")

    return (
        base:gsub("[TR]", function(c)
            if c == "T" then
                return target
            elseif c == "R" then
                return ruby
            end
        end)
    )
end

--------------------------------------------------------------------------------
--- setup
--------------------------------------------------------------------------------
function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

    M.define_commands()
end

local function get_base()
    return M.config.useHWVerticalBar and "|T《R》" or "｜T《R》"
end

--------------------------------------------------------------------------------
-- define commands
--------------------------------------------------------------------------------
function M.define_commands()
    vim.api.nvim_create_user_command("RubiInsert", function(opts)
        if opts.range > 0 then
            M.InsertRubi("v", opts)
        else
            M.InsertRubi("n", opts)
        end
    end, {
        range = true,
    })

    if M.config.autoComplete.enable then
        vim.api.nvim_create_user_command("RubiInsertAC", function(opts)
            if opts.range > 0 then
                M.InsertRubiAndAC(opts)
            else
                vim.notify("Text is not selected", vim.log.levels.ERROR)
            end
        end, {
            range = true,
        })
    end
end

--------------------------------------------------------------------------------
--- Commands
--------------------------------------------------------------------------------

function M.InsertRubi(mode, _)
    local target = "Target"

    if mode == "v" then
        target = get_visual_text() or "Target"
    end

    local text = build_rubi(get_base(), target, "R")

    if mode == "n" then
        insert_at_cursor(text)
    elseif mode == "v" then
        if replace_visual(text) then
            move_back_one()
        end
        move_back_one()
    end
end

function M.InsertRubiAndAC(_)
    if not M.config.autoComplete.enable then
        vim.notify("Auto complete is disabled", vim.log.levels.WARN)
        return
    end

    local target = get_visual_text() or "Target"
    local ruby = kanji2kana(target)

    local text = build_rubi(get_base(), target, ruby)

    replace_visual(text)
end

return M
