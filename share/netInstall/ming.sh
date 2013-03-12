#!/bin/sh

SHARE=/share/netInstall/


sed 's/\r//g' "$SHARE"/fileList-mingw.txt |
	(cd /bin && tar -c --file=- --files-from=-;
	 echo $? > /tmp/exitstatus) |
	tar xvf -