class FAQModel {
  bool? status;
  FAQData? data;

  FAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FAQData.fromJson(json['data']);
  }
}

class FAQData {
  late int currentPage;
  late List<DetailedFAQData> data = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late String path;
  late int perPage;
  late int to;
  late int total;

  FAQData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DetailedFAQData.fromJson(element));
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

class DetailedFAQData {
  late int id;
  late String question;
  late String answer;

  DetailedFAQData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
