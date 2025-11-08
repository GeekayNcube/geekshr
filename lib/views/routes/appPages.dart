import 'package:geekshr/controllers/bindings/clientBinding.dart';
import 'package:geekshr/controllers/bindings/expenseClaimBinding.dart';
import 'package:geekshr/controllers/bindings/leaveApplicationBinding.dart';
import 'package:geekshr/controllers/bindings/scheduleBinding.dart';
import 'package:geekshr/views/clientProfile/clientProfile.dart';
import 'package:geekshr/views/dashboard/dashboard.dart';
import 'package:geekshr/views/expenseClaims/expenseClaims.dart';
import 'package:geekshr/views/leaveApplication/leaveApplication.dart';
import 'package:geekshr/views/routes/routes.dart';
import 'package:geekshr/views/settings/settings.dart';
import 'package:geekshr/views/sites/sitesPage.dart';
import 'package:geekshr/views/teams/teams.dart';
import 'package:get/get.dart';

import '../../controllers/bindings/announcementBinding.dart';
import '../../controllers/bindings/changePasswordBinding.dart';
import '../../controllers/bindings/clientLogsBinding.dart';
import '../../controllers/bindings/dashboardBinding.dart';
import '../../controllers/bindings/profileBinding.dart';
import '../../controllers/bindings/signInBinding.dart';
import '../../controllers/bindings/sitesBinding.dart';
import '../../controllers/bindings/timeTrackerBinding.dart';
import '../../controllers/bindings/userBinding.dart';
import '../../controllers/bindings/welcomeBinding.dart';
import '../announcement/announcement.dart';
import '../announcementDetail/announcementDetail.dart';
import '../changePassword/changePasswordPage.dart';
import '../clientLogs/clientLogsPage.dart';
import '../clients/clientPage.dart';
import '../expenseClaim/expenseClaim.dart';
import '../login/login.dart';
import '../onBoarding/onBoardingPage.dart';
import '../profile/profile.dart';
import '../requestLeaveApplication/RequestLeaveApplication.dart';
import '../schedules/schedulePage.dart';
import '../timeTracker/timeTracker.dart';
import '../timeTrackerMaintain/timeTrackerMaintain.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.OnBoarding,
      binding: WelcomeBinding(),
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      binding: SignInBinding(),
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      binding: DashboardBinding(),
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      binding: ProfileBinding(),
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: Routes.ChangePaswordPage,
      binding: ChangePasswordBinding(),
      page: () => const ChangePasswordPage(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      binding: UserBinding(),
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: Routes.ANNOUNCEMENTS,
      binding: AnnouncementBinding(),
      page: () => const AnnouncementPage(),
    ),
    GetPage(
      name: Routes.ANNOUNCEMENTSDETAIL,
      binding: AnnouncementBinding(),
      page: () => const AnnouncementDetailPage(),
    ),
    GetPage(
      name: Routes.LEAVEAPPLICATION,
      binding: LeaveApplicationBinding(),
      page: () => const LeaveApplicationPage(),
    ),
    GetPage(
      name: Routes.REQUESTLEAVEAPPLICATION,
      binding: LeaveApplicationBinding(),
      page: () => const RequestLeaveApplication(),
    ),
    GetPage(
      name: Routes.TEAMS,
      binding: UserBinding(),
      page: () => const TeamsPage(),
    ),
    GetPage(
      name: Routes.EXPENSES,
      binding: ExpenseClaimBinding(),
      page: () => const ExpenseClaimsPage(),
    ),
    GetPage(
      name: Routes.EXPENSECLAIMMAINTAIN,
      binding: ExpenseClaimBinding(),
      page: () => const ExpenseClaimPage(),
    ),
    GetPage(
      name: Routes.TIMETRACKERLIST,
      binding: TimeTrackerBinding(),
      page: () => const TimeTrackerPage(),
    ),
    GetPage(
      name: Routes.TIMETRACKER,
      binding: TimeTrackerBinding(),
      page: () => const TimeTrackerMaintainPage(),
    ),
    GetPage(
      name: Routes.SCHEDULES,
      binding: ScheduleBinding(),
      page: () => const SchedulesPage(),
    ),
    GetPage(
      name: Routes.CLIENTS,
      binding: ClientBinding(),
      page: () => const ClientPage(),
    ),
    GetPage(
      name: Routes.CLIENTPROFILE,
      binding: ClientBinding(),
      page: () => const ClientProfilePage(),
    ),
    GetPage(
      name: Routes.CLIENTLOGS,
      binding: ClientLogsBinding(),
      page: () => const ClientLogsPage(),
    ),
    GetPage(
      name: Routes.SITES,
      binding: SitesBinding(),
      page: () => const SitesPage(),
    ),
    /*



   ,





    GetPage(
      name: Routes.MESSAGEDETAIL,
      binding: DashboardBinding(),
      page: () => const InboxDetailPage(),
    ),
   */
  ];
}
