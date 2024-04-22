// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    List<CategoryModelDatum>? data;
    Meta? meta;

    CategoryModel({
        this.data,
        this.meta,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: json["data"] == null ? [] : List<CategoryModelDatum>.from(json["data"]!.map((x) => CategoryModelDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class CategoryModelDatum {
    int? id;
    PurpleAttributes? attributes;

    CategoryModelDatum({
        this.id,
        this.attributes,
    });

    factory CategoryModelDatum.fromJson(Map<String, dynamic> json) => CategoryModelDatum(
        id: json["id"],
        attributes: json["attributes"] == null ? null : PurpleAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
    };
}

class PurpleAttributes {
    String? title;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? publishedAt;
    String? iconUrl;
    Products? products;

    PurpleAttributes({
        this.title,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.iconUrl,
        this.products,
    });

    factory PurpleAttributes.fromJson(Map<String, dynamic> json) => PurpleAttributes(
        title: json["title"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        iconUrl: json["iconUrl"],
        products: json["products"] == null ? null : Products.fromJson(json["products"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "iconUrl": iconUrl,
        "products": products?.toJson(),
    };
}

class Products {
    List<ProductsDatum>? data;

    Products({
        this.data,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: json["data"] == null ? [] : List<ProductsDatum>.from(json["data"]!.map((x) => ProductsDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProductsDatum {
    int? id;
    FluffyAttributes? attributes;

    ProductsDatum({
        this.id,
        this.attributes,
    });

    factory ProductsDatum.fromJson(Map<String, dynamic> json) => ProductsDatum(
        id: json["id"],
        attributes: json["attributes"] == null ? null : FluffyAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
    };
}

class FluffyAttributes {
    String? title;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? publishedAt;
    String? price;
    String? rating;
    String? description;
    String? quantity;

    FluffyAttributes({
        this.title,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.price,
        this.rating,
        this.description,
        this.quantity,
    });

    factory FluffyAttributes.fromJson(Map<String, dynamic> json) => FluffyAttributes(
        title: json["title"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        price: json["price"],
        rating: json["rating"],
        description: json["description"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "price": price,
        "rating": rating,
        "description": description,
        "quantity": quantity,
    };
}

class Meta {
    Pagination? pagination;

    Meta({
        this.pagination,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
    };
}

class Pagination {
    int? page;
    int? pageSize;
    int? pageCount;
    int? total;

    Pagination({
        this.page,
        this.pageSize,
        this.pageCount,
        this.total,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
