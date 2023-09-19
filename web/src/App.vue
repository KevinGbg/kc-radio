<template>
  <v-app style="background-color: transparent;">
    <v-img 
      class="pos" 
      :style="{ 'transform': 'scale(' + $store.state.settings.size + ')', left: dragX + 'px', top: dragY + 'px' }"
      @mousedown="startDrag"
      @mousemove="doDrag"
      @mouseup="stopDrag"
      cover 
      height="fit-content" 
      width="340" 
      src="./assets/motorola.png"
    >
      <v-card
        @mousemove.stop
        class="display" 
        color="background">
        <v-system-bar height="32" style="position: relative!important;" color="grey-darken-3">
          <v-icon icon="mdi-bluetooth" class="ms-1"></v-icon>
    
          <v-icon icon="mdi-battery" class="ms-1"></v-icon>
    
          <span class="ms-2">08:30</span>
        </v-system-bar>
        <router-view v-slot="{ Component, route }">
          <transition :name="route.meta.transition || 'fade'">
            <component :is="Component" />
          </transition>
        </router-view>
      </v-card>
      <div class="home-btn" @click="$router.push('/')">
        <v-tooltip
          activator="parent"
          location="top"
        >
          Home
        </v-tooltip>
      </div>
    </v-img>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      dragging: false,
      dragX: 0,
      dragY: 0,
      offsetX: 0,
      offsetY: 0,
    };
  },
  methods: {
    startDrag(event) {
      this.dragging = true;
      this.offsetX = event.clientX - this.dragX;
      this.offsetY = event.clientY - this.dragY;
    },
    doDrag(event) {
      if (this.dragging) {
        this.dragX = event.clientX - this.offsetX;
        this.dragY = event.clientY - this.offsetY;
      }
    },
    stopDrag() {
      this.dragging = false;
    },
  },
};
</script>



<style>

.side {
  position: absolute!important;
  width: 100%;

}

.pos {
  right: 0px;
  bottom: 0px;
  position: absolute!important;
  cursor: grab;
}

.inner {
  padding: 100px;
}

.display {
  margin: auto;
  width: 175px;
  height: 330px;
  position: absolute!important;
  top: 220px;
  left: 0;
  right: 6px;
  bottom: 0;
  cursor: default;
}

.pad {
  padding: 4px 4px 0px 4px;
}

.bar {
  height: 70px;
}

.wid {
  width: 50%;
  padding: 0px 0px;
  display: flex!important;
  place-content: center;
  align-items: center;
  align-content: center;
  justify-content: center;
  flex-wrap: wrap;
  flex-direction: column;
  min-height: 64px;
}

.home-btn {
  background: transparent;
  width: 58px;
  height: 28px;
  margin: auto;
  position: absolute;
  top: 608px;
  bottom: 0;
  right: 7px;
  left: 0;
  border-radius: 18px;
  cursor: pointer;
}

.home-btn:hover {
  background: #ffffff12;
}


</style>
