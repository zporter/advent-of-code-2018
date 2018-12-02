use std::collections::BTreeSet;
use std::io::prelude::*;
use std::io::SeekFrom;

mod input_reader;

fn main() -> std::io::Result<()> {
    let mut reader = input_reader::create("data/day-1.txt");

    let mut line = String::new();
    let mut current_freq: i32 = 0;
    let mut frequencies: BTreeSet<i32> = BTreeSet::new();

    frequencies.insert(current_freq);

    loop {
        while reader.read_line(&mut line)? > 0 {
            match line.trim().parse::<i32>() {
                Ok(num) => current_freq += num,
                Err(_) => continue,
            };

            if !frequencies.insert(current_freq) {
                println!("Duplicate frequency: {}", current_freq);
                return Ok(());
            }

            line.clear();
        }

        reader.seek(SeekFrom::Start(0))?;
    }
}
