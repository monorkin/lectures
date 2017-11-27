#include "ruby.h"

VALUE Demo = Qnil;
void Init_demo();
VALUE method_hello_world(int argc, VALUE *argv, VALUE self);

void Init_demo() {
	Demo = rb_define_module("Demo");
	rb_define_method(Demo, "hello_world", method_hello_world, -1);
}

VALUE method_hello_world(int argc, VALUE *argv, VALUE self) {
  if (argc == 0) {
    printf("Hello World!\n");
    return Qnil;
  }

  if (argc >= 1) {
    VALUE name = argv[0];
    printf("Hello %s\n", StringValueCStr(name));
    return Qnil;
  }

  return Qnil;
}
