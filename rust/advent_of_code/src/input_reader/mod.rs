use std::fs::File;
use std::io::BufReader;

pub fn create(file_name: &str) -> BufReader<File> {
  let file = File::open(file_name).expect("Opening file");

  BufReader::new(file)
}
