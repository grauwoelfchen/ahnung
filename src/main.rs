extern crate structopt;

use structopt::StructOpt;

/// Command line options.
#[derive(Debug, StructOpt)]
#[structopt(
    name = "ahnung",
    about = "\nAn utility command for AST Hash of Rust codes."
)]
struct Opts {
    /// Filename
    #[structopt(short = "f", long = "file", default_value = "")]
    file: String,
}

fn main() {
    let opts = Opts::from_args();
    println!("file: {file}", file = opts.file)
}
