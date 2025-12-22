class AppException implements Exception {
  final String message;
  AppException(this.message);
  @override
  String toString() => message;
}

class InsufficientFundsException extends AppException {
  InsufficientFundsException() : super('Insufficient stars');
}

class OutOfStockException extends AppException {
  OutOfStockException() : super('Reward is out of stock');
}

class RewardInactiveException extends AppException {
  RewardInactiveException() : super('Reward is no longer active');
}
