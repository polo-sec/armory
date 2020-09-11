# Upgrading Shells

## Upgrading & Stabilising Shells

After gaining a reverse shell, you're not often going to have a fully featured TTY session. You need to use programs that are already on the system to get one. This will allow you to execude commands that require a fully functional TTY session such as "sudo". Also, most text editors such as vi or nano won't work properly without a proper TTY. 

### Python

	python -c 'import pty; pty.spawn("/bin/bash")'

### stty

1. In reverse shell
	python -c 'import pty; pty.spawn("/bin/bash")'
	Ctrl-Z

2. Attacker Terminal
	stty raw -echo
	fg

3. In reverse shell
	reset
	export SHELL=bash
	export TERM=xterm-256color
	stty rows <num> columns <cols>

### Exporting Terminal Type 

It's often good practice to set your reverse shell, which does not set a terminal variable by default,to something common- like:

	export TERM=xterm-256color
