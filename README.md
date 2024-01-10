# tinymediamanager5-docker

A repository for creating a docker container including TinyMediaManager with GUI interface (**with Chinese and Japanese fonts**).

```bash
docker pull dzhuang/tinymediamanager:latest-v5
```


## modification to the original repo
- Add Chinese and Japanese fonts support out of the box (中文支持开箱即用)
- Quick fix for [bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13) that image change did not result in changes of version in running containers . Need to test if version change between v3 and v4 works and will submit PR to original repo. (修复image升级/变化后，容器实际运行的tmm版本未变化的[bug](https://github.com/dzhuang/tinymediamanager-docker/issues/13)，跨V3和V4的版本切换未测试，请谨慎使用)
- Demo docker compose file that enable container auto upgrade (支持自动升级版本的docker compose示例文件).

The build also fixes the version not updated issue of the 
To use this build, please use `dzhuang/tinymediamanager:v5-latest`.


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

## Update from v4

Make sure the v4 `config/data` directory is mapped and can be accesses from the new version, and when “Tools -> Import data/settings from another v4 installation”, and select that
folder. 
