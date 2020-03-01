import * as api from "../api";

function stop_unit(command) {
    const ident = command.parameters[0];

    // TODO: handle error
    api.stop(ident)
        .then(() => console.log(`${ident} was stopped`));
}

export default stop_unit;
