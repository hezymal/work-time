import * as api from "../api";

async function print_version() {
    // TODO: get version from package.json
    console.log("WorkTime CLI v1.0");

    try {
        const response = await api.version();
        console.log(response.data);
    } catch (e) {
        console.error(e.response.data);
    }
}

export default print_version;
