function DisableUIMenuControllerPlugin() {}

DisableUIMenuControllerPlugin.install = function() {
    if (!window.plugins) {
      window.plugins = {};
    }
    window.plugins.disableUIMenuControllerPlugin = new DisableUIMenuControllerPlugin();
    return window.plugins.disableUIMenuControllerPlugin;
};

cordova.addConstructor(DisableUIMenuControllerPlugin.install);