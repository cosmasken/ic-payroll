<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import router from "../../router";
import PhonePicker from "../Common/PhonePicker.vue";
import EmailInput from "../Common/EmailInput.vue";
import DatePicker from "../Common/DatePicker.vue";
import NumberPicker from "../Common/NumberPicker.vue";
import Swal from "sweetalert2";
const authStore = useAuthStore();
let departmentsArray = ref([]);
let noOfDepartments = ref(0);
let designationsArray = ref([]);
let noOfDesignations = ref(0);
let organizationsArray = ref([]);
let noOfOrganizations = ref(0);
const isLoading = ref(false);
const filterOpen = ref(false);
const importdata = ref(null);
const blobUrl = ref(null);
const imgBlob = ref(null);
const uploadComplete = ref(false);
const isUploading = ref(false);
const selectedFile = ref(null);

const importAndAddEmployees = (event) => {
  const file = event.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = async (e) => {
      try {
        const jsonData = JSON.parse(e.target.result);
        // Assuming jsonData is an array of employee objects
        const employeesData = Array.isArray(jsonData) ? jsonData : [jsonData];

        let successfulAdditions = 0;
        let failedAdditions = 0;

        try {
          isLoading.value = true;

          for (const data of employeesData) {
            try {
              const res = await authStore.whoamiActor?.create_emp({
                first_name: data.first_name,
                last_name: data.last_name,
                email_address: data.email_address,
                phone_number: data.phone_number,
                joining_date: data.joining_date,
                gender: data.gender,
                disability: data.disability || false,
                organization: data.organization,
                department: data.department,
                designation: data.designation,
                employee_type: data.employee_type,
                job_group: data.job_group,
                gross_salary: data.gross_salary,
                role: data.role,
                identity: data.identity,
              });

              if (res.status === 200) {
                successfulAdditions++;
              } else {
                failedAdditions++;
              }
            } catch (error) {
              console.error("Error adding employee:", error);
              failedAdditions++;
            }
          }
        } finally {
          isLoading.value = false;

          Swal.fire({
            title: "Employee Import Result",
            html: `Successfully added: ${successfulAdditions}<br>Failed to add: ${failedAdditions}`,
            confirmButtonText: "OK",
          }).then((result) => {
            if (result.isConfirmed && successfulAdditions > 0) {
              router
                .push("/home/all-employees")
                .catch((err) => console.error(err));
            } else if (result.isConfirmed && successfulAdditions === 0) {
              router
                .push("/home/add-employee")
                .catch((err) => console.error(err));
            }
          });
        }
      } catch (error) {
        Swal.fire({
          title: "Error",
          text: "Failed to parse JSON file",
          icon: "error",
          confirmButtonText: "Retry",
        });
      }
    };
    reader.readAsText(file);
  }
};

const handleFileUpload = (event) => {
  const file = event.target.files[0];
  selectedFile.value = file;
};

const uploadImage = async () => {
  if (!selectedFile.value) return;

  isUploading.value = true;

  const img = new Image();
  img.src = URL.createObjectURL(selectedFile.value);
  img.onload = async () => {
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    canvas.width = img.naturalWidth;
    canvas.height = img.naturalHeight;
    ctx.drawImage(img, 0, 0);

    canvas.toBlob(
      async (blob) => {
        const arrayBuffer = await blob.arrayBuffer();
        const myupload = await authStore.whoamiActor?.uploadImg("img001", [
          ...new Uint8Array(arrayBuffer),
        ]);
        console.log("myupload", myupload);
        isUploading.value = false;
        uploadComplete.value = true;

        blobUrl.value = URL.createObjectURL(blob);

        // Convert blob to base64 string
        const reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = () => {
          const base64data = reader.result;
          imgBlob.value = base64data; // Store the base64 encoded string
          console.log(imgBlob);
        };
      },
      "image/jpeg",
      1.0
    );
  };
};

const gender = [
  {
    id: 1,
    name: "Male",
  },
  {
    id: 2,
    name: "Female",
  },
];

const employeeType = [
  {
    id: 1,
    name: "Consultant",
  },
  {
    id: 2,
    name: "Fixed Type",
  },
  {
    id: 3,
    name: "Contract",
  },
  {
    id: 4,
    name: "Gig",
  },
];
const jobGroup = [
  {
    id: 1,
    name: "A1",
  },
  {
    id: 2,
    name: "A2",
  },
  {
    id: 3,
    name: "A3",
  },
  {
    id: 4,
    name: "A4",
  },
];

const role = [
  {
    id: 1,
    name: "Administrator",
  },
  {
    id: 2,
    name: "Hr Manager",
  },
  {
    id: 3,
    name: "Finance Manager",
  },
  {
    id: 4,
    name: "Employee",
  },
  {
    id: 4,
    name: "Intern",
  },
];

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getDepartmentsLength();
  noOfDepartments.value = res;
});

watchEffect(async () => {
  try {
    isLoading.value = true;
    const res = await authStore.whoamiActor?.getDepartments();
    console.log("res array:", res);
    let departments = [];
    // Loop through the result and create an array of objects
    for (let i = 0; i < res.length; i++) {
      const data = res[i];
      console.log("data is", data);
      departments.push(data);
    }
    // Assign the array of objects to the users ref
    departmentsArray.value = departments;

    console.log("Departments", departments);
  } catch (error) {
    console.error("Error fetching departments list:", error);
  } finally {
    isLoading.value = false;
  }
});

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getDesignationsLength();
  noOfDesignations.value = res;
});

watchEffect(async () => {
  try {
    isLoading.value = true;
    const res = await authStore.whoamiActor?.getDesignations();
    console.log("res array:", res);
    let designations = [];
    // Loop through the result and create an array of objects
    for (let i = 0; i < res.length; i++) {
      const data = res[i];
      console.log("data is", data);
      designations.push(data);
    }
    // Assign the array of objects to the users ref
    designationsArray.value = designations;

    console.log("Designations", designations);
  } catch (error) {
    console.error("Error fetching designations list:", error);
  } finally {
    isLoading.value = false;
  }
});

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getOrganizationsLength();
  noOfOrganizations.value = res;
});

watchEffect(async () => {
  try {
    isLoading.value = true;
    const res = await authStore.whoamiActor?.getOrganizations();
    console.log("res array:", res);
    let organizations = [];
    // Loop through the result and create an array of objects
    for (let i = 0; i < res.length; i++) {
      const data = res[i];
      console.log("data is", data);
      organizations.push(data);
    }
    // Assign the array of objects to the users ref
    organizationsArray.value = organizations;

    console.log("organizations", organizations);
  } catch (error) {
    console.error("Error fetching organizations list:", error);
  } finally {
    isLoading.value = false;
  }
});

const goToAddOrganization = () => {
  router.push("/home/organizations");
};

const goToAddDeparment = () => {
  router.push("/home/departments");
};

const goToAddDesignation = () => {
  router.push("/home/designations");
};

const goToAAllEmployees = () => {
  router.push("/home/all-employees");
};

const data = {
  first_name: "",
  last_name: "",
  email_address: "",
  phone_number: "",
  joining_date: "",
  gender: "",
  organization: "",
  department: "",
  designation: "",
  employee_type: "",
  job_group: "",
  gross_salary: "",
  role: "",
  identity: "",
};
function handlePhoneNumberInput(fullNumber) {
  console.log("Full phone number:", fullNumber);
}

const userpermissions = {
  canAdd: Boolean,
  canView: Boolean,
  canEdit: Boolean,
  canDelete: Boolean,
  canUpdate: Boolean,
  canPay: Boolean,
};

const addUser = async () => {
  let resStatus = null; // To capture the response status

  try {
    isLoading.value = true;
    console.log("DATA IS:", data);

    const res = await authStore.whoamiActor?.create_emp({
      first_name: data.first_name,
      last_name: data.last_name,
      email_address: data.email_address,
      phone_number: data.phone_number,
      joining_date: data.joining_date,
      gender: data.gender,
      disability: false,
      organization: data.organization,
      department: data.department,
      designation: data.designation,
      employee_type: data.employee_type,
      job_group: data.job_group,
      gross_salary: data.gross_salary,
      role: data.role,
      identity: data.identity,
    });

    resStatus = res.status; // Capture the response status

    console.log("res array:", res);
  } catch (error) {
    console.error("Error fetching organizations list:", error);
    resStatus = "error"; // Set status to 'error' in case of an exception
  } finally {
    isLoading.value = false; // Ensure loading state is reset

    // Handle Swal based on response status
    if (resStatus === 200) {
      Swal.fire({
        title: "Employee Registered",
        confirmButtonText: "Okay",
      }).then((result) => {
        if (result.isConfirmed) {
          router.push("/home/all-employees").catch((err) => console.error(err));
        }
      });
    } else if (resStatus === "error" || resStatus !== 200) {
      Swal.fire({
        title: "Employee Not Added",
        text: "Employee has not been added successfully",
        confirmButtonText: "Retry",
      }).then((result) => {
        if (result.isConfirmed) {
          router.push("/home/add-employee").catch((err) => console.error(err));
        }
      });
    }
  }
};
</script>
<template>
  <main class="min-h-full h-screen px-4 md:px-6 lg:px-7 pt-4 md:pt-6">
    <div v-if="isLoading">
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
    <div v-else>
      <div class="mb-6 flex flex-row justify-between">
        <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
          Add Employee
        </h2>
        <div class="flex flex-col">
          <label
            for="fimport"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Import</label
          >
          <input
            name="import"
            id="import"
            type="file"
            @change="importAndAddEmployees"
            accept=".json"
            class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
          />
        </div>

        <!--button
      @click="importAndAddEmployees()"
        type="button"
        class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
      >
        Import Employees
      </button-->
      </div>

      <div class="space-y-3 h-full">
        <div
          class="container grid grid-cols-1 lg:grid-cols-6 w-full space-y-5 lg:space-y-0 lg:space-x-5"
        >
          <div class="rounded-lg lg:col-span-4">
            <div class="pb-4 border-b border-[#E4EBEF]">
              <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
                Basic Info
              </h4>
            </div>

            <div
              class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-4 gap-5 mt-4"
            >
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >First Name</label
                >
                <div class="mt-1">
                  <input
                    v-model="data.first_name"
                    type="text"
                    name="first-name"
                    id="first-name"
                    autocomplete="first-name"
                    class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
              <div class="lg:col-span-2">
                <label
                  for="last-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Last name</label
                >
                <div class="mt-1">
                  <input
                    v-model="data.last_name"
                    type="text"
                    name="last-name"
                    id="last-name"
                    autocomplete="last-name"
                    class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
              <div class="lg:col-span-2">
                <label
                  for="phone-number"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Phone</label
                >

                <PhonePicker
                  v-model="data.phone_number"
                  @input="handlePhoneNumberInput"
                />
              </div>
              <div class="lg:col-span-2">
                <label
                  for="email"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Email</label
                >

                <EmailInput v-model="data.email_address" />
              </div>
              <div class="lg:col-span-2">
                <label
                  for="joining-date"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Joining Date</label
                >

                <DatePicker v-model="data.joining_date" />
              </div>
              <div class="lg:col-span-2">
                <label
                  for="gender"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Gender</label
                >
                <div class="mt-1">
                  <select
                    id="gender"
                    name="gender"
                    v-model="data.gender"
                    class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  >
                    <option v-for="org in gender" :key="org.id">
                      {{ org.name }}
                    </option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="rounded-lg lg:col-span-2">
            <div class="pb-4 border-b border-[#E4EBEF]">
              <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
                Profile Photo
              </h4>
            </div>

            <div class="bg-[#fff] md:p-5 rounded-md mt-4">
              <div
                class="border md:h-[300px] p-2 md:p-5 border-dashed border-autom8-blue-500 bg-[#f8fafb] grid grid-cols-1 items-center justify-center text-center mt-4 rounded-md"
              >
                <div class="flex flex-col">
                  <div
                    class="flex flex-col mx-auto items-center justify-center"
                  >
                    <input
                      class="w-auto inline-flex items-center justify-center"
                      type="file"
                      @change="handleFileUpload"
                    />
                  </div>

                  <button
                    type="button"
                    @click="uploadImage"
                    :disabled="isUploading"
                    class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                  >
                    Upload a File
                  </button>
                </div>
                <div v-if="uploadComplete && blobUrl">
                  <h3>Uploaded Image:</h3>
                  <img :src="blobUrl" alt="Profile Image" />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="flex flex-col border-b mb-4 border-[#E4EBEF]">
          <div class="pb-4 border-b border-[#E4EBEF]">
            <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
              Company Relations
            </h4>
          </div>
          <div
            class="bg-[#ffffff] grid grid-cols-1 p-2 lg:p-5 rounded-md lg:grid-cols-6 gap-5 mt-4"
          >
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Organization</label
              >
              <div class="mt-1">
                <div v-if="organizationsArray.length === 0">
                  <button
                    @click="goToAddOrganization"
                    type="button"
                    class="inline-flex items-center justify-center sm:w-48 min-w-full rounded-md border border-gray-300 bg-[#fff] px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                  >
                    No Organization.Add Organization +
                  </button>
                </div>
                <div v-else>
                  <!--DropdownMenu :triggerText="'Options'" :items="dropdownItems" /-->
                  <select
                    id="organization"
                    name="organization"
                    v-model="data.organization"
                    class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  >
                    <option v-for="org in organizationsArray" :key="org.code">
                      {{ org.name }}
                    </option>
                    <option
                      class="cursor-pointer bg-blue-500"
                      value="add_department"
                      @click="goToAddOrganization"
                    >
                      Add Organization
                    </option>
                  </select>
                </div>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="designation"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Department</label
              >
              <div class="mt-1">
                <div v-if="departmentsArray.length === 0">
                  <button
                    @click="goToAddDeparment"
                    type="button"
                    class="inline-flex items-center justify-center sm:w-48 min-w-full rounded-md border border-gray-300 bg-[#fff] px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                  >
                    No Departments.Add Department +
                  </button>
                </div>
                <div v-else>
                  <!--DropdownMenu :triggerText="'Options'" :items="dropdownItems" /-->
                  <select
                    id="departments"
                    name="departments"
                    v-model="data.department"
                    class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  >
                    <option v-for="org in departmentsArray" :key="org.code">
                      {{ org.name }}
                    </option>
                    <option
                      class="cursor-auto bg-blue-500"
                      value="add_department"
                      @click="goToAddDeparment"
                    >
                      Add Department
                    </option>
                  </select>
                </div>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="designation"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Designation</label
              >
              <div class="mt-1">
                <div v-if="designationsArray.length === 0">
                  <button
                    @click="goToAddDesignation"
                    type="button"
                    class="inline-flex items-center justify-center sm:w-48 min-w-full rounded-md border border-gray-300 bg-[#fff] px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                  >
                    No Designations.Add Designations +
                  </button>
                </div>
                <div v-else>
                  <!--DropdownMenu :triggerText="'Options'" :items="dropdownItems" /-->
                  <select
                    id="designation"
                    name="designation"
                    v-model="data.designation"
                    class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  >
                    <option v-for="org in designationsArray" :key="org.code">
                      {{ org.name }}
                    </option>
                    <option
                      class="cursor-auto bg-blue-500"
                      value="add_department"
                      @click="goToAddDesignation"
                    >
                      Add Designation
                    </option>
                  </select>
                </div>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="employeetype"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Employee Type</label
              >
              <div class="mt-1">
                <select
                  id="employeetype"
                  name="employeetype"
                  v-model="data.employee_type"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in employeeType" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="job-group"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Job Group</label
              >
              <div class="mt-1">
                <select
                  id="job-group"
                  name="job-group"
                  v-model="data.job_group"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in jobGroup" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="lg:col-span-2">
              <label
                for="gross-salary"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Gross Salary</label
              >

              <NumberPicker v-model="data.gross_salary" />
            </div>
            <div class="lg:col-span-2">
              <label
                for="role"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Role</label
              >
              <div class="mt-1">
                <select
                  id="role"
                  name="role"
                  v-model="data.role"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in role" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="lg:col-span-2">
              <label
                for="identity"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Identity</label
              >
              <div class="mt-1">
                <input
                  v-model="data.identity"
                  type="text"
                  name="identity"
                  id="identity"
                  autocomplete="identity"
                  class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                />
              </div>
            </div>
          </div>
        </div>
        <div class="pb-2 md:pb-5">
          <button
            type="button"
            @click="addUser"
            class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
          >
            Save
          </button>
        </div>
      </div>
    </div>
  </main>
</template>
