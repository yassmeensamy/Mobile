import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Models/ProductModel.dart';
import 'package:app/Models/RestaurantModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatelessWidget 
{

   ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<ResturantCubit, ResturantState>(
        listener: (context, state) {
         
        },
        builder: (context, state) 
        {  
          if (state is ProductsSucess)
           {
              Restaurant restaurant =state.restaurant;
          return Container(
            height: screenHeight,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'Assets/cover-uploadjpeg-1652873595 1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.5,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.5,
                  child: Container(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.16,
                  left: 15,
                  right: 15,
                  child:
                      NameResturant(nameresturant:restaurant.name,rate: restaurant.rating,imageUrl:restaurant.image), // Ensure NameRestaurant widget fits in the designated space
                ),
                Positioned(
                  top: screenHeight * 0.38,
                  left: 0,
                  right: 0,
                  bottom: 0, // Extends to the bottom of the screen
                  child: ListView.builder(
                    itemCount: restaurant.products.length, // Adjust itemCount as needed
                    // Disable scrolling within the ListView
                    itemBuilder: (context, index) {
                      return ProductCard(restaurant.products[index]);
                    },
                  ),
                ),
              ],
            ),
          );
           }
           else 
           {
            return Container(color:Colors.black);
           }
        }
      ),
    );
  }
}

class NameResturant extends StatelessWidget {
  String nameresturant ;
  double rate;
  String imageUrl;
   NameResturant({required this.nameresturant ,required this.rate ,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ImageContainer(imageUrl: imageUrl),
                SizedBox(width: 10), // Space between image and text
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      nameresturant ,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "Desserts, Waffles, Ice Cream",
                      style: GoogleFonts.dmSans(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ), // Corrected typo and wording
                    // Corrected typo and wording
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(rate.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10), // Space between sections
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Space evenly between data items
              children: [
                Data(
                  title: "Delivery fee",
                  subtitle: "AED 6.50",
                ),
                Line(),
                Data(
                  title: "Deliverytime",
                  subtitle: "24 mins",
                ),
                Line(),
                Diliverd()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Data extends StatelessWidget {
  String title;
  String subtitle;
  Data({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: GoogleFonts.dmSans(color: Colors.black.withOpacity(.5))),
        Text(subtitle,
            style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 14)),
      ],
    );
  }
}

class Diliverd extends StatelessWidget {
  Diliverd();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Delivered by",
            style: GoogleFonts.dmSans(
              color: Colors.black.withOpacity(.5),
            )),
        Row(
          children: [
            Text("Talabat",
                style: GoogleFonts.dmSans(
                    color: Color(0xFFFF6100),
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            //Icon(Icons.mark_as_unread)
          ],
        )
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1, // Width of the divider
      height: 40, // Height of the divider
      color: Colors.black, // Color of the divider
    );
  }
}

class ProductCard extends StatelessWidget {
   Product product;
   ProductCard(this.product, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0, color: Colors.white), // Border styling
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding for the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Space out content
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      Text(
                        product.description, // Adjusted text content
                        style: GoogleFonts.dmSans(
                            color: Colors.black54, fontSize: 16),
                        softWrap:
                            true, // Allows wrapping within available space
                        overflow:
                            TextOverflow.clip, // Ensures text doesn't overflow
                      ),
                      SizedBox(height: 15),
                      Text(
                        'AED ${product.price}',
                        style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ) // Adjusted text alignment
                    ],
                  ),
                ),
                ImageContainer(imageUrl: product.image,)
                // You can include additional content here without causing overflow
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  String imageUrl;
 ImageContainer({ required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            10), // This is necessary to ensure rounded corners are applied to the image
        child: Image.asset(
          'Assets/cover-uploadjpeg-1652873595 1.png', // Update this to your image path
          width: 90,
          height: 75,
          fit:
              BoxFit.cover, // Ensures the image covers the container completely
        ),
      ),
    );
  }
}
