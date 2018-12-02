use super::input_reader;
use std::io::prelude::*;

pub fn run() -> std::io::Result<()> {
  let mut reader = input_reader::create("data/day-1.txt");
  let mut line = String::new();
  let mut current_freq: i32 = 0;

  while reader.read_line(&mut line)? > 0 {
    match line.trim().parse::<i32>() {
      Ok(num) => current_freq += num,
      Err(_) => continue,
    }

    line.clear();
  }

  println!("Current frequency: {}", current_freq);

  Ok(())
}
