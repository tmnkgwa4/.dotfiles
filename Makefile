NAME	   := DotfileInstaller
VERSION  := 1.0.0

.PHONY: install clean

install:
	/bin/zsh ./setup.zsh
