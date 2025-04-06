return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua"},
        python = {"black", "isort"},
        javascript = {"prettier"},
        rust = {"rustfmt"},
        go = {"gofmt", "goimports"},
        ruby = {"rubocop"},
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end
}
