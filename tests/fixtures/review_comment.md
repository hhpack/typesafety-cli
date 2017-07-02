Type check error found in your pull request.

* [ ] **fixtures/Example1.txt**

	This method is not declared as abstract, it must have a body

	```hack
	5:
	6:    public function __construct(T $)
	                      ^^^^^^^^^^^
	7:    {
	```

	https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

* [ ] **fixtures/Example1.txt**

	Unbound name: T (an object type)

	```hack
	5:
	6:    public function __construct(T $)
	                                  ^
	7:    {
	```

	https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

* [ ] **fixtures/Example1.txt**

	You probably forgot to bind this type parameter right?
	Add <T> somewhere (after the function name definition, or after the class name)
	Examples: function foo<T> or class A<T>

	```hack
	5:
	6:    public function __construct(T $)
	                                  ^
	7:    {
	```

	https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6

* [ ] **fixtures/Example1.txt**

	Expected variable

	```hack
	5:
	6:    public function __construct(T $)
	                                    ^
	7:    {
	```

	https://github.com/holyshared/typesafety/blob/master/fixtures/Example1.txt#L6
