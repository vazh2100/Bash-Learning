###### Reading

```bash
while read; do
  echo $REPLY
done < kjv.txt
```

```bash
while IFS=" " read name phone; do
  printf "Name: %-10s\tPhone: %s\n" "$name" "$phone"
done << EOF
John 555-1234
Jane 555-7531
EOF
```

AWK в данном случае будет работать быстрее
```bash
time while IFS=: read book chapter verse text; do
  first_word=${text%% *}
  printf "%s %s:%s %s\n" "$book" "$chapter" "$verse" "$first_word"
done < kjv.txt

time awk -F':' 'print $1, $2, $3, $4}' < kjv.txt
```

###### External commands: cat

`cat` - выводит содержимое файла/файлов в стандартный вывод
Если какая-то команда не умеет читать из файла или умеет читать только из одного файла, то стоит использовать cat
Если комнада умеет читать из файла, cat не нужно использовать.
```bash
cat thisfile.txt | head -n 25 > thatfile.txt ## WRONG
head -n 25 thisfile.txt > thatfile.txt       ## CORRECT
```

```bash
cat "$@" | while read x; do whatever; done
while read x; do whatever; done < <(cat "$@")
```

###### External commands: head

```bash
head -n 5 kjv.txt
```

```bash
{
  read line1
  read line2
  read line3
  read line4
} < kjv.txt
```

Этот код кладёт каждую прочитанную строку в массив
```bash
for n in {1..4}; do
  read lines[${#lines[@]}] # ${#lines[@]} - длина массива
done < kjv.txt
```
Делает то же самое
```bash
mapfile -tn 4 lines < "$kjv" 
```

###### External commands: touch
`touch` - обновляет временную метку файла или создаёт пустой файл, если файла не существует
`touch -d DATE` - обновляет временную метку файла на заданную дату

Для создания файла лучше всего использовать пустое перенаправление? Это быстрее
```bash
> file.txt # Создаст или перезапишет файл

for file in {a..z}.txt; do
  > "$file"
done

#>> file.txt # Не обновит временную метку
```

###### External commands: ls
Если нужно вывести список файлов, то лучше использоваться wildcards для файлов, а не ls

```bash
./sa *
ls
ls -l   # Подробный вывод(права, пользователи, группы, размер, дата, имя)
ls -t   # Сортирует по дате изменения
ls -r   # Обратный алфавитный или по дате изменению порядок
ls *.md # Выводит только совпадающие по шаблону
```

Проблема с пробелами при использовании ls
```bash
touch {zzz,xxx,yyy}\ a
for file in $(ls *\ *); do echo "$file"; done
for file in *\ *; do echo "$file"; done
```

###### External commands: cut
Извлекает подстроку из строки
`cut -c 12,15` `12-15` - извлекает посимвольно
`cut -b` - извлекает побайтово
`cut -f` - извлекает поля
`cut -d,` - задаёт разделитель для полей

```bash
cut -c 22,26,27 kjv.txt | head -n3
cut -c 22-27 kjv.txt | head -n3
```

Извлекать строки быстрее средствами оболочки
```bash
boys="Brian,Carl,Dennis,Mike,Al"
printf "%s\n" "$boys" | cut -d, -f3 ## WRONG

IFS=, ## Better, no external command used
boy_array=($boys)
printf "%s\n" "${boy_array[2]}"

temp=${boys#*,*,} ## Better still, and more portable
printf "%s\n" "${temp%%,*}"
```

###### External commands: wc
Считает количество строк, слов, байтов.
`-l` - ограничивает вывод строками
`-w` - ограничивает вывод словами
`-c` - ограничивает вывод байтами
`-m` - ограничивает вывод символами

```bash
wc kjv.txt /etc/passwd
wc < kjv.txt
wc -lwcm < kjv.txt
```

Узнать количество слов в строке.
```bash
set -f
set -- $var
echo $#
```

Узнать количество строк в файле
```bash
IFS=$'\n'
set -f
set -- $var
echo $#
```
