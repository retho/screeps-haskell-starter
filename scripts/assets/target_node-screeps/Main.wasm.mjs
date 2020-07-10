import fs from "fs";
export default Promise.resolve(new WebAssembly.Module(fs.readFileSync("compiled.wasm")));
