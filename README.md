![ppo_logo_wide](https://github.com/glebi574/pewpew-overhaul-lite/assets/38727318/bb436a4d-0201-4f9f-bc2d-c51a8e06ee45)  
# pewpew-overhaul-lite <a href="https://discord.gg/JwFyBgX8cV"><img src="https://img.shields.io/discord/1244949330029318174?style=for-the-badge&logo=discord&label=Discord&color=4f58d6" align="right"></a>  
PPOL(ppol) is lite variant of `ppo`. This variant focuses on keeping main pewpew features, renaming and slightly changing them to optimize development process. `ppol` also adds new features to simplify certain development processes, such as mesh helpers and camera framework. Currently `ppol` is only compatible with singleplayer, as it is imposible to create custom levels for multiplayer anyway.  

To include ppol in your level, copy `ppol` folder in your level folder. In the beginning of the file, that is the entry point of your level, defined in manifest.json (usually level.lua), require `ppol` entry point:
```
require'/dynamic/ppol/.lua'
```
I assume, that you'll copy `ppol` folder directly in your level folder, but if you need to place it somewhere else, just modify `ppo_require` function in ppol\.lua so it returns the correct path of `ppol` files.

`ppol` includes some functions for debugging and testing. To not load them, create global variable `PPO_NDEBUG` before requiring ppol and set it to value other than `nil` or `false`.  

`ppol` uses custom camera movement, so you will have to set it up first. By default camera is in the free mode, which means it will receive direct input from movement joystick. Camera in `ppol` has plenty of settings, but in usual case of level with 1 player ship this would be enough to make camera follow your player ship:  
```
camera.set_args(camera_mode.entity, id)  
```
In this case `id` is an id of entity you want to follow and `camera_mode.entity` is camera mode, which specifies how camera should work. For more information see documentation in one of the sources, presented below.  

Read documentation at [ppol Docs](https://pewpew-overhaul.gitbook.io/pewpew-overhaul-lite), created by [artiekra](https://github.com/artiekra).  

[documentation.txt](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/documentation.txt) usually is most up-to-date and contains all changes and additions.  

[ppl-diff.txt](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/ppl-diff.txt) has changes from PewPew Live API, including what function were renamed to, if they're still presented and what they were replaced with.  

If you have any questions or suggestions, join our [Discord server](https://discord.gg/JwFyBgX8cV).
