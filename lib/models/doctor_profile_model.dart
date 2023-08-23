class DoctorProfileModel {
  int? doctorID;
  String? name;
  String? speciality;
  String? experienceYears;
  //Location? location;
  String? location;
  String? image;
  String? title;
  String? overview;
  List<Charges>? charges;
  OpeningHours? openingHours;

  DoctorProfileModel(
      {this.doctorID,
      this.name,
      this.speciality,
      this.experienceYears,
      this.location,
      this.image,
      this.title,
      this.overview,
      this.charges,
      this.openingHours});

  DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    name = json['name'];
    speciality = json['speciality'];
    experienceYears = json['experience_years'];
    // location = json['location'] != null
    //     ? new Location.fromJson(json['location'])
    //     : null;
    location = json['location'];
    image = json['image'];
    title = json['title'];
    overview = json['overview'];
    if (json['charges'] != null) {
      charges = <Charges>[];
      json['charges'].forEach((v) {
        charges!.add(new Charges.fromJson(v));
      });
    }
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    data['experience_years'] = this.experienceYears;
    // if (this.location != null) {
    //   data['location'] = this.location!.toJson();
    // }
    data['location'] = this.location;
    data['image'] = this.image;
    data['title'] = this.title;
    data['overview'] = this.overview;
    if (this.charges != null) {
      data['charges'] = this.charges!.map((v) => v.toJson()).toList();
    }
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    return data;
  }
}

// class Location {
//   String? lat;
//   String? lng;

//   Location({this.lat, this.lng});

//   Location.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }

class Charges {
  int? phoneCall;
  int? chat;
  int? videoCall;

  Charges({this.phoneCall, this.chat, this.videoCall});

  Charges.fromJson(Map<String, dynamic> json) {
    phoneCall = json['phone_call'];
    chat = json['chat'];
    videoCall = json['video_call'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_call'] = this.phoneCall;
    data['chat'] = this.chat;
    data['video_call'] = this.videoCall;
    return data;
  }
}

class OpeningHours {
  String? weekdays;
  String? weekend;
  String? openSundays;
  String? openPublicHolidays;

  OpeningHours(
      {this.weekdays, this.weekend, this.openSundays, this.openPublicHolidays});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    weekdays = json['weekdays'];
    weekend = json['weekend'];
    openSundays = json['openSundays'];
    openPublicHolidays = json['openPublicHolidays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekdays'] = this.weekdays;
    data['weekend'] = this.weekend;
    data['openSundays'] = this.openSundays;
    data['openPublicHolidays'] = this.openPublicHolidays;
    return data;
  }
}
