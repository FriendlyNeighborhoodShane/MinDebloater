# Minimal Debloater
### By FriendlyNeighborhoodShane
*A simple, flexible debloater*

### Links
* [GitHub](https://github.com/FriendlyNeighborhoodShane/MinDebloater)
* [Support](https://t.me/microgsupport)

### What is this?
This zip debloats your system partition (making backups) or pseudo-debloats as a Magisk module (if you uninstall the module, the debloated stuff will come back). It supports virtually all mobile architectures (arm/64, x86/64, mips/64) and fully supports ALL android versions. It can even uninstall itself from your device, just rename it and flash it again.

It contains an extensive default debloat list based on [CHEF-KOCH's debloat script](https://github.com/CHEF-KOCH/Remove-Gapps), and a cleanup script adapted from [NanoDroid](nanolx.org).

If you flash the pack from Magisk Manager, it will install itself to Magisk. From recovery, by default it will do system mode, but you can choose to use Magisk. In Magisk mode, the debloated apps won't be removed from system, and if you uninstall the pack, they'll come back. If you install in system, the debloated stuff will be stored in internal-storage/MinDebloater/Backup.

### Notes
How to control the zip by changing its name:

NOTE: Control by name is not possible in magisk manager, since it copies the zip to a cache directory and renames it install.zip. This is unavoidable behaviour.

- Add 'magisk' to its filename to force it to install/uninstall from magisk. Otherwise, it installs to system. Obviously, if you flash it through Magisk manager, you want to install it to Magisk. If not, you have to flash it through recovery.

- Add 'restore' to its filename to uninstall it from your device, whether in magisk mode or system mode. In system mode, it will restore the backups it made in internal-storage/MinDebloater if they still exist. If you use Magisk Manager, your preferred method of uninstallation is from there.

- If you don't wanna use the default debloat list, you can put your own lists as these files (in decreasing order of preference):
  - [Zip's directory]/mindebloater.txt
  - internal-storage/MinDebloater/mindebloater.txt

The list file should consist of paths to files or folders separated by spaces, tabs, or newlines (Don't worry, there's no spaces in any real android system file name). Shell-style comments (beggining with #) are supported.
If you're hardcore, you can start your list with "#MINDLIST" and echo it to or cat it after the zip itself. Don't ask me why I made that possible. I don't know.

- If you don't wanna use the default debloat script, you can put your own script as these files (in decreasing order of preference):
  - [Zip's directory]/mindebloater.sh
  - internal-storage/MinDebloater/mindebloater.sh

The script file should be a valid shell script. It will be called as:
```
script [state] [root] [magisk]
```
where 
  - state will be one of predebloat, postdebloat, prerestore, postrestore
  - root will be either the system root (normally / or /system on some A/B devices) or the root in our module on the magisk image.
  - magisk will be yes or no

Just rename it and flash it again for the intended effect.

For support:
If you flashed through recovery, provide its logs.
If you used Magisk Manager, provide its logs.

### Credits
Thanks to @osm0sis for the base magisk/recovery code and inspiration and guidance on the majority of the stuff in here. You're awesome.
Thanks to CHEF-KOCH for the debloat list, and @Setialpha, the creator of NanoDroid.
