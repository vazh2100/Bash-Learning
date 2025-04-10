###### Массивы. Доступ к элементам массива
`${BASH_VERSINFO[0]}` - доступ к элементу массива
`${BASH_VERSINFO[*]}` - все элементы массива в виде строки
`${BASH_VERSINFO[*]}` - все элементы массива в виде массива
`${BASH_VERSINFO[@]:1:2}` - получить первый и второй элемент массива
`${#BASH_VERSINFO[*]}` - длина массива
`${#BASH_VERSINFO[@]}` - длина массива
`${#BASH_VERSINFO[5]}` - длина переменной массива

```bash
printf "%s\n" "${BASH_VERSINFO[0]}"
printf "%s\n" "${BASH_VERSINFO[1]}"
./sa ${BASH_VERSINFO[*]}
./sa "${BASH_VERSINFO[*]}"
./sa "${BASH_VERSINFO[@]}"
./sa ${BASH_VERSINFO[@]}
printf "%s\n" "${BASH_VERSINFO[@]:1:2}"

printf "%s\n" ${#BASH_VERSINFO[*]}
printf "%s\n" ${#BASH_VERSINFO[@]}
printf "%s\n" ${#BASH_VERSINFO[5]}
```

###### Массивы. Присваивание элементов массива

```bash
name[0]=Aaron
name[42]=Adams
./sa ${name[@]}
```

Добавление элемента в конец массива
```bash
numbers[${#numbers[@]}]="1 $RANDOM"
numbers[${#numbers[@]}]="2 $RANDOM"
numbers[${#numbers[@]}]="3 $RANDOM"
numbers[${#numbers[@]}]="4 $RANDOM"
./sa "${numbers[@]}"
```

Более короткая версия
```bash
numbers+=("1 $RANDOM")
numbers+=("2 $RANDOM")
numbers+=("3 $RANDOM")
numbers+=("4 $RANDOM")
./sa "${numbers[@]}"

```

Заполнение массива во время создания
```bash
states=($RANDOM $RANDOM $RANDOM)
printf "%s\n" "${states[@]}"
```

###### Ассоциативные массивы
```bash
keys=(a b c d e) # Создание обычного массива
declare -A array # Объявление ассоциативного массива
for key in "${keys[@]}"; do
  array["$key"]=$RANDOM # Присваивание значения по ключу
done
for key in "${keys[@]}"; do
  echo $key ${array[$key]} # Получение значения по ключу
done
```

