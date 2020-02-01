<template>
  <div id="ambient">
    <h1>ambient viewer</h1>
    <div class="dltable">
      <dl v-if="info">
        <dt>CO2</dt>
        <dd>{{ info.ambient.co2 }} [ppm]</dd>
        <dt>temperature</dt>
        <dd>{{ info.ambient.temperature }} [degree C]</dd>
        <dt>humidity</dt>
        <dd>{{ info.ambient.humidity }} [%]</dd>
        <dt>timestamp</dt>
        <dd>{{ info.timestamp }}</dd>
      </dl>
      <p v-else>err</p>
    </div>
  </div>
</template>


<script>
import axios from "axios";

export default {
  name: "AmbientViewer",
  data() {
    return {
      info: null
    };
  },
  methods: {
    ambientAPICall: function() {
      axios
        .get("https://ambient.ty0.jp/api/v1/ambient")
        .then(response => (this.info = response.data))
        .catch(error => {
          // eslint-disable-next-line no-console
          console.log(error);
          this.errored = true;
        });
    },
    intervalFetchData: function() {
      setInterval(() => {
        this.ambientAPICall();
      }, 60);
    }
  },
  mounted() {
    this.ambientAPICall();
    this.intervalFetchData();
  }
};
</script>

<style scoped>
h1 {
  font-size: 4em;
}
dl {
  font-size: 2em;
  display: flex;
  flex-wrap: wrap;
  border: 1px solid #ccc;
  border-top: none;
}
dt {
  background: #ddd;
  width: 30%;
  padding: 10px;
  box-sizing: border-box;
  border-top: 1px solid #ccc;
}
dd {
  padding: 10px;
  margin: 0;
  border-left: 1px solid #ccc;
  border-top: 1px solid #ccc;
  width: 70%;
  background: #fff;
  box-sizing: border-box;
}
@media screen and (max-width: 320px) {
  dl {
    flex-flow: column nowrap;
  }
  dt,
  dd {
    width: 100%;
  }
  dd {
    border-left: none;
  }
}
</style>