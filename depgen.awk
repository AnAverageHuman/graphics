#!/usr/bin/gawk -f
BEGINFILE {
    sub(s, o, FILENAME);
    sub(".for", ".o", FILENAME)
    printf("%s:", FILENAME);
}

toupper($1) ~ "USE" && NF == 2 { printf " %s%s.o", o, tolower($2) }

END { print }

