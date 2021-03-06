import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfirstpro/models/product_model.dart';
import 'package:myfirstpro/utility/my_constant.dart';
import 'package:myfirstpro/utility/my_dialog.dart';
import 'package:myfirstpro/widgets/show_progress.dart';
import 'package:myfirstpro/widgets/show_title.dart';

class SellerEditProduct extends StatefulWidget {
  final ProductModel? productModel;
  const SellerEditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  _SellerEditProductState createState() => _SellerEditProductState();
}

class _SellerEditProductState extends State<SellerEditProduct> {
  ProductModel? productModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<String> pathImages = [];
  List<File?> files = [];
  bool statusImage = false; // false ==> haven't change

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    //print('### image from mySQL ===> ${productModel!.imagesPd}');
    convertStringToArray();
    nameController.text = productModel!.namePd;
    priceController.text = productModel!.pricePd;
    detailController.text = productModel!.detailPd;
  }

  void convertStringToArray() {
    String string = productModel!.imagesPd;
    //print('string before ==> $string');
    string = string.substring(1, string.length - 1);
    //print('string after ==> $string');'
    List<String> strings = string.split(',');
    for (var item in strings) {
      pathImages.add(item.trim());
      files.add(null);
    }
    print('### this path images ==> $pathImages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => processEdit(),
              icon: Icon(Icons.edit),
              tooltip: 'Edit',
            )
          ],
          title: Text('Edit Product'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusScopeNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitle('General: '),
                      buildName(constraints),
                      buildPrice(constraints),
                      buildDetail(constraints),
                      buildTitle('Image: '),
                      buildImage(constraints, 0),
                      buildImage(constraints, 1),
                      buildImage(constraints, 2),
                      buildImage(constraints, 3),
                      buildEditProduct(constraints)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Container buildEditProduct(BoxConstraints constraints) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: constraints.maxWidth,
        child: ElevatedButton.icon(
            onPressed: processEdit,
            icon: Icon(Icons.edit),
            label: Text('Edit')));
  }

  Future<Null> chooseImage(int index, ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxHeight: 800, maxWidth: 800);
      setState(() {
        files[index] = File(result!.path);
        statusImage = true;
      });
    } catch (e) {}
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.camera),
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: constraints.maxWidth * 0.5 - 4,
            height: constraints.maxWidth * 0.5,
            child: files[index] == null
                ? CachedNetworkImage(
                    imageUrl:
                        '${Myconstant.domain}/tu2hand/${pathImages[index]}',
                    placeholder: (context, url) => ShowProgress(),
                  )
                : Image.file(files[index]!),
          ),
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.gallery),
            icon: Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Fill in blank';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name: ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPrice(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Fill in blank';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Price: ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Fill in blank';
              } else {
                return null;
              }
            },
            maxLines: 4,
            controller: detailController,
            decoration: InputDecoration(
              labelText: 'Detail: ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitle(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowTitle(title: title, textStyle: Myconstant().h2Style()),
        ),
      ],
    );
  }

  Future<Null> processEdit() async {
    if (formKey.currentState!.validate()) {
      MyDialog().showProgressDialog(context);

      String namePd = nameController.text;
      String pricePd = priceController.text;
      String detailPd = detailController.text;
      String id = productModel!.id;
      String imagesPd;
      if (statusImage) {
        //upload image & refesh array pathImages
        int index = 0;
        for (var item in files) {
          if (item != null) {
            int i = Random().nextInt(1000000);
            String nameImage = 'pdEdit_$i.jpg';
            String apiUploadImage =
                '${Myconstant.domain}/tu2hand/saveFilePD.php';

            Map<String, dynamic> map = {};
            map['file'] =
                await MultipartFile.fromFile(item.path, filename: nameImage);
            FormData formData = FormData.fromMap(map);
            await Dio().post(apiUploadImage, data: formData).then((value) {
              pathImages[index] = '/pdImg/$nameImage';
            });
          }
          index++;
        }
        imagesPd = pathImages.toString();
        Navigator.pop(context);
      } else {
        imagesPd = pathImages.toString();
        Navigator.pop(context);
      }

      print('## statusImage = $statusImage');
      print(
          '## id = $id , name = $namePd, price = $pricePd, detail = $detailPd');
      print('## images = $imagesPd');

      String apiEditProduct =
          '${Myconstant.domain}/tu2hand/editProductWhereId.php?isAdd=true&id=$id&namePd=$namePd&pricePd=$pricePd&detailPd=$detailPd&imagesPd=$imagesPd';
      await Dio().get(apiEditProduct).then((value) => Navigator.pop(context));
    }
  }
}
