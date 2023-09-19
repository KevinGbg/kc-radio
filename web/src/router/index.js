// Composables
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    component: () => import('@/views/Home.vue'),
    meta: { transition: 'slide-y-transition' },
  },
  {
    path: '/connect',
    component: () => import('@/views/Connect.vue'),
    meta: { transition: 'slide-y-transition' },
  },
  {
    path: '/settings',
    component: () => import('@/views/Settings.vue'),
    meta: { transition: 'slide-y-transition' },
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
