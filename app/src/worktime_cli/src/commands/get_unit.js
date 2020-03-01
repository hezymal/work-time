import * as api from "../api";

async function get_unit({ parameters: [ident] }) {
    try {
        const response = await api.get_unit(ident);
        const { unit, transitions } = response.data;

        console.log(`name: ${unit.name}\ninserted_at: ${unit.inserted_at}`);
        transitions.forEach(t => console.log(`\t${t.kind} -> ${t.inserted_at}`));
    } catch (e) {
        console.error(e.response.data);
    }
}

export default get_unit;
