LUA=./lua
FTPLUGIN=./ftplugin

.PHONY: lint format

all: format lint

lint: 
	luacheck ${LUA}  --globals vim

format:
	stylua ${LUA}  --config-path=.stylua.toml

