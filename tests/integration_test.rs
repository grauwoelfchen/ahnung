#[cfg(test)]
mod integration_test {
    use std::process::Command;

    #[test]
    fn test_missing_option_argument() {
        let output = Command::new("./target/debug/ahnung")
            .arg("--file")
            .output()
            .unwrap();

        assert!(String::from_utf8_lossy(&output.stderr).contains("error:"));
        assert_eq!(String::from_utf8_lossy(&output.stdout), "");
    }

    #[test]
    fn test_file_not_found() {
        let output = Command::new("./target/debug/ahnung")
            .arg("-f")
            .arg("unknown")
            .output()
            .unwrap();

        assert!(String::from_utf8_lossy(&output.stderr)
            .contains("file does not exist"));
        assert_eq!(String::from_utf8_lossy(&output.stdout), "");
    }

    #[test]
    fn test_run_with_require_valid_options() {
        let mut output;

        output = Command::new("./target/debug/ahnung")
            .arg("-f")
            .arg("Cargo.toml")
            .output()
            .unwrap();

        assert_eq!(String::from_utf8_lossy(&output.stderr), "");
        assert!(String::from_utf8_lossy(&output.stdout).contains("[package]"));

        output = Command::new("./target/debug/ahnung")
            .arg("--file")
            .arg("Cargo.toml")
            .output()
            .unwrap();

        assert_eq!(String::from_utf8_lossy(&output.stderr), "");
        assert!(String::from_utf8_lossy(&output.stdout).contains("[package]"));
    }
}
