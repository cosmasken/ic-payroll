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
      name: "Auth",
      component: () => import("../App.vue"),
    },

    {
      path: "/home",
      component: () => import("../Home.vue"),
      children: [
        {
          path: "/home/dashboard",
          component: () => import("../views/Dashboard.vue"),
          meta: { transition: 'slide-left' },
        },
        {
          path: "/home/attendance",
          component: () => import("../views/Attendance.vue"),
        },
        {
          path: "/home/all-employees",
          component: () => import("../views/AllEmployees.vue"),
        },
        {
          path: "/home/contacts",
          component: () => import("../views/Contacts.vue"),
        },
        {
          path: "/home/transfer",
          component: () => import("../views/Transfer.vue"),
        },
        {
          path: "/home/candidates",
          component: () => import("../views/Candidates.vue"),
        },
        {
          path: "/home/departments",
          component: () => import("../views/Departments.vue"),
        },
        {
          path: "/home/holidays",
          component: () => import("../views/Holidays.vue"),
        },
        {
          path: "/home/transactions",
          component: () => import("../views/Transactions.vue"),
        },
        {
          path: "/home/invoices",
          component: () => import("../views/Invoices.vue"),
        },
        {
          path: "/home/jobs",
          component: () => import("../views/Jobs.vue"),
        },
        {
          path: "/home/notifications",
          component: () => import("../views/Notifications.vue"),
        },
        {
          path: "/home/payroll",
          component: () => import("../views/Payroll.vue"),
        },
        {
          path: "/home/leaves",
          component: () => import("../views/Leaves.vue"),
        },
        {
          path: "/home/profile",
          component: () => import("../views/Profile.vue"),
        },
        {
          path: "/home/settings",
          component: () => import("../views/Settings.vue"),
        },
        {
          path: "/home/view-department",
          name: "ViewDepartment",
          component: () => import("../views/ViewDepartments.vue"),
        },
        {
          path: "/home/add-employee",
          component: () => import("../views/AddEmployee.vue"),
          children: [
            {
              path: "/home/add-employee/personal-information",
              component: () => import("../components/PersonalInformation.vue"),
            },
            {
              path: "/home/add-employee/professional-information",
              component: () => import("../components/ProfessionalInformation.vue"),
            },
            {
              path: "/home/add-employee/documents",
              component: () => import("../components/Documents.vue"),
            },
            {
              path: "/home/add-employee/account-access",
              component: () => import("../components/AccountAccess.vue"),
            },
          ]
        },
        {
          path: "/home/view-employee",
          component: () => import("../views/ViewEmployee.vue"),
          children: [
            {
              path: "/home/view-employee/personal-information",
              component: () => import("../components/ViewPersonalInformation.vue"),
            },
            {
              path: "/home/view-employee/professional-information",
              component: () => import("../components/ViewProfessionalInformation.vue"),
            },
            {
              path: "/home/view-employee/documents",
              component: () => import("../components/ViewDocuments.vue"),
            },
            {
              path: "/home/view-employee/account-access",
              component: () => import("../components/ViewAccountAccess.vue"),
            },
          ]
        },
      ],
    },
  ],
});

export default router;
