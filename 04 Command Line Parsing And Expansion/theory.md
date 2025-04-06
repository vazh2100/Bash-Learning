###### Цитирование
```bash
./sa \ this "is a" 'demonstration of' \ quotes\ and\ escapes
# \ this - | this|
# "is a" - |is a|
# 'demonstration of' = |demonstration of|
# \ quotes\ and\ escapes - | quotes and escapes|

```
Внутри одинарных кавычек двойные кавычки имеют буквальное значение. В одинарных кавычках экранированная кавычка не
работает. В одинарных кавычках весь текст понимается буквально, символ экранирования понимается буквально.
В одинарных кавычках можно применять одинарные кавычки, если перед начало поставить $ и экранировать одинарные кавычки.

Внутри двойных кавычек одинарные кавычки имеют буквальное значение. Можно применить двойные кавычки внутри двойных, если
их экранировать.

```bash
./sa "a double-quoted single quote, '" "a double-quoted double quote, \""
./sa 'a single-quoted double quotation mark, "'
./sa "First argument "'still the first argument'
./sa 'First argument ''still the first argument'
./sa "First argument ""still the first argument"
echo $'\'line1\'\n\'line2\''
./sa $'\'line1\'\n\'line2\''
./sa "Argument containing
a newline"

```

###### Распаковка фигурными скобками
```bash
./sa {one,two,three}
./sa {1..4}
./sa {4..1}
./sa {a..d}
./sa {d..a}
./sa {а..я}             # Кириллица не  поддерживается
./sa abc{a..d}efg       # Работает
./sa {{1..3},{a..c}}    # Вложенные "{}", раскрываются как одни
./sa {1..2}{a..b}{y..z} # Все возможные варианты (2*2*2)
./sa {001..13..4}       # Форматирование и шаг
./sa {c..k..4}          # С буквами шаг тоже работает

```

###### Распаковка тильдой
`~` - возвращает home директорию

```bash
./sa ~
./sa ~root
./sa ~vazh2100
./sa "~"     # Не работает
./sa "~root" # Не работает
./sa ~ciadpi

```

###### Распаковка параметров и переменных
```bash
var="whatever"
./sa "$var"
var=qwerty
./sa "${var}"

```
Повтор:
Shell Bourne может принимать только 9 позиционных параметра.
Bash может больше, только обращаться нужно к ним через фигурные скобки `${12}`

```bash
first=Jane
last=Johnson
./sa "$first_$last" "${first}_$last" # переменная first_ не объявлена, поэтому пусто

```


