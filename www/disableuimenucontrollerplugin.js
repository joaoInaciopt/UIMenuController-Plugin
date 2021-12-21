function DisableUIMenuControllerPlugin() {}

DisableUIMenuControllerPlugin.prototype.activate = function(successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, 'DisableUIMenuController', 'activate');
}

DisableUIMenuControllerPlugin.prototype.deactivate = function(successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, 'DisableUIMenuController', 'deactivate');
}

DisableUIMenuControllerPlugin.install = function() {
    if (!window.plugins) {
      window.plugins = {};
    }
    window.plugins.disableUIMenuControllerPlugin = new DisableUIMenuControllerPlugin();
    return window.plugins.disableUIMenuControllerPlugin;
};

cordova.addConstructor(DisableUIMenuControllerPlugin.install);