// stores/counter.js
import { defineStore } from "pinia";
import { useAuthStore } from "./auth";

export const useCompanyStore = defineStore("company", {
  state: () => {
    return {
      accountType: "Individual",
      isInitialized: false,
      storeName: "",
      departments: [],
      employees: [],
      identity: null,
    };
  },
  getters: {
    getAccountType() {
      return this.accountType;
    },
    getIsInitialized() {
      return this.isInitialized;
    },
    getStoreName() {
      return this.storeName;
    },
    getDepartments() {
      return this.departments;
    },
    getEmployees() {
      return this.employees;
    },
    getIdentity() {
      return this.identity;
    },
  },
  // could also be defined as
  // state: () => ({ count: 0 })
  actions: {
    async setupStore(storeName, departments, employees) {
      const authStore = useAuthStore();
      if (authStore.isAuthenticated) {
        this.isInitialized = true;
        this.storeName = storeName;
        this.departments = departments;
        employees = employees;
      } else {
        throw new Error("User must be authenticated");
      }
      this.isInitialized = true;
    },
    setAccountType(type) {
      if (type === "Individual" || type === "Company") {
        this.accountType = type;
      } else {
        throw new Error("Invalid account type");
      }
    },
    toggleAccountType() {
      this.accountType =
        this.accountType === "Individual" ? "Company" : "Individual";
    },
  },
});
