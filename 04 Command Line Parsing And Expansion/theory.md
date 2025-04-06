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


