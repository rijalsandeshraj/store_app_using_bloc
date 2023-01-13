enum MobileResultStatus {
  processError,
  databaseConnectionError,
  comError,
  unhandledException,
  ok,
  invalidToken,
}

enum OrderStatus { newOrder, confirmed, delivered, billed, cancelled }
