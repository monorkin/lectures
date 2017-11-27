#[macro_use]
extern crate helix;

ruby! {
    class Demo {
        def hello_world(name: Option<String>) {
            let name = match name {
                Some(string) => string,
                _ => "World".to_string()
            };

            println!("Hello {}", name);
        }
    }
}
