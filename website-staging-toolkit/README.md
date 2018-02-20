Servers
=======

Docker container based servers
------------------------------

These container based servers are designed to be loaded onto an existing legacy webhost,
in order to take over or run in parallel to the legacy setup. 

### Benefits

This enables the testing of several alternative server configurations, using the same html
files, vhost configuration and DB, without disturbing the live server.

These servers are fully functional in a bare test scenario.

* a dummy configuration is provided in /web
* a dummy test 'site' is provided in /web/html

Each shadow server can be published to a different port

*  `--publish 8056:80

Normally a specific server configuration is provided via a mounted /web volume

* `--volume /home/testuser/alpine3.7-apache2.4-php5.6.33/web:/web`

The main website to be served is expected to be mounted in the container at

* `--volume /var/www:/var/www`
	
For staging purposes it is expected that files be organised under a dual A/B hierarchy,
and there will be symlinks internally between them. (e.g. a user uploads directory will
be symlinked to the same source directory to maintain integrity between switches)
See: [atomic deployment](https://codeascraft.com/2013/07/01/atomic-deploys-at-etsy/)

	/var/www/htmlA
	/var/www/htmlB
	/var/www/html --symlink-> /var/www/htmlA
	
If the server does not (yet) handle the atomic scheme with a symlinked DocumentRoot,
just serve `/www/html` and symlink A->html, and use B for staging.

	/var/www/html
	/var/www/htmlB
	/var/www/htmlA --symlink-> /var/www/html	  

The host server itself may be mounted in the container at `/server` in order for other
config to be available. (or host:/ or host:/etc)

* `--volume /:/server`
* `--volume /etc:/server`

Website Staging Toolkit
=======================

A Rake based solution. Git repository changes are monitored, and when a new [tagged] release
is pushed, the existing `production` site is efficiently duplicated into the `rehearsal`
area, and merged with new code.

The server website files are mounted locally at (/var/www):

* `--volume /var/www:/var/www

Working directory structure:

	/production --symlinked--> /var/www/html --symlinked--> /var/www/htmlA (or B)
	/rehearsal  --symlinked--> /var/www/htmlB (or A)
	/stage
	


	