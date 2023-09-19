<template>
  <v-app style="background-color: transparent;">
    <v-img class="pos" cover max-height="800" width="340" src="./assets/motorola.png">
      <v-card class="display" color="background">
        <v-system-bar height="32" style="position: relative!important;" color="grey-darken-3">
          <v-icon icon="mdi-bluetooth" class="ms-1"></v-icon>
    
          <v-icon icon="mdi-battery" class="ms-1"></v-icon>
    
          <span class="ms-2">08:30</span>
        </v-system-bar>
        <router-view v-slot="{ Component, route }">
          <!-- Use any custom transition and  to `fade` -->
          <transition :name="route.meta.transition || 'fade'">
            <component :is="Component" />
          </transition>
        </router-view>
      </v-card>
    </v-img>
  </v-app>
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
