use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;

fn main() -> std::io::Result<()> {
    let input = File::open("data/day-1.txt")?;
    let mut reader = BufReader::new(input);

    let mut line = String::new();
    let mut current_freq: i32 = 0;

    while reader.read_line(&mut line)? > 0 {
        match line.trim().parse::<i32>() {
            Ok(num) => current_freq += num,
            Err(_) => continue,
        };

        line.clear();
    }

    println!("Current frequency: {}", current_freq);

    Ok(())
}
