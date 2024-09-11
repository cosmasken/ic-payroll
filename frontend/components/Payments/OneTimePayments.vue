<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
let tradingbalance = ref("");
import Swal from "sweetalert2";
let transferResult = ref("");
const isTransferring = ref(false);
const showSuccess = ref(false);
const showFailure = ref(false);
const isRefreshing = ref(false);
const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};

const authStore = useAuthStore();
const transferArgs = {
  address: "",
  memo: "",
  created_at: getTime(),
  amount: 0,
};

watchEffect(async () => {
  tradingbalance.value = await authStore.tradingbalance;
  console.log(tradingbalance);
});

const refreshBalance = async () => {
  try {
    isRefreshing.value = true;
    const res = await authStore.refresh();
    tradingbalance.value = await authStore.tradingbalance;
    console.log(res);
  } catch (e) {
    console.log("Error fetching data");
  } finally {
    isLoading.value = false;
  }
};

//set max amount on click
// async setMax () => {
//   maxAmount.value = await authStore.tradingbalance;
// };

const transfer = async () => {
  isTransferring.value = true;
  showFailure.value = false;
  showSuccess.value = false;
  authStore.updateTranferArgs(transferArgs);
  const address = authStore.transferArgs.address;
  const amount = authStore.transferArgs.amount;
  const memo = authStore.transferArgs.memo;
  const created_at = authStore.transferArgs.created_at;
  let response = ref("");
  try {
    response = await authStore.whoamiActor?.transferFromSubAccountToSubAccount(
      address,
      parseInt(amount, 10)
    );

    console.log(response);
  } catch (error) {
    console.error("Error fetching data:", error);
  } finally {
    isTransferring.value = false;

    if (response.status === 200) {
      //  refreshBalance();
      Swal.fire({
        title: "Success",
        text: "You sent cksats",
        icon: "success",
      });
      transferArgs.address = "";
      transferArgs.amount = "";
      transferArgs.memo = "";
    } else {
      Swal.fire({
        title: "Failure",
        text: "You transcation was unsuccessful.Make sure you have some sats.Click on Get test token button",
        icon: "error",
      });
    }
  }
};
</script>
<template>
  <main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div class="mb-6">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">Transfer</h2>
      <p class="text-sm sm:text-base text-gray-500 font-normal">
        Send some cksats
      </p>
    </div>
    <!-- title section -->
    <!-- table section -->
    <div>
      <div class="bg-[#fff] border border-gray-100 shadow rounded-lg">
        <div>
          <div v-if="isTransferring == true">
            <div class="flex justify-center items-center h-screen">
              <div
                class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
              ></div>
            </div>
          </div>
          <div v-else class="p-5 flex flex-col space-y-4">
            <div
              v-show="showSuccess == true"
              role="alert"
              class="alert alert-success"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="stroke-current shrink-0 h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
              <span
                >Your transfer was successful! Go to transactions to view
                it</span
              >
            </div>
            <div
              v-show="showFailure == true"
              role="alert"
              class="alert alert-error"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="stroke-current shrink-0 h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
              <span>Error! Transfer failed . Retry</span>
            </div>

            <h1 class="text-3xl text-[#16151C] dark:text-white font-semibold">
              Transfer
            </h1>

            <div class="flex flex-col space-y-1">
              <div class="flex flex-row justify-between">
                <p
                  class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
                >
                  Enter AMount
                </p>
                <button
                  @click="transferArgs.amount = tradingbalance"
                  class="rounded-[10px] p-2 bg-slate-400"
                >
                  <span
                    class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
                    >Max</span
                  >
                </button>
              </div>

              <div class="flex items-center space-x-2">
                <div
                  class="select-none font-bold h-full bg-gray-200 rounded-md px-2 py-1 flex items-center justify-center text-gray-800 border border-gray-300"
                >
                  KES
                </div>
                <input
                  v-model="transferArgs.amount"
                  type="text"
                  class="flex h-9 w-full border border-slate-200 px-3 shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-slate-500 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-slate-950 disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-800 dark:placeholder:text-slate-400 dark:focus-visible:ring-slate-800 focus-visible:border-gray-700 bg-gray-100 rounded-md py-2 text-md uppercase tracking-widest font-bold"
                  inputmode="numeric"
                  aria-label="Enter Amount"
                  placeholder="Enter Amount in ckSats"
                  value="0"
                />
              </div>
              <div class="text-right text-sm text-black dark:text-white">
                <div v-if="isRefreshing == true">
                  <span class="loading loading-spinner loading-xs"></span>
                </div>
                <div v-else>
                  <span
                    class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
                  >
                    Available Balance:
                    {{ authStore.tradingbalance }}
                    ckSats
                  </span>
                </div>
              </div>
            </div>

            <div class="space-y-2">
              <p
                class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
              >
                Wallet Address
              </p>

              <input
                v-model="transferArgs.address"
                type="text"
                class="flex h-9 w-full border border-slate-200 px-3 shadow-sm transition-colors file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-slate-500 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-slate-950 disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-800 dark:placeholder:text-slate-400 dark:focus-visible:ring-slate-800 focus-visible:border-gray-700 bg-gray-100 rounded-md py-2 text-md uppercase tracking-widest font-bold"
                aria-label="Enter Wallet Address"
                placeholder="Enter Wallet Address"
                value="qcere-cvwig-oc5gc-rxklh-wmpwf-2ce5g-evkxy-zxi4q-bkvbh-spuf2-eae"
              />
            </div>

            <div class="space-y-2">
              <label
                class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
              >
                Memo (Optional)
              </label>
              <!--textarea
                v-model="transferArgs.memo"
                name="memo"
                placeholder="Add Memo to Transaction"
                class="w-full h-50 rounded-md border uppercase tracking-widest text-gray-800 dark:text-white font-semibold bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
              >
              </textarea
            -->
              <input
                v-model="transferArgs.memo"
                type="text"
                name="memo"
                id="memo"
                autocomplete="memo"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>

            <button
              @click="transfer"
              type="button"
              class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
            >
              Send
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- table section -->
  </main>
</template>
