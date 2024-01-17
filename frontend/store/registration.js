// registrationStore.js
import { defineStore } from 'pinia'


import router from '../router/index.js'

export const useRegistrationStore = defineStore('registration', {
  state: () => ({
    registrationData: {},
    identity : String,
  }),
  actions: {
    updateRegistrationData(data) {
      this.registrationData = { ...this.registrationData, ...data }
    },
    clearRegistrationData() {
      this.registrationData = {}
    },
    setUserInfo(identity) {
      this.identity =identity;
    },
    async registration(
      usertype,
      firstname,
      lastname,
      idno,
      dob,
      gender,
      birthplace,
      issuedate,
      expirydate,
      email,
      password,
      phone
    ) {
      this.loading = true
      //const response = await axios.post('https://concerned-plum-gazelle.cyclic.app/api/user/login', { 'dev@waiafrica.com', password });
      const response = await axios({
        headers: {
          'Content-Type': 'application/json'
        },
        method: 'post',
        url: 'https://concerned-plum-gazelle.cyclic.app/api/user',
        data: {
          usertype: usertype,
          firstname: firstname,
          lastname: lastname,
          idno: idno,
          dob: dob,
          gender: gender,
          birthplace: birthplace,
          issuedate: issuedate,
          expirydate: expirydate,
          email: email,
          password: password,
          phone: phone
        }
      })

      if (response.status === 200) {
        console.log('Registered', response)
        this.setUserInfo(JSON.stringify(response))
        console.log(response)
        this.user = response.data.user
        this.error = null
        router.push('/auth/login')
      } else {
        this.error = response.data.message
        console.log('An error occurred during Registration:', response.data.message)
      }
    }
  }
})
