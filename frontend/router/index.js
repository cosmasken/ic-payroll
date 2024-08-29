import { createRouter, createWebHistory } from "vue-router";

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
      path: "/setup-account",
      component: () => import("../SetupAccount.vue"),
    },

    {
      path: "/home",
      component: () => import("../App.vue"),
      children: [
        {
          path: "/home/dashboard",
          component: () => import("../components/Dashboard/Dashboard.vue"),
        },

        {
          path: "/home/add-employee",
          component: () => import("../components/Employee/AddEmployee.vue"),
        },

        {
          path: "/home/all-employees",
          component: () => import("../components/Employee/AllEmployees.vue"),
        },
        {
          path: "/home/consultants",
          component: () => import("../components/Employee/Consultants.vue"),
        },
        {
          path: "/home/edit-employee",
          component: () => import("../components/Employee/EditEmployee.vue"),
        },
        {
          path: "/home/view-employee",
          component: () => import("../components/Employee/EmployeeProfile.vue"),
        },
        {
          path: "/home/all-leaves",
          component: () => import("../components/Leave/AllLeaves.vue"),
        },
        {
          path: "/home/leave-application",
          component: () => import("../components/Leave/LeaveApplication.vue"),
        },
        {
          path: "/home/leave-settings",
          component: () => import("../components/Leave/LeaveSettings.vue"),
        },
        {
          path: "/home/departments",
          component: () => import("../components/Organogram/Departments.vue"),
        },
        {
          path: "/home/designations",
          component: () => import("../components/Organogram/Designations.vue"),
        },
        {
          path: "/home/organizations",
          component: () => import("../components/Organogram/Organizations.vue"),
        },
        {
          path: "/home/assign-assets",
          component: () => import("../components/Assets/AssignAssets.vue"),
        },
        {
          path: "/home/assigned-assets",
          component: () => import("../components/Assets/AssignedAssets.vue"),
        },
        {
          path: "/home/all-salary",
          component: () => import("../components/Payments/AllSalary.vue"),
        },
        {
          path: "/home/one-time-payments",
          component: () => import("../components/Payments/OneTimePayments.vue"),
        },
        {
          path: "/home/deductions",
          component: () => import("../components/Payments/Deductions.vue"),
        },
        {
          path: "/home/payslips",
          component: () => import("../components/Payments/Payslips.vue"),
        },
        {
          path: "/home/owner-profile",
          component: () => import("../components/Owner/OwnerProfile.vue"),
        },
        {
          path: "/home/transfer",
          component: () => import("../components/Payments/Transfer.vue"),
        },
        {
          path: "/home/transactions",
          component: () => import("../components/Payments/Transactions.vue"),
        },
        {
          path: "/home/freelancer",
          component: () => import("../components/Freelancer/Freelancer.vue"),
        },
        {
          path: "/home/bulk-payments",
          component: () => import("../components/Payments/BulkPayments.vue"),
        },
        {
          path: "/home/schedule-payments",
          component: () =>
            import("../components/Payments/SchedulePayments.vue"),
        },
      ],
    },
  ],
});

export default router;
