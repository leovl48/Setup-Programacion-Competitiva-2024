local config_file = vim.fn.stdpath("config") .. "/theme_config.lua"

local themes = {
	dark = function()
		vim.cmd("colorscheme dracula")
	end,
	light = function()
		vim.cmd("let g:solarized_termcolors=256")
		vim.cmd("let g:solarized_italic=0")
		vim.cmd("set background=light")
		vim.cmd("colorscheme solarized")
	end,
}

local function save_theme(name)
	local file = io.open(config_file, "w")
	if file then
		file:write("return '" .. name .. "'\n")
		file:close()
	else 
		print("No se pudo guardar la configuracion del tema.")
	end
end

local function load_theme()
	local ok, name = pcall(dofile, config_file)
	if ok and name and themes[name] then
		themes[name]()
	else
		print("No se pudo cargar el tema. Usando dracula.")
		themes["dark"]()
	end
end

-- Funcion para cambiar el tema
function setTheme(theme_name)
	if themes[theme_name] then
		themes[theme_name]()
		save_theme(theme_name)
		-- Aplica el tema
		print("Tema cambiado a: " .. theme_name)
	else
		print("Tema no encontrado: " .. theme_name)
	end
end

load_theme()
