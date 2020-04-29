### rename multiple files

```bash
for f in *.prog; do mv -- "$f" "${f%.prog}.prg"
```

[how-to-use-the-rename-command-on-linux](https://www.howtogeek.com/423214/how-to-use-the-rename-command-on-linux/)