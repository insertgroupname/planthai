import 'dart:convert';
import 'package:planthai/tatapi/misc_model.dart';

//Class section
//Attraction place
class AttractionPlaceInformation {
  String introduction;
  String detail;
  List attractionTypes;

  AttractionPlaceInformation._(
      {this.introduction, this.detail, this.attractionTypes});

  factory AttractionPlaceInformation.fromJson(
          Map<String, dynamic> placeInfomationJson) =>
      new AttractionPlaceInformation._(
        introduction: placeInfomationJson["introduction"],
        detail: placeInfomationJson["detail"],
        attractionTypes: placeInfomationJson["attraction_type"],
      );
  @override
  String toString() {
    // TODO: implement toString
    return '''\n  introduction : $introduction
    detail : $detail
    attractionType : $attractionTypes''';
  }
}

class AttractionPlace {
  String placeId;
  String placeName;
  double latitude;
  double longitude;
  AttractionPlaceInformation attractionPlaceInformation;
  Location location;
  Contact contact;
  String thumbnailUrl;
  List mobilePictureUrls;
  List facilities;
  List paymentMethods;
  OpeningHours openingHours;
  var hitScore;

  AttractionPlace._(
      {this.placeId,
      this.placeName,
      this.latitude,
      this.longitude,
      this.attractionPlaceInformation,
      this.location,
      this.contact,
      this.thumbnailUrl,
      this.mobilePictureUrls,
      this.facilities,
      this.paymentMethods,
      this.hitScore});

  factory AttractionPlace.fromJson(Map<String, dynamic> json) {
    print("json from attraction Places");
    try {
      print("AttractionPlace.fromJson__");
      print(json["place_information"]);
      var attractionPlace = new AttractionPlace._(
          placeId: json["place_id"],
          placeName: json["place_name"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          attractionPlaceInformation: new AttractionPlaceInformation.fromJson(
              json["place_information"]),
          location: Location.fromJson(json["location"]),
          contact: Contact.fromJson(json["contact"]),
          thumbnailUrl: json["thumbnail_url"],
          mobilePictureUrls: json["mobile_picture_urls"],
          facilities:
              json["facilities"] != null ? json["facilities"] : [("no data")],
          paymentMethods: json["payment_methods"] != null
              ? json["payment_methods"]
              : ["ไม่มีข้อมูล"],
          hitScore:
              json["hit_score"] != null ? json["hit_score"] : [("no data")]);
      return attractionPlace;
    } catch (e) {
      throw "caught error at  AttractionPlace.fromJson" + e.toString();
    }
  }
  @override
  String toString() {
    return '''\nplaceId: $placeId
placeName: $placeName
latitude: $latitude
longitude: $longitude
attractionPlaceInformation: $attractionPlaceInformation
location: $location
contact: $contact
thumbnailUrl: $thumbnailUrl
mobilePictureUrls: $mobilePictureUrls
facilities: $facilities
paymentMethods: $paymentMethods
hitScore: $hitScore
''';
  }
}

//Accommodation Place
class AccommodationPlace {
  String placeId;
  String placeName;
  double latitude;
  double longitude;
  AccommodationPlaceInfomation accommodationPlaceInfomation;
  Location location;
  Contact contact;
  String thumbnailUrl;
  List mobilePictureUrls;
  List facilities;
  List paymentMethods;
  List awards;
  String standard;

  AccommodationPlace._({
    this.placeId,
    this.placeName,
    this.latitude,
    this.longitude,
    this.accommodationPlaceInfomation,
    this.location,
    this.contact,
    this.thumbnailUrl,
    this.mobilePictureUrls,
    this.facilities,
    this.paymentMethods,
    this.awards,
    this.standard,
  });
  factory AccommodationPlace.fromJson(Map<String, dynamic> json) {
    try {
      return AccommodationPlace._(
        placeId: json["place_id"],
        placeName: json["place_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        accommodationPlaceInfomation:
            AccommodationPlaceInfomation.fromJson(json["place_information"]),
        location: Location.fromJson(json['location']),
        contact: json["contact"] != null
            ? new Contact.fromJson(json["contact"])
            : null,
        thumbnailUrl: json["thumbnail_url"] as String,
        mobilePictureUrls: (json["mobile_picture_urls"] as List).length != 0
            ? json["mobile_picture_urls"]
            : ["no data"],
        facilities: json["facilities"],
        paymentMethods: json["payment_methods"],
        awards:
            (json["awards"] as List).length != 0 ? json["awards"] : ["No data"],
        standard: json["standard"],
      );
    } catch (e) {
      throw "Error catch at AccommodationPlace.fromJson : \n" + e.toString();
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''placeId : $placeId
placeName : $placeName
latitude : $latitude
longitude : $longitude
accommodationPlaceInfomation : $accommodationPlaceInfomation
location : $location
contact : $contact
thumbnailUrl : $thumbnailUrl
mobilePictureUrls : $mobilePictureUrls
facilities : $facilities
paymentMethods : $paymentMethods
awards : $awards
standard : $standard''';
  }
}

class AccommodationPlaceInfomation {
  String introduction;
  String detail;
  List accommodationTypes;
  String registerLicenseId;
  String hotelStar;
  String displayCheckinTime;
  String displayCheckoutTime;
  int numberOfRoom;
  String priceRange;
  AccommodationPlaceInfomation._({
    this.introduction,
    this.detail,
    this.accommodationTypes,
    this.registerLicenseId,
    this.hotelStar,
    this.displayCheckinTime,
    this.displayCheckoutTime,
    this.numberOfRoom,
    this.priceRange,
  });

  factory AccommodationPlaceInfomation.fromJson(
      Map<String, dynamic> placeInformationJson) {
    try {
      return AccommodationPlaceInfomation._(
        introduction: placeInformationJson["introduction"],
        detail: placeInformationJson["detail"],
        accommodationTypes: placeInformationJson["accommodation_types"],
        registerLicenseId: placeInformationJson["register_license_id"],
        hotelStar: placeInformationJson["hotel_star"],
        displayCheckinTime: placeInformationJson["display_checkin_time"],
        displayCheckoutTime: placeInformationJson["display_checkout_time"],
        numberOfRoom: placeInformationJson["number_of_room"],
        priceRange: placeInformationJson["price_range"],
      );
    } catch (e) {
      throw "Error caught at AccommodationPlaceInfomation.fromJson: \n " + e;
    }
  }
  @override
  String toString() {
    // TODO: implement toString
    return '''\n
    introduction: $introduction
    detail: $detail
    accommodationTypes: $accommodationTypes
    registerLicenseId: $registerLicenseId
    hotelStar: $hotelStar
    displayCheckinTime: $displayCheckinTime
    displayCheckoutTime: $displayCheckoutTime
    numberOfRoom: $numberOfRoom
    priceRange: $priceRange''';
  }
}

//Restaurant Place
class RestaurantPlaceInformation {
  String introduction;
  String detail;
  List restaurantTypes;
  List cuisineTypes;
  RestaurantPlaceInformation._({
    this.introduction,
    this.detail,
    this.restaurantTypes,
    this.cuisineTypes,
  });
  factory RestaurantPlaceInformation.fromJson(Map<String, dynamic> json) =>
      RestaurantPlaceInformation._(
        introduction: json["introduction"],
        detail: json["detail"],
        restaurantTypes: json["restaurant_types"],
        cuisineTypes: json["cuisine_types"],
      );

  @override
  String toString() {
    // TODO: implement toString
    return '''\n
      introduction : $introduction
      detail : $detail
      restaurantTypes : $restaurantTypes
      cuisineTypes : $cuisineTypes''';
  }
}

class RestaurantPlace {
  String placeId;
  String placeName;
  double latitude;
  double longitude;
  RestaurantPlaceInformation restaurantPlaceInformation;
  Location location;
  Contact contact;
  String thumbnailUrl;
  List mobilePictureUrls;
  List facilities;
  List paymentMethods;
  OpeningHours openingHours;
  String standard;
  List awards;
  List michelins;
  String area;
  RestaurantPlace._(
      {this.placeId,
      this.placeName,
      this.latitude,
      this.longitude,
      this.restaurantPlaceInformation,
      this.location,
      this.contact,
      this.thumbnailUrl,
      this.mobilePictureUrls,
      this.facilities,
      this.paymentMethods,
      this.openingHours,
      this.standard,
      this.awards,
      this.michelins,
      this.area});
  factory RestaurantPlace.fromJson(Map<String, dynamic> json) =>
      RestaurantPlace._(
        placeId: json["place_id"],
        placeName: json["place_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        restaurantPlaceInformation:
            RestaurantPlaceInformation.fromJson(json["place_information"]),
        location: Location.fromJson(json["location"]),
        contact: Contact.fromJson(json["contact"]),
        thumbnailUrl: json["thumbnail_url"],
        mobilePictureUrls: json["mobile_picture_urls"],
        facilities: json["facilities"],
        paymentMethods: json["payment_methods"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        standard: json["standard"],
        awards: json["awards"],
        michelins: json["michelins"],
        area: json["area"],
      );
  @override
  String toString() {
    // TODO: implement toString
    return '''placeId: $placeId 
placeName: $placeName 
latitude: $latitude 
longitude: $longitude 
restaurantPlaceInformation: $restaurantPlaceInformation 
location: $location 
contact: $contact 
thumbnailUrl: $thumbnailUrl 
mobilePictureUrls: $mobilePictureUrls 
facilities: $facilities 
paymentMethods: $paymentMethods 
openingHours: $openingHours 
standard: $standard 
awards: $awards 
michelins: $michelins 
area: $area ''';
  }
}

//Parse section

Future<List> parsePlaces(String responseBody) async {
  final parsed = jsonDecode(responseBody)['result'];
  return await parsed.map<Place>((json) => Place.fromJson(json)).toList();
}

Future<List> parseAttraction(String responseBody) async {
  final parsed = [jsonDecode(responseBody)['result']];
  try {
    if (parsed.length != 0) {
      return await parsed
          .map<AttractionPlace>((json) => AttractionPlace.fromJson(json))
          .toList();
    }
    return ["No data"];
  } catch (e) {
    throw "catched error at parseAttraction function \n" + e.toString();
  }
}

Future<List> parseAccommodationPlace(String responseBody) async {
  final parsed = [jsonDecode(responseBody)['result']];
  return parsed
      .map<AccommodationPlace>((json) => AccommodationPlace.fromJson(json))
      .toList();
}

Future<List> parseRestaurantPlace(String responseBody) async {
  final parsed = [jsonDecode(responseBody)["result"]];
  return parsed
      .map<RestaurantPlace>((json) => RestaurantPlace.fromJson(json))
      .toList();
}
