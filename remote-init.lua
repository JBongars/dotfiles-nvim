-- sync remote and local system paste

-- to include, do
-- :luafile ./remote-init.lua

-- to test if osc52 is working, use following command and paste somewhere, you should see "hello world"
-- printf $'\e]52;c;%s\a' "$(base64 <<<'hello world')"

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
