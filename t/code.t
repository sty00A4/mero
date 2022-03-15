set @f <func {str <randint 0 9>}>
set @code ""
repeat 16 <
    set @code <con @code <@f()>>
>
print @code
