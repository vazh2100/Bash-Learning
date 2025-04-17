###### Help - описание встроенных команд
`help -s help` - синопсис команды
`help -d help` - краткое описание
`help -m help` - подробное описание

`time` - измеряет время выполнения команды или блока команд

`read` - читает ввод. $REPLY хранит строку, если переменные не указаны
`read -r` - читать `\` буквально, а не как псевдо-перенос строки

```bash
printf "%s\n" ' First line \' ' Second line ' | {
  read
  ./sa "$REPLY"
}
printf "%s\n" ' First line \' ' Second line ' | {
  read -r
  ./sa "$REPLY"
  read -r second # Сохранение в переменную обрезает пробелы по IFS
  ./sa "$second"
}
```

`read -e` - позволяет редактировать ввод перемещая курсор
`read -a` - читает ввод, разделяет слова одной строки и кладёт в массив
`read -d` - читает до указанного разделителя, вместо \n

```bash
printf "%s\n" 'first second third fourth fifth sixth' | {
  read -a array
  ./sa "${array[0]}"
  ./sa "${array[1]}"
  ./sa "${array[2]}"
}

printf "%s\n" 'first second third fourth fifth sixth' | {
  read -d t a
  read -d t b
  read -d t c
  ./sa "${a}"
  ./sa "${b}"
  ./sa "${c}"
}
```

`read -n` - берёт из ввода ограниченное количество символов
`read -s` - не отображать вводимые символы в терминале
`read -p` - отображает сообщение ввода
`read -t 2` - даёт 2 секунды на ввод

```bash
echo y or n?
read -n 1
read -s -n4 -p 'enter password:' -t 5

```

`read -u` - читать из файлового дескриптора, а не из стандартного ввода

```bash
exec 3< sa # Перенаправляет файл в третий файловый дескриптор
read -u 3
echo $REPLY
read -u 3
echo $REPLY
read -u 3
echo $REPLY
exec 3<&- # Освобождение дескриптора
```

`read -i` - задаёт предустановленное значение ввода, работает только с readline (-e)

```bash
spinner="\|/-"                                ## spinner
chars=1                                       ## number of characters to display
delay=0.25                                      ## time in seconds between characters
prompt="press any key..."                     ## user prompt
clear_line="\e[K"                             ## clear to end of line (ANSI terminal)
CR="\r"                                       ## carriage return
until read -sn1 -t$delay -p "$prompt" var; do ## loop until user presses a key
  printf " %.${chars}s$CR" "$spinner"
  temp=${spinner#?}               ## remove first character from $spinner
  spinner=$temp${spinner%"$temp"} ## and add it to the end
done
printf "$CR$clear_line"

```

