// Composables
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    component: () => import('@/views/Home.vue'),
    meta: { transition: 'slide-x-reverse-transition' },
  },
  {
    path: '/connect',
    component: () => import('@/views/Connect.vue'),
    meta: { transition: 'slide-x-transition' },
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
