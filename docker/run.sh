#! /bin/bash -eu

echo fs.inotify.max_user_watches=1048576 | tee -a /etc/sysctl.conf && sysctl -p
echo "${COOKIES}" >> /go/src/app/auth.json
echo "Run gphotosUploader"
/bin/bash -c "sleep 4; /go/bin/gphotosuploader --watch /photo --maxConcurrent 4" 
