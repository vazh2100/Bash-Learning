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
a=value
: ${a:?An argument is required} ${b?Two arguments are required}
echo "Are we here?"
```
###### Posix Shell. Длина, обрезка с начала и с конца

`${#var}` - возвращает длину значения переменной
`${var%PATTERN}` - обрезает значение переменной с конца по первому совпадению
`${var%%PATTERN}` - обрезает значение переменной с конца по последнему совпадению
`${var#PATTERN}` - обрезает значение переменной с начала по первому совпадению
`${var##PATTERN}` - обрезает значение переменной с начала по последнему совпадению

```bash
read passwd
if [ ${#passwd} -lt 8 ]; then
  printf "Password is too short: %d characters\n" "${#passwd}" >&2
  exit 1
fi
```
```bash
var=Wollongong
printf "%s\n" "${var%o*}"
printf "%s\n" "${var%%o*}"
printf "%s\n" "${var#*o}"
printf "%s\n" "${var##*o}"
```

###### Bash. Поиск и замена, подстрока, непрямая ссылка
`${var/PATTERN/STRING}` заменяет первое найденные совпадения на STRING
`${var//PATTERN/STRING}` заменяет все найденные совпадения на STRING
`${var:OFFSET:LENGTH}` возвращает подстроку

```bash
passwd=zxQ1.=+-a
echo "${passwd/?/*}"
echo "${passwd//?/*}"
```

```bash
var=Wollongong
printf "%s\n" "${var//o/e}"
./sa "${var:4:3}"  # Начать с индекса 4 включительно и взять 3 символа
./sa "${var:4}"    # Начать с индекса 4 включительно и взять до конца
./sa "${var: -4}"  # Начать с 4 символа с конца включительно и взять до конца
./sa "${var:0:-4}" # Начать с индекса 0 и взять до 4 символа с конца исключительно
```

`${!var}` - взять значение var, найти переменную с таким же именем и взять у неё значение
```bash
a=value
b=a
c=b
d=c
echo ${!d}
eval "echo \$$d"
```

###### Bash 4.0. toUppercase, toLowercase
`${var^PATTERN}`  - делает первое совпадение с большой буквы, PATTERN опционален
`${var^^PATTERN}` - делает все совпадения с большой буквы, PATTERN опционален
`${var,PATTERN}`  - делает первое совпадение с маленькой буквы, PATTERN опционален
`${var,,PATTERN}` - делает все совпадения с маленькой буквы, PATTERN опционален
`${var~PATTERN}`  - инвертирует первое совпадение, PATTERN опционален
`${var~~PATTERN}` - инвертирует все совпадения, PATTERN опционален

```bash
var=melbourne
./sa "${var^}"
./sa "${var^[m-z]}"
./sa "${var^^[a-l]}"
./sa "${var^^[m-z]}"
./sa "${var^^}"
echo
var=MELBOURNE
./sa "${var,}"
./sa "${var,[M-Z]}"
./sa "${var,,[A-L]}"
./sa "${var,,[M-Z]}"
./sa "${var,,}"
echo
var=MELbouRNE
./sa "${var~}"
./sa "${var~~}"
```

###### Удаление позиционных параметров
`shift "$#"`             удалить все параметры
`shift "$(( $# - 2 ))"`  удалить все кроме последних двух

```bash
name() {
  local param
  for param in "$@"; do ## Можно просто for param, без in $@
    echo $param
  done
  echo "$@"
  while (($#)); do
    echo $1
    shift
  done
  echo "$@"
}

name 1 2 3 4 5
```



