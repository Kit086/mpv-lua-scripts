# mpv-lua-scripts

[中文 README](./README.md) [English README](./README-en.md)

本仓库包含了一些适用于 [mpv 媒体播放器](https://mpv.io/) 的 Lua 脚本。这些脚本是为我个人使用编写的，但你可以根据需要使用它们。

如果你使用的是像 Ubuntu 22.04 这样的 Linux 系统，只需将你想使用的脚本放入以下目录：`~/.config/mpv/scripts`。如果 `mpv` 文件夹下没有 `scripts` 文件夹，你可以自行创建。

## Scripts

### jump-to-previous-sub-ass.lua

我编写这个脚本是为了帮助我学习英语。当我观看英文视频时，我希望通过重复字幕来学习表达方式。我经常需要回到上一行来复习或重复它们，但大多数视频播放器都不具备这个功能。

这个脚本仅支持 `.ass` 格式的字幕文件。

示例 mpv 命令：

```bash
mpv ./myvideo.mkv --sub-file=./myvideo.ChsEngA.ass
```
