class MarkedInSetup {
  final String id;
  final String name;
  final String street;
  final String city;
  final String postcode;
  final String country;
  MarkedInSetup({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.postcode,
    required this.country,
  });
}

class MarkedInOwner {
  final String id;
  final String name;
  final String street;
  final String city;
  final String postcode;
  final String country;
  final List<String> sellers;
  MarkedInOwner({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.postcode,
    required this.country,
    required this.sellers,
  });
}

class DateAndDay {
  final DateTime date;
  final String day;
  final int sels;
  DateAndDay({
    required this.date,
    required this.day,
    required this.sels,
  });
}

class FindMarkedClass {
  final String id;
  final String name;
  final String street;
  final String city;
  final String postcode;
  final String country;
  final List<DateAndDay> dates;
  final bool free;
  final String admintext;
  FindMarkedClass({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.postcode,
    required this.country,
    required this.dates,
    required this.free,
    required this.admintext,
  });
}

class OnlyOneMarkedCust {
  final String id;
  final String name;
  final String street;
  final String city;
  final String postcode;
  final String country;
  final DateTime date;
  final String day;
  final bool free;
  final List<String> seller;
  final List<String> category;
  OnlyOneMarkedCust({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.postcode,
    required this.country,
    required this.date,
    required this.day,
    required this.free,
    required this.seller,
    required this.category,
  });
}

class MarkedDates {
  final DateTime date;
  final String sellers;
  MarkedDates({
    required this.date,
    required this.sellers,
  });
}

class Category {
  final String id;
  final String name;
  final String parent;
  Category({
    required this.id,
    required this.name,
    required this.parent,
  });
}

class AdminSetup {
  final String id;
  final String name;
  final String email;
  final String password;
  //final String position;

  AdminSetup({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    //required this.position,
  });
}

class Me {
  final String phone;
  final String name;
  final String email;
  final String who;
  Me({
    required this.phone,
    required this.name,
    required this.email,
    required this.who,
  });
}

class Product {
  final String prodid;
  final String addedby;
  final String imageurl;
  final String name;
  final double price;
  final int available;
  final int tax;
  final int qty;
  final String unit;
  final String tempzone;
  final String category;
  final String description;
  final DateTime expiry;
  Product({
    required this.prodid,
    required this.addedby,
    required this.imageurl,
    required this.name,
    required this.price,
    required this.available,
    required this.tax,
    required this.qty,
    required this.unit,
    required this.tempzone,
    required this.category,
    required this.description,
    required this.expiry,
  });
}

class SellerDeta {
  final String company;
  final String phone;
  final String emial;
  final String org;
  SellerDeta({
    required this.company,
    required this.phone,
    required this.emial,
    required this.org,
  });
}

class CustProd {
  final String id;
  final String image;
  final String name;
  final double price;
  final int available;
  final String description;
  final String unit;
  final int qty;
  final int tax;
  CustProd({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.available,
    required this.description,
    required this.unit,
    required this.qty,
    required this.tax,
  });
}

class SellerCust {
  final String phone;
  final String company;
  SellerCust({
    required this.phone,
    required this.company,
  });
}

class CartProd {
  final String id;
  final int count;
  final double price;
  CartProd({
    required this.id,
    required this.count,
    required this.price,
  });
}

class OrderProd {
  final String id;
  final String name;
  final String image;
  final double price;
  int available;
  final double total;
  final int qty;
  final String unit;
  final int tax;
  final double taxprice;
  final int count;
  OrderProd({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.total,
    required this.qty,
    required this.unit,
    required this.tax,
    required this.taxprice,
    required this.count,
  });
}

class AllowOrder {
  final String name;
  final int count;
  AllowOrder({
    required this.name,
    required this.count,
  });
}

class OrderProdCust {
  final String id;
  final String name;
  final String image;
  final double price;
  final int qty;
  final String unit;
  OrderProdCust({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.unit,
  });
}

class OrderCust {
  final String id;
  final String orderid;
  final String safeword;
  final String sellerid;
  final String sellername;
  final List<OrderProdCust> product;
  OrderCust({
    required this.id,
    required this.orderid,
    required this.safeword,
    required this.sellerid,
    required this.sellername,
    required this.product,
  });
}

class OrderMarkedMy {
  final String mid;
  final String name;
  final String street;
  final String postcode;
  final String city;
  final String day;
  final DateTime date;
  final List<OrderCust> order;
  OrderMarkedMy({
    required this.mid,
    required this.name,
    required this.street,
    required this.postcode,
    required this.city,
    required this.day,
    required this.date,
    required this.order,
  });
}

class ProdinPickUp {
  final String id;
  final String name;
  final String image;
  final double price;
  final int qty;
  ProdinPickUp({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });
}

class OrderInPickup {
  final String id;
  final String orderid;
  final String safeword;
  final String custname;
  final List<ProdinPickUp> product;
  OrderInPickup({
    required this.id,
    required this.orderid,
    required this.safeword,
    required this.custname,
    required this.product,
  });
}

class PicUpSeller {
  final String mid;
  final String name;
  final String street;
  final String postcode;
  final String city;
  final String day;
  final DateTime date;
  final List<OrderInPickup> order;
  PicUpSeller({
    required this.mid,
    required this.name,
    required this.street,
    required this.postcode,
    required this.city,
    required this.day,
    required this.date,
    required this.order,
  });
}

class MarkedInSelOwner {
  final String name;
  final String street;
  final String postcode;
  final String city;
  final String day;
  final DateTime date;
  MarkedInSelOwner({
    required this.name,
    required this.street,
    required this.postcode,
    required this.city,
    required this.day,
    required this.date,
  });
}

class SellerInOwner {
  final String phone;
  String company;
  String org;
  String email;
  final String password;
  String street;
  String city;
  String postcode;
  final double total;
  List<MarkedInSelOwner> marked;
  SellerInOwner({
    required this.phone,
    required this.company,
    required this.org,
    required this.email,
    required this.password,
    required this.street,
    required this.city,
    required this.postcode,
    required this.total,
    required this.marked,
  });
}

class SellerInOwnerCommition {
  final String phone;
  String name;
  double total;
  SellerInOwnerCommition({
    required this.phone,
    required this.name,
    required this.total,
  });
}

class OnlyForComSel {
  final String phone;
  bool invoice;
  OnlyForComSel({
    required this.phone,
    required this.invoice,
  });
}

class MarkedInCommistion {
  final String id;
  final String name;
  final String day;
  final DateTime date;
  final String street;
  final String city;
  final String postcode;
  List<OnlyForComSel> sel;
  MarkedInCommistion({
    required this.id,
    required this.name,
    required this.day,
    required this.date,
    required this.street,
    required this.city,
    required this.postcode,
    required this.sel,
  });
}

class Datewithselandcust {
  final DateTime date;
  final String day;
  List<String> seller;
  List<String> customer;
  Datewithselandcust({
    required this.date,
    required this.day,
    required this.seller,
    required this.customer,
  });
}

class StatasticProd {
  final String id;
  final String name;
  final String image;
  final double price;
  int count;
  StatasticProd({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.count,
  });
}

class InvoiceMarked {
  final String id;
  final String name;
  final DateTime date;
  final String day;
  final String address;
  InvoiceMarked({
    required this.id,
    required this.name,
    required this.date,
    required this.day,
    required this.address,
  });
}
