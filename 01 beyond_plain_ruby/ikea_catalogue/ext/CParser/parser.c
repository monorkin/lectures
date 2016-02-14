#include "ruby.h"
#include <string.h>
#include <stdio.h>
#include <ctype.h>

/* Define module object */
VALUE CParser = Qnil;

/* Define functions */
void Init_CParser();
VALUE method_parse(VALUE self, VALUE file_path);
char *trimwhitespace(char *str);

/* Implement functions */
void Init_CParser() {
  CParser = rb_define_module("CParser");
	rb_define_method(CParser, "parse", method_parse, 1);
}

VALUE method_parse(VALUE self, VALUE file_path) {
  static int array_size = 255;
  FILE *fp;
  char str[array_size];
  char product[array_size];
  char description[array_size];
  double price;
  VALUE active_country;
  VALUE result = rb_hash_new();
  VALUE temp_hash;

  /* opening file for reading, if unable to raise an error */
  fp = fopen(RSTRING_PTR(file_path), "r");
  if(fp == NULL) {
    rb_raise(rb_eIOError, "file not found or unable to open");
  }

  /* Iterate through file */
  while( fgets(str, array_size, fp) != NULL ) {
    if (str[0] != ' ') {
      *str = *strtok(str, "\n");
      active_country = rb_str_new(str, strlen(str));
      if (TYPE(rb_hash_aref(result, active_country)) == T_NIL) {
        rb_hash_aset(result, active_country, rb_hash_new());
      }
    } else {
      sscanf(str, "  %[^:]: %[^(](%lf)\n", product, description, &price);
      *product = *trimwhitespace(product);
      *description = *trimwhitespace(description);
      temp_hash = rb_hash_new();
      rb_hash_aset(
        temp_hash,
        ID2SYM(rb_intern("description")),
        rb_str_new(description, strlen(description))
      );
      rb_hash_aset(
        temp_hash,
        ID2SYM(rb_intern("price")),
        DBL2NUM((double)price)
      );
      rb_hash_aset(
        rb_hash_aref(result, active_country),
        rb_str_new(product, strlen(product)),
        temp_hash
      );
    }
  }
  fclose(fp);

  return(result);
}

char *trimwhitespace(char *str)
{
  char *end;

  // Trim leading space
  while(isspace(*str)) str++;

  if(*str == 0)  // All spaces?
    return str;

  // Trim trailing space
  end = str + strlen(str) - 1;
  while(end > str && isspace(*end)) end--;

  // Write new null terminator
  *(end+1) = 0;

  return str;
}
