# syntax=docker/dockerfile:1
ARG RUBY_IMAGE_TAG
FROM ruby:${RUBY_IMAGE_TAG}

ARG PROJECT_NAME
ARG RUBYGEMS_VERSION
ARG USER_NAME=ruby
ENV TZ=Asia/Tokyo

RUN adduser ${USER_NAME}

WORKDIR /${PROJECT_NAME}
RUN	<<-EOF
	set -eu
	gem update --system ${RUBYGEMS_VERSION}
	chown -R ${USER_NAME} ${GEM_HOME}
EOF

RUN <<-EOF
  mkdir -p /home/${USER_NAME}/.gem
  touch /home/${USER_NAME}/.gem/credentials
  chown ${USER_NAME} /home/${USER_NAME}/.gem/credentials
  chmod 600 /home/${USER_NAME}/.gem/credentials
EOF

USER ${USER_NAME}

RUN <<-EOF
	set -eu
	cat <<-'EOT' >> /home/${USER_NAME}/.bashrc
		if [ "$SHLVL" -eq 2 ] ; then
		  script --flush ~/bashlog/script/`date "+%Y%m%d%H%M%S"`.log
		fi
		export PROMPT_COMMAND='history -a'
		export HISTFILE=~/bashlog/.bash_history
	EOT
	mkdir -p /home/${USER_NAME}/bashlog/script
	touch /home/${USER_NAME}/bashlog/.bash_history
EOF

RUN mkdir -p /home/${USER_NAME}/.vscode-server/extensions
