import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geekshr/models/announcement.dart';
import 'package:geekshr/models/clientDetailDto.dart';
import 'package:geekshr/models/clientDto.dart';
import 'package:geekshr/models/clientLogTypeDto.dart';
import 'package:geekshr/models/expenseClaimDto.dart';
import 'package:geekshr/models/leaveApplicationDto.dart';
import 'package:geekshr/models/leaveApplicationTypesDto.dart';
import 'package:geekshr/models/scheduleDto.dart';
import 'package:geekshr/models/siteDto.dart';
import 'package:geekshr/models/timeTrackerDto.dart';
import 'package:geekshr/models/userDTo.dart';
import 'package:get/get.dart';

import '../../models/Failure.dart';
import '../../models/User.dart';
import '../../models/changePasswordDto.dart';
import '../../models/clientLogDto.dart';
import '../../models/inboxDto.dart';
import '../../models/loginDTO.dart';
import '../../models/resetPassword.dart';
import '../http/HttpService.dart';
import '../http/http_service_impl.dart';
import '../type_defs.dart';
import 'mainRepository.dart';

class MainRepositoryImplementation implements MainRepository {
  HttpService? _httpService;

  MainRepositoryImplementation() {
    _httpService = Get.put(HttpServiceImpl());
  }

  @override
  FutureEither<bool> changePassword(ChangePasswordDto changePasswordDto) async {
    try {
      final response = await _httpService?.post(
        "api/user/ChangePassword",
        changePasswordDto.toJson(),
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];

        bool verified = results;
        return right(verified);
      }
      return left(
        Failure("Your request could not be processed, please try again"),
      );
    } on DioException catch (e) {
      var message = _getMessage(e);
      return left(Failure(message!));
    }
  }

  /// always return  FutureEither<> someting. Left mean its unsuccessful and right mean success
  @override
  FutureEither<User> login(LoginDto loginDto) async {
    try {
      final response = await _httpService?.post(
        "api/User/LoginUser",
        loginDto.toJson(),
      );
      var user = User();
      if (response?.statusCode == 200) {
        final results = response?.data['data'];

        user = User().fromJson(results, true);
        return right(user);
      }
      return left(Failure("Could not login, please try again"));
    } on DioException catch (e) {
      var message = _getMessage(e);
      return left(Failure(message!));
    }
  }

  @override
  FutureEither<bool> resetPassword(ResetPasswordDto resetPasswordDto) async {
    try {
      final response = await _httpService?.post(
        "api/User/ResetPassword",
        resetPasswordDto.toJson(),
      );

      if (response?.statusCode == 200) {
        return right(true);
      }
      return left(
        Failure("Your request could not be processed, please try again"),
      );
    } on DioException catch (e) {
      var message = e.response?.data["message"].toString();

      return left(Failure(message!));
    }
  }

  _getMessage(DioException e) {
    String? message;
    if (e.response!.data.toString().isEmpty) {
      message = e.message.toString();
    } else {
      message = e.response?.data["message"].toString();
    }
    return message;
  }

  @override
  FutureEither<List<InboxDto>> getMessages(int pageNumber, int pageSize) async {
    try {
      if (pageSize == 0) pageSize = 10;
      final response = await _httpService?.getRequest(
        "/api/inbox/GetMessagesByUser?pageNumber=$pageNumber&pageSize=$pageSize",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final inboxData = List<Map<String, dynamic>>.from(results['items']);
        List<InboxDto> data = [];

        if (inboxData.isNotEmpty) {
          List<InboxDto> list = inboxData
              .map((data) => InboxDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<bool> updateInbox(int inboxId) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data["inboxId"] = inboxId.toString();
      final response = await _httpService?.post("api/Inbox/Update", data);

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("Could update, please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<bool> delete() async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data["UseId"] = "0";
      final response = await _httpService?.post("api/User/Delete", data);

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("Could delete, please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<AnnouncementDto>> getAnnouncements(
    int pageNumber,
    int pageSize,
    String search,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;
      final response = await _httpService?.getRequest(
        "/api/Announcement/Search?pageNumber=$pageNumber&pageSize=$pageSize&Search=$search&ActiveOnly=true",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final announcementDtoData = List<Map<String, dynamic>>.from(
          results['items'],
        );
        List<AnnouncementDto> data = [];

        if (announcementDtoData.isNotEmpty) {
          List<AnnouncementDto> list = announcementDtoData
              .map((data) => AnnouncementDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<LeaveApplicationDto>> getLeaves(
    DateTime start,
    DateTime end,
  ) async {
    try {
      String startdate = start.toIso8601String();
      String enddate = end.toIso8601String();

      final response = await _httpService?.getRequest(
        "/api/LeaveApplication/Search?StartDate=$startdate&EndDate=$enddate&leaveapplicationTypeId=0&leaveapplicationStatusId=0&userId=0",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final leaveApplicationDto = List<Map<String, dynamic>>.from(results);
        List<LeaveApplicationDto> data = [];

        if (leaveApplicationDto.isNotEmpty) {
          List<LeaveApplicationDto> list = leaveApplicationDto
              .map((data) => LeaveApplicationDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<LeaveApplicationTypesDto>>
  getLeaveApplicationTypes() async {
    try {
      final response = await _httpService?.getRequest(
        "/api/LeaveApplicationTypes/GetLeaveApplicationTypes",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final leaveApplicationTypesDtoData = List<Map<String, dynamic>>.from(
          results,
        );
        List<LeaveApplicationTypesDto> data = [];

        if (leaveApplicationTypesDtoData.isNotEmpty) {
          List<LeaveApplicationTypesDto> list = leaveApplicationTypesDtoData
              .map((data) => LeaveApplicationTypesDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<int> requestLeave(
    DateTime start,
    DateTime end,
    int leaveApplicationTypeId,
    int numberOfDays,
    String notes,
  ) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data["startDate"] = start.toIso8601String();
      data["endDate"] = start.toIso8601String();
      data["leaveApplicationTypeId"] = leaveApplicationTypeId;
      data["numberOfDays"] = numberOfDays;
      data["notes"] = notes;

      final response = await _httpService?.post(
        "/api/LeaveApplication/Save",
        data,
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<bool> cancelLeaveApplication(int leaveApplicationId) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data["LeaveApplicationId"] = leaveApplicationId;
      data["Code"] = "CAN";
      final response = await _httpService?.post(
        "/api/LeaveApplication/ApproveOrDecline",
        data,
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<UserDto> getUsers(
    String search,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;
      final response = await _httpService?.getRequest(
        "/api/user/getcompanyusers?search=$search&pageNumber=$pageNumber&pageSize=$pageSize&userStatusId=0",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        UserDto data = UserDto.fromJson(results);
        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<ExpenseClaimDto>> getExpenseClaims(
    String search,
    int userId,
    String expenseClaimStatusCode,
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;

      String start = startDate.toIso8601String();
      String end = endDate.toIso8601String();

      final response = await _httpService?.getRequest(
        "/api/ExpenseClaim/GetExpenseClaims?search=$search&pageNumber=$pageNumber&pageSize=$pageSize&userId=0&expenseClaimStatusCode=$expenseClaimStatusCode&startDate=$start&endDate=$end",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final expenseData = List<Map<String, dynamic>>.from(results);
        List<ExpenseClaimDto> data = [];

        if (expenseData.isNotEmpty) {
          List<ExpenseClaimDto> list = expenseData
              .map((data) => ExpenseClaimDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<int> claim(
    DateTime expenseDate,
    double amount,
    String title,
    String notes,
    String imageData,
  ) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      String date = expenseDate.toIso8601String();
      data["expenseDate"] = date;
      data["amount"] = amount;
      data["title"] = title;
      data["notes"] = notes;
      data["imageData"] = imageData;
      final response = await _httpService?.post("/api/ExpenseClaim/Save", data);

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<TimeTrackerDto>> getTimeTrackerQueryByUser(
    String search,
    int userId,
    String timeTrackerStatusCode,
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;

      String start = startDate.toIso8601String();
      String end = endDate.toIso8601String();

      final response = await _httpService?.getRequest(
        "/api/TimeTracker/GetTimeTrackerQueryByUser?search=$search&pageNumber=$pageNumber&pageSize=$pageSize&userId=0&timeTrackerStatusCode=$timeTrackerStatusCode&startDate=$start&endDate=$end",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final timeTrackerDtoData = List<Map<String, dynamic>>.from(results);
        List<TimeTrackerDto> data = [];

        if (timeTrackerDtoData.isNotEmpty) {
          List<TimeTrackerDto> list = timeTrackerDtoData
              .map((data) => TimeTrackerDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<SiteDto>> getSitesByLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await _httpService?.getRequest(
        "/api/Site/GetSiteByLocaton?latitude=$latitude&longitude=$longitude",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        List<SiteDto> data = [];
        final siteDtoDtoData = List<Map<String, dynamic>>.from(results);

        if (siteDtoDtoData.isNotEmpty) {
          List<SiteDto> list = siteDtoDtoData
              .map((data) => SiteDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<int> trackerSave(
    int timeTrackerId,
    String notes,
    bool checkIn,
    double checkInLat,
    double checkInLong,
    double checkOutLat,
    double checkOutLong,
    int siteId,
  ) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};

      data["timeTrackerId"] = timeTrackerId;
      data["notes"] = notes;
      data["checkIn"] = checkIn;
      data["checkInLat"] = checkInLat;
      data["checkInLong"] = checkInLong;
      data["checkOutLat"] = checkOutLat;
      data["checkOutLong"] = checkOutLong;
      data["siteId"] = siteId;
      final response = await _httpService?.post("/api/TimeTracker/Save", data);

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<ScheduleDto>> getSchedules(
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;

      String start = startDate.toIso8601String();
      String end = endDate.toIso8601String();

      final response = await _httpService?.getRequest(
        "/api/Schedule/GetUserSchedules?pageNumber=$pageNumber&pageSize=$pageSize&userId=0&dateFrom=$start&dateTo=$end",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final scheduleDtoData = List<Map<String, dynamic>>.from(results);
        List<ScheduleDto> data = [];

        if (scheduleDtoData.isNotEmpty) {
          List<ScheduleDto> list = scheduleDtoData
              .map((data) => ScheduleDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<ClientDto>> getClients(int siteId) async {
    try {
      final response = await _httpService?.getRequest(
        "/api/client/GetClientList?siteId=$siteId&search=",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final clientDtoData = List<Map<String, dynamic>>.from(results);
        List<ClientDto> data = [];

        if (clientDtoData.isNotEmpty) {
          List<ClientDto> list = clientDtoData
              .map((data) => ClientDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<ClientDetailDto> getClient(int clientId) async {
    try {
      final response = await _httpService?.getRequest(
        "/api/Client/GetClient?clientId=$clientId",
      );
      var clientDto = ClientDetailDto();
      if (response?.statusCode == 200) {
        final results = response?.data['data'];

        clientDto = ClientDetailDto.fromJson(results);
        return right(clientDto);
      }
      return left(Failure("Could not login, please try again"));
    } on DioException catch (e) {
      var message = _getMessage(e);
      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<ClientLogDto>> getClientLogs(
    DateTime startDate,
    DateTime endDate,
    int pageNumber,
    int pageSize,
    clientId,
  ) async {
    try {
      if (pageSize == 0) pageSize = 10;

      String start = startDate.toIso8601String();
      String end = endDate.toIso8601String();

      final response = await _httpService?.getRequest(
        "/api/ClientLog/GetClientLogList?pageNumber=$pageNumber&pageSize=$pageSize&clientId=$clientId&dateFrom=$start&dateTo=$end",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final clientLogDtoData = List<Map<String, dynamic>>.from(results);
        List<ClientLogDto> data = [];

        if (clientLogDtoData.isNotEmpty) {
          List<ClientLogDto> list = clientLogDtoData
              .map((data) => ClientLogDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<int> saveClientLog(
    String notes,
    int clientLogTypeId,
    int clientId,
    String image,
  ) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};

      data["clientLogTypeId"] = clientLogTypeId;
      data["notes"] = notes;
      data["clientId"] = clientId;
      data["ImageData"] = image;
      final response = await _httpService?.post("/api/ClientLog/Save", data);

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        return right(results);
      }
      return left(Failure("please try again"));
    } on DioException catch (e) {
      String? message = _getMessage(e);

      return left(Failure(message!));
    }
  }

  @override
  FutureEither<List<ClientLogTypeDto>> getClientLogTypes() async {
    try {
      final response = await _httpService?.getRequest(
        "/api/ClientLogType/GetClientLogTypeList",
      );

      if (response?.statusCode == 200) {
        final results = response?.data['data'];
        final clientLogTypeDtoData = List<Map<String, dynamic>>.from(results);
        List<ClientLogTypeDto> data = [];

        if (clientLogTypeDtoData.isNotEmpty) {
          List<ClientLogTypeDto> list = clientLogTypeDtoData
              .map((data) => ClientLogTypeDto.fromJson(data))
              .toList(growable: false);
          data = list;
        }

        return right(data);
      }
      return left(Failure("No data"));
    } on DioException catch (e) {
      var message = _getMessage(e);

      return left(Failure(message!));
    }
  }
}
