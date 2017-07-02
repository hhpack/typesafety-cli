# Type checking errors

## File: fixtures/Example1.txt

This method is not declared as abstract, it must have a body

```
5:
6:    public function __construct(T $)
                      ^^^^^^^^^^^
7:    {
```

https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

## File: fixtures/Example1.txt

Unbound name: T (an object type)

```
5:
6:    public function __construct(T $)
                                  ^
7:    {
```

https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

## File: fixtures/Example1.txt

You probably forgot to bind this type parameter right?
Add <T> somewhere (after the function name definition, or after the class name)
Examples: function foo<T> or class A<T>

```
5:
6:    public function __construct(T $)
                                  ^
7:    {
```

https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

## File: fixtures/Example1.txt

Expected variable

```
5:
6:    public function __construct(T $)
                                    ^
7:    {
```

https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6
