#[allow(unused_imports)]
#[macro_use]
extern crate structopt;

use std::process;

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

    let s = ahnung::read_file(&opts.file);
    match s {
        Ok(content) => println!("{}", content),
        Err(e) => panic!(e),
    };
}
