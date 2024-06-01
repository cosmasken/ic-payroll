<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import DropDown from "./DropDown.vue";
import router from "../../router";
const authStore = useAuthStore();
let departmentsArray = ref([]);
let noOfDepartments = ref(0);
let designationsArray = ref([]);
let noOfDesignations = ref(0);
let organizationsArray = ref([]);
let noOfOrganizations = ref(0);
const isLoading = ref(false);
const filterOpen = ref(false);

const dropdownItems = [
  { text: "Account settings", url: "#" },
  { text: "Support", url: "#" },
  { text: "License", url: "#" },
];

const organizations = [
  {
    id: 1,
    name: "HarambeeApps",
  },
  {
    id: 2,
    name: "BitPochi",
  },
  {
    id: 3,
    name: "Bounty Safari",
  },
];

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

const departments = [
  {
    id: 1,
    name: "Hr",
  },
  {
    id: 2,
    name: "Software Deveopment",
  },
  {
    id: 3,
    name: "Technical Support",
  },
];

const designation = [
  {
    id: 1,
    name: "Hr Manager",
  },
  {
    id: 2,
    name: "Software Developer",
  },
  {
    id: 3,
    name: "Full Stack Developer",
  },
  {
    id: 4,
    name: "Front End Developer",
  },
  {
    id: 5,
    name: "Back End Developer",
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
  disability: "",
  organization: "",
  department: "",
  designation: "",
  employee_type: "",
  job_group: "",
  identity: "",
  gross_salary: "",
  role: "",
};

const permissions = {
  canAdd: Boolean,
  canView: Boolean,
  canEdit: Boolean,
  canDelete: Boolean,
  canUpdate: Boolean,
  canPay: Boolean,
};

const addUser = async () => {
  try {
    isLoading.value = true;
    console.log("DATA:", data);
    const res = await authStore.whoamiActor?.create_emp({
      first_name: data.first_name,
      last_name: data.last_name,
      email_address: data.email_address,
      phone_number: data.phone_number,
      joining_date: data.joining_date,
      gender: data.gender,
      disability: data.disability,
      organization: data.organization,
      department: data.department,
      designation: data.designation,
      employee_type: data.employee_type,
      job_group: data.job_group,
      identity: data.identity,
      gross_salary: data.gross_salary,
      role: data.role,
      permissions: {
        canAdd: true,
        canView: false,
        canEdit: true,
        canDelete: true,
        canUpdate: true,
        canPay: true,
      },
    });

    if (res.status === 200) {
      console.log(" employee registered");
      console.log(res);
    }
    console.log("res array:", res);
  } catch (error) {
    console.error("Error fetching organizations list:", error);
  } finally {
    isLoading.value = false;
    router.push("/home/all-employees");
  }
};
</script>
<template>
  <main class="min-h-full h-screen px-4 md:px-6 lg:px-7 pt-4 md:pt-6">
    <div class="mb-6 flex flex-row justify-between">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Add Employee
      </h2>
      <button
        type="button"
        class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
      >
        Import Employee
      </button>
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
              <div class="mt-1">
                <input
                  v-model="data.phone_number"
                  type="text"
                  name="phone-number"
                  id="phone-number"
                  autocomplete="phone-number"
                  class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                />
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="email"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Email</label
              >
              <div class="mt-1">
                <input
                  v-model="data.email_address"
                  type="text"
                  name="email"
                  id="email"
                  autocomplete="email"
                  class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                />
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="joining-date"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Joining Date</label
              >
              <div class="mt-1">
                <input
                  v-model="data.joining_date"
                  type="text"
                  name="joining-date"
                  id="joining-date"
                  autocomplete="joining-date"
                  class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                />
              </div>
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
            <div class="lg:col-span-4">
              <label
                for="disability"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Person with Diability</label
              >
              <div class="mt-1">
                <input
                  type="checkbox"
                  v-model="data.disability"
                  class="checkbox rounded-md"
                />
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
              class="border md:h-[300px] p-2 md:p-5 border-dashed border-autom8-blue-500 bg-[#f8fafb] grid items-center justify-center text-center mt-4 rounded-md"
            >
              <div class="flex flex-col">
                <img
                  class="h-8 w-auto"
                  src="../../assets/upload.svg"
                  alt="autom8"
                />

                <p>Upload a File</p>
              </div>

              <button
                type="button"
                class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
              >
                Upload a File
              </button>
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
              for="identity"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Identity</label
            >
            <div class="mt-1">
              <input
                type="text"
                name="identity"
                id="identity"
                v-model="data.identity"
                autocomplete="identity"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="gross-salary"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Gross Salary</label
            >
            <div class="mt-1">
              <input
                type="text"
                name="gross-salary"
                id="gross-salary"
                v-model="data.gross_salary"
                autocomplete="gross-salary"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
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
              for="first-name"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Permissions</label
            >
            <div class="mt-1">
              <input
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="given-name"
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
  </main>
</template>
