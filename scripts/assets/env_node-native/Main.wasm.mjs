import fs from "fs";
export default fs.promises.readFile("compiled.wasm").then(bufferSource => WebAssembly.compile(bufferSource));
