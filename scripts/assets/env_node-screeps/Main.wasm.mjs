import fs from "fs";
export default new WebAssembly.Module(fs.readFileSync("compiled.wasm"));
