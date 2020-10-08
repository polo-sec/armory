# Dumping Git Directories 

## Overview
If you find a .git directory during enumeration, you sometimes able to dump the .git folder using a tool called gitdumper.sh

## Getting Files from Previous Commits 
In order to get all the files in the previous commits:

	git checkout .
	ls -a
