fn main() {
    let name = match get_name() {
        Some(name) => name,
        _ => return println!("ERROR: No name given!")
    };

    let message = match build_message(name) {
        Ok(message) => message,
        Err(error) => return println!("ERROR: {}", error)
    };

    println!("{} - {}", name, message)
}

fn get_name() -> Option<String> {
}

fn build_message() -> Result<String, String> {
}
