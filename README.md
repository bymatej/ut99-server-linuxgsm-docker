# ut99-server-linuxgsm-docker
Unreal Tournament 2000 Server in Docker container installed with LinuxGSM

# Intro
After fiddling around with my past projects, I wanted to start from scratch and create a new UT2000 server to my likings.

Things I wanted: 
- Containerized server (docker)
- With nice admin GUI (old UT server admin)
- With a File browser (filebrowser app - web gui for file browsing)
- Some level of customization on server creation

## Sources I used to make the server (including my past projects)
- https://github.com/bymatej/ut99-server
- https://github.com/bymatej/ut99-patching-guide
- https://linuxgsm.com/servers/ut99server/
- https://docs.linuxgsm.com/game-servers/unreal-tournament-99
- https://filebrowser.org/installation
- https://tonyteaches.tech/filebrowser-tutorial/
- https://github.com/hurlenko/filebrowser-docker/

```
docker build -t bymatej/ut99-linuxgsm \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  .
```


```
docker run -d \
  -p 7777:7777/tcp \
  -p 7777:7777/udp \
  -p 7778:7778/tcp \
  -p 7778:7778/udp \
  -p 7779:7779/tcp \
  -p 7779:7779/udp \
  -p 8075:8075/tcp \
  -p 8075:8075/udp \
  -p 8076:8076/tcp \
  -p 8076:8076/udp \
  -p 8077:8077/tcp \
  -p 8077:8077/udp \
  -p 28900:28900/tcp \
  -p 28900:28900/udp \
  -p 28901:28901/tcp \
  -p 28901:28901/udp \
  -p 28902:28902/tcp \
  -p 28902:28902/udp \
  -p 8080:8080 \
  --name ut99-linuxgsm \
  bymatej/ut99-linuxgsm:latest
```