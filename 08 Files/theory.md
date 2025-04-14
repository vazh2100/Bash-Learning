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
