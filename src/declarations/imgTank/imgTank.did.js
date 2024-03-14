export const idlFactory = ({ IDL }) => {
  const ImgId = IDL.Text;
  const HeaderField = IDL.Tuple(IDL.Text, IDL.Text);
  const Request = IDL.Record({
    'url' : IDL.Text,
    'method' : IDL.Text,
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HeaderField),
  });
  const StreamingCallbackToken = IDL.Record({
    'key' : IDL.Text,
    'index' : IDL.Nat,
    'content_encoding' : IDL.Text,
  });
  const StreamingCallbackResponse = IDL.Record({
    'token' : IDL.Opt(StreamingCallbackToken),
    'body' : IDL.Vec(IDL.Nat8),
  });
  const StreamingCallback = IDL.Func(
      [StreamingCallbackToken],
      [StreamingCallbackResponse],
      ['query'],
    );
  const StreamingStrategy = IDL.Variant({
    'Callback' : IDL.Record({
      'token' : StreamingCallbackToken,
      'callback' : StreamingCallback,
    }),
  });
  const Response = IDL.Record({
    'body' : IDL.Vec(IDL.Nat8),
    'headers' : IDL.Vec(HeaderField),
    'streaming_strategy' : IDL.Opt(StreamingStrategy),
    'status_code' : IDL.Nat16,
  });
  return IDL.Service({
    'getPic' : IDL.Func([ImgId], [IDL.Vec(IDL.Nat8)], ['query']),
    'getThumbnail' : IDL.Func([ImgId], [IDL.Vec(IDL.Nat8)], ['query']),
    'http_request' : IDL.Func([Request], [Response], ['query']),
    'uploadImg' : IDL.Func([ImgId, IDL.Vec(IDL.Nat8)], [], ['oneway']),
    'uploadThumbnail' : IDL.Func([ImgId, IDL.Vec(IDL.Nat8)], [], ['oneway']),
  });
};
export const init = ({ IDL }) => { return []; };
