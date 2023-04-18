class Product {
  int id;
  String name;

  Product({this.id = 0, this.name = 'x'});
}

class ProductWithTotal {
  int id;
  String name;
  int total;

  ProductWithTotal({this.id = 0, this.name = 'x', this.total = 0});
}

void main() {
  List<Product> products = [
    Product(id: 1, name: 'a'),
    Product(id: 1, name: 'a'),
    Product(id: 2, name: 'b'),
  ];

  Map<int, int> idToCountMap = {};
  for (Product product in products) {
    idToCountMap[product.id] = (idToCountMap[product.id] ?? 0) + 1;
  }

  List<ProductWithTotal> productsWithTotal = [];
  for (Product product in products) {
    int? count = idToCountMap[product.id];
    if (count != null) {
      productsWithTotal.add(ProductWithTotal(id: product.id, name: product.name, total: count));
      idToCountMap.remove(product.id);
    }
  }

  print(productsWithTotal);
}