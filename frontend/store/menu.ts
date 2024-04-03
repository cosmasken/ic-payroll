import { defineStore } from 'pinia';
import { ref } from 'vue';
import allPlans from '../constants/selectPlans';
import { AddOns, PricingObjKey } from '../types';

export const useMenuStore = defineStore('menu', () => {
  const menus = ref(['your info', 'select plan', 'add-ons', 'summary']);
  const currentMenuIdx = ref(1);

  const setMenu = (menuIdx: number) => {
    currentMenuIdx.value = menuIdx;
  };

  return { menus, currentMenuIdx, setMenu };
});

export const useStepOneStore = defineStore('step-1', () => {
  const name = ref('');
  const email = ref('');
  const phoneNumber = ref('');

  return { name, email, phoneNumber };
});

export const usePlanStore = defineStore('step-2', () => {
  const pricingType = ref('monthly');
  const selectedPlan = ref({
    title: 'arcade',
    price: 9,
  });

  const handleChangePlan = () => {
    pricingType.value = pricingType.value === 'monthly' ? 'yearly' : 'monthly';

    const currentPlan = allPlans.find(
      (plan) =>
        plan.title.toLowerCase() === selectedPlan.value.title.toLowerCase()
    );

    selectedPlan.value.price =
      currentPlan!.pricing[pricingType.value as PricingObjKey];
  };

  const handleSelectPlan = (title: string, price: number) => {
    selectedPlan.value = { title, price };
  };

  return { pricingType, selectedPlan, handleChangePlan, handleSelectPlan };
});

export const useAddOnsStore = defineStore('step-3', () => {
  const allSelectedAddOns = ref<AddOns[]>([]);

  const selectAddOns = (newTitle: string, price: number) => {
    const title = newTitle.toLowerCase();

    const alreadySelectedItem = allSelectedAddOns.value.find(
      (item) => item.title === title
    );

    if (alreadySelectedItem) {
      allSelectedAddOns.value = allSelectedAddOns.value.filter(
        (item) => item.title !== alreadySelectedItem.title
      );
    } else {
      allSelectedAddOns.value.push({ title, price });
    }
  };

  const isSelected = (title: string) => {
    return allSelectedAddOns.value.some(
      (t) => t.title.toLowerCase() === title.toLowerCase()
    );
  };

  return { allSelectedAddOns, isSelected, selectAddOns };
});
