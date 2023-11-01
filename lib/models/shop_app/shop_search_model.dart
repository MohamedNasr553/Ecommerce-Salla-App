class SearchModel{
  bool? status;
  SearchDataModel? data;

  SearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel{
  int? currentPage;
  List<DetailedSearchDataModel> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];

    json['data'].forEach((element)
    {
      data.add(DetailedSearchDataModel.fromJson(element));
    });
  }
}

class DetailedSearchDataModel{
  int? id;
  String? name;
  String? image;
  num? price;
  bool? inCart;
  bool? inFavorites;

  DetailedSearchDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    inCart = json['in_cart'];
    inFavorites = json['in_favorites'];
  }
}