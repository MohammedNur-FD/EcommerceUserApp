const String takaSymbol = '৳';
const String photoDirectory = 'PnTflutter';
const emptyFiledMsg = 'This field must not be empty';
const negativePriceReeMsg = 'Price should\'t be less than 0';
const negativeStockErrMsg = 'Quantity should be greater than 0';

class PaymentMethod {
  static String cod = 'Cass on Delivery';
  static String online = 'Online Payment';
}

class OrderStatus {
  static String pending = 'Pending';
  static String delivered = 'Delivered';
  static String cancelled = 'Cancelled';
}
