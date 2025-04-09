###### Именование переменных

Случай когда можно использовать одно-буквенные переменные:
```bash
cat /etc/passwd
while IFS=: read login a b c name e; do
  printf "%-12s %s\n" "$login" "$name"
done </etc/passwd
```

###### Видимость переменных
```bash
unset x
./show_var.sh
x=3
./show_var.sh
export x
./show_var.sh
x=
./show_var.sh
```

###### Синтаксис создающий подпроцессы
`$(command)`
`( commands... )`
`|`

```bash
printf "%s\n" ${RANDOM}{,,,,,} |
  while read num; do
    ((num > ${biggest:=0})) && biggest=$num
  done
echo "$biggest"
printf "The largest number is: %d\n" "$biggest" # Переменная biggest пуста, т.к. находится в подпроцессе из-за конвейера
```

```bash
echo "$PS1"
echo "$PS2"
echo "$PS3"
echo "$PS4"
```

###### Переменная, значение по умолчанию и альтернативное значение
`${var:-default}` - если переменная var не задана или пуста, то вместо неё будет возвращено default
`${var-default}` - если переменная не задана, то вместо неё будет возвращено значение default
`${var:=default}` - если переменная var не задана или пуста, то переменной присваивается default
`${var=default}` - если переменная не задана, то переменной присваивается default

```bash
var=
./sa "${var:-default}"
./sa "${var-default}"
unset var
./sa "${var-default}"
```

```bash
while true; do
  echo "|$n|"
  [ ${n:=0} -gt 3 ] && break
  n=$(($n + 1))
done

```

`${var:+alternate}` - если переменная задана и не пуста, то ей присваивается значение alternate
`${var+alternate}` - если переменная задана, то ей присваивается значение alternate
```bash
var=
./sa "${var+alternate}"
./sa "${var:+alternate}"
var=a
./sa "${var+alternate}"
./sa "${var:+alternate}"
unset var
./sa "${var+alternate}"
./sa "${var:+alternate}"
```

```bash
for n in a b c d e f g; do
  var="${var:+"$var "}$n" # Если переменная var задана и не пуста, то добавляем пробел в конец и добавляем новую букву,
done                      # а если нет, то просто добавляем новую букву
./sa "$var"
exit
if [ -n "$var" ]; then
  var="$var $n"
else
  var=$n
fi
exit
[ -n "$var" ] && var="$var $n" || var=$n
```

`${var:?message}` - если переменная не задана или пуста, то в поток ошибок добавится message, скрипт выходит
`${var?message}` - если переменная не задана, то в поток ошибок добавится message, скрипт выходит

```bash
a=ф
: ${a:?An argument is required} ${b?Two arguments are required}
echo "Are we here?"
```
######


