{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Name for the shell environment
  name = "my-python-env";

  # Define build inputs (system packages, including Python and its libraries)
  buildInputs = [
    pkgs.python311 # Use a specific Python version (e.g., 3.11)
    (pkgs.python311.withPackages (ps: [
      ps.pandas    # Example library 1
      ps.requests  # Example library 2
      # Add other packages here in the format ps.<package-name>
    ]))
  ];

  # Optional: Define actions to take when entering the shell
  shellHook = ''
    echo "Welcome to the NixOS Python environment!"
    # You can add other setup commands here
  '';
}
