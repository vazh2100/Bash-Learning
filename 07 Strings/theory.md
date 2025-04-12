###### Слияние строк
`+=`
`time` - вывод времени потраченный на конвейер
```bash
var=abc
var2=def
var+="$var2"
var+=def
echo "$var"
```

```bash
var=
time for i in {1..100000}; do
  var=${var}foo
done

# Быстрее в 60-250 раз
var=
time for i in {1..100000}; do
  var+=foo
done
```

###### Работа с символами
```bash
var=strip
all_but_first=${var#?}
all_but_last=${var%?}
./sa "$all_but_first" "$all_but_last"
first=${var%"$all_but_first"}
last=${var#"$all_but_last"}
./sa "$first" "$last"
```
Можно то ведь по индексу обрезать и сначала и с конца...
```bash
var=strip
first=${var:0:1}
last=${var: -1:1}
./sa "$first" "$last"

# Ещё один способ получить первый символ
printf -v first "%c" "$var"
./sa $first
```

```bash
word=strip
while [ -n "$word" ]; do
  char=${word:0:1}
  echo $char
  word=${word:1}
done

```
```bash
word=strip
word_length=${#word}
for i in $(seq 0 $((word_length - 1))); do
  echo "${word:$i:1}"
done

for ((i = 0; i < word_length; i++)); do
  echo "${word:$i:1}"
done
```

```bash
reverse_string() {
  local string="$1"
  local result=""
  for ((i = ${#string} - 1; i >= 0; i--)); do
    result+="${string:i:1}"
  done
  echo "$result"
}

reverse_string strip
```

```bash
title=" für èlisé"
echo ${title^^}
```