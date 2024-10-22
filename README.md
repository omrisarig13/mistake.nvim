# mistake.nvim

![Demo](https://github.com/user-attachments/assets/06167e5a-43cf-460b-b750-6fca75010f90)

**mistake.nvim** is a spelling auto correct plugin for Neovim based on [GitHub's *"Fixed typo"* commits](https://github.com/mhagiwara/github-typo-corpus). 

## Features
- Includes over 20,000 entries for correction 
- Lazy loads the correction dictionary in chunks with dynamic timing to reduce performance impact
- Supports adding personal corrections

## Installing (lazy.nvim)

```lua
{
  "https://github.com/ck-zhang/mistake.nvim",
}
```
## Adding Custom Corrections

To add your own corrections, edit the custom dictionary file:
```shell
nvim ~/.config/nvim/mistake_custom_dict.lua
```
## Feedback

Please create an issue for any faulty corrections you encounter, the entries are processed with NLTK to minimize faulty corrections, but I can't check them all.
