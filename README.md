# tinymediamanager5-docker

A repository for creating a docker container including TinyMediaManager with GUI interface (**with Chinese and Japanese fonts**).

## modification to the original repo
- Add Chinese and Japanese fonts support out of the box (中文支持开箱即用)
- Quick fix for [bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13) that image change did not result in changes of version in running containers . Need to test if version change between v3 and v4 works and will submit PR to original repo. (修复image升级/变化后，容器实际运行的tmm版本未变化的[bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13)，跨V3和V4的版本切换未测试，请谨慎使用)
- Demo docker compose file that enable container auto upgrade (支持自动升级版本的docker compose示例文件).

The build also fixes the version not updated issue of the 
To use this build, please use `dzhuang/tinymediamanager:v5-latest`.

![docker pulls](https://img.shields.io/docker/pulls/dzhuang/tinymediamanager.svg) ![docker stars](https://img.shields.io/docker/stars/dzhuang/tinymediamanager.svg)

Latest versions:

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dzhuang/tinymediamanager/v5) ![docker size](https://img.shields.io/docker/image-size/dzhuang/tinymediamanager/v5)

Instructions:
- Map any local port to 5800 for web access
- Map any local port to 5900 for VNC access
- Map a local volume to /config (Stores configuration data)
- Map a local volume to /media (Access media files)

Sample run command:

```bash
docker run -d --name=tinymediamanager \
-v /share/Container/tinymediamanager/config:/config \
-v /share/Container/tinymediamanager/media:/media \
-e GROUP_ID=0 -e USER_ID=0 -e TZ=Europe/Madrid \
-p 5800:5800 \
-p 5900:5900 \
dzhuang/tinymediamanager:v5-latest
```
