use std::env;

// cargo run -- "$(cat data/day-1_1.txt)"
fn main() {
    let args: Vec<String> = env::args().collect();
    let freq_changes: Vec<&str> = args[1].split("\n").collect();
    let mut current_freq: i32 = 0;

    for change in freq_changes.iter() {
        let amount: i32 = match change.parse() {
            Ok(num) => num,
            Err(_) => 0,
        };

        current_freq += amount;
    }

    println!("Current frequency: {}", current_freq);
}
