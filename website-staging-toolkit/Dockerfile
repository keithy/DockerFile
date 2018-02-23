FROM nimmis/alpine-micro:edge
MAINTAINER Keith keithy@consultant.com

COPY root/. /

RUN	printf "Build of keithy/website-staging-toolkit, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILDS/website-staging-toolkit && \

    # UPDATE

	apk update && apk upgrade && \

    # SSH

    apk --upgrade add openssh-client && \
	echo "UserKnownHostsFile /.ssh-agent/known_hosts" >> /etc/ssh/ssh_config && \

    # TOOLS

	apk add git nano rsync && \

    # RUBY

	apk add ruby ruby-rake ruby-rspec ruby-rdoc  && \

    # RUBY GEMS

	gem install thor rio && \

	# http://www.rubydoc.info/gems/tty-command
	gem install tty-command pastel && \

    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /backup
VOLUME /wst

ENV MYSQL_HOST=240.1.1.1

#docs need to know!
#https://github.com/nardeas/docker-ssh-agent