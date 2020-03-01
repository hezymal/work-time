import * as api from "../api";

function rename_unit({ parameters: [ident, name] }) {
    // TODO: handle error
    api.rename(ident, name).then(({ status, data: unit }) => {
        if (status === 204) {
            console.log(`Unit ${ident} not found`);
        } else {
            console.log(`Unit #${ident} was renamed to ${unit.name}`);
        }
    });
}

export default rename_unit;
