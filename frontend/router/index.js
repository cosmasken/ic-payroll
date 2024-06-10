import { createRouter, createWebHistory } from "vue-router";
import AllEmployees from "../components/Employee/AllEmployees.vue";
import Departments from "../components/Organogram/Departments.vue";
import Designations from "../components/Organogram/Designations.vue";
import Organizations from "../components/Organogram/Organizations.vue";
import AddEmployee from "../components/Employee/AddEmployee.vue";
import Consultants from "../components/Employee/Consultants.vue";
import EditEmployee from "../components/Employee/EditEmployee.vue";
import ViewEmployee from "../components/Employee/EmployeeProfile.vue";
import AllLeaves from "../components/Leave/AllLeaves.vue";
import LeaveApplication from "../components/Leave/LeaveApplication.vue";
import LeaveSettings from "../components/Leave/LeaveSettings.vue";
import AssignAssets from "../components/Assets/AssignAssets.vue";
import AssignedAssets from "../components/Assets/AssignedAssets.vue";
import AllSalary from "../components/Payments/AllSalary.vue";
import OneTimePayments from "../components/Payments/OneTimePayments.vue";
import Deductions from "../components/Payments/Deductions.vue";
import Payslips from "../components/Payments/Payslips.vue";
import Dashboard from "../components/Dashboard.vue";
import OwnerProfile from "../components/Owner/OwnerProfile.vue";
import Transfer from "../components/Payments/Transfer.vue";
import Transactions from "../components/Payments/Transactions.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      redirect: "/auth",
    },
    {
      path: "/auth",
      component: () => import("../AuthGuard.vue"),
    },

    {
      path: "/account-selector",
      component: () => import("../AccountSelector.vue"),  
    },

    {
      path: "/home",
      component: () => import("../App.vue"),
      children: [
        {
          path: "/home/dashboard",
          component: Dashboard,
        },

        {
          path: "/home/add-employee",
          component: AddEmployee,
        },

        {
          path: "/home/all-employees",
          component: AllEmployees,
        },
        {
          path: "/home/consultants",
          component: Consultants,
        },
        {
          path: "/home/edit-employee",
          component: EditEmployee,
        },
        {
          path: "/home/view-employee",
          component: ViewEmployee,
        },
        {
          path: "/home/all-leaves",
          component: AllLeaves,
        },
        {
          path: "/home/leave-application",
          component: LeaveApplication,
        },
        {
          path: "/home/leave-settings",
          component: LeaveSettings,
        },
        {
          path: "/home/departments",
          component: Departments,
        },
        {
          path: "/home/designations",
          component: Designations,
        },
        {
          path: "/home/organizations",
          component: Organizations,
        },
        {
          path: "/home/assign-assets",
          component: AssignAssets,
        },
        {
          path: "/home/assigned-assets",
          component: AssignedAssets,
        },
        {
          path: "/home/all-salary",
          component: AllSalary,
        },
        {
          path: "/home/one-time-payments",
          component: OneTimePayments,
        },
        {
          path: "/home/deductions",
          component: Deductions,
        },
        {
          path: "/home/payslips",
          component: Payslips,
        },
        {
          path: "/home/owner-profile",
          component: OwnerProfile,
        },
        {
          path: "/home/transfer",
          component: Transfer,
        },
        {
          path: "/home/transactions",
          component: Transactions,
        }
      ],
    },
  ],
});

export default router;
