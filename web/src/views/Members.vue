<template>
  <div class="side">
    <div class="pad">
      <v-card class="pa-1 rounded-0" color="cards">
        <p class="text-h6 pb-0 pt-0 px-1">
          Members
        </p>
        <div>
          <v-card class="mb-1" v-for="(member, index) in radioMembers" :key="index">
            <v-icon>
              mdi-account
            </v-icon>
            {{ member.name }}
          </v-card>
        </div>
      </v-card>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    radioMembers() {
      return this.$store.state.data.members;
    },
  },
};
</script>
