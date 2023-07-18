import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
    print(message);
    if (response.statusCode == 200) {
      //final jsonData = jsonDecode(response.stream.bytesToString())['data'];
      // final doctor = DoctorProfileModel.fromJson(jsonData);
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
    required PlatformFile profilePicture,
  }) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://mydoc.my-daktari.com/new_api/updateDrProfile.php'));
    final profileFile = platformFileToFile(profilePicture);
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
    print(message);
    if (response.statusCode == 200) {
      //final jsonData = jsonDecode(response.stream.bytesToString())['data'];
      // final doctor = DoctorProfileModel.fromJson(jsonData);
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
}
