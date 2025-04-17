###### Регулярные выражения: grep

Стоит использовать только если нужно отфильтровать строки по условию ждя дальнейшей обработки.
Для одной строки использовать не нужно.

`grep` намного быстрее, чем bash
```bash
time grep ':0[57]0:001:' kjv.txt | cut -c -78
```
```bash
time while read line; do
  case $line in
    *0[57]0:001:*) printf "%s\n" "${line:0:78}" ;;
  esac
done < kjv.txt
```

```bash
grep Psalms:023 kjv.txt |
  {
    total=0
    while IFS=: read book chapter verse text; do
      set -- $text           ## put the text into the positional parameters
      total=$(($total + $#)) ## add the number of parameters
    done
    echo $total
  }
```

###### Регулярные выражения: sed
Для модификации строки.
`Stream EDitor`
`sen -n` - печатает только изменённые строки

```bash
sed -n '/Lev.*:001:001/,/Lev.*:001:003/ s/Leviticus/ LEVITICUS/p' kjv.txt | cut -c -78 # Отбирает 3 строки между регулярными
:                                                                                      # И меняет строчные буквы на заглавные
```

###### Регулярные выражения: awk

```bash
awk -F: ' /Lev.*:00.:001/ {
    split($4, words, " ") ## split the fourth field into an array of words
    printf "%s %s:%s %s\n", $1, $2, $3, words[1] ## printf the first three fields and the first word of the fourth
}' kjv.txt
```

```bash
awk -F: 'BEGIN { min = 999 }
length($0) - length($1) < min { min = length($0) - length($1); verse = $0 }
END { print verse }' kjv.txt
```

```bash
awk '
/Jesus wept/ { print previous_line; print $0; n = 1; next }
n == 1 { print $0;  exit  }
{ previous_line = $0 }
' kjv.txt
```


