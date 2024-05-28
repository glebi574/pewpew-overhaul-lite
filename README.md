# pewpew-overhaul-lite
PPOL(ppol) is lite variant of `ppo`. This variant focuses on keeping main pewpew features, renaming and slightly changing them to optimize development process. `ppol` also adds new functions to simplify mesh development. Currently `ppol` is only compatible with singleplayer(as there are no way to create custom multiplayer levels).  

To include ppol in your level, copy `ppol` folder in your level folder. In the beginning of the file, that is the entry point of your level, defined in manifest.json (usually level.lua), require `ppol` entry point:
```
require'/dynamic/ppol/.lua'
```
I assume, that you'll copy `ppol` folder directly in your level folder, but if you need to place it somewhere else, just modify `ppo_require` function in ppol\.lua so it returns the correct path of `ppol` files.

ppol includes some functions for debugging and testing. To not load them, create global variable `PPO_NDEBUG` before requiring ppol and set it to value other than nil.

[description.txt](https://github.com/glebi574/pewpew-overhaul-lite/blob/main/description.txt) contains all changes and additions.  

If you have any questions or suggestions, join our [Discord server](https://discord.gg/JwFyBgX8cV).
