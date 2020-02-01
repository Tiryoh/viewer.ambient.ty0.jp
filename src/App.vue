<template>
  <div id="app">
    <AmbientViewer />
  </div>
</template>

<script>
import AmbientViewer from "./components/AmbientViewer.vue";

export default {
  name: "app",
  components: {
    AmbientViewer
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
