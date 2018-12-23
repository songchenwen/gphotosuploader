Google Photo uploader Docker for Synology


Features:
  - ignore Synology thumb "@eaDir" folders
  - monitoring all changes
  - support socks5 proxy



How to Install:
  1. docker pull muyouming/gphotosuploader
  2. get google cookie by using chrome extension by refer to [here](https://github.com/muyouming/gphotosuploader/tree/master/crx-auth).
  3. run docker in privillage mode, and set the photo folder to /photo.
  4. input the cookie string in docker env COOKIES
  4. if  proxy needed ,please change the SOCKS5_PROXY to your proxy, if no proxy needed ,pease delete the http_proxy and https_proxy.
  5. run ,and this uploader will monitor all changes in your /photo folder, and upload to your google photo storage.
  6. if this folder is new, you can go to the terminal and start a bash ,then execute:
      gphotosuploader --upload /photo --maxConcurrenct 4
    this comamnd will upload all your photos and videos in /photo .
  7. enjoy.