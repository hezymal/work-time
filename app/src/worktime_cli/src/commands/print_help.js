function print_help() {
    console.log(
        "\nUsage: worktime <command> [-v] [-h]" +
        "\n" +
        "\nArguments:" +
        "\n  -v --version           display version" +
        "\n  -h --help              display this text" +
        "\n" +
        "\nCommands:" +
        "\n  list                   display all of time units" +
        "\n  help                   display this text" +
        "\n  version                display version" +
        "\n  remove <ident>         remove time unit, where <ident> is a name or id" +
        "\n  rename <ident> <name>  rename time unit, where <ident> is a name or id, <name> is a new name" +
        "\n  start <ident>          start time unit, where <ident> is a name or id" +
        "\n  stop <ident>           stop time unit, where <ident> is a name or id" +
        "\n  transitions <ident>    display all transitions at <ident> time unit, where <ident> is a name or id" +
        "\n"
    );
}

export default print_help;
