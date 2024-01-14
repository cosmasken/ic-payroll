import { createRouter, createWebHistory } from 'vue-router'
const router = createRouter({
    history: createWebHistory(
        import.meta.env.BASE_URL),
    routes: [

        {
            path: '/',
            redirect: '/auth'
          },
          {
            path: '/auth',
            name: 'Auth',
            component: () => import('../App.vue')
          },
          {
            path: '/home',
            name: 'Home',
            component: () => import('../Home.vue')
          },
        {
            path: '/dashboard',
            name: 'Dashboard',
            component: () =>
                import ('../views/Dashboard.vue')
        },
        {
            path: '/freelancers',
            name: 'Freelancers',
            component: () =>
                import ('../freelancer/Dashboard.vue')
        },
        {
            path: '/attendance',
            name: 'Attendance',
            component: () => import('../views/Attendance.vue')
          },
          {
            path: '/candidates',
            name: 'Candidates',
            component: () => import('../views/Candidates.vue')
          },
          {
            path: '/departments',
            name: 'Departments',
            component: () => import('../views/Departments.vue')
          },
          {
            path: '/add-employee',
            component: () => import('../views/AddEmployee.vue'),
            children: [
              {
                path: '',
                component: () => import('../components/PersonalInformation.vue')
              },
              {
                path: '/add-employee/professional-information',
                component: () => import('../components/ProfessionalInformation.vue')
              },
              {
                path: '/add-employee/account-access',
                component: () => import('../components/AccountAccess.vue')
              },
              {
                path: '/add-employee/documents',
                component: () => import('../components/Documents.vue')
              }
            ]
          },
          {
            path: '/employees',
            name: 'Employees',
            component: () => import('../views/Employees.vue')
          },
          {
            path: '/holidays',
            name: 'Holidays',
            component: () => import('../views/Holidays.vue')
          },
          {
            path: '/jobs',
            name: 'Jobs',
            component: () => import('../views/Jobs.vue')
          },
          {
            path: '/leaves',
            name: 'Leaves',
            component: () => import('../views/Leaves.vue')
          },
          {
            path: '/payroll',
            name: 'Payroll',
            component: () => import('../views/Payroll.vue')
          },
          {
            path: '/settings',
            name: 'Settings',
            component: () => import('../views/Settings.vue')
          },
          // {
          //   path: '/add-employee',
          //   name: 'AddEmployee',
          //   component: () => import('../views/AddEmployee.vue')
          // },
          {
            path: '/view-department',
            name: 'ViewDepartment',
            component: () => import('../views/ViewDepartments.vue')
          }


       

    ]
})

export default router