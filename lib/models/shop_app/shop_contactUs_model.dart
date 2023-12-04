class ContactUsModel {
  bool? status;
  ContactData? data;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ContactData.fromJson(json['data']);
  }
}

class ContactData {
  late int currentPage;
  late List<DetailedData> data = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late String path;
  late int perPage;
  late int to;
  late int total;

  ContactData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DetailedData.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class DetailedData {
  late int id;
  late int type;
  late String value;
  late String image;

  DetailedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}
