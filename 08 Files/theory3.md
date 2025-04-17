###### Shell опции для распаковки имён файлов
`shopt -s` - включить опцию
`shopt -u` - выключить опцию

`nullglob` - если нет совпадения, то возвращает пустое значение, а не само расширение(по умолчанию)
`failglob` - если нет совпадения, то высвечивает ошибку
`dotglob`  - включает в распаковку файлы и папки, начинающиеся с точки
`nocaseglob` - считает строчную и заглавную буквы одной и той же буквой
`globstar` - включает `**` - поиск подходящих файлов внутри вложенных папок
`extglob`  - включает 5 дополнительных wildcards оператора

```bash
mkdir glob_fest && cd glob_fest && touch {a..f}{0..9}{t..z}$RANDOM .{a..f}{0..9}$RANDOM
```

```bash
cd glob_fest
../sa *xy
shopt -s nullglob
../sa *xy
```

```bash
cd glob_fest
../sa *xy
shopt -s failglob
../sa *xy
```

По умолчанию папки и файлы, начинающиеся с точки не учитываются в распаковке. `dotglob` исправляет эту ситуацию
```bash
cd glob_fest
../sa * | wc -l
../sa .* | wc -l
shopt -s dotglob
../sa * | wc -l
```

###### extglob
`?(PATTERN)` - 0 или 1 совпадение
`*(PATTERN)` - 0 и более совпадений
`@(PATTERN)` - 1 совпадение ровно
`+(PATTERN)` - 1 и более совпадение
`!(PATTERN)` - подходит всё, кроме совпадения

```bash
mkdir beatles
cd beatles
touch {john,paul,george,ringo}{john,paul,george,ringo}{1,2}$RANDOM {john,paul,george,ringo}{1,2}$RANDOM{,,} {1,2}$RANDOM{,,,}
```

```bash
cd beatles

shopt -s extglob
echo '?'
../pr4 ?(john|paul)2*
echo '*'
../pr4 *(john|paul)2*
echo '@'
../pr4 @(john|paul)2*
echo '+'
../pr4 +(john|paul)2*
echo '!'
../pr4 !(john|paul)2*
```




