<template>
<v-app style="background-color: transparent;">
    <v-slide-y-transition>
        <v-img v-if="$store.state.Menu" class="pos" :style="{ 'transform': 'scale(' + $store.state.settings.size + ')', left: dragX + 'px', top: dragY + 'px' }" @mousedown="startDrag" @mousemove="doDrag" @mouseup="stopDrag" cover height="fit-content" width="340" src="./assets/motorola.png">
            <v-card v-if="$store.state.on" @mousemove.stop class="display" color="background">
                <v-system-bar height="32" style="position: relative!important;" color="grey-darken-3">

                    <v-tooltip :text="$store.state.volume">
                        <template v-slot:activator="{ props }">
                            <v-icon v-bind="props" icon="mdi-volume-high" class="ms-1"></v-icon>
                        </template>
                    </v-tooltip>

                    <v-icon icon="mdi-bluetooth" class="ms-1"></v-icon>

                    <v-icon icon="mdi-battery" class="ms-1"></v-icon>

                    <span class="ms-2">{{ currentTime }}</span>
                </v-system-bar>
                <router-view v-slot="{ Component, route }">
                    <transition :name="route.meta.transition || 'fade'">
                        <component :is="Component" />
                    </transition>
                </router-view>
            </v-card>
            <div class="home-btn" @click="Home()">
                <v-tooltip activator="parent" location="top">
                    Home
                </v-tooltip>
            </div>
            <div class="up-btn" @click="increaseVolume()">
                <v-tooltip activator="parent" location="start">
                    Volume up
                </v-tooltip>
            </div>
            <div class="down-btn" @click="decreaseVolume()">
                <v-tooltip activator="parent" location="end">
                    Volume down
                </v-tooltip>
            </div>
            <div class="toggle-btn" @click="ToggleRadio()">
                <v-tooltip activator="parent" location="top">
                    Toggle on/off
                </v-tooltip>
            </div>
        </v-img>
    </v-slide-y-transition>
</v-app>
</template>

<script>
import router from '@/router/index'
import store from '@/store/index'

export default {
    data() {
        return {
            dragging: false,
            dragX: 0,
            dragY: 0,
            offsetX: 0,
            offsetY: 0,
            currentTime: '',
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
        Home() {
            if (router.currentRoute.value.path == '/') {
                store.dispatch('Close');
            } else {
                router.push('/')
            }
        },
        ToggleRadio() {
            store.state.on = !store.state.on
            store.dispatch('ToggleRadio', store.state.on)
        },
        updateCurrentTime() {
            const now = new Date();
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            this.currentTime = `${hours}:${minutes}`;
        },
        increaseVolume() {
      store.commit('increaseVolume');
    },

    decreaseVolume() {
      store.commit('decreaseVolume');
    },
    },
    mounted() {
        this.escapeListener = window.addEventListener("keyup", (event) => {
            if (event.keyCode === 27) {
                store.dispatch('Close');
            }
        });
        this.messageListener = window.addEventListener("message", (event) => {
            const item = event.data || event.detail;
            if (store._actions[item.type]) {
                store.dispatch(item.type, item);
            }
            if (item.type == 'Open') {
                router.push('/')
            }
        });

        this.updateCurrentTime();

        setInterval(() => {
            this.updateCurrentTime();
        }, 60000);
    },
};
</script>

<style>
html {
    overflow: hidden !important;
}

:root {
    color-scheme: light !important;
}

.side {
    position: absolute !important;
    width: 100%;

}

.pos {
    right: 0px;
    bottom: 0px;
    position: absolute !important;
    cursor: grab;
}

.inner {
    padding: 100px;
}

.display {
    margin: auto;
    width: 175px;
    height: 330px;
    position: absolute !important;
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
    display: flex !important;
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

.up-btn {
    background: transparent;
    width: 20px;
    height: 68px;
    margin: auto;
    position: absolute;
    top: 0px;
    bottom: 371px;
    right: 20px;
    left: 0;
    border-radius: 0px;
    cursor: pointer;
}

.down-btn {
    background: transparent;
    width: 20px;
    height: 68px;
    margin: auto;
    position: absolute;
    top: 0px;
    bottom: 371px;
    right: 0;
    left: 10px;
    border-radius: 0px;
    cursor: pointer;
}

.toggle-btn {
    background: transparent;
    width: 46px;
    height: 46px;
    margin: auto;
    position: absolute;
    top: 0px;
    bottom: 308px;
    right: 0;
    left: 213px;
    border-radius: 0px;
    cursor: pointer;
}
</style>
