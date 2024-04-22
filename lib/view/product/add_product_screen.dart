import 'dart:io';

import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/model/product_request_model.dart';
import 'package:e_commerce_app/service/utility/status.dart';
import 'package:e_commerce_app/service/view_model/image_viewmodel.dart';
import 'package:e_commerce_app/service/view_model/product_request_viewmodel.dart';
import 'package:e_commerce_app/util/myfont.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatefulWidget {
  AddProductScreen({this.productmodel, this.isFromUpdate});
  bool? isFromUpdate;
  Datum? productmodel;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var imageFile;
  var imageId;
  var productId;
  bool? isPicked;
  final _imageViewModel = ImageViewModel();
  final _productRequestViewModel = ProductRequestViewmodel();
  final titleController = TextEditingController();
  final ratingController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkIfFromUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFromUpdate == false ? "Add Product " : " Update product", style: MyFont.TextContentStyle,)
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Image Picker
            Align(
              alignment: Alignment.center,
              child: ChangeNotifierProvider(
                create: (context) => _imageViewModel,
                child: Consumer<ImageViewModel>(
                  builder: (ctx, viewModel, _) {
                    if (widget.isFromUpdate!) {
                      var image =
                          widget.productmodel!.attributes!.thumbnail!.data ??
                              "";
                      if (viewModel.response.data != null) {
                        imageId = viewModel.response.data![0].id;
                        print("image id : $imageId");
                      }
                      return InkWell(
                        onTap: () {
                          _getImageFromSource(source: 'gallery');
                        },
                        child: imageFile == null
                            ? Image.network(
                                image != ""
                                    ? 'https://cms.istad.co${widget.productmodel!.attributes!.thumbnail!.data?.attributes!.url!}'
                                    : 'https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg',
                                fit: BoxFit.contain,
                              )
                            : Image.file(imageFile),
                      );
                    }
                    if (viewModel.response.status == null) {
                      if (viewModel.response.data != null) {
                        imageId = viewModel.response.data![0].id;
                        print("image id : $imageId");
                      }
                      return InkWell(
                          onTap: () {
                            _getImageFromSource(source: 'gallery');
                            // imageId = viewModel.response.data[0].id;
                          },
                          child: Image.network(
                            'https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg',
                            fit: BoxFit.contain,
                          ));
                    }

                    switch (viewModel.response.status!) {
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        imageId = viewModel.response.data[0].id;
                        print("image id :$imageId");
                        return InkWell(
                          onTap: () {
                            _getImageFromSource(source: 'gallery');
                          },
                          child: SizedBox(
                              width: 350,
                              height: 250,
                              child: Image.network(
                                  'https://cms.istad.co${viewModel.response.data[0].url!}')),
                        );
                      case Status.ERROR:
                        return Text(viewModel.response.message!);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Title', border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: ratingController,
                decoration: InputDecoration(
                    hintText: 'Rating', border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Description', border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: quantityController,
                decoration: InputDecoration(
                    hintText: 'Quantity', border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: categoryController,
                decoration: InputDecoration(
                    hintText: 'Category', border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                    hintText: 'Price', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 10),
            ChangeNotifierProvider(
              create: (context) => _productRequestViewModel,
              child: Consumer<ProductRequestViewmodel>(
                builder: (ctx, viewModel, _) {
                  if (viewModel.response.status == null) {
                    return ElevatedButton(
                        onPressed: () {
                          _saveProduct();
                        },
                        child: widget.isFromUpdate!
                            ? Text('Update')
                            : Text('Save'));
                  }
                  switch (viewModel.response.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(content: Text('Post Success')));
                      });
                      return ElevatedButton(
                          onPressed: () {
                            _saveProduct();
                          },
                          child: Text('Save'));
                    case Status.ERROR:
                      return Text(viewModel.response.message!);
                  }
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _getImageFromSource({source}) async {
    // print('picking image ');
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      // uploading image to server
      _imageViewModel.uploadImage(pickedFile.path);
      setState(() {
        isPicked = true;
        imageFile = File(pickedFile.path);
      });
      print('Picked Image : ${File(pickedFile.path)}');
    }
  }

  void _saveProduct() {
    var productRequestModel = ProductRequestModel(
        data: Data(
            title: titleController.text,
            rating: ratingController.text,
            description: descriptionController.text,
            quantity: quantityController.text,
            price: priceController.text,
            category: categoryController.text != ""
                ? categoryController.text
                : "",
            thumbnail: imageId != "" ? imageId.toString() : ""));
    _productRequestViewModel.postProduct(productRequestModel,
        id: productId, isUpdate: widget.isFromUpdate);
  }

  void checkIfFromUpdate() {
    if (widget.isFromUpdate!) {
      titleController.text = widget.productmodel!.attributes!.title.toString();
      ratingController.text =
          widget.productmodel!.attributes!.rating.toString();
      descriptionController.text =
          widget.productmodel!.attributes!.description.toString();
      quantityController.text =
          widget.productmodel!.attributes!.quantity.toString();
      categoryController.text =
          widget.productmodel!.attributes!.category?.data != null
              ? widget.productmodel!.attributes!.category!.data!.id.toString()
              : "";
      imageId = widget.productmodel!.attributes!.thumbnail!.data != ""
          ? widget.productmodel!.attributes!.thumbnail!.data?.id.toString()
          : imageFile;
      priceController.text = widget.productmodel!.attributes!.price.toString();
      productId = widget.productmodel!.id;
    }
  }
}
