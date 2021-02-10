import { Elm } from './Main.elm'

function initComments(config) {
  // get nullable session object from localstorage
  config['storedSession'] = JSON.parse(localStorage.getItem("cactus-session"));

  // make a comments section in DOM element `node`
  // initialize with provided config
  var app = Elm.Main.init({
    node: config['node'],
    flags: config
  });

  // subscribe to commands from localstorage port
  app.ports.storeSession.subscribe(s => localStorage.setItem("cactus-session", s));
}

window.initComments = initComments;
