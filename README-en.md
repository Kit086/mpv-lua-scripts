# mpv-lua-scripts

[中文 README](./README.md) [English README](./README-en.md)

This repository contains a collection of Lua scripts for the [mpv media player](https:/mpv.io/). These scripts are for personal use, but feel free to use them if you'd like.

If you're using a Linux system like Ubuntu 22.04, simply place the scripts you want in this folder: `~/.config/mpv/scripts`. If you don't have a `scripts` folder under `mpv`, you can create it. 

## Scripts

### jump-to-previous-sub-ass.lua

I wrote this script to help me learn English. When I watch English videos, I want to repeat the subtitles to learn expressions, I often need to go back to the previous line to review or repeat them. However, most video players do not have this feature. 

This script works only with `.ass` subtitle files.

Example mpv commands:

```bash
mpv ./myvideo.mkv --sub-file=./myvideo.ChsEngA.ass 
```
