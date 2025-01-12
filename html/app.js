const app = Vue.createApp({
  data() {
    return {
      isVisible: false,
      shortcuts: [] 
    };
  },
  methods: {
    handleNuiMessage(message) {
      const parsedMessage = typeof message === "string" ? JSON.parse(message) : message;

      if (parsedMessage.action === "show") {
        this.shortcuts = parsedMessage.data; 
        this.isVisible = true; // Slide in
      } else if (parsedMessage.action === "hide") {
        this.isVisible = false; // Slide out
      }
    }
  },
  mounted() {
    // Listen for NUI messages, also always listen to circle
    window.addEventListener("message", (event) => {
      this.handleNuiMessage(event.data);
    });
  }
});

app.mount("#app");
