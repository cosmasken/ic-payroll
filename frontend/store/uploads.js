import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import { createActor, canisterId } from "../../src/declarations/backend";
import { toRaw } from "vue";
import Swal from "sweetalert2";

const useUpload = defineStore('upload', () => {
 id: 'upload',
    state: () => {
        return {
            uploads: [],
            upload: null,
            uploadError: null,
            uploadSuccess: null,
            uploadLoading: false,
        };
    },
    actions: {
    },
    getters: {
        
    }
  });