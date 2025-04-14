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

###### Поиск совпадения независимо от регистра

```bash
read ok
case $ok in
  y | Y) echo "Great!" ;;
  n | N)
    echo Good-bye
    exit 1
    ;;
  *) echo Invalid entry ;;
esac
```

```bash
read ok
case $ok in
  [yY]) echo "Great!" ;;
  [nN])
    echo Good-bye
    exit 1
    ;;
  *) echo Invalid entry ;;
esac
```

```bash
read month_name
lower_cased=${month_name,,}
case $lower_cased in
  jan*) month=1 ;;
  feb*) month=2 ;;
  dec*) month=12 ;;
  [1-9] | 1[0-2]) month=$month_name ;; ## accept number if entered
  *) echo "Invalid month: $month_name" >&2 ;;
esac
echo $month
```

Валидация переменных
```bash
validate_name() case $1 in
  [!a-zA-Z_]* | *[!a-zA-Z0-9_]*) return 1 ;;
esac

for name in name1 2var first.name first_name last-name; do
  validate_name "$name" && echo "  valid: $name" || echo "invalid: $name"
done
```

###### Вставка, замена, удаление

Вставка одних строк в другие
```bash
# bashsupport disable=BP2001
insert_string() { # insert_string STRING INSERTION [POSITION]
  local string=$1
  local string_to_insert=$2
  local insert_position=${3:-1}
  local left right
  local insert_string_result
  left=${string:0:$insert_position}
  right=${string:$insert_position}
  insert_string_result=${left}${string_to_insert}${right}
  echo $insert_string_result
}
insert_string JohnConor " Michailovich " 4
```

Вставка с переписыванием
```bash
overlay() { #@ USAGE:  overlay STRING SUBSTRING START
  local string=$1
  local overlay=$2
  local overlay_position=$3
  local left right
  local overlay_result
  left=${string:0:overlay_position} # Здесь знак доллара и {} не обязательны, как и $(())
  right=${string:overlay_position+${#overlay}}
  overlay_result=$left$overlay$right
  echo $overlay_result
}
overlay Andromeda "ey and Alex" 4
```

Обрезка неугодных символов
```bash
var="   John    "
while :; do
  case $var in
    ' '*) var=${var#?} ;;
    *' ') var=${var%?} ;;
    *) break ;;
  esac
done
./sa "$var"
```

```bash
var="   John    "
right_spaces=${var##*[! ]}
var=${var%"$right_spaces"}
left_spaces=${var%%[! ]*}
var=${var#"$left_spaces"}
./sa "$var"

```

```bash
var="   John    "
var="${var#"${var%%[! ]*}"}" 
var="${var%"${var##*[! ]}"}"
./sa "$var"
```

```bash
trim() {
  local input="$1"
  local char_to_trim="${2:- }"

  local trailing="${input##*[!$char_to_trim]}"
  input="${input%"$trailing"}"

  local leading="${input%%[!$char_to_trim]*}"
  input="${input#"$leading"}"
  trim_result=$input
}
trim "  aabbaaJohnaababaa  " "ab "
./sa "$trim_result"
```

```bash
index() { #@ Store position of $2 in $1 in $_INDEX
  local idx
  index_result=
  case $1 in
    "")
      index_result=0
      return 1
      ;;
    *"$2"*)
      idx=${1%%"$2"*}
      index_result=$((${#idx} + 1))
      ;;
    *)
      index_result=0
      return 1
      ;;
  esac
}

month2num() {
  local months=JAN.FEB.MAR.APR.MAY.JUN.JUL.AUG.SEP.OCT.NOV.DEC
  local input=${1:0:3}
  input=${input^^}

  index "$months" "$input" || return 1
  month2num_result=$(($index_result / 4 + 1))
}

month2num december
echo $month2num_result
```
