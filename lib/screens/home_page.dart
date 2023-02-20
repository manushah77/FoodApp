import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/product_provider.dart';
import 'package:food_app_complete/providers/user_provider.dart';
import 'package:food_app_complete/screens/prodct_overview/product_overview.dart';
import 'package:food_app_complete/screens/review_cart/review_cart.dart';
import 'package:food_app_complete/screens/search/search.dart';
import 'package:food_app_complete/widgets/drawer.dart';
import 'package:food_app_complete/widgets/single_product.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductProvider? productProvider;
  final PageController controller = PageController();

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fetchAppleProduct();
    initproductProvider.fetchVegProduct();
  }

  List imageUrl = [
    'https://images.squarespace-cdn.com/content/v1/5b35b18af93fd4d75e591f4a/1543985705633-PCFJHY4L8CTTOR4NSRW9/HS-Website---Fruit-Products.jpg?format=2500w',
    'https://media.istockphoto.com/id/1285272101/photo/assortment-of-fresh-fruits-and-water-splashes-on-panoramic-background.jpg?b=1&s=612x612&w=0&k=20&c=67xuBq5aWlvCaLyxu4N9SUWQHf5WaQP2c1YBB74cwG8=',
    'https://afproduce.com/wp-content/uploads/2018/08/fruits1.jpg',
    'https://i.ndtvimg.com/i/2017-02/veggies_620x350_51486066494.jpg',
    'https://img.etimg.com/thumb/msid-69712122,width-640,height-480,imgsize-1226932,resizemode-4/eat-your-fruits-and-veggies-to-avoid-strokes.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerSide(
          userProvider: userProvider,
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: primaryColor,
          ),
          backgroundColor: primaryColor,
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.list,
              ),
            ),
          ),
          actions: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(
                          search: productProvider!.searchitems,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green.withOpacity(0.5),
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewCart(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green.withOpacity(0.5),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: ListView(
            children: [
              // SizedBox(
              //   height: 150,
              //   child: PageView.builder(
              //     controller: controller,
              //     itemCount: imageUrl.length,
              //     itemBuilder: (context, index) {
              //       if (imageUrl == null) {
              //         Image.asset('assets/images/oop.png');
              //       } else {
              //         imageUrl[index];
              //       }
              //       return Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: Container(
              //           height: 150,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             image: DecorationImage(
              //               image: NetworkImage('${imageUrl[index]}'),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Container(
              //                   child: Column(
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.only(
              //                             right: 120.0, bottom: 10),
              //                         child: Container(
              //                           height: 50,
              //                           width: 85,
              //                           decoration: BoxDecoration(
              //                             color: primaryColor,
              //                             borderRadius: BorderRadius.only(
              //                               bottomRight: Radius.circular(50),
              //                               bottomLeft: Radius.circular(50),
              //                             ),
              //                           ),
              //                           child: Center(
              //                             child: Text(
              //                               'All Prodcts',
              //                               style: TextStyle(
              //                                   fontSize: 15,
              //                                   color: Colors.white,
              //                                   shadows: [
              //                                     BoxShadow(
              //                                       blurRadius: 2,
              //                                       color:
              //                                           Colors.green.shade900,
              //                                       offset: Offset(2, 2),
              //                                     ),
              //                                   ]),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Text(
              //                         '30% Off',
              //                         style: TextStyle(
              //                           fontSize: 35,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w600,
              //                           shadows: [
              //                             BoxShadow(
              //                               blurRadius: 2,
              //                               color: Colors.green.shade900,
              //                               offset: Offset(2, 2),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         height: 10,
              //                       ),
              //                       Text(
              //                         'On All Products',
              //                         style: TextStyle(
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w600,
              //                           shadows: [
              //                             BoxShadow(
              //                               blurRadius: 2,
              //                               color: Colors.green.shade900,
              //                               offset: Offset(2, 2),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Container(),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Column(
              //   children: [
              //     SmoothPageIndicator(
              //       controller: controller,
              //       count: imageUrl.length,
              //       effect: ExpandingDotsEffect(
              //         activeDotColor: primaryColor,
              //         dotColor: Colors.black38,
              //       ),
              //     ),
              //
              //
              //   ],
              // ),
              CarouselSlider(
                items: imageUrl
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  e,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       right: 85.0, bottom: 10),
                                        //   child: Container(
                                        //     height: 50,
                                        //     width: 85,
                                        //     decoration: BoxDecoration(
                                        //       color: primaryColor,
                                        //       borderRadius: BorderRadius.only(
                                        //         bottomRight: Radius.circular(50),
                                        //         bottomLeft: Radius.circular(50),
                                        //       ),
                                        //     ),
                                        //     child: Center(
                                        //       child: Text(
                                        //         'All Prodcts',
                                        //         style: TextStyle(
                                        //             fontSize: 15,
                                        //             color: Colors.white,
                                        //             shadows: [
                                        //               BoxShadow(
                                        //                 blurRadius: 2,
                                        //                 color:
                                        //                     Colors.green.shade900,
                                        //                 offset: Offset(2, 2),
                                        //               ),
                                        //             ]),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          '30% Off',
                                          style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            shadows: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.green.shade900,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'On All Products',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            shadows: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.green.shade900,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 150,
                  // aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  // enableInfiniteScroll: true,
                  // reverse: false,
                  autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 4),
                  // autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // // onPageChanged: callbackFunction,
                  // scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildFreshFruit(context),
              SizedBox(
                height: 10,
              ),
              _buildFreshVeg(context),
              SizedBox(
                height: 10,
              ),
              _buildFreshFruit(context),
              SizedBox(
                height: 10,
              ),
              _buildFreshVeg(context),
            ],
          ),
        ),
      ),
    );
  }

  //apple
  Widget _buildFreshFruit(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Fruits',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Search(
                      //           search: productProvider!.appleproductlist,
                      //         ),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Scroll',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.appleproductlist
                .map((e) => SingleProduct(
                      productImage: e.ProductImage.toString(),
                      productName: e.ProductName.toString(),
                      productPrice: e.ProductPrice,
                      productId: e.ProductId,
                      // productUnit: e.productUnit![],
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productName: e.ProductName.toString(),
                              productPrice: e.ProductPrice,
                              productImage: e.ProductImage.toString(),
                              productId: e.ProductId,
                              productQuantity: 1,
                            ),
                          ),
                        );
                      },
                      productUnit: e,
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  ///////////////Vegtable buil///////////

  Widget _buildFreshVeg(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Vegitables',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Search(
                      //           search: productProvider!.vegproductlist,
                      //         ),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Scrol',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.vegproductlist
                .map((e) => SingleProduct(
                      productUnit: e,
                      productId: e.ProductId,
                      productImage: e.ProductImage.toString(),
                      productName: e.ProductName.toString(),
                      productPrice: e.ProductPrice,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productName: e.ProductName.toString(),
                              productPrice: e.ProductPrice,
                              productImage: e.ProductImage.toString(),
                              productId: e.ProductId,
                              productQuantity: 1,
                            ),
                          ),
                        );
                      },
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
