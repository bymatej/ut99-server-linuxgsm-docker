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
docker build -t testing/server . 
```