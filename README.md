# Mero
A minimalistic operating system for the minecraft mod cc tweaked

### Content
- `turt` a programming language for cc tweaked turtles (file format is `.t`)
  - `tedit` a program for editing in the turt language
- `libs/` usefull libraries:
  - `gui` a cc tweaked gui renderer module
  - `ext` a module which extends lua's and craft os apis's functions
  - `chars` a module which gives every unicode character usable in craft os a name for easy use
- `redweb` a program that pretty much adds internet into minecraft using the built-in `rednet` and the `gui.lua` module
  - `web` a program for accessing/searching/creating redweb websites

---

### Turt

#### Introduction
turt is a dynamically typed language which uses an operation concept. That means a **turt** program is just a collection of operations being executed after one another.
here is a basic example:
  ```
  set @a 1
  print @a
  ```
first it sets the **tag** `@a` to the **integer** `1` with the `set` **operator**. **Tags**, known in other languages as **variables**, can be asigned a **value** and have to be prefix with `@` for clarity reasons. Next the **value** of `@a` will be printed to the console with the `print` **operator**.
  
  So now we know there are 4 types of tokens in turt:
  - **operation** (seperated by a line-break or `;`)
  - **operators** (ex.: `print`)
  - **tags** (prefixed with `@`)
  - **values**

#### Operations
Now let's come to some more usefull **operators** like `while`, `repeat` or `if`. But before that, you should know the most important expretions in turt:

`<` and `>`

Those two define a whole new collection of **operations**, so that makes the whole script an **operation collection** like stated before.
What you also need to know is that if you don't put an operator at the start of an **operation** but just a value like `< 1 >` for example, that'll return you `1`. and now knowing that the whole script is just a collection of **operations** means that the following is a valid turt script:

```
"hello"
```

if you execute this, it'll print `exit: "hello"` because you returned the string `hello`. That also means anything you type after that `"hello"` will never be reached.

combining that knowledge we can write a simple program that asks for user input and returns `true` if the input is `"yes"` and `false` if the user input is `"no"` or anything else.

for that we need to know what **booleans** are:
**booleans** can only have 1 of 2 values, `true` or `false`.
**booleans** are used in operators like `if` or `while`:

```
if true <
  "this statement is true"
>
```
