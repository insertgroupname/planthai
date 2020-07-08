import 'dart:convert';

//Misc. class
class Location {
  String address;
  String subDistrict;
  String district;
  String province;
  String postcode;

  Location._(
      {this.address,
      this.subDistrict,
      this.district,
      this.province,
      this.postcode});
  factory Location.fromJson(Map<String, dynamic> locationJson) {
    try {
      return Location._(
          address: locationJson['address'],
          subDistrict: locationJson['sub_district'],
          district: locationJson['district'],
          province: locationJson['province'],
          postcode: locationJson['postcode']);
    } catch (e) {
      throw "Error caught in Location.fromJson : \n" + e.toString();
    }
  }
  @override
  String toString() {
    return ('''\n
    address: $address
    subDistrict: $subDistrict
    district: $district
    province: $province
    postcode: $postcode''');
  }
}

class Place {
  String placeId;
  String placeName;
  double latitude;
  double longitude;
  String categoryCode;
  String categoryDescription;
  Location location;
  String thumbnailUrl;
  String destination;
  String tags;
  double distance;
  DateTime updateDate;

  Place._({
    this.placeId,
    this.placeName,
    this.latitude,
    this.longitude,
    this.categoryCode,
    this.categoryDescription,
    this.location,
    this.thumbnailUrl,
    this.destination,
    this.tags,
    this.distance,
    this.updateDate,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    // String dateText =
    return new Place._(
      placeId: json['place_id'],
      placeName: json['place_name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      categoryCode: json['category_code'] as String,
      categoryDescription: json['category_description'] as String,
      location: Location.fromJson(json['location']),
      thumbnailUrl: json['thumbnail_url'] as String,
      destination: json['destination'] as String,
      tags: json['tags'] as String,
      distance: json['distance'] as double,
      updateDate: DateTime.parse(json['update_date'].toString()),
    );
  }

  @override
  String toString() {
    return '''placeId: $placeId
placeName: $placeName
latitude: $latitude
longitude: $longitude
categoryCode: $categoryCode
categoryDescription: $categoryDescription
location: $location
thumbnailUrl: $thumbnailUrl
destination: $destination
distance: $distance
updateDate: $updateDate\n''';
  }
}

class Contact {
  List phones;
  List mobiles;
  String fax;
  List emails;
  List urls;

  Contact._({
    this.phones,
    this.mobiles,
    this.fax,
    this.emails,
    this.urls,
  });

  factory Contact.fromJson(Map<String, dynamic> contactJson) {
    print("Im here @ contact.fromjson");
    return Contact._(
      phones: contactJson["phones"] != null ? contactJson["phones"] : ["ไม่มี"],
      mobiles:
          contactJson["mobiles"] != null ? contactJson["mobiles"] : ["ไม่มี"],
      fax: contactJson["fax"] != null ? contactJson["fax"] : "ไม่มี",
      emails: contactJson["emails"] != null ? contactJson["emails"] : ["ไม่มี"],
      urls: contactJson["urls"] != null ? contactJson["urls"] : ["ไม่มี"],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return '''\nphones: $phones
  mobiles: $mobiles
  fax: $fax
  emails: $emails
  urls: $urls''';
  }
}

class OpeningHours {
  var openNow;
  List periods;
  var weekdayText;
  String specialCloseText;

  OpeningHours._(
      {this.openNow, this.periods, this.weekdayText, this.specialCloseText});

  factory OpeningHours.fromJson(Map<String, dynamic> openingHoursJson) =>
      new OpeningHours._(
        openNow: openingHoursJson["open_now"] != null
            ? openingHoursJson["open_now"]
            : "ไม่มีข้อมูล",
        periods: openingHoursJson["open_now"] != null
            ? openingHoursJson["periods"]
            : ["ไม่มีข้อมูล"],
        weekdayText: openingHoursJson["periods"] != null
            ? openingHoursJson["weekday_text"]
            : "ไม่พบข้อมูล",
        specialCloseText: openingHoursJson["special_close_text"],
      );

  @override
  String toString() {
    // TODO: implement toString
    return '''\n
    openNow: $openNow, 
    periods: $periods, 
    weekdayText: $weekdayText, 
    specialCloseText: $specialCloseText
    ''';
  }
}

//RecommendRouteList
class RecommendRouteList {
  String routeId;
  String routeName;
  String routeIntroduction;
  int numberOfDays;
  String thumbnailUrl;
  double distance;
  RecommendRouteList._({
    this.routeId,
    this.routeName,
    this.routeIntroduction,
    this.numberOfDays,
    this.thumbnailUrl,
    this.distance,
  });
  factory RecommendRouteList.fromJson(Map<String, dynamic> json) {
    return new RecommendRouteList._(
        routeId: json["route_id"],
        routeName: json["route_name"],
        routeIntroduction: json["route_introduction"],
        numberOfDays: json["number_of_days"] as int,
        thumbnailUrl: json["thumbnail_url"],
        distance: json["distance"] as double);
  }
  @override
  String toString() {
    return '''routeId: $routeId
routeName: $routeName
routeIntroduction: $routeIntroduction
numberOfDays: $numberOfDays
thumbnailUrl: $thumbnailUrl
distance: $distance''';
  }
}

Future<List> parseRecommendRouteList(String responseBody) async {
  final parsed = jsonDecode(responseBody)["result"];
  List result = await parsed
      .map<RecommendRouteList>((parsed) => RecommendRouteList.fromJson(parsed))
      .toList();
  return result;
}
