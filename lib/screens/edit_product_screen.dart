import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/EditProduct';
  EditProductState createState() {
    return EditProductState();
  }
}

class EditProductState extends State<EditProduct> {
  final _pricefocusnode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _editedProduct = Product(
    id: '',
    title: "",
    price: 0,
    description: "",
    imageUrl: "",
  );

  var _initValues = {
    'title': '',
    'description': "",
    'price': "",
    "imageUrl": "",
  };
  @override
  void initState() {
    _imgUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null && productId != '') {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
      }
      _initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        //'imageUrl': _editedProduct.imageUrl
        'imageUrl': '',
      };
      print(_initValues);
      _imgUrlController.text = _editedProduct.imageUrl;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(updateImageUrl);
    _pricefocusnode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  void updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (isValid == null) {
      return;
    }
    //print("this is saveForm current state ${_form.currentState}");
    _form.currentState?.save();
    if (_editedProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateproducts(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_pricefocusnode);
                },
                validator: (value) {
                  //this will check the given value is fair or not
                  //we can write our own logic
                  if (value == null) {
                    return "Please Provide a Value";
                  }
                  return null; //this means that every thing is Okk
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: value as String,
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite);
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _pricefocusnode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  print("This is value in OnSaved $value");
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      price: value == null ? null : double.tryParse(value),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite);
                },
                validator: (value) {
                  //this will check the given value is fair or not
                  //we can write our own logic
                  print("This is value $value");
                  if (value == null) {
                    return "Please Provide a Value";
                  }
                  if (double.tryParse(value) == null)
                    return 'please enter a valid number';
                  //this means that every thing is Okk
                  if (double.parse(value) <= 0)
                    return "Please enter a number greater then zero";
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  //this will check the given value is fair or not
                  //we can write our own logic
                  if ((value == null) || (value.isEmpty)) {
                    return "Please Provide a Value";
                  }
                  if (value.length < 10)
                    return "Description too short must be atleast 10 character long";
                  return null; //this means that every thing is Okk
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value as String,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Container(
                      child: _imgUrlController.text.isEmpty
                          ? Text("Enter the Url")
                          : FittedBox(
                              child: Image.network(
                                _imgUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      //initialValue: _initValues['imageUrl'], //we cant use controller and initialValue both together
                      decoration: const InputDecoration(
                        labelText: "ImgUrl",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: value as String,
                            id: _editedProduct.id,
                            isFavourite: _editedProduct.isFavourite);
                      },
                      validator: (value) {
                        if (value == null) return "Please enter the url";
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) return 'invalid url';
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) return 'invalid url';

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
