<template>
  <v-app>
    <v-img class="pos" cover max-height="800" width="340" src="./assets/motorola.png">
      <v-card class="display" color="blue-lighten-4">
        <v-system-bar height="32" style="position: relative!important;" color="grey-darken-3">
          <v-icon icon="mdi-bluetooth" class="ms-1"></v-icon>
  
          <v-icon icon="mdi-battery" class="ms-1"></v-icon>
  
          <span class="ms-2">08:30</span>
        </v-system-bar>
        <div class="pad">
          <v-card class="px-1 rounded-0" color="#465f75">
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
              </div>
            </div>
          </v-card>
        </div>
        <div class="pad">
          <v-card
            style="border-left: 7px solid white;"
            class="pa-1 rounded-0" 
            height="123"
            color="#465f75"
          >
            <div class="d-flex">
              <v-icon size="15">
                mdi-wifi
              </v-icon>
              <v-icon size="15">
                mdi-bluetooth
              </v-icon>
            </div>
            <div style="line-height: 1rem!important;" class="text-h6 pt-2">
              In Radio
            </div>
            <div class="text-caption d-flex justify-space-between">
              <p>
                Channel: 120
              </p>
              <div class="bar">
                <v-divider :thickness="2" vertical></v-divider>
                <v-icon style="bottom: 11px;" size="40" class="pa-3">
                  mdi-account-multiple
                </v-icon>
              </div>
            </div>
          </v-card>
        </div>
        <div class="pad">
          <v-card
            class="px-0 rounded-0" 
            color="#465f75"
          >
            <v-card-title style="line-height: 1rem!important;" class="pt-2 pa-0 px-1 text-subtitle-1">
              Welcome Dev
            </v-card-title>
            <v-card-subtitle class="pa-0 text-caption px-1">
              Where are we heading?
            </v-card-subtitle>
            <v-divider :thickness="2">

            </v-divider>
            <div class="d-flex justify-space-evenly">
              <div v-ripple class="text-center wid" style="display: block;">
                <v-icon class="text-center">
                  mdi-cog
                </v-icon>
                <p class="text-caption">
                  Settings
                </p>
              </div>
              <v-divider vertical :thickness="2">

              </v-divider>
              <div v-ripple class="text-center wid" style="display: block;">
                <v-icon>
                  mdi-phone
                </v-icon>
                <p class="text-caption">
                  Join
                </p>
              </div>
            </div>
          </v-card>
        </div>
      </v-card>
    </v-img>
  </v-app>
</template>

<script setup>
  //
</script>

<style>

.pos {
  position: absolute!important;
  right: 0px;
  bottom: 0px;
}

.inner {
  padding: 100px;
}

.display {
  top: 345px;
  right: 3px;
  margin: auto;
  width: 175px;
  height: 330px;
}

.pad {
  padding: 4px 4px 0px 4px;
}

.bar {
  height: 70px;
}

.wid {
  width: 100px;
  padding: 10px 0px;
}

</style>