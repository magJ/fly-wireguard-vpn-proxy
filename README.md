# Running a general purpose wireguard VPN on fly.io

Run a VPN for general web browsing, on fly.io

fly.io utilises wireguard internally for a bunch of stuff, this isn't that.

## Why
- Fly.io has a nice free tier
- Sometimes you need a VPN to get around content blocking or whatever

## How
- Clone this project
- Run `./launch.sh`

## Further information
This project is just some fly.io specific configuration of the [`linuxserver/docker-wireguard` image](https://github.com/linuxserver/docker-wireguard).

See the documentation there for more information about configuring the VPN to work as you desire.

fly.io uses docker images for it's build process, but a built fly app doesn't actually run on docker, 
so there are a couple differences we need to cater for.

Firstly that the docker process doesn't run as pid 1, 
and secondly that sysctls can be, and need to be configured at run-time, rather than externally.

## Known issues

Currently outbound traffic from fly.io does not go via the public IP of the instance.
Also fly.io IP addresses seem to not be reliably geo-locatable to the region that you run the app in,
which may be an issue for you if you want to use the VPN to access geo-fenced content.