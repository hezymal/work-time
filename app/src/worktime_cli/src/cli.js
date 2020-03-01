import arg from "arg";
import "./init_axios";
import print_help from "./commands/print_help";
import print_version from "./commands/print_version";
import start_unit from "./commands/start_unit";
import stop_unit from "./commands/stop_unit";
import list_units from "./commands/list_units";
import remove_unit from "./commands/remove_unit";
import rename_unit from "./commands/rename_unit";
import get_unit from "./commands/get_unit";

function parse_args_to_command(args) {
    const parsed_args = arg(
        {
            "--help": Boolean,
            "--version": Boolean,
            "-v": "--version",
            "-h": "--help"
        },
        {
            argv: args.slice(2)
        }
    );

    if (parsed_args["--help"]) {
        return { name: "help" };
    }

    if (parsed_args["--version"]) {
        return { name: "version" };
    }

    return {
        name: parsed_args._[0],
        parameters: parsed_args._.slice(1) // TODO: add validation for required arguments
    };
}

async function execute_command(command) {
    switch (command.name) {
        case "version":
            print_version();
            break;

        case "help":
            print_help();
            break;

        case "start":
            start_unit(command);
            break;

        case "stop":
            stop_unit(command);
            break;

        case "rename":
            rename_unit(command);
            break;

        case "ls":
        case "list":
            list_units(command);
            break;

        case "rm":
        case "remove":
            remove_unit(command);
            break;

        case "get":
            await get_unit(command);
            break;
    }
}

export function cli(args) {
    const command = parse_args_to_command(args);
    console.log(command); // TODO: remove line
    execute_command(command); // TODO: this function is async
}
