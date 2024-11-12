return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "j-hui/fidget.nvim",
        opts = {},
      }
    },
    config = function()
      local user_keymaps = require("user.keymaps")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "omnisharp", "gopls" }
      })

      require 'lspconfig'.gopls.setup {}

      require 'lspconfig'.lua_ls.setup {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          user_keymaps.setup_lsp_keys(bufnr)
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize 'vim' as a global
            },
          }
        }
      }

      require 'lspconfig'.omnisharp.setup {
        cmd = { "omnisharp" },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          user_keymaps.setup_lsp_keys(bufnr)
        end,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          MsBuild = {
            LoadProjectsOnDemand = nil,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      }
    end
  },
  "tpope/vim-sleuth"
}
