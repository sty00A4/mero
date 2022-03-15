set @hex ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "e", "f"]
set @code ""
repeat <len @hex> <
    set @code <con @code <@hex <randint <len @hex>>>>
>
@code
