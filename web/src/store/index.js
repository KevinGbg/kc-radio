import { createStore } from 'vuex'

const resourceid = (window).GetParentResourceid ? (window).GetParentResourceid() : 'edvin-tablet';

export default createStore({
  state: {
    Menu: true,

    on: true,

    settings: {
      anon: true,
      dark: true,
      size: '1',
    }
  },
  getters: {
  },
  mutations: {
  },
  actions: {
    Open(_commit, item) {
      this.state.Menu = true
      this.state.data = item.data
    },
    Close(){
      this.state.Menu = false
      post('Close', { }, (res) => {
        if (res) {

        } 
      });
    },
  },
  modules: {
  }
})

const post = (event, data, cb) => {
  if (event) {
    fetch(`https://${resourceid}/${event}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify(data || {}),
    })
      .then((resp) => resp.json())
      .then((resp) => {
        if (cb) {
          cb(resp);
        }
      });
  }
};
