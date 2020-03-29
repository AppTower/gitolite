#!/bin/sh
set -eo pipefail

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
	if [ ! -f /home/git/ssh_host_ed25519_key ]; then
	ssh-keygen -q -N "" -t ed25519 -f /home/git/ssh_host_ed25519_key
	fi
	ln -s /home/git/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
fi

if [ -z "$ADMIN_PUBLIC_KEY" ]; then
	>&2 echo "You have to asign one administrator public key."
	>&2 echo "  e.g., docker run -e ADMIN_PUBLIC_KEY='administrator public key'"
	exit 1
fi

echo $ADMIN_PUBLIC_KEY > /tmp/administrator.pub
su -s /bin/sh -c "gitolite setup -pk /tmp/administrator.pub" git
su -s /bin/sh -c "gitolite setup" git
rm -f /tmp/administrator.pub

/usr/sbin/sshd

exec "$@"
