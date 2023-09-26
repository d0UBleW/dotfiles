return {
	cmd = {
		"arduino-language-server",
		"-cli-config",
		"/home/doublew/.arduino15/arduino-cli.yaml",
		"-fqbn",
		"arduino:avr:uno",
		"-cli",
		"/home/doublew/.local/bin/wsl2-arduino-cli",
		"-clangd",
		"/home/doublew/bin/clangd",
	},
}
