import { createStore } from 'vuex'

const resourceid = (window).GetParentResourceid ? (window).GetParentResourceid() : 'kc-radio';
import router from '@/router/index'

export default createStore({
  state: {
    Menu: false,

    on: true,

    data: {
      name: "Hejsan",
      channel: 0,
      text: "Test",
      volume: '100',
      members: [
        'Dev Devsson',
        'Dev Devsson',
      ],
    },

    darkMode: false,

    settings: {
      anon: false,
      dark: false,
      size: '1',
    },
  },
  getters: {
  },
  mutations: {
    increaseVolume(state) {
      const currentVolume = parseInt(state.data.volume);
      if (!isNaN(currentVolume) && currentVolume <= 95) {
        state.data.volume = `${currentVolume + 5}%`;
      } else {
        state.data.volume = '100%';
      }

      this.dispatch('setVolume', state.data.volume);
    },
    decreaseVolume(state) {
      const currentVolume = parseInt(state.data.volume);
      if (!isNaN(currentVolume) && currentVolume >= 5) {
        state.data.volume = `${currentVolume - 5}%`;
      }

      this.dispatch('setVolume', state.data.volume);
    },
    toggleAnonymous(state) {
      state.settings.anon = !state.settings.anon;
      post('savesettings', { anon: state.settings.anon, size: state.settings.size })
    },
    updateSize(state, newSize) {
      state.settings.size = newSize;
      post('savesettings', { anon: state.settings.anon, size: state.settings.size })
    },
    toggleDarkMode(state) {
      state.darkMode = !state.darkMode;
    },
  },
  actions: {
    Open(_commit, item) {
      this.state.Menu = true
      this.state.data = item.data
      this.state.settings = item.settings
    },
    Close(){
      this.state.Menu = false
      post('Close');
    },
    JoinChannel(_commit, { frequency, cb}) {
      post('JoinChannel', {frequency: frequency}, (res)=> {
        if (res) {
          cb(res)
        } else {
          cb(false)
        }
      })
    },
    ToggleRadio(_commit, item) {
      post('ToggleRadio', item)
    },
    setVolume(_commit, item) {
      post('setVolume', item)
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
