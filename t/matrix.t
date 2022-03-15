set @matrix [ [ 1, 2, 3 ], [ 4, 5, 6 ], [7, 8, 9] ]
set @space <int <input>>
var @y 0
repeat <len @matrix> <
    var @x 0
    repeat <len <@matrix 0>> <
        write <<@matrix @y> @x>
        repeat @space <
            write " "
        >
        inc @x
    >
    print ""
    repeat @space <
        print ""
    >
    inc @y
>
