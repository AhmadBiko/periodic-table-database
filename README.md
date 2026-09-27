# Periodic Table Database 🧪

A command-line application built for the freeCodeCamp Relational Databases certification. It uses a **Bash script** to query a **PostgreSQL database** and returns properties of chemical elements.

## Features
* Rebuilt and normalized an existing database to enforce strict data integrity (Constraints, Foreign Keys).
* Bash script (`element.sh`) accepts an atomic number, symbol, or name to fetch and display element data.
* Maintained using conventional Git version control.

## Usage
Run the script with an element as an argument:

```bash
./element.sh 1
./element.sh H
./element.sh Hydrogen
