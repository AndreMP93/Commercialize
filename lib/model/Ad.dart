class Ad {
  late String id;
  late String state;
  late String category;
  late String title;
  late String price;
  late String phone;
  late String description;
  late List<dynamic> photos;

  Ad({
    this.id = "",
    required this.state,
    required this.category,
    required this.title,
    required this.price,
    required this.phone,
    required this.description,
    required this.photos,
  });

  Ad.map(Map<String, dynamic> map){
    id = map["id"];
    state = map["state"];
    category = map["category"];
    title = map["title"];
    price = map["price"];
    phone = map["phone"];
    description = map["description"];
    photos = map["photos"];
  }

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "state": state,
      "category": category,
      "title": title,
      "price": price,
      "phone": phone,
      "description": description,
      "photos": photos
    };
  }
  copy(Ad ad){
    id = ad.id;
    state = ad.state;
    category = ad.category;
    title = ad.title;
    price = ad.price;
    phone = ad.phone;
    photos = ad.photos;
  }
}
