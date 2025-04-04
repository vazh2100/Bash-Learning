###### Три типа итерации
`while`
`until`
`for`

###### Три типа ветвления
`if`
`case`
`&& and ||`

###### Exit status
За исключением `for` и `case` статус выхода влияет на ветвление.

```bash
printf "%v\n"
echo $?
mkdir /qwerty
echo $?
```

###### Тестирование выражений
`test`,` [ ]` сравнивает строки, числа, и различные файловые атрибуты
`((` тестирует арифметические операции
`[[ ... ]]`  то же самое,что и тест + сравнение по регулярному выражению

###### Тестирование файлов
`test -e` существует ли файл?
`test -f` файл файл?
`test -d` файл директория?
`test -L`, `test -h`  файл символическая ссылка на файл?
`test -x` файл исполняемый?
`test -s` файл существует и не пустой

`! test`отрицание

```bash
[ ! -f /etc/fstab ]
echo $?
[ -L /bin ]
echo $?
[ -x /bin/bash ]
echo $?
[ -s $HOME/.bashrc ]
test -f /etc/fstab
echo $?
test -L /bin
echo $?
test -x /bin/bash
echo $?
! test -d $HOME/.bashrc
echo $?

```

###### Тестирование чисел

`test 1 -eq 2` число 1 равно числу 2?
`test 1 -ne 2` число 1 не равно числу 2?
`test 1 -gt 2` число 1 больше чем число 2?
`test 1 -lt 2` число 1 меньше, чем число 2?
`test 1 -ge 2` число 1 равно или больше, чем число 2?
`test 1 -le 2` число 1 равно или меньше, чем число 2?
Нестандартный способ работать с числами:
`(( 1 + 2 ))` результат вычисления не равен 0?
`(( 1 == 2 ))` число 1 равно числу 2?
`(( 1 != 2 ))` число 1 не равно числу 2?
`(( 1 > 2 ))` число 1 больше чем число 2?
`(( 1 < 2 ))` число 1 меньше, чем число 2?
`(( 1 >= 2 ))` число 1 равно или больше, чем число 2?
`(( 1 <= 2 ))` число 1 равно или меньше, чем число 2?

```bash
test 1 -eq 2 # число 1 равно числу 2?
echo $?
test 1 -ne 2 # число 1 не равно числу 2?
echo $?
test 1 -gt 2 # число 1 больше чем число 2?
echo $?
test 1 -lt 2 # число 1 меньше, чем число 2?
echo $?
test 1 -ge 2 # число 1 равно или больше, чем число 2?
echo $?
test 1 -le 2 # число 1 равно или меньше, чем число 2?
echo $?

echo second
((1 + 2)) # результат вычисления не равен 0?
echo $?
((1 == 2)) # число 1 равно числу 2?
echo $?
((1 != 2)) # число 1 не равно числу 2?
echo $?
((1 > 2)) # число 1 больше чем число 2?
echo $?
((1 < 2)) # число 1 меньше, чем число 2?
echo $?
((1 >= 2)) # число 1 равно или больше, чем число 2?
echo $?
((1 <= 2)) # число 1 равно или меньше, чем число 2?
echo $?

```

Строки интерпретируются как 0, поэтому проверка условия возвращает ложно
```bash
y=abc
((y))
echo $?
```

###### Тестирование строк
`==` равенство
`!=` неравенство
`-z` пустая?
`-n` непустая?
`\>` больше?
`\<` меньше?
`-a` &&
`-o` ||
`=~` - сравнение по регулярному выражению

```bash
str1=abc
str2=acc
test $str1 == $str2
echo $?
test $str1 != $str2
echo $?

test -z $str1
echo $?
test -n $str2
echo $?

test "$str1" \< "$str2"
echo $?
test "$str1" \> "$str2"
echo $?

[[ "$str1" =~ a*cc ]]
echo $?
```

###### Выполнение по условию if elif else
Синтаксис if elif else
```bash
if ((2 + 2 == 4)) && [[ "abc" =~ a.c ]]; then
  echo first condition
elif [ -e theory.mdd ]; then
  echo second condition
else
  echo else section
fi
```

```bash
read name
if [[ -z $name ]]
then
echo "No name entered" >&2
exit 1 ## Set a failed return code
fi
```

```bash
printf "Enter a number not greater than 10: "
read number
if ((number > 10)); then
  printf "%d is too big\n" "$number" >&2
  exit 1
else
  printf "You entered %d\n" "$number"
fi

```

```bash
printf "Enter a number between 10 and 20 inclusive: "
read number
if ((number < 10)); then
  printf "%d is too low\n" "$number" >&2
  exit 1
elif ((number > 20)); then
  printf "%d is too high\n" "$number" >&2
  exit 1
else
  printf "You entered %d\n" "$number"
fi
```

###### Выполнение по условию && ||

```bash
directory=../../../../..
test -d "$directory" && cd "$directory"
ls
cd notexisted || echo "not existed"

```

###### Выполнение по условию case

```bash
a=abcd
b=bcd
case $a in
*$b*) true ;;
*) false ;;
esac
echo $?
```
Проверка - строка является числом?
```bash
string=20
case $string in
*[!0-9]*) false ;;
*) true ;;
esac
echo $?
```

```bash
case $# in
3) ;; ## We need 3 args, so do nothing
*)
  printf "%s\n" "Please provide three names" >&2
  exit 1
  ;;
esac

```

###### Wildcards
Более ограниченные, чем регулярные выражения
`*` - любое количество любых символов
`?` - один любой символ
`[abc]` - любой символ из списка
`[a-z]` - любой символ из диапазона
`[^abc]` - любой символ, не входящий в список



