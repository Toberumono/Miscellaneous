# Miscellaneous
A collection of potentially useful scripts and support files that don't fit into my other projects.

## <a name="general"></a>General
A few quick notes:

* The commands given to execute the scripts use `wget` to pipe the script into a anonymous file descriptor (temporary "file").  This eliminates the need for external cleanup because the shell automatically handles it.
* These scripts have been tested on bash 4.3 only.  While they *should* work on all recent unix shells, don't run them on anything important without verifying that they work with your chosen shell.
* Any script marked with "**This is a Linux-only script.**" is *Linux-only for a reason*.  You will break a *lot* of stuff if you try to run them on OSX.
* If you think that you've found a bug in any of these, and you know how to fix it, create a pull request! 

Each subfolder has a readme specific to its files, so select the subfolder that contains the items you're interested in to get information on their contents.
