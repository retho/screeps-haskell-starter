import 'fast-text-encoding';

const FastTextDecoder = global.TextDecoder;

global.TextDecoder = class TextDecoderPolyfill extends FastTextDecoder {
  constructor(enc, opts) {
    const {fatal, restOpts} = opts || {};
    super(enc, opts && restOpts);
  }
}
