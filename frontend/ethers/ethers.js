"use strict";
import { ethers } from "ethers";
Plugin.install = function (Vue) {
  Vue.prototype.ethers = ethers;
  Object.defineProperties(Vue.prototype, {
    $ethers: {
      get() {
        return ethers;
      },
    },
  });
};
export default Plugin;
