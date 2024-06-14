import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/top_cities_model.dart';
import 'package:scan_cart_clone/Models/top_countries_model.dart';
import 'package:scan_cart_clone/Models/top_us_state_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends GetxController {
  RxList topCountriesList = <TopCountriesModel>[].obs;
  RxList topStateList = <TopUSStateModel>[].obs;
  RxList topCitiesList = [].obs;

  RxBool isCountries = false.obs;
  RxBool isState = false.obs;
  RxBool isCities = false.obs;

  @override
  void onInit() {
    getTopCountries();
    getTopUSState();
    getTopCities();
    super.onInit();
  }

  //! Getting the TopCountries..!

  Future getTopCountries() async {
    isCountries.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitTopCountries(clientID!, token);
    topCountriesList.clear();
    if (data['success'] == true) {
      for (int i = 0; i < data['topCountries'].length; i++) {
        topCountriesList.add(
          TopCountriesModel(
            cnt: data['topCountries'][i]['cnt'],
            countryName: data['topCountries'][i]['country_name'],
          ),
        );
      }
      print(" State ${topCountriesList[0].cnt}");
      isCountries.value = false;
    } else {
      isCountries.value = false;
      topCountriesList.clear();
    }
  }

  //! Getting top US State..!
  Future getTopUSState() async {
    isState.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitTopUSState(clientID!, token);
    topStateList.clear();
    if (data['success'] == true) {
      for (int i = 0; i < data['topUSStates'].length; i++) {
        topStateList.add(
          TopUSStateModel(
            cnt: data['topUSStates'][i]['cnt'],
            stateName: data['topUSStates'][i]['state'],
            total: data['topUSStates'][i]['total'],
            percentCnt: data['topUSStates'][i]['percent_cnt'],
          ),
        );
      }
      print(" State ${topStateList[0].stateName}");
      isState.value = false;
    } else {
      isState.value = false;
      topStateList.clear();
    }
  }
  //! Getting the Top Cities ..!

  Future getTopCities() async {
    isCities.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("admin_token");
    int? clientID = prefs.getInt("client_id");
    var data = await APIServices.hitTopCities(clientID!, token);
    topCitiesList.clear();
    if (data['success'] == true) {
      for (int i = 0; i < data['topCities'].length; i++) {
        topCitiesList.add(
          TopCitiesModel(
            cnt: data['topCities'][i]['cnt'],
            city: data['topCities'][i]['city'],
            countryCode: data['topCities'][i]['country_code'],
            regionCode: data['topCities'][i]['region_code'],
          ),
        );
      }
      print(" dgrd ${topCitiesList[0].cnt}");
      isCities.value = false;
    } else {
      isCities.value = false;
      topCitiesList.clear();
    }
  }
}
