import * as api from "../api";

function start_unit(command) {
    const ident = command.parameters[0];
    api.start_unit(ident).then(() => console.log(`${ident} was started`));
}

export default start_unit;
