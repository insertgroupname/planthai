import 'package:http/http.dart' as http;
import 'package:planthai/tatapi/place_model.dart';
import 'package:planthai/tatapi/misc_model.dart';

final _url = 'tatapi.tourismthailand.org';
final Map<String, String> _header = {
  'Content-Type': 'application/json',
  'Accept-Language': 'th',
  'Authorization':
      'Bearer Gfqdn8Nba22Ovv0g28rMPHfJowrUPezjJfnpiV7bKDA(idTxOSm8eGwPt(zHWVp6QcQU8YsGP0dzoQixaR)qGt0=====2'
};

/**
	TAT ’s Place category such as "SHOP|ACCOMMODATION".
  All categories are separated using the pipe (|) character.
  Category for Filter support: ALL = All Category,
  OTHER = Other Place Type,
  SHOP = Shopping Type,
  RESTAURANT = Restaurant Type,
  ACCOMMODATION = Hotel Type,
  ATTRACTION = Attraction Type
  category code coulde be "RESTAURANT,OTHER" for multi-value
  Category code is not case sentitive 

    _queryParameter {'keyword': '$_keywordController', 
               'geolocation':'$_latitudeController,$_longitudeController', //userGeolocation
               'category_code': '$_categoryCodeController',
               'provincename': '$_provinceNameController',
               'searchradius': '$_searchRadius',  // this value require geolocation since this is radius around the user location
               'numberofresult': '$_numberOfResult', //should be 20
               'pagenumber' : '$_pageNumber', // User selected page number
               'destination' : '$_destination',
               } 

**/

class TatHttp {
  final http.Client _httpClient;
  TatHttp({http.Client httpClient}) : _httpClient = httpClient ?? http.Client();

//Firsttest function
  Future<List<dynamic>> retrieveData() async {
    try {
      // var url =
      //     "https://tatapi.tourismthailand.org/tatapi/v5/places/search?keyword=สยาม";

      var _path = '/tatapi/v5/places/search';
      var _queryParameter = {'keyword': ''};

      final _requestUrl =
          (new Uri.http(_url, _path, _queryParameter)).toString();

      final response = (await _httpClient.get(_requestUrl, headers: _header));

      final listPlaces = await parsePlaces(response.body);
      print("List length : " + listPlaces.length.toString());
      return listPlaces;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

//test search with type
  Future<List> retrieveAttractionData() async {
    try {
      // var url =
      //     "https://tatapi.tourismthailand.org/tatapi/v5/places/search?keyword=สยาม";

      var _path = '/tatapi/v5/places/search';
      var _queryParameter = {'categorycodes': 'ATTRACTION'};

      final _requestUrl =
          (new Uri.http(_url, _path, _queryParameter)).toString();

      final response = (await _httpClient.get(_requestUrl, headers: _header));

      final listPlaces = await parsePlaces(response.body);
      print("List length : " + listPlaces.length.toString());
      return listPlaces;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  //transform url
  String requestUrl(_url, _path, Map<dynamic, dynamic> _parameter) {
    return Uri.http(_url, _path, _parameter).toString();
  }

  Future<List> searchPlace(Map<String, dynamic> _queryParameter) async {
    final _path = '/tatapi/v5/places/search';
    print(requestUrl(_url, _path, null));
    final _requestUrl = requestUrl(_url, _path, _queryParameter);
    try {
      final response = (await _httpClient.get(_requestUrl, headers: _header));
      final listPlaces = parsePlaces(response.body);
      print("list length from search : " + listPlaces.toString());
      return listPlaces;
    } catch (e) {
      throw e;
    }
  }

  Future<List> getAttractionPlace(String _pathPlaceId) async {
    final _path = '/tatapi/v5/attraction/$_pathPlaceId';
    final _requestUrl = requestUrl(_url, _path, null);
    try {
      final response = (await _httpClient.get(_requestUrl, headers: _header));
      final attractionPlace = parseAttraction(response.body);
      return attractionPlace;
    } catch (e) {
      throw e;
    }
  }

  Future<List> getAccommodationPlace(String _pathPlaceId) async {
    final _path = '/tatapi/v5/accommodation/$_pathPlaceId';
    final _requestUrl = requestUrl(_url, _path, null);
    try {
      final response = (await _httpClient.get(_requestUrl, headers: _header));
      final accommodation = parseAccommodationPlace(response.body);
      return accommodation;
    } catch (e) {
      throw "Error caught at getAttractionPlace before parse data :\n" +
          e.toString();
    }
  }

  /**
   * A GIS location of Latitude and Longitude in decimal degree. 
   * latitude is between -90 to 90 and 
   * longitude is between -180 and 180. 
   * For example: geolocation=13.7222793,100.528923
   * 
     _queryParameter = {
      "numberofday": _numberOfDay,
      "geolocation":"$_latitude,$_longitude",
      "region":"$_region",
    } 
  
  * Number of days for filter numberOfDay
  * Region Region code. 
  *   'C' = Central 
  * or 'S' = Southern 
  * or 'N' = Northern 
  * or 'NE' = Northeastern 
  * or 'E' = Eastern or 'W' = Western
  */
  Future<List> getRecommendedRouteList(
      Map<String, dynamic> _queryParameter) async {
    final _path = '/tatapi/v5/routes';

    final _requestUrl = requestUrl(_url, _path, _queryParameter);
    try {
      final response = (await _httpClient.get(_requestUrl, headers: _header));
      final recommendRouteList = parseRecommendRouteList(response.body);
      return recommendRouteList;
    } catch (e) {
      throw e;
    }
  }

  Future<List> getRestaurantPlace(String _pathPlaceId) async {
    var _path = "/tatapi/v5/restaurant/$_pathPlaceId";
    var _requestUrl = requestUrl(_url, _path, null);
    try {
      var response = (await _httpClient.get(_requestUrl, headers: _header));
      final resturant = parseRestaurantPlace(response.body);
      return resturant;
    } catch (e) {
      throw "Error caught at getRestaurantPlace \n" + e.toString();
    }
  }
}
