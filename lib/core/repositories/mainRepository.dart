import 'package:geekshr/models/clientDto.dart';
import 'package:geekshr/models/clientLogTypeDto.dart';
import 'package:geekshr/models/expenseClaimDto.dart';
import 'package:geekshr/models/userDTo.dart';

import '../../models/User.dart';
import '../../models/announcement.dart';
import '../../models/changePasswordDto.dart';
import '../../models/clientDetailDto.dart';
import '../../models/clientLogDto.dart';
import '../../models/inboxDto.dart';
import '../../models/leaveApplicationDto.dart';
import '../../models/leaveApplicationTypesDto.dart';
import '../../models/loginDTO.dart';
import '../../models/resetPassword.dart';
import '../../models/scheduleDto.dart';
import '../../models/siteDto.dart';
import '../../models/timeTrackerDto.dart';
import '../type_defs.dart';

abstract class MainRepository {
  FutureEither<User> login(LoginDto loginDto);
  FutureEither<bool> changePassword(ChangePasswordDto changePasswordDto);
  FutureEither<bool> resetPassword(ResetPasswordDto resetPasswordDto);
  FutureEither<List<InboxDto>> getMessages(int pageNumber, int pageSize);
  FutureEither<bool> updateInbox(int inboxId);
  FutureEither<bool> delete();

  FutureEither<List<AnnouncementDto>> getAnnouncements(
    int pageNumber,
    int pageSize,
    String search,
  );
  FutureEither<List<LeaveApplicationDto>> getLeaves(
    DateTime startDate,
    DateTime endDate,
  );

  FutureEither<List<LeaveApplicationTypesDto>> getLeaveApplicationTypes();

  FutureEither<int> requestLeave(
    DateTime start,
    DateTime end,
    int leaveApplicationTypeId,
    int numberOfDays,
    String notes,
  );
  FutureEither<bool> cancelLeaveApplication(int leaveApplicationId);
  FutureEither<UserDto> getUsers(String search, int pageNumber, int pageSize);

  FutureEither<List<ExpenseClaimDto>> getExpenseClaims(
    String search,
    int userId,
    String expenseClaimStatusCode,
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  );

  FutureEither<int> claim(
    DateTime expenseDate,
    double amount,
    String title,
    String notes,
    String imageData,
  );

  FutureEither<List<TimeTrackerDto>> getTimeTrackerQueryByUser(
    String search,
    int userId,
    String timeTrackerStatusCode,
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  );

  FutureEither<List<SiteDto>> getSitesByLocation(
    double latitude,
    double longitude,
  );

  FutureEither<int> trackerSave(
    int timeTrackerId,
    String notes,
    bool checkIn,
    double checkInLat,
    double checkInLong,
    double checkOutLat,
    double checkOutLong,
    int siteId,
  );

  FutureEither<List<ScheduleDto>> getSchedules(
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  );

  FutureEither<List<ClientDto>> getClients(int siteId);
  FutureEither<ClientDetailDto> getClient(int clientId);

  FutureEither<List<ClientLogDto>> getClientLogs(
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
    clientId,
  );

  FutureEither<List<ClientLogTypeDto>> getClientLogTypes();

  FutureEither<int> saveClientLog(
    String notes,
    int clientLogTypeId,
    int clientId,
    String image,
  );
}
