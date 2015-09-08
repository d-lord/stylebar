# stylebar
Vim plugin. Statusbar to assist style marking for CSSE2310.

## usage
```bash
mark() { vim -p $(find ~/marking/"$1" -name '*.c.styled' -o -name '*.h.styled') -c "cd ~/marking/$1" ; }
```
