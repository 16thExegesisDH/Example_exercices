#pour les données de marion, j'ai modifier la fonction dans ordre_files.py  FG
# chemin vers le fichier modifier : PipeLine_marion/PYTHON/alto2tei/content/scripts/src/*

import subprocess

def main():
    # Define the command to be executed
    command = [
        "python",
        "content/scripts/alto2tei.py",
        "--config",
        "content/config.yml",
        "--version",
        "4.1.3",
        "--header",
        "--sourcedoc",
        "--body"
    ]

    try:
        # Run the command and capture output
        result = subprocess.run(command, check=True, text=True, capture_output=True)
        print("Command executed successfully:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print("Error while executing command:")
        print(e.stderr)

if __name__ == "__main__":
    main()
