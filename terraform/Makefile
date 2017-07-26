all: keys/deployer keys/master get

get: 
	terraform get

keys/deployer:
	ssh-keygen -f $@

keys/master:
	ssh-keygen -f $@

clean:
	rm -rf .terraform keys/master keys/master.pub

clean_all: clean
	rm secrets.tf variables.tf


.PHONY: all get clean clean_all
