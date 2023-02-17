class ReviewCartModel {
  String? cartId;
  String cartImage;
  var cartUnit;
  String cartName;
  int cartPrice;
  int cartQuantity;

  ReviewCartModel({
 this.cartId,
    required this.cartName,
    required this.cartImage,
    this.cartUnit,
    required this.cartPrice,
    required this.cartQuantity,
  });
}
