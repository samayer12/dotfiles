Dear self,

Herein lie all your dotfiles.
Clone the repo and execute [`./setup-everything`] to symlink your dotfiles and install all the basic essentials. 
Edit [_config.json_] to change how files get symlinks.

#### Behavior of [_setup-everything_] script

* Idempotent
* Prompts for confirmation before each change

#### Notes

The [_dotphile_] python script reads the symlink configuration from [_config.json_].
This script creates those symlinks in a safe and communicative manner.
Python is pre-installed on most unix systems.
If the system Python is version 3, then [_setup-everything_] script runs [_dotphile_] through Python's `2to3` transpiler before execution.

[_config.json_]:        https://github.com/samayer12/dotfiles/blob/main/config.json      "View File"
[_dotphile_]:           https://github.com/samayer12/dotfiles/blob/main/dotphile         "View File"
[_setup-everything_]:   https://github.com/samayer12/dotfiles/blob/main/setup-everything "View File"
[`./setup-everything`]: https://github.com/samayer12/dotfiles/blob/main/setup-everything "View File"
[vimrc]:                https://github.com/samayer12/dotfiles/blob/main/vim/vimrc        "View File"

[modeline]: # ( vim: set tw=120: )
