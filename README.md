# LoRa Server Raspberry Pi image generator

Scripts to generate a Raspbian based LoRa Server image for the Raspberry Pi.
The image is intended to use on a Rasberry Pi based LoRa Gateway, for example
the [RisingHF IoT Discovery](http://www.risinghf.com/product/risinghf-iot-dicovery/?lang=en)
kit.
These scripts are based on [RPi-Distro/pi-gen](https://github.com/RPi-Distro/pi-gen).

Components installed:

* [packet_forwarder](https://github.com/Lora-net/packet_forwarder) (master branch)
* [Redis](https://redis.io)
* [Mosquitto](https://mosquitto.org)
* [PostgreSQL](https://www.postgresql.org)
* [LoRa Gateway Bridge](https://docs.loraserver.io/lora-gateway-bridge/) (latest release)
* [LoRa Server](https://docs.loraserver.io/loraserver/) (latest release)
* [LoRa App Server](https://docs.loraserver.io/lora-app-server/) (latest release)

## Notes

* LoRa App Server is accessible on port `80` (http) and port `8080` (
  https with self-signed certificate).
* SSH is disabled by default. See the
  [Raspberry Pi documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/)
  for more information.
* The default configuration is for the EU 868 ISM band. To change this, you
  need to modify two files:
  * `stage3/02-packet-forwarder/files/global_conf.json`
  * `stage3/04-loraserver/files/loraserver`

## Dependencies

When running this script outside Docker, you need to install the following
dependencies:

`quilt parted realpath qemu-user-static debootstrap zerofree pxz zip dosfstools bsdtar libcap2-bin grep rsync`

## Docker Build

```bash
./build-docker.sh
```

If everything goes well, your finished image will be in the `deploy/` folder.
You can then remove the build container with `docker rm pigen_work`

If something breaks along the line, you can edit the corresponding scripts, and
continue:

```
CONTINUE=1 ./build-docker.sh
```

There is a possibility that even when running from a docker container,
the installation of `qemu-user-static` will silently fail when building the
image because `binfmt-support` _must be enabled on the underlying kernel_.
An easy fix is to ensure `binfmt-support` is installed on the host machine
before starting the `./build-docker.sh` script (or using your own docker build
solution).
