use super::input_reader;
use std::io::prelude::*;

use std::collections::BTreeMap;

pub fn run() -> std::io::Result<()> {
  let mut reader = input_reader::create("data/day-2.txt");
  let mut line = String::new();
  let mut two_count: u32 = 0;
  let mut three_count: u32 = 0;

  while reader.read_line(&mut line)? > 0 {
    let letter_counts: Vec<u32> = count_letters(line.trim()).values().cloned().collect();

    if letter_counts.contains(&2) {
      two_count += 1;
    }

    if letter_counts.contains(&3) {
      three_count += 1;
    }

    line.clear();
  }

  let checksum = two_count * three_count;

  println!("Checksum: {}", checksum);

  Ok(())
}

fn count_letters(box_id: &str) -> BTreeMap<char, u32> {
  let mut count: BTreeMap<char, u32> = BTreeMap::new();

  // count the number of occurrences of letters in the vec
  for letter in box_id.chars() {
    *count.entry(letter).or_insert(0) += 1;
  }

  count
}
