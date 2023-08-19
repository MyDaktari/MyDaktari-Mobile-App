import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/urls.dart';
import '../../../models/models.dart';
import '../../../models/supplier.dart';
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
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 200) {
        preferences.setBool('otpVerified', false);
        final responseBody = jsonDecode(response.body);
        ClientModel client = ClientModel.fromJson(responseBody['user']);
        userPhoneNumber = client.phone.toString().trim();
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
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 201) {
        preferences.setBool('otpVerified', false);
        final responseBody = jsonDecode(response.body);
        ClientModel client = ClientModel.fromJson(responseBody['data']);
        preferences.setString('user', jsonEncode(responseBody['data']));
        preferences.setString('userType', UserType.client.name);
        userPhoneNumber = client.phone.toString().trim();
        return client;
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        throw Exception('Incorrect username or password');
      } else if (response.statusCode == 409) {
        throw Exception('Email already exist');
      } else {
        throw Exception('Failed to register user');
      }
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
    //print(response.body);
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 200) {
        preferences.setBool('otpVerified', false);
        final responseBody = jsonDecode(response.body);
        DoctorModel doctor = DoctorModel.fromJson(responseBody['data'][0]);
        userPhoneNumber = doctor.phone.toString().trim();
        preferences.setString('user', jsonEncode(responseBody['data'][0]));
        preferences.setString('userType', UserType.doctor.name);
        preferences.setString(
            'profileCompleted', jsonEncode(responseBody['profile_completed']));
        preferences.setString('fullProfileCompleted',
            jsonEncode(responseBody['full_profile_completed']));
        //Doctor Availability
        bool fullProfileCompleted = responseBody['full_profile_completed'];
        if (fullProfileCompleted) {
          schedulesConstant = availabilityToSchedules(responseBody['data'][0]
              ['doctorAvailability'] as Map<String, dynamic>);
          preferences.setString('schedules',
              jsonEncode(responseBody['data'][0]['doctorAvailability']));
        }
        return doctor;
      } else if (response.statusCode == 401 ||
          response.statusCode == 404 ||
          response.statusCode == 400) {
        throw Exception('Incorrect username or password');
      } else {
        throw Exception('Failed to login ${response.statusCode}');
      }
    } else {
      throw Exception('Failed to login ${response.statusCode}');
    }
  }

  @override
  Future<DoctorModel> registerDoctor(
      {required String name,
      required String password,
      required String phone,
      required String dob,
      required String gender,
      required String email}) async {
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
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        DoctorModel doctor = DoctorModel.fromJson(responseBody['data']);
        preferences.setString('user', jsonEncode(responseBody['data']));
        preferences.setString('userType', UserType.doctor.name);
        preferences.setBool('otpVerified', false);
        preferences.setString(
            'profileCompleted', jsonEncode(responseBody['profile_completed']));
        preferences.setString('fullProfileCompleted',
            jsonEncode(responseBody['full_profile_completed']));
        userPhoneNumber = doctor.phone.toString().trim();
        return doctor;
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        throw Exception('Incorrect username or password');
      } else if (response.statusCode == 409) {
        throw Exception('Email already exist');
      } else {
        throw Exception('Failed to register doctor');
      }
    } else {
      throw Exception('Failed to register doctor');
    }
  }
  //end of doctor

  //supplier
  //client
  @override
  Future<SupplierModel> loginSupplier(
      {required String username, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(loginSupplierUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 200) {
        preferences.setBool('otpVerified', false);
        final responseBody = jsonDecode(response.body);
        print(responseBody['OTP ']);
        SupplierModel supplier = SupplierModel.fromJson(responseBody['user']);
        preferences.setString('user', jsonEncode(responseBody['user']));
        preferences.setString('userType', UserType.supplier.name);
        print(responseBody['user']);

        userPhoneNumber = supplier.supplierPhone.toString().trim();
        print(userPhoneNumber);
        return supplier;
      } else if (response.statusCode == 401 ||
          response.statusCode == 404 ||
          response.statusCode == 400) {
        throw Exception('Incorrect username or password');
      } else {
        throw Exception('Failed to login');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<SupplierModel> registerSupplier(
      {required String address,
      required String dob,
      required String email,
      required String gender,
      required String name,
      required String password,
      required String phone}) async {
    DateTime parsedDate = DateTime.parse(dob);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    final response = await http.post(Uri.parse(registerSupplierUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "supplierName": name,
          "supplierEmail": email,
          "supplierPhone": phone,
          "supplierPassword": password,
          "supplierCategory": "1,2,3",
          "supplierBirthDate": formattedDate,
          "supplierAddress": address,
          "supplierGender": gender
        }));
    print(jsonEncode({
      "supplierName": name,
      "supplierEmail": email,
      "supplierPhone": phone,
      "supplierPassword": password,
      "supplierCategory": "1,2,3",
      "supplierBithDate": dob,
      "supplierAddress": address,
      "supplierGender": gender
    }));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(response.body);
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 201) {
        preferences.setBool('otpVerified', false);
        final responseBody = jsonDecode(response.body);
        SupplierModel supplier = SupplierModel.fromJson(responseBody['data']);
        preferences.setString('user', jsonEncode(responseBody['data']));
        preferences.setString('userType', UserType.supplier.name);
        userPhoneNumber = supplier.supplierPhone.toString().trim();
        return supplier;
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        throw Exception('Incorrect username or password');
      } else if (response.statusCode == 409) {
        throw Exception('Email already exist');
      } else {
        throw Exception('Failed to register user');
      }
    } else {
      throw Exception('Failed to register user');
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
    bool? otpVerified = preferences.getBool('otpVerified');
    dynamic user;
    if (userTypeFromPrefs != null && otpVerified != null) {
      if (userFromPrefs != null) {
        if (userTypeFromPrefs == UserType.client.name) {
          final userString = jsonDecode(userFromPrefs);
          ClientModel client = ClientModel.fromJson(userString);
          user = client;
        } else if (userTypeFromPrefs == UserType.supplier.name) {
          final userString = jsonDecode(userFromPrefs);
          SupplierModel supplier = SupplierModel.fromJson(userString);
          user = supplier;
        } else {
          final userString = jsonDecode(userFromPrefs);
          DoctorModel doctor = DoctorModel.fromJson(userString);
          user = doctor;
        }
      }
      return {
        'user': user,
        'otpVerified': otpVerified,
        'profileCompleted': profileCompletedFromPrefs,
        'fullProfileCompleted': fullProfileCompletedFromPrefs,
        'doctorSchedule': doctorSchedules,
        'userType': (userTypeFromPrefs == UserType.client.name)
            ? UserType.client
            : (userTypeFromPrefs == UserType.supplier.name)
                ? UserType.supplier
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
      {required String phoneNumber,
      required String otp,
      required bool isLogIn}) async {
    final response = await http.post(
        Uri.parse(isLogIn ? loginOtpVerificationUrl : otpVerificationUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber, "otp": otp}));

    print('##############################');
    print(phoneNumber);
    print('##############################');

    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('otpVerified', true);
      return message;
    } else {
      throw Exception('Invalid OTP ${response.statusCode}');
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
    client = ClientModel();
    supplier = SupplierModel();
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
    return userProfile;
  }

  @override
  Future<String> passwordOtpRequest(
      {required String phoneNumber, required UserType userType}) async {
    const String clientUrl =
        'https://mydoc.my-daktari.com/new_api/forgotPasswordClient.php';
    const String doctorUrl =
        'https://mydoc.my-daktari.com/new_api/forgotPasswordDoctor.php';
    const String supplierUrl =
        'https://mydoc.my-daktari.com/new_api/forgotPasswordSupplier.php';

    final response = await http.post(
        Uri.parse(userType == UserType.client
            ? clientUrl
            : userType == UserType.supplier
                ? supplierUrl
                : doctorUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));
    if (!response.body.contains('<b>')) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        String message = jsonDecode(response.body)['message'];
        return message;
      } else if (response.statusCode == 401) {
        throw Exception(
            'No account found for the provided number. Please check the number and try again.');
      } else {
        throw Exception('Fail to send OTP');
      }
    } else {
      throw Exception('Fail to send OTP');
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
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['UserID'].toString();
      return message;
    } else {
      throw Exception('Invalid OTP');
    }
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
    const String supplierUrl =
        'https://mydoc.my-daktari.com/new_api/updatePasswordSupplier.php';
    final response = await http.post(
      Uri.parse(userType == UserType.client
          ? clientUrl
          : userType == UserType.supplier
              ? supplierUrl
              : doctorUrl),
      body: jsonEncode(
        userType == UserType.supplier
            ? {"supplierID": userId, "password": password}
            : {"userID": userId, "password": password},
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
