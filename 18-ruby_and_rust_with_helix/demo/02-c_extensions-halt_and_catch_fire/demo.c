#include "ruby.h"

VALUE Demo = Qnil;
void Init_demo();
VALUE method_halt_and_catch_fire(VALUE self);

void Init_demo() {
	Demo = rb_define_module("Demo");
	rb_define_method(Demo, "halt_and_catch_fire", method_halt_and_catch_fire, 0);
}

VALUE method_halt_and_catch_fire(VALUE self) {
  printf("🚨 🔥 🔥 🔥 🚨\n");
  char *s="hello world";
  *s='H';
  return Qnil;
}
