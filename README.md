# mistake.nvim

![Demo](https://github.com/user-attachments/assets/06167e5a-43cf-460b-b750-6fca75010f90)

**mistake.nvim** is a spelling auto correct plugin for Neovim based on [GitHub's *"Fixed typo"* commits](https://github.com/mhagiwara/github-typo-corpus).

## Features
- Includes over 20,000 entries for correction
- Lazy loads the correction dictionary in chunks with dynamic timing to reduce startup performance impact
- Includes user command for adding personal corrections
- Includes UI for editing personal corrections

## Installing (lazy.nvim)

```lua
{
  "https://github.com/ck-zhang/mistake.nvim",
}
```
## Personal Corrections

To add your own corrections, use `:MistakeAdd`;
to edit your personal dictionary, use `:MistakeEdit`.

These updates will take effect immediately, no restart required.

## Feedback

Please create a PR for any faulty corrections you encounter, the entries are processed with NLTK to minimize faulty corrections, but quality isn't guaranteed.
