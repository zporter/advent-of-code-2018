use std::env;
use std::io::{Error, ErrorKind};

mod day_1;
mod day_2;
mod input_reader;

fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();

    match args[1].as_str() {
        "day-1-1" => day_1::freq_calc::run(),
        "day-1-2" => day_1::dup_freq::detect(),
        "day-2-1" => day_2::box_id_checksum::run(),
        _ => Err(Error::new(ErrorKind::InvalidInput, "invalid argument")),
    }
}
