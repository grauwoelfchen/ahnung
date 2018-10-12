#[allow(unused_imports)]
#[macro_use]
extern crate structopt;

use std::process;
use std::path::Path;

use structopt::StructOpt;

/// Command line options.
#[derive(StructOpt)]
#[structopt(
    name = "ahnung",
    about = "\nAn utility command for AST Hash of Rust codes."
)]
struct Opts {
    /// Filename
    #[structopt(short = "f", long = "file")]
    file: String,
}

fn main() {
    let opts = Opts::from_args();
    if opts.file == "" {
        eprintln!("file path required");
        process::exit(1);
    }

    let path = Path::new(&opts.file);
    if !path.exists() {
        eprintln!("file does not exist");
        process::exit(1);
    }

    println!("path: {path}", path = path.to_string_lossy());
}
