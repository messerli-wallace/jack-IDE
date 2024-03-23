-- command to return to chosen theme whenever it gets deactivated
function ColorMyPencils(color)
	color = color or "monokai-nightasty"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

ColorMyPencils()

