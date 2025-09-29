# automatically git rm the deleted files

```bash
git ls-files --deleted | xargs git rm
```

# disable file mode changes from git tracking
```bash
git config --global core.fileMode false
```
