import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/client.dart';
import '../../models/doctor.dart';
import 'base_profile_repository.dart';

class ProfileRepository extends BaseProfileRepository {
  // update Client profile.
  @override
  Future<String> updateClientProfile(
      {required String userId,
      required String name,
      required String dob,
      required String gender,
      required String phoneNumber,
      required File profilePicture}) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://mydoc.my-daktari.com/new_api/updateUserProfile.php'));
    // final profileFile = platformFileToFile(profilePicture);
    final profileFile = profilePicture;
    // Add files to the request
    request.files.add(
      http.MultipartFile('profileImages', profileFile.readAsBytes().asStream(),
          profileFile.lengthSync(),
          filename: profileFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg')),
    );
    // Add form data fields
    request.fields['userID'] = userId;
    request.fields['name'] = name;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['dob'] = dob;
    request.fields['gender'] = gender;
    var response = await request.send();
    var message = await response.stream.bytesToString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(message);
      preferences.setString('user', jsonEncode(responseBody['data']));
      return message;
    } else {
      String error = message;
      String errorDecoded = jsonDecode(error)['message'].toString();
      throw (errorDecoded);
    }
  } // update Client profile.

  @override
  Future<String> updateDoctorProfile({
    required String userId,
    required String name,
    required String dob,
    required String gender,
    required String phoneNumber,
    required File profilePicture,
  }) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://mydoc.my-daktari.com/new_api/updateDrProfile.php'));
    // final profileFile = platformFileToFile(profilePicture);
    final profileFile = profilePicture;
    // Add files to the request
    request.files.add(
      http.MultipartFile('profileImages', profileFile.readAsBytes().asStream(),
          profileFile.lengthSync(),
          filename: profileFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg')),
    );
    // Add form data fields
    request.fields['doctorID'] = userId;
    request.fields['name'] = name;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['dob'] = dob;
    request.fields['gender'] = gender;

    var response = await request.send();
    var message = await response.stream.bytesToString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // Store the 'data' part of the response in local storage
      var responseBody = jsonDecode(message);
      preferences.setString('user', jsonEncode(responseBody['data']));
      return message;
    } else {
      String error = message;
      String errorDecoded = jsonDecode(error)['message'].toString();
      throw (errorDecoded);
    }
  }

//function to convert the file type from platformFile to File
  File platformFileToFile(PlatformFile platformFile) {
    final filePath = platformFile.path;
    // final fileName = path.basename(filePath.toString());
    final file = File(filePath.toString());
    return file;
  }

  Future<ClientModel> getClientModelFromLocalStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userData = preferences.getString('user');
    if (userData != null) {
      try {
        Map<String, dynamic> userDataMap = jsonDecode(userData);
        return ClientModel.fromJson(userDataMap);
      } catch (e) {
        // Handle decoding error here (if needed)
        throw ('Error decoding user data from local storage: $e');
      }
    } else {
      throw ('Failed');
    }
  }

  Future<DoctorModel> getDoctorModelFromLocalStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userData = preferences.getString('user');
    if (userData != null) {
      try {
        Map<String, dynamic> userDataMap = jsonDecode(userData);
        return DoctorModel.fromJson(userDataMap);
      } catch (e) {
        // Handle decoding error here (if needed)
        throw ('Error decoding user data from local storage: $e');
      }
    } else {
      throw ('Failed');
    }
  }
}
