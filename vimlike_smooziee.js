with(KeyEvent){
  add(['z','i'],Zoom['in']  );
  add(['z','o'],Zoom.out    );
  add(['z','m'],Zoom.more   );
  add(['z','r'],Zoom.reduce );
  add(['z','z'],Zoom.reset  );

  add([']',']'],Page.next   );
  add(['[','['],Page.prev   );

  add(['g','g'],Scroll.top  );
  add(['G'], Scroll.bottom  );
  add(['0'], Scroll.first   );
  add(['$'], Scroll.last    );
  add(['j'], Scroll.up      );
  add(['k'], Scroll.down    );
  add(['l'], Scroll.left    );
  add(['h'], Scroll.right   );

  add(['r'],   Tab.reload   );
  add(['R'],   Tab.reloadAll);
  add(['d'],   Tab.close    );
  add(['u'],   Tab.reopen   );
  add(['C-p'], Tab.prev     );
  add(['C-n'], Tab.next     );

  add(['H'], History.back   );
  add(['L'], History.forward);

  add(['g','i'], Util.focusFirstTextInput);
  add(['C-z'],   disableVimlike);

  // Edit Mode
  add(['Esc'], Util.blurFocus, true);

  add(['C-w'], Util.deleteBackwardWord, true);
  add(['C-h'], Util.deleteBackward, true);
  add(['C-d'], Util.deleteForward, true);

  add(['C-a'], Util.moveFirstOrSelectAll, true);
  add(['C-e'], Util.moveEnd, true);

  //add(['C-u'], Util.moveEnd, true); // delete to begin
  //add(['C-k'], Util.moveEnd, true); // delete to end
}

function disableVimlike(){
  //TODO Add Notice
  localStorage._disableVimlike = true;
}

//function runLastSetting(){
//  if(document.body){
//    if(localStorage.disableVimlike){ passMode(); }
//    if(localStorage.vimlike_zoom){ setZoom(localStorage.vimlike_zoom); }
//  }else{
//    setTimeout(runLastSetting,100);
//  }
//}
//runLastSetting();
