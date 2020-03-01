import axios from 'axios';

export const version = () => axios.get("/api/version");

export const get_unit = (ident) => axios.get(`/api/${ident}`);

export const list_units = () => axios.get("/api/list");

export const start_unit = (ident) => axios.post("/api/start", { ident });

export const stop_unit = (ident) => axios.put("/api/stop", { ident });

export const remove_unit = (ident) => axios.delete(`/api/remove/${ident}`);

export const rename_unit = (ident, name) => axios.put(`/api/rename/${ident}/to/${name}`);
