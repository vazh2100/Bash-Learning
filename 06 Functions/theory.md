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