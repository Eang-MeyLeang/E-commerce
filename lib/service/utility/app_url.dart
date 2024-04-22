class AppUrl {
  static var baseUrl = "https://cms.istad.co";
  static var getAllCategory = "$baseUrl/api/e-commerce-categories?populate=*";
  static var getProduct ="$baseUrl/api/e-commerce-products?populate=*&sort=id:desc";
  static var uploadImage = "$baseUrl/api/upload";
  static var PostProduct = "$baseUrl/api/e-commerce-products";
  static var searchProduct = "$baseUrl/api/e-commerce-products?populate=%2A&filters%5Btitle%5D=";
                                    
}
