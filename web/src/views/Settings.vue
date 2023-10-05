<template>
    <div class="side">
      <div class="pad">
        <v-card class="rounded-0" color="cards">
          <p class="text-h6 pb-0 pt-0 px-1">Settings</p>
          <div class="px-2">
            <p class="text-caption">General</p>
            <v-switch hide-details label="Anonymous" color="btn" v-model="isAnonymous" @click="toggleAnonymousSetting"></v-switch>
            <p class="text-caption">Style</p>
            <v-switch hide-details color="btn" v-model="darkMode" @click="toggleTheme" label="Darkmode"></v-switch>
            <v-slider thumb-label color="btn" v-model="size" min="0.5" max="1.5">
              <template v-slot:append>
                <span class="text-grey-lighten-1">Size</span>
              </template>
            </v-slider>
          </div>
        </v-card>
      </div>
    </div>
</template>

<script setup>
import { useTheme } from 'vuetify'
import { computed, onMounted } from 'vue'
import { useStore } from 'vuex'

const theme = useTheme()
const store = useStore()

const darkMode = computed(() => store.state.darkMode)
const isAnonymous = computed(() => store.state.settings.anon)
const size = computed({
  get: () => store.state.settings.size,
  set: (newSize) => {
    store.commit('updateSize', newSize)
  }
})

function toggleTheme () {
  theme.global.name.value = darkMode.value ? 'light' : 'dark'
  store.commit('toggleDarkMode')
}

function toggleAnonymousSetting() {
  store.commit('toggleAnonymous')
}
</script>
  
<style>

.v-input--density-default {
    --v-input-control-height: 38px!important;
}

.v-list {
    padding: 0!important;
}

.v-list-item--density-default:not(.v-list-item--nav).v-list-item--one-line {
    padding-inline-start: 0px!important;
    padding-inline-end: 0px!important;
}

.v-list-item--density-default.v-list-item--one-line {
    min-height: 41px!important;
    padding-top: 0px!important;
    padding-bottom: 0px!important;
}

</style>