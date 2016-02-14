#include "ruby.h"
#include <string.h>
#include <stdio.h>
#include <ctype.h>

/* Define module object */
VALUE Hello = Qnil;

/* Define functions */
void Init_Hello();
VALUE method_hello(VALUE self, VALUE name);

/* Implement functions */
void Init_Hello() {
  Hello = rb_define_module("Hello"); // Name of the module
	rb_define_method(Hello, "hello", method_hello, 1); // Name of the method
}

VALUE method_hello(VALUE self, VALUE name) {
  char hello[6] = "Hello ";
  char *result = malloc(strlen(hello) + strlen(RSTRING_PTR(name)) + 1);

  strcpy(result, hello);
  strcat(result, RSTRING_PTR(name));

  return(rb_str_new(result, strlen(result)));
}
