<template>
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
        <span>Your transfer was successful! Go to transactions to view it</span>
      </div>
      <div v-show="showFailure == true" role="alert" class="alert alert-error">
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
            Enter Amount
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
              {{
                selectedAccountType === "main"
                  ? BigInt(Math.round(authStore.fundingbalance))
                  : authStore.tradingbalance
              }}
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
        <textarea
          v-model="transferArgs.memo"
          name="memo"
          placeholder="Add Memo to Transaction"
          class="w-full h-50 rounded-md border uppercase tracking-widest text-gray-800 dark:text-white font-semibold bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
        >
  Write something here</textarea
        >
      </div>

      <div>
        <button
          @click="transfer"
          type="button"
          class="inline-flex w-1/5 items-center gap-x-1.5 justify-between rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        >
          Send
          <div class="-mr-0.5 h-5 w-5" aria-hidden="true">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="20"
              viewBox="0 0 20 20"
              fill="none"
            >
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M0 10C0 4.48609 4.48609 0 10 0C15.5143 0 20 4.48609 20 10C20 15.5143 15.5143 20 10 20C4.48609 20 0 15.5143 0 10ZM12.0465 13.7857L15.5243 10.3078C15.5648 10.2674 15.5965 10.2196 15.6187 10.1661C15.6626 10.06 15.6626 9.94 15.6187 9.83391C15.5965 9.78043 15.5648 9.73217 15.5243 9.69217L12.0465 6.21435C11.8765 6.04435 11.6017 6.04435 11.4317 6.21435C11.2617 6.38435 11.2617 6.65913 11.4317 6.82913L14.1678 9.56522H4.78261C4.54261 9.56522 4.34783 9.76 4.34783 10C4.34783 10.24 4.54261 10.4348 4.78261 10.4348H14.1678L11.4317 13.1709C11.2617 13.3409 11.2617 13.6157 11.4317 13.7857C11.5165 13.8704 11.6278 13.913 11.7391 13.913C11.8504 13.913 11.9617 13.8704 12.0465 13.7857Z"
                fill="white"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M13.6377 9.2429H4.24774C3.83478 9.2429 3.5 9.58178 3.5 9.99981C3.5 10.4178 3.83478 10.7567 4.24774 10.7567H13.6375L11.2162 13.2079C10.9243 13.5035 10.9243 13.9828 11.2163 14.2783C11.5083 14.5739 11.9818 14.5739 12.2738 14.2783L16.5 9.99984L12.2745 5.72175C11.9826 5.42613 11.5091 5.42608 11.2171 5.72164C10.925 6.0172 10.925 6.49645 11.217 6.79207L13.6377 9.2429Z"
                fill="#FA7200"
              />
            </svg>
          </div>
        </button>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
let tradingbalance = ref("");
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
  amount: "",
};

watchEffect(async () => {
  tradingbalance.value = await authStore.tradingbalance;
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
    // response = await authStore.whoamiActor?.transferFromSubAccountToSubAccount(
    //   address,
    //   BigInt(Math.round(amount))
    // );
    response = await authStore.whoamiActor?.transferFromSubAccountToSubAccount(
      address,
      amount
    );

    console.log(response);
  } catch (error) {
    console.error("Error fetching data:", error);
  } finally {
    isTransferring.value = false;

    if (response.status === 200) {
      refreshBalance();
      showSuccess.value = true;
      transferArgs.address = "";
      transferArgs.amount = "";
      transferArgs.memo = "";
    } else {
      showFailure.value = true;
    }
  }
};
</script>
