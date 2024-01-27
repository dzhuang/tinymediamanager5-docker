# tinymediamanager5-docker


### [中文说明](https://github.com/dzhuang/tinymediamanager5-docker/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E)

![docker pulls](https://img.shields.io/docker/pulls/dzhuang/tinymediamanager.svg) ![docker stars](https://img.shields.io/docker/stars/dzhuang/tinymediamanager.svg)

Latest versions:
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/dzhuang/tinymediamanager/latest-v5) ![docker size](https://img.shields.io/docker/image-size/dzhuang/tinymediamanager/latest-v5)

This repository is dedicated to creating a Docker container featuring TinyMediaManager with a GUI interface, enhanced with both Chinese and Japanese font support.

```bash
docker pull dzhuang/tinymediamanager:latest-v5
```

### Important Notice for Version Upgrades

Before upgrading from an older version (e.g., 3.x to 4.x, 3.x to 5.x, or 4.x to 5.x), it is imperative to safeguard your configuration settings. Please ensure you have backed up your `/config` directory thoroughly. This precaution is essential to protect your settings and preferences during the upgrade process.

## Why Choose This Over the Official Docker Image?

Our Docker image, is significantly more compact than the official Docker images (150M vs. 300M+ as image, 230M vs. 800M when extracted). This leaner size leads to reduced system resource consumption, offering users a more efficient and streamlined experience. Opt for this image if you prioritize optimal resource management and performance in your system.

## Features
- Out-of-the-box support for Chinese and Japanese fonts (中文支持开箱即用).
- A quick resolution for the [bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13) where changes in the image version did not reflect in running containers. (修复image升级/变化后，容器实际运行的tmm版本未变化的[bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13)).
- A demonstrative Docker Compose file enabling container auto-upgrades (支持自动升级版本的docker compose示例文件).

For utilizing this build, use `dzhuang/tinymediamanager:latest-v5`.

Instructions:
- Map any local port to 5800 for web access.
- Map any local port to 5900 for VNC access.
- Map a local volume to `/config` to store configuration data.
- Map a local volume to `/media` for accessing media files.

Sample Run Command:

```bash
docker run -d --name=tinymediamanager \
-v /share/Container/tinymediamanager/config:/config \
-v /share/Container/tinymediamanager/media:/media \
-e GROUP_ID=0 -e USER_ID=0 -e TZ=Europe/Madrid \
-p 5800:5800 \
-p 5900:5900 \
dzhuang/tinymediamanager:latest-v5
```
