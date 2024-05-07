import 'package:app/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';

class Search extends StatefulWidget 
{
  @override
  SearchState createState() => SearchState();
}
class SearchState extends State<Search> {
  late Product? selectedProduct;
  late Set<Product> products;

  @override
  void initState() 
  {
    super.initState();
    products =BlocProvider.of<ResturantCubit>(context).Products as Set<Product>;
    selectedProduct = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Product>(
              value: selectedProduct,
              icon: Icon(Icons.search),
              hint: Text('Select an option'),
              onChanged: (Product? newProduct) 
              {
                setState(() {
                  selectedProduct = newProduct;
                });
                BlocProvider.of<ResturantCubit>(context).ResultSearch(newProduct!.id);
                print(newProduct!.id);
              },
              items: products.map((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                
                  child: Text(product.name),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
