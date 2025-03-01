![ppo_logo_wide](https://github.com/glebi574/pewpew-overhaul-lite/assets/38727318/bb436a4d-0201-4f9f-bc2d-c51a8e06ee45)  
# Important
I'm not working on `ppol` anymore.
# pewpew-overhaul-lite  
PPOL(ppol) is lite variant of `ppo`. This variant focuses on keeping main pewpew features, renaming and slightly changing them to optimize development process. `ppol` also new features to simplify certain development processes, such as mesh helpers, sound parser and camera framework. `ppol` also adds proper error messages to functions, that don't have them. Currently `ppol` is only compatible with singleplayer, as it is imposible to create custom levels for multiplayer anyway.  

To include ppol in your level, copy `ppol` folder in your level folder. In the beginning of the file, that is the entry point of your level, defined in manifest.json (usually level.lua), require `ppol` entry point:
```
require'/dynamic/ppol/.lua'
```
I assume, that you'll copy `ppol` folder directly in your level folder, but if you need to place it somewhere else, just modify `ppo_require` function in ppol\.lua so it returns the correct path of `ppol` files.  

`ppol` has special features for mesh and sound environments. To use them, require `ppol` in file, which needs these features, as you did earlier. Mesh environment will be recognized automatically, but for sound environment you would have to define `PPO_SOUND` first and set it to value other than `nil` or `false`.  

`ppol` includes some functions for debugging and testing. To not load them, create global variable `PPO_NDEBUG` before requiring ppol and set it to value other than `nil` or `false`. That also turns off error messages, added by `ppol` to some functions, so be careful.  

Read documentation at [ppol Docs](https://pewpew-overhaul.gitbook.io/pewpew-overhaul-lite), created by [artiekra](https://github.com/artiekra).  

[documentation.txt](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/documentation.txt) usually is most up-to-date and contains all changes and additions.  

[ppl-diff.txt](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/ppl-diff.txt) has changes from PewPew Live API, including what functions and variables were renamed to, if they're still presented or what they were replaced with.  

[examples.lua](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/examples.lua) has examples and explanations for some complicated features.  

If you have any questions or suggestions, join our [Discord server](https://discord.gg/JwFyBgX8cV).
