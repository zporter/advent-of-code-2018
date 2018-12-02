use std::collections::BTreeSet;
use std::fs::File;
use std::io::prelude::*;
use std::io::BufReader;
use std::io::SeekFrom;

fn main() -> std::io::Result<()> {
    let input = File::open("data/day-1.txt")?;
    let mut reader = BufReader::new(input);

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
