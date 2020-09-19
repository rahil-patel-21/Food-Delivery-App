import 'package:food_delivery/Helper/RequestManager.dart';
import 'package:food_delivery/ModelClass/Dashboard.dart';
import 'package:food_delivery/ModelClass/ModelAddressList.dart';
import 'package:food_delivery/ModelClass/ModelAllRestaurantList.dart';
import 'package:food_delivery/ModelClass/ModelAllReviewList.dart';
import 'package:food_delivery/ModelClass/ModelCategoryList.dart';
import 'package:food_delivery/ModelClass/ModelCheckOut.dart';
import 'package:food_delivery/ModelClass/ModelMealDeals.dart';
import 'package:food_delivery/ModelClass/ModelNotificationList.dart';
import 'package:food_delivery/ModelClass/ModelOrderDetails.dart';
import 'package:food_delivery/ModelClass/ModelOrderList.dart';
import 'package:food_delivery/ModelClass/ModelOrderStatus.dart';
import 'package:food_delivery/ModelClass/ModelProfileData.dart';
import 'package:food_delivery/ModelClass/ModelRestaurantDetails.dart';
import 'package:food_delivery/ModelClass/ModelSearchResult.dart';
import 'package:food_delivery/ModelClass/ModelUserLogin.dart';

class Repository {
  final reqManager = Requestmanager();
  //Fetch Login Data
  Future<UserLogin> fetchUserLogin(String strUrl, dynamic param) =>
      reqManager.getUserLogin(strUrl, true, param);
  //Fetch user data after registrations
  Future<UserLogin> fetchUserRegistration(String strUrl, dynamic param) =>
      reqManager.requestForUserRegistration(strUrl, true, param);
  //Fetch main Dashboard restaurants and meal deals
  Future<Dashboard> fetchDashboardData(String url, dynamic param) =>
      reqManager.requestApiForDashboard(url, param);
  //Fetch perticular restaurant details
  Future<ResRestaurantDetails> fetchRestaurantDetails(
          String resID, String strUrl) =>
      reqManager.requestForFetchRestaurantDetails(resID, strUrl);
  //Fetch All address list
  Future<ResAddressList> fetchAddressList(String url, String userId) =>
      reqManager.requestForFetchAddressList(url, userId);
  //Fetch all order list data
  Future<ResOrderList> fetchAllOrders(
          String strUrl, String userId, String isAll) =>
      reqManager.fetchAllOrderList(strUrl, userId, isAll);
  //Fetch perticular order details
  Future<ResOrderDetails> fetchOrderDetails(String orderId) =>
      reqManager.fetchOrderDetails(orderId);
  //Fetch all popular and top restaurant list
  Future<ResAllRestaurantList> fetchAllRestaurantList(String strUrl) =>
      reqManager.fetchAllRestaurantList(strUrl);
  //Fetch profile data
  Future<ResProfileData> fetchProfileData(String userId) =>
      reqManager.fetchProfileData(userId);
  //Fetch all meal deal items
  Future<ResMealDeals> fetchMealDealsItems(String url) =>
      reqManager.featchMealDealsItems(url);
  //Fetch search result restaurants and meal deal items.
  Future<ResSearchResult> fetchSearchResultData(String keyWord) =>
      reqManager.fetchSearcResultData(keyWord);
  //Make order with different payment methods.
  Future<ResAddOrder> proccedToCheckOut(String strUrl, dynamic param) =>
      reqManager.proccedToCheckOut(strUrl, param);
  //Fetch all Notification Lists.
  Future<ResNotificationList> fetchAllNotifications(String userId) =>
      reqManager.fetchAllNotificationList(userId);
  //Fetch order Status.
  Future<ResOrderStatus> fetchCurrentOrderStatus(String orderId) =>
      reqManager.fetchCurrentOrderStatus(orderId);
  //Fetch Restaurant Reviews.
  Future<ResAllReview> fetchRestaurantReviews(String resId) =>
      reqManager.fetchRestaurantReview(resId);
  //Fetch CategoryList
  Future<ResCategoryList> fetchCategoryList() =>
      reqManager.fetchAllCategoryList();
}
