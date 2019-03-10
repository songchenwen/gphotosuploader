#! /bin/bash -eu

echo fs.inotify.max_user_watches=1048576 | tee -a /etc/sysctl.conf && sysctl -p
echo "listen = http://127.0.0.1:7777" > ~/.cow/rc
echo "proxy = socks5://${SOCKS5_PROXY}" >> ~/.cow/rc
echo "${COOKIES}" >> /go/src/app/auth.json
echo "Run gphotosUploader"
/bin/bash -c "nohup ./cow & "
/bin/bash -c "sleep 4; /go/bin/gphotosuploader --watch /photo --maxConcurrent 4" 
