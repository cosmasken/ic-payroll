// registrationStore.js
import { defineStore } from "pinia";
import axios from "axios";

import router from "../router/index.js";

export const useRegistrationStore = defineStore("registration", {
  state: () => ({
    registrationData: {},
    userInfo: String,
  }),
  actions: {
    updateRegistrationData(data) {
      this.registrationData = { ...this.registrationData, ...data };
    },
    clearRegistrationData() {
      this.registrationData = {};
    },
    setUserInfo(userInfo) {
      this.userInfo = userInfo;
    },
    async registration(
      firstname,
      lastname,
      email,
      phone,
      address,
      country,
      designation
    ) {
      this.loading = true;
      //const response = await axios.post('https://concerned-plum-gazelle.cyclic.app/api/user/login', { 'dev@waiafrica.com', password });
      const response = await axios({
        headers: {
          "Content-Type": "application/json",
        },
        method: "post",
        url: "https://concerned-plum-gazelle.cyclic.app/api/user",
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
          phone: phone,
        },
      });

      if (response.status === 200) {
        console.log("Registered", response);
        this.setUserInfo(JSON.stringify(response));
        console.log(response);
        this.user = response.data.user;
        this.error = null;
        router.push("/auth/login");
      } else {
        this.error = response.data.message;
        console.log(
          "An error occurred during Registration:",
          response.data.message
        );
      }
    },
  },
});
