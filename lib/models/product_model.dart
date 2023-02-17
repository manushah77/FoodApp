class ProductModel {
  String ProductName;
  String ProductImage;
  String ProductId;
  int ProductPrice;
  int? ProductQuantity;
  List<dynamic>? productUnit;

  ProductModel({
    required this.ProductImage,
    required this.ProductName,
    required this.ProductPrice,
    required this.ProductId,
    this.ProductQuantity,
    this.productUnit
  });
}
