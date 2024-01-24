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
        },
        {
          path: "/home/attendance",
          component: () => import("../views/Attendance.vue"),
        },
        {
          path: "/home/employees",
          component: () => import("../views/Employees.vue"),
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
          path: "/home/jobs",
          component: () => import("../views/Jobs.vue"),
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
        },
      ],
    },
  ],
});

export default router;
