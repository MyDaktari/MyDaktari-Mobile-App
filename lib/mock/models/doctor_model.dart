class DoctorModel {
  String? name;
  String? speciality;
  int? experienceYears;
  String? institution;
  Location? location;
  String? image;
  String? title;
  String? overview;
  Charges? charges;
  OpeningHours? openingHours;

  DoctorModel(
      {this.name,
      this.speciality,
      this.experienceYears,
      this.institution,
      this.location,
      this.image,
      this.title,
      this.overview,
      this.charges,
      this.openingHours});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    speciality = json['speciality'];
    experienceYears = json['experience_years'];
    institution = json['institution'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    image = json['image'];
    title = json['title'];
    overview = json['overview'];
    charges =
        json['charges'] != null ? Charges.fromJson(json['charges']) : null;
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['speciality'] = speciality;
    data['experience_years'] = experienceYears;
    data['institution'] = institution;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['image'] = image;
    data['title'] = title;
    data['overview'] = overview;
    if (charges != null) {
      data['charges'] = charges!.toJson();
    }
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Charges {
  double? phoneCall;
  double? chat;
  double? videoCall;

  Charges({this.phoneCall, this.chat, this.videoCall});

  Charges.fromJson(Map<String, dynamic> json) {
    phoneCall = json['phone_call'];
    chat = json['chat'];
    videoCall = json['video_call'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_call'] = phoneCall;
    data['chat'] = chat;
    data['video_call'] = videoCall;
    return data;
  }
}

class OpeningHours {
  String? weekdays;
  String? weekend;
  bool? openSunday;
  bool? openPublicHolidays;

  OpeningHours(
      {this.weekdays, this.weekend, this.openSunday, this.openPublicHolidays});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    weekdays = json['weekdays'];
    weekend = json['weekend'];
    openSunday = json['open_sunday'];
    openPublicHolidays = json['open_public_holidays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekdays'] = weekdays;
    data['weekend'] = weekend;
    data['open_sunday'] = openSunday;
    data['open_public_holidays'] = openPublicHolidays;
    return data;
  }
}
