import { defineStore } from "pinia"

export const useMbrsStore = defineStore("mbrs", {
  state: () => ({
    trustee: null,
    registryType: "company",
    user: null,
    context: "user",
    openProfile: false,
    mobileActiveTab: null,
  }),
  getters: {
    getTrusteeValue(state) {
      return state.trustee
    },
    getUserValue(state) {
      return state.user
    },
    getContext(state) {
      return state.context
    },
    isProfileOpen(state) {
      return state.openProfile
    },
    ismobileTabActive(state) {
      return state.mobileActiveTab
    },
    getRegistryType(state) {
      return state.registryType
    },
  },
  actions: {
    setTrusteeValue(value) {
      this.trustee = value
    },
    setContext(value) {
      this.context = value
    },
    setUserValue(value) {
      this.user = value
    },
    setOpenProfile(value) {
      this.openProfile = value
    },
    setMobileActiveTab(value) {
      this.mobileActiveTab = value
    },
    setRegistryType(value) {
      this.registryType = value
    },
  },
})
