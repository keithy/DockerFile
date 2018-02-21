Servers
=======

Docker container based servers
------------------------------

This container based _shadow_ server is designed to be loaded onto an existing legacy webhost,
in order to take over or run in parallel to the legacy setup. 

### Benefits

This enables testing of alternative server configurations, using the same html
files, vhosts configuration and mysql DB, without disturbing the live server.

### Out of the Box

A _shadow_ server container is fully functional in a bare test _run_ scenario.

* a dummy configuration is provided in /web
* a dummy test 'site' is provided in /web/html

Each instance of a _shadow_ server can be published to a different port

*  `--publish 8056:80

### Configuration for Real Use

For normal day to day use these containers are state free and disposable, all configuration is
via a mounted /web volume.

* `--volume /home/adminuser/alpine3.7-apache2.4-php5.6.33-production@web:/web`

All of the main website files to be served are mounted in the container in one root.
(This is essential if hard-links are to be used to conserve disk space)

* `--volume /var/www:/var/www`

### Atomic Deployment
	
For atomic deployment purposes it is expected that files be organised under a dual A/B hierarchy.
To deploy, switch the `/var/www/html` symlink (⟹) to `htmlA/htmlB` as required. 
See: [atomic deployment](https://codeascraft.com/2013/07/01/atomic-deploys-at-etsy/).

There may be directories shared internally between the `htmlA` and `htmlB` trees using symlinks.
(e.g. a user uploads directory needs to be shared to maintain integrity between switches)

	/var/www/htmlA
	/var/www/htmlB
	/var/www/html ⟹ /var/www/htmlA

### Not-yet Atomic Deployment
	
If the site codebase does not yet handle the atomic deployment scheme (above), just serve 
`/var/www/html`, symlink `htmlA ⟹ html`, and use `htmlB` for `rehearsal` staging. 
Deployment is performed by renaming: `html`⟺`htmlB`.

	/var/www/html
	/var/www/htmlB
	/var/www/htmlA ⟹ /var/www/html	  

### Virtual Hosts and other Config

Additional host-server configurations may be mounted in the container at `/server` in order for 
other configuration files (vhosts/db etc.) to be available in the container. (host:/ or host:/etc)

* `--volume /:/server`
* or... `--volume /etc:/server`

### mod_realdoc is included

References:
 
* [atomic deployment](https://codeascraft.com/2013/07/01/atomic-deploys-at-etsy/).
* [mod_realdoc](https://github.com/etsy/mod_realdoc).

Website Staging Toolkit
=======================

**Note: this is only a spec - code to be written!**

keithy/website-staging-toolkit:latest

Staging and Deployment
----------------------

A [Rake](https://github.com/ruby/rake) based solution. 

This container is a repository of useful server management scripts that can be deployed
to each live server. The container incluse all of the tools preconfigured to run the scripts. 

#### Tasks supported:

* Staging the next release
* Sanity Checks
* A/B Atomic switching
* B/A Atomic Rollback
* other:
 * disk space usage analysis
 * log file analysis
 * integration with monitoring container

When a new release is uploaded to `/var/www/stage` (via whatever means, rsync/ftp etc) this
triggers the staging process. The existing `production` site is efficiently duplicated 
into a `rehearsal` site, and new code is merged in from the `stage`.

This container is also responsible for performing and managing the A/B atomic deployment
switching process on the server. This allows pre-requisite checks and post-tidy up rules
to be defined to ensure integrity.

**NOTE:** The A/B atomic deployment process uses two html trees simultaneously. 
Since there may be symlinks between the the trees internally, the rehearsal area is NOT disposable. 
When deployment takes place, `production` and `rehearsal` switch places and `rehearsal` now points
to the previous `production` area, which may contain the master copies of some files. Therefore 
it is NOT SAFE to *blow away* the `rehearsal` area at any time. 

> todo: add a task to move any symlinked resources in rehearsal area over to production area,
> post-deployment (or vice versa pre-deployment) }

Live server website files are mounted locally at (/var/www):

* `--volume /var/www:/var/www

Container internal working directory structure, ensures that all files are on the same
filesystem so that hard-links work (including to the stage area)

	/var/www/stage
	/var/www/production ⟹ /var/www/html ⟹ /var/www/htmlA (or B)
	/var/www/rehearsal  ⟹ /var/www/htmlB (or A)

Viewing of rehearsal sites prior to deployment requires a separately configured _shadow_ server

* `--volume /home/adminuser/alpine3.7-apache2.4-php7.2.1@web:/web`
* `--volume /var/www:/var/www'
* `--publish 9721:80`
* `-e DOCROOT=/var/www/rehearsal

Website Testing Toolkit
=======================

**Note: this is only a spec - code to be written!**

keithy/website-testing-toolkit

Testing Branches
----------------
The testing version of the website staging toolkit specifies a distinct testing stage area, 
but it is also within the same filesystem

* `--volume /var/www:/var/www 
* `--publish 721:80`
* `--volume /home/adminuser/git-repo/branch-master:/stage
* `-e TESTROOT=/var/www/testing/my-feature-branch/html`

Viewing of testing sites prior to deployment requires a separately configured _shadow_ server

* `--volume /home/adminuser/alpine3.7-apache2.4-php7.2.1@web:/web`
* `--volume /var/www:/var/www'
* `--publish 99721:80`
* `-e DOCROOT=/var/www/testing/my-feature-branch/html

Additional `testing` sites can be created as needed, they do not participate in the A/B 
atomic switch process.
Testing sites never contain the master copies of shared resources but do link to shared
resources in the /var/www/production or /var/www/rehearsal sites.

Testing sites can be safely *blown away* at any time.
Code is never released directly from the testing area into production.
The website-staging-toolkit deployment method is always used.
	