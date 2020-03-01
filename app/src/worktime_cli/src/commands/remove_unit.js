import * as api from "../api";

function removeUnit({ parameters: [ident] }) {
    // TODO: handle error
    api.remove(ident).then(({ status, data: unit }) => {
        if (status === 204) {
            console.log(`Unit ${ident} not found`);
        } else {
            console.log(`#${unit.id} ${unit.name} was removed`);
        }
    });
}

export default removeUnit;
