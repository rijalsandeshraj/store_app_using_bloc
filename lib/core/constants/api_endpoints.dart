class UserSession {
  static int branchId = 1;
}

class APIUrl {
  static String baseUrl = "http://192.168.20.83:8080";

  static String loginUrl =
      "$baseUrl/api/MLoginApi/Login?companyCode={0}&userName={1}&password={2}";
  static String allTableUrl = "$baseUrl/";

  static String yourOrderUrl =
      "$baseUrl/api/MOrderApi/GetExistingOrderByTable?tableId={0}";
  static String tableByBranchUrl = "$baseUrl/api/MTableApi?branchId={0}";

  static String dishCategoriesUrl =
      "$baseUrl/api/MDishCategoryApi?branchId={0}";
  static String menuItemsUrl = "$baseUrl/api/MDishApi?dishCategoryId={0}";
  static String updateItemsUrl = "$baseUrl/Api/MOrderApi/UpdateOrder";
  static String confirmOrderUrl = "$baseUrl/Api/MOrderApi/ConfirmOrder";
  static String deliverOrderUrl = "$baseUrl/Api/MOrderApi/DeliverOrder?id={0}";
  static String createOrderUrl = "$baseUrl/Api/MOrderApi/CreateOrder";
  static String menuItemsBySearchUrl =
      "$baseUrl/api/MDishApi/SearchDish?searchParam={0}&branchId={1}";
}
