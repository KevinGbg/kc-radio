<template>
    <div class="side">
        <div class="pad">
            <v-card class="pa-1 rounded-0" color="cards">
                <p class="text-h6 pb-2">
                    Join channel
                </p>
                <v-text-field class="px-2"
                    label="Frequency"
                    hint="1-9999"
                    variant="solo"
                >

                </v-text-field>
                <div class="d-flex justify-center pt-4 pb-2">
                    <v-btn
                        @click="$router.push('/')"
                        color="btn"
                    >
                        Join
                    </v-btn>
                </div>
                
            </v-card>
          </div>
    </div>
</template>

<style>

.v-field {
    --v-field-padding-start: 8px!important;
    --v-field-padding-end: 8px!important;
}

.v-text-field .v-input__details {
    padding-inline-start: 8px!important;
    padding-inline-end: 8px!important;
}

</style>