# ss-rubi.nvim
##### A Neovim plugin to insert ruby notation (ルビ記法) in your file.
<br>
<a href="https://neovim.io/">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/%20Neovim-%2357a143?style=flat&logo=Neovim&logoColor=%2357a143&label=Built%20for&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
        <source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/%20Neovim-%2357a143?style=flat&logo=Neovim&logoColor=%2357a143&label=Built%20for&labelColor=%23ffffff&link=https%3A%2F%2Fneovim.io%2F">
        <img alt="Built for Neovim" src="https://img.shields.io/badge/%20Neovim-%2357a143?style=flat&logo=Neovim&logoColor=%2357a143&label=Built%20for&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
    </picture>
<a href="https://neovim.io/doc/install/">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/%200.11+-%233791d4?style=flat&logo=Neovim&logoColor=%233791d4&label=Required&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
        <source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/%200.11+-%233791d4?style=flat&logo=Neovim&logoColor=%233791d4&label=Required&labelColor=%23ffffff&link=https%3A%2F%2Fneovim.io%2F">
        <img alt="Required Neovim 0.11+" src="https://img.shields.io/badge/%200.11+-%233791d4?style=flat&logo=Neovim&logoColor=%233791d4&label=Required&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
    </picture>
<br>
<a href="./LICENSE">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/%20MIT%20License%20-%23004584?style=flat&label=License&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
        <source media="(prefers-color-scheme: light)" srcset="https://img.shields.io/badge/%20MIT%20License%20-%23004584?style=flat&label=License&labelColor=%23ffffff&link=https%3A%2F%2Fneovim.io%2F">
        <img alt="License" src="https://img.shields.io/badge/%20MIT%20License%20-%23004584?style=flat&label=License&labelColor=%23444444&link=https%3A%2F%2Fneovim.io%2F">
    </picture>
</a>

<hr>

## ✨ 概要 - Overview -
<sub>This plugin is a Neovim plugin to insert ruby notation (ルビ記法) easier.</sub><br>
ss-rubi.nvimは、ルビ記法を容易に挿入するためのNeovimプラグインです。<br>

<sub>Also, enabling the API allows for automatic completion of ruby.</sub><br>
また、APIを有効化することにより、ルビの自動補完が可能です。<br>

## 💼 依存関係 - Dependents -
- [Neovim](https://github.com/neovim/neovim) 0.11+
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## 🔧 インストール - Install -
### In Neovim
#### lazy.nvim
```lua
return {
    "T-b-t-Nchos/ss-rubi.nvim",
    cmd = { "RubiInsert", "RubiInsertAC" },
    opts = {
        -- your options here.
    },
}

```


## 🛠️ オプション - Options -
```lua
{
    useHWVerticalBar = false,   -- false: ｜対象《ルビ》
                                -- true: |対象《ルビ》


    autoComplete = {
        -- If you wanna use Auto Complete, 
        -- you have to agree to the ToS of used API (default is ExcelAPI (https://excelapi.org/terms/) ).
        enable = false,

        api = {
            url = "https://api.excelapi.org/language/kanji2kana",  -- API URL
            contentQuery = "text",                                 -- Content query
            otherQuery = {{}},                                     -- Other query (e.g. otherQuery = {{ key = "xxx"},)
        }
    },
}
```

## 🔠 コマンド/関数 - Commands/Functions -
### `RubiInsert` (`require("ss-rubi").RubiInsert`)
<sub>Insert ruby notation in the current cursor position.</sub><br>
現在のカーソル位置にルビ記法を挿入します。<br>
<sub>If selected any text in Visual mode, it will be converted to ruby notation.</sub><br>
Visualモードで文字列が選択されている場合は、その文字列をルビ記法に変換します。<br>

### `RubiInsertAC` (`require("ss-rubi").RubiInsertAC`)
<sub>Convert selected text to ruby notation and auto complete it.</sub><br>
選択されている文字列をルビ記法に変換し、自動補完します。<br>
<sub>To use this function, you have to agree to the ToS of used API,</sub><br>
本機能を有効化するには、使用するAPIの利用規約に同意し、<br>
<sub>And you have to set `autoComplete.enable` to `true`.</sub><br>
`autoComplete.enable`を`true`に設定してください。<br>
<sub>Default API is [ExcelAPI](https://excelapi.org/) (Terms of Use: [here](https://excelapi.org/terms/)).</sub><br>
デフォルトで設定されているAPIは、[ExcelAPI](https://excelapi.org/)です。 (利用規約は[こちら](https://excelapi.org/terms/))。<br>


## 💡 使用ソフトウェア類 - Used Softwares -
- [ExcelAPI](https://excelapi.org/) (デフォルトAPI / Default API)

## 🤔 "ss-rubi.nvim"の"ss"とは? - What is "ss" in "ss-rubi.nvim"?
<sub>The "ss" in ss-rubi.nvim is stands for "Syobosetsu" a application developed by me.</sub><br>
ss-rubi.nvimの"ss"は、私が開発に参加しているしているアプリケーション「Syobosetsu」の略称です。<br>
<sub>The function of this plugin is based on Syobosetsu.</sub><br>
本プラグインの機能のベースはSyobosetetsu由来のものです。<br>
