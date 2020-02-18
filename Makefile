up:
	git pull --rebase origin master
	cd pack/gitmodules/ && git submodule update --remote
	git commit -am 'extension submodules updated'
	git push origin master
