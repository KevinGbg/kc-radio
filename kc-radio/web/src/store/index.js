import { createStore } from 'vuex'

const resourceid = (window).GetParentResourceid ? (window).GetParentResourceid() : 'kc-radio';
import router from '@/router/index'

export default createStore({
  state: {
    Menu: true,

    on: true,

    data: {
      name: "Hejsan",
      channel: 0
    },

    settings: {
      anon: true,
      dark: true,
      size: '1',
    },

    members: [
      'Dev Devsson',
      'Dev Devsson',
    ],

    volume: '100%'
  },
  getters: {
  },
  mutations: {
    increaseVolume(state) {
      const currentVolume = parseInt(state.volume);
      if (!isNaN(currentVolume) && currentVolume <= 95) {
        state.volume = `${currentVolume + 5}%`;
      } else {
        state.volume = '100%';
      }
    },
    
    decreaseVolume(state) {
      const currentVolume = parseInt(state.volume);
      if (!isNaN(currentVolume) && currentVolume >= 5) {
        state.volume = `${currentVolume - 5}%`;
      }
    },
  },
  actions: {
    Open(_commit, item) {
      this.state.Menu = true
      this.state.data = item.data
    },
    Close(){
      this.state.Menu = false
      post('Close');
    },
    JoinChannel(_commit, { frequency, cb}) {
      post('JoinChannel', {frequency: frequency}, (res)=> {
        if (res) {
          cb(true)
        } else {
          cb(false)
        }
      })
    },
    ToggleRadio(_commit, item) {
      post('ToggleRadio', item)
    } 
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
