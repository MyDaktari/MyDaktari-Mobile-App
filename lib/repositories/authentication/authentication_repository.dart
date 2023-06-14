import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/urls.dart';
import '../../models/models.dart';
import './base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final baseUrl = "https://goldeneaglespurs.vesencomputing.com";
  //client
  @override
  Future<ClientModel> loginClient(
      {required String username, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('$loginClientUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['user']);
      preferences.setString('user', jsonEncode(responseBody['user']));
      preferences.setString('userType', UserType.client.name);
      return client;
    } else if (response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 400) {
      throw Exception('Incorrect username or password');
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<ClientModel> registerClient(
      {required String address,
      required String dob,
      required String email,
      required String gender,
      required String name,
      required String password,
      required String phone}) async {
    final response = await http.post(Uri.parse('$registerClientUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "dob": dob,
          "gender": gender,
          "password": password,
          "address": address,
          "lat": "",
          "lng": "",
        }));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['data']);
      preferences.setString('user', jsonEncode(responseBody['data']));
      preferences.setString('userType', UserType.client.name);

      userPhoneNumber = client.phone!;
      return client;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception('Incorrect username or password');
    } else if (response.statusCode == 409) {
      throw Exception('Email already exist');
    } else {
      throw Exception('Failed to register user');
    }
  }

  //doctor
  @override
  Future<DoctorModel> loginDoctor(
      {required String username, required String password}) async {
    final response = await http.post(Uri.parse('$loginDoctorUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(responseBody['data']);
      preferences.setString('user', jsonEncode(responseBody['data']));
      preferences.setString('userType', UserType.doctor.name);
      preferences.setString(
          'profileCompleted', jsonEncode(responseBody['profile_completed']));
      preferences.setString('fullProfileCompleted',
          jsonEncode(responseBody['full_profile_completed']));
      //Doctor Availability
      bool fullProfileCompleted = responseBody['full_profile_completed'];
      if (fullProfileCompleted) {
        schedulesConstant = availabilityToSchedules(
            responseBody['data']['doctorAvailability'] as Map<String, dynamic>);
        preferences.setString('schedules',
            jsonEncode(responseBody['data']['doctorAvailability']));
      }
      return doctor;
    } else if (response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 400) {
      throw Exception('Incorrect username or password');
    } else {
      throw Exception('Failed to login ${response.statusCode}');
    }
  }

  @override
  Future<DoctorModel> registerDoctor({
    required String name,
    required String password,
    required String phone,
    required String dob,
    required String gender,
    required String email,
  }) async {
    final response = await http.post(Uri.parse('$registerDoctorUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "dob": dob,
          "gender": gender,
          "password": password
        }));

    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(responseBody['data']);
      preferences.setString('user', jsonEncode(responseBody['data']));
      preferences.setString('userType', UserType.doctor.name);
      preferences.setString(
          'profileCompleted', jsonEncode(responseBody['profile_completed']));
      preferences.setString('fullProfileCompleted',
          jsonEncode(responseBody['full_profile_completed']));
      userPhoneNumber = doctor.phone!;
      return doctor;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception('Incorrect username or password');
    } else if (response.statusCode == 409) {
      throw Exception('Email already exist');
    } else {
      throw Exception('Failed to register doctor');
    }
  }

  //function to check the user Authentication status
  @override
  Future<Map<String, dynamic>> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userFromPrefs = preferences.getString('user');
    String? userTypeFromPrefs = preferences.getString('userType');
    String? profileCompletedFromPrefs =
        preferences.getString('profileCompleted');
    String? fullProfileCompletedFromPrefs =
        preferences.getString('fullProfileCompleted');
    String? doctorSchedules = preferences.getString('schedules');

    dynamic user;

    if (userTypeFromPrefs != null) {
      if (userFromPrefs != null) {
        if (userTypeFromPrefs == UserType.client.name) {
          final userString = jsonDecode(userFromPrefs);
          ClientModel client = ClientModel.fromJson(userString);
          user = client;
        } else {
          final userString = jsonDecode(userFromPrefs);
          DoctorModel doctor = DoctorModel.fromJson(userString);
          user = doctor;
        }
      }
      return {
        'user': user,
        'profileCompleted': profileCompletedFromPrefs,
        'fullProfileCompleted': fullProfileCompletedFromPrefs,
        'doctorSchedule': doctorSchedules,
        'userType': (userTypeFromPrefs == UserType.client.name)
            ? UserType.client
            : UserType.doctor
      };
    } else {
      throw Exception('User Not Authenticated');
    }
  }

  @override
  Future<String> otpRequest({required String phoneNumber}) async {
    final response = await http.post(Uri.parse('$otpRequestUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else {
      throw Exception('Fail to send OTP ${response.statusCode}');
    }
  }

  @override
  Future<String> otpVerification(
      {required String phoneNumber, required String otp}) async {
    final response = await http.post(Uri.parse('$otpVerificationUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber, "otp": otp}));

    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else {
      throw Exception('Invalid OTP ${response.statusCode}');
    }
  }

  @override
  Future<String> passwordOtpVerification(
      {required String phoneNumber, required String otp}) async {
    final response = await http.post(
        Uri.parse(
            "https://mydoc.my-daktari.com/new_api/verifyForgotPasswordOTP.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"identifier": phoneNumber, "otp": otp}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['UserID'].toString();

      return message;
    } else {
      throw Exception('Invalid OTP');
    }
  }

  @override
  Future<String> passwordOtpRequest(
      {required String phoneNumber, required UserType userType}) async {
    print('jskjdskjdnbj');
    print(phoneNumber);
    const String clientUrl =
        'https://mydoc.my-daktari.com/new_api/forgotPasswordClient.php';
    const String doctorUrl =
        'https://mydoc.my-daktari.com/new_api/forgotPasswordDoctor.php';

    final response = await http.post(
        Uri.parse(userType == UserType.client ? clientUrl : doctorUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else if (response.statusCode == 401) {
      throw Exception(
          'No account found for the provided number. Please check the number and try again.');
    } else {
      throw Exception('Fail to send OTP');
    }
  }

  @override
  Future<bool> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool deleteUseType = await preferences.remove('userType');
    bool logUerOut = await preferences.remove('user');
    bool removeProfileStatus = await preferences.remove('profileCompleted');
    bool removeDoctorSchedule = await preferences.remove('schedules');
    bool removeFullProfileStatus =
        await preferences.remove('fullProfileCompleted');

    userId = '';
    userPhoneNumber = '';
    doctor = DoctorModel();
    schedulesConstant = daysOfWeek.map((day) {
      return DaySchedule(
        id: '${day}-${timeIntervals.first}-${timeIntervals.first}',
        day: day,
        isEnabled: true,
        startTime: timeIntervals.first,
        endTime: timeIntervals.last,
      );
    }).toList();

    return deleteUseType &&
        logUerOut &&
        removeProfileStatus &&
        removeDoctorSchedule &&
        removeFullProfileStatus;
  }

  Future<bool> updateUserProfile({bool fullProfile = false}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userProfile = fullProfile
        ? await preferences.setString('fullProfileCompleted', 'true')
        : await preferences.setString('profileCompleted', 'true');
    String? profileCompletedFromPrefs =
        preferences.getString('profileCompleted');
    String? fullProfileCompletedFromPrefs =
        preferences.getString('fullProfileCompleted');

    print('Checking ###########');
    print("Profile Completed: $profileCompletedFromPrefs");
    print("Full Profile Completed: $fullProfileCompletedFromPrefs");
    return userProfile;
  }

  @override
  Future<String> resetPassword(
      {required String userId,
      required String password,
      required UserType userType}) async {
    const String clientUrl =
        'https://mydoc.my-daktari.com/new_api/updatePasswordClient.php';
    const String doctorUrl =
        'https://mydoc.my-daktari.com/new_api/updatePasswordDoctor.php';
    final response = await http.post(
      Uri.parse(userType == UserType.client ? clientUrl : doctorUrl),
      body: jsonEncode(
        {
          "userID": userId,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['message'];
      return jsonData;
    } else if (response.statusCode == 401 || response.statusCode == 422) {
      throw Exception(jsonDecode(response.body)['message']);
    } else {
      throw Exception("Service unavailable. Try again later");
    }
  }
}
