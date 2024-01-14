LUA=./lua
FTPLUGIN=./ftplugin

.PHONY: lint format

all: format lint

lint: 
	luacheck ${LUA} ${FTPLUGIN} --globals vim

format:
	stylua ${LUA} ${FTPLUGIN} --config-path=.stylua.toml

