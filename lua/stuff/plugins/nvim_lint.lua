return {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")


      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        kotlin = { "ktlint" },
        terraform = { "tflint" },
        cpp = { "cppcheck" },
        c = { "cppcheck" },
        bash = { "beautysh" },
        html = { "htmlhint"},
        gdscript = { "gdlint" },
      }

        --[[require("lint").linters_by_ft.cppcheck = {
            cmd = 'cppcheck',
            stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
            append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
            args = {"--max-ctu-depth=100", "--check-level=exhaustive", "jskdfjskd"}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
            stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
            --ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
            --env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
            --parser = your_parse_function
        }]]
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  }
