<template>
  <div class="side">
    <div class="pad">
      <v-card class="px-1 rounded-0" color="cards">
        <div class="d-flex justify-space-between align-center">
          <div>
            <p class=" text-h6 pt-2" style="line-height: 1rem!important;">
              My Status
            </p>
            <p>
              En Route
            </p>
          </div>
          <div>
            <v-icon class="px-2">
              mdi-calendar
            </v-icon>
            <v-tooltip
              activator="parent"
              location="start"
            >{{ formattedDate }}</v-tooltip>
          </div>
        </div>
      </v-card>
    </div>
    <div class="pad">
      <v-card
        style="border-left: 7px solid white;"
        class="pa-1 rounded-0" 
        height="123"
        color="cards"
      >
        <div style="gap: 5px;" class="d-flex">
          <v-icon size="15">
            mdi-network-strength-3
          </v-icon>
          <v-icon size="15">
            mdi-wifi
          </v-icon>
          <v-icon size="15">
            mdi-access-point
          </v-icon>
        </div>
        <div style="line-height: 1rem!important;" class="text-h6 pt-2">
          In Radio
        </div>
        <div class="text-caption d-flex justify-space-between">
          <p>
            Channel: {{ $store.state.data.channel }}
          </p>
          <div class="bar d-flex align-end">
            <v-divider :thickness="2" vertical></v-divider>
            <div @click="$router.push('/members')">
              <v-icon style="bottom: 0px;" size="40" class="pa-3">
                mdi-account-multiple
              </v-icon>
              <v-tooltip
                activator="parent"
                location="start"
              >Members</v-tooltip>
            </div>
          </div>
        </div>
      </v-card>
    </div>
    <div class="pad">
      <v-card
        class="px-0 rounded-0" 
        color="cards"
      >
        <v-card-title style="line-height: 1rem!important;" class="pt-2 pa-0 px-1 text-subtitle-1">
          Welcome {{ $store.state.data.name }}
        </v-card-title>
        <v-card-subtitle class="pa-0 text-caption px-1">
          Where are we heading?
        </v-card-subtitle>
        <v-divider :thickness="2">

        </v-divider>
        <div class="d-flex justify-space-evenly">
          <v-hover v-slot="{ isHovering, props }">
            <div @click="$router.push('/settings')" v-bind="props" v-ripple class="text-center wid" style="display: block;">
              <v-icon>
                mdi-cog
              </v-icon>
              <v-expand-transition>
                <p class="text-caption" v-if="isHovering">
                  Settings
                </p>
              </v-expand-transition>
            </div>
          </v-hover>
          <v-divider vertical>

          </v-divider>
          <v-hover v-slot="{ isHovering, props }">
            <div @click="$router.push('/connect')" v-bind="props" v-ripple class="text-center wid" style="display: block;">
              <v-icon>
                mdi-phone
              </v-icon>
              <v-expand-transition>
                <p class="text-caption" v-if="isHovering">
                  Join
                </p>
              </v-expand-transition>
            </div>
          </v-hover>
        </div>
      </v-card>
    </div>
  </div>
</template>

<script>

export default {
  data() {
    return {

    };
  },
  computed: {
    formattedDate() {
      const options = { weekday: 'short', month: 'short', day: 'numeric', year: 'numeric' };
      return new Date().toLocaleDateString('en-US', options);
    },
  },
};
</script>
