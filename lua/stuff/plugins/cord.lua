return {
	"vyfor/cord.nvim",
    lazy = false,
	dependencies = {},
	opts = {
	},
    config = function()
		local cord = require("cord")
		cord.setup({
			display = {
				theme = 'default',   -- 'default', 'atom', 'catppuccin', 'minecraft', 'void', 'classic'
				flavor = 'dark',   -- 'dark', 'light', 'accent'
				view = 'full',      -- both the file/asset icon and the editor icon (default)
			  --view = 'asset',  -- only the file/asset icon
			  --view = 'editor', -- only the editor icon
			  --view = 'auto',   -- both, but drop the file icon in new/empty buffers
				swap_icons = true,  -- editor icon becomes the large image, file icon the small one
				swap_fields = true, -- show the workspace name above the file name
			},
--			idle = {
--				details = function(opts)
--					return 'Taking a break from ' .. opts.workspace
--				end,
--				state = 'Be right back',
--				tooltip = '😴',
--			},
			text = {
--				default = 'doing cool things in neovim yea', -- applies to all unset categories
				workspace = function(opts) return 'In ' .. opts.workspace end, -- overrides the default
				editing = function(opts)
					return string.format('doing cool stuff in %s:%d:%d', opts.filename, opts.cursor_line, opts.cursor_char)
				end,
			},
			hooks = {
				post_activity = function(opts, activity)
					activity.status_display_type = 'details' -- 'name' | 'details' | 'state'
					activity.type = 'playing' -- 'playing' | 'listening' | 'watching' | 'competing'
					local v = vim.version()
					activity.assets.small_text = string.format('Neovim %d.%d.%d', v.major, v.minor, v.patch)
				end
			},
			assets = {
--				myfiletype = {
--					name = 'Plugin Name',
--					icon = '...',
--					tooltip = 'My custom filetype',
--					type = 'file_browser',  -- categorize it
--				},
--				['.rs'] = 'https://example.com/my-rust-icon.png',
			},
			extensions = {
				visibility = {
					rules = {
						blacklist = {
							'secret',                                  -- matches a workspace name
							'~/work/private',                          -- matches a path
							{ type = 'glob', value = '**/vendor/**' }, -- matches a glob
						},
					},
				},
			},
		})
	end
}
