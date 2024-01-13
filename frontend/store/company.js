// stores/counter.js
import { defineStore } from 'pinia'
import {useAuthStore} from './auth'

export const useCompanyStore = defineStore('company', {
  state: () => {
    return { 
        userType : '',
        isInitialized : false,
        storeName : '',
        departments : [],
        employees : [],

     }
  },
  // could also be defined as
  // state: () => ({ count: 0 })
  actions: {
  async  setupStore(storeName, departments, employees) {

      const authStore = useAuthStore()
      if (authStore.isAuthenticated) {
        this.isInitialized = true;
        this.storeName = storeName;
        this.departments = departments;
        employees = employees;
      } else {
        throw new Error('User must be authenticated')
      }
      this.isInitialized = true
    },
  },
})