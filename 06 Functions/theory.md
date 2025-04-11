###### Определение функции
`set -- $1` заменяет позиционные параметры параметром $1  после разделения строки по IFS, т.к. $1 не в кавычках.
`source` или `.`  читает из файла и выполняет в текущем процессоре
```bash
#!/bin/bash
source is_ip_valid.sh # Экспортируем код из файла

for ip in 127.0.0.1 168.260.0.234 1.2.3.4 123.1OO.34.21 204.225.122.150; do
  if is_ip_valid "$ip"; then
    printf "%15s: valid\n" "$ip"
  else
    printf "%15s: invalid\n" "$ip"
  fi
done
```

###### Составные команды
`(...)`
`{...}`
`((...))`
`[[...]]`
`if`
`case`
`for`
`select`
`while`
`until`
Если функция состоит из одной составной команды, то фигурные скобки можно не писать.
Если функция выполняется в subshell, то она не меняет переменные за пределами функции

```bash
source is_int_valid.sh
is_int_valid -100
echo $?
```

```bash
funky() (
  name=nobody
  echo "name = $name"
)
name=Rumpelstiltskin
funky
echo "name = $name"
```

###### Результат выполнения функции
Коды выхода: от 0 до 255
```bash
check_range() {
  if [ "$1" -lt ${2:-10} ]; then
    return 1
  elif [ "$1" -gt ${3:-20} ]; then
    return 2
  else
    return 0
  fi
}
check_range 101 50 100
echo $?
```

Вывод в файл или в стандартный вывод
```bash
user_info() {
  printf "%12s: %s\n" \
    USER "${USER:-No value assigned}" \
    PWD "${PWD:-No value assigned}" \
    COLUMNS "${COLUMNS:-No value assigned}" \
    LINES "${LINES:-No value assigned}" \
    SHELL "${SHELL:-No value assigned}" \
    HOME "${HOME:-No value assigned}" \
    TERM "${TERM:-No value assigned}"
} >${1:-/dev/fd/1}

info=$(user_info)
echo "$info"
```

Сохранение в переменные
```bash
max3() {
  (($# < 3)) && return 1
  (($1 > $2)) && set -- "$2" "$1" "$3"
  (($2 > $3)) && set -- "$1" "$3" "$2"
  (($1 > $2)) && set -- "$2" "$1" "$3"
  _max3=("$3" "$2" "$1")
}
max3 5 100 25
echo "${_max3[@]}"

```

```bash
./create_html.sh html
```


