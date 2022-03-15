set @num <randint 1 10>
set @exit false
set @try 0
print "number from 1-10 was chosen"
while <not @exit> <
    inc @try
    var @guess <int <input>>
    if <big @guess @num> <print "guess is bigger than number">
    if <less @guess @num> <print "guess is smaller than number">
    if <or <eq @guess @num> <eq @try 5>> <set @exit true>
>
if <eq @try 5> <print "you ran out of tries"> else <print "correct!!!">
