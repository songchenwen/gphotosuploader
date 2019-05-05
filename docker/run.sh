#!/usr/bin/with-contenv bash

echo fs.inotify.max_user_watches=1048576 | tee -a /etc/sysctl.conf && sysctl -p
chown abc:abc /app
s6-setuidgid abc echo "${COOKIES}" >> /app/auth.json
echo "Run gphotosUploader"
s6-setuidgid abc ls /photo
sleep 4
s6-setuidgid abc /go/bin/gphotosuploader --watch /photo --maxConcurrent 4 --ignore "${IGNORE}"
