#!/usr/bin/env perl -w
# Apache mod_perl additional configuration file
#
#	If configured manually, it could be worth to use relative
#	file paths so that this file is location independent.
#	Relative file paths are here relative to LXR root directory.

@INC=	( @INC
		, "/lxr"		# <- LXR root directory
		, "/lxr/lib"	# <- LXR library directory
		);

1;
