import * as api from "../api";

function list_units() {
    // TODO: handle error
    api.list_units().then(({ data: units }) => {
        console.log("- --------\n" + "# name\n" + "- --------");
        units.forEach(unit => console.log(`${unit.id} ${unit.name}`));
        console.log("- --------");
    });
}

export default list_units;
