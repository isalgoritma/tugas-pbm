import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import 'tambahproduct_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final productService =
      ProductService();

  late Future<List<Product>>
      futureProducts;

  @override
  void initState() {

    super.initState();

    loadProducts();
  }

  void loadProducts() {

    futureProducts =
        productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffEFE8DD),

      appBar: AppBar(

        backgroundColor:
            const Color(0xffEFE8DD),

        elevation: 0,

        automaticallyImplyLeading:
            false,

        title: const Text(

          "Buy-Books",

          style: TextStyle(

            color: Color(0xff3C2A21),

            fontWeight:
                FontWeight.bold,

            fontSize: 28,
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(

        backgroundColor:
            const Color(0xff3C2A21),

        elevation: 2,

        onPressed: () async {

          await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (context) =>
                  const AddProductScreen(),
            ),
          );

          setState(() {

            loadProducts();
          });
        },

        icon: const Icon(

          Icons.add,

          color: Colors.white,
        ),

        label: const Text(

          "Add Book",

          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                24,
              ),

              decoration:
                  BoxDecoration(

                color:
                    const Color(
                  0xff3C2A21,
                ),

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: const [

                  Text(

                    "Welcome....",

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize: 15,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(

                    "Find Your Next\nFavorite Book",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 31,

                      fontWeight:
                          FontWeight.bold,

                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(

              "Popular Books",

              style: TextStyle(

                color: Color(0xff3C2A21),

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            Expanded(

              child:
                  FutureBuilder<List<Product>>(

                future: futureProducts,

                builder:
                    (context, snapshot) {

                  if (snapshot
                          .connectionState ==
                      ConnectionState
                          .waiting) {

                    return const Center(

                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (snapshot
                      .hasError) {

                    return Center(

                      child: Text(
                        snapshot.error
                            .toString(),
                      ),
                    );
                  }

                  final products =
                      snapshot.data ?? [];

                  if (products
                      .isEmpty) {

                    return Center(

                      child: Column(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: const [

                          Icon(

                            Icons
                                .menu_book_rounded,

                            size: 90,

                            color:
                                Color(
                              0xffBCA37F,
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(

                            "No Books Yet",

                            style: TextStyle(

                              fontSize: 24,

                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  Color(
                                0xff3C2A21,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(

                            "Start building your\nbookstore collection 📚",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors.grey,

                              height: 1.5,

                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return ListView.builder(

                    itemCount:
                        products.length,

                    itemBuilder:
                        (context, index) {

                      final product =
                          products[index];

                      return Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 22,
                        ),

                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                            0xffFFFDF8,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            28,
                          ),

                          boxShadow: [

                            BoxShadow(

                              // ignore: deprecated_member_use
                              color: Colors.black
                                  .withOpacity(
                                0.04,
                              ),

                              blurRadius:
                                  18,

                              offset:
                                  const Offset(
                                0,
                                8,
                              ),
                            )
                          ],
                        ),

                        child: Row(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            ClipRRect(

                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),

                              child:
                                  product.imageUrl
                                          .isNotEmpty

                                      ? Image.network(

                                          product
                                              .imageUrl,

                                          width:
                                              100,

                                          height:
                                              145,

                                          fit: BoxFit
                                              .cover,

                                          errorBuilder:
                                              (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {

                                            return Container(

                                              width:
                                                  100,

                                              height:
                                                  145,

                                              color:
                                                  const Color(
                                                0xffD6C7AE,
                                              ),

                                              child:
                                                  const Icon(

                                                Icons
                                                    .menu_book,

                                                size:
                                                    38,

                                                color:
                                                    Color(
                                                  0xff3C2A21,
                                                ),
                                              ),
                                            );
                                          },
                                        )

                                      : Container(

                                          width:
                                              100,

                                          height:
                                              145,

                                          color:
                                              const Color(
                                            0xffD6C7AE,
                                          ),

                                          child:
                                              const Icon(

                                            Icons
                                                .menu_book,

                                            size:
                                                38,

                                            color:
                                                Color(
                                              0xff3C2A21,
                                            ),
                                          ),
                                        ),
                            ),

                            const SizedBox(
                              width: 20,
                            ),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    product.name,

                                    maxLines: 2,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(

                                      color:
                                          Color(
                                        0xff3C2A21,
                                      ),

                                      fontSize:
                                          21,

                                      fontWeight:
                                          FontWeight.bold,

                                      height:
                                          1.4,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(

                                    product
                                        .description,

                                    maxLines: 3,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors.grey,

                                      fontSize:
                                          14,

                                      height:
                                          1.6,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 24,
                                  ),

                                  Row(

                                    children: [

                                      Container(

                                        padding:
                                            const EdgeInsets.symmetric(

                                          horizontal:
                                              18,

                                          vertical:
                                              10,
                                        ),

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              const Color(
                                            0xff3C2A21,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            16,
                                          ),
                                        ),

                                        child: Text(

                                          "Rp ${product.price}",

                                          style:
                                              const TextStyle(

                                            color:
                                                Colors.white,

                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      const Spacer(),

                                      Container(

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              const Color(
                                            0xffEFE8DD,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            14,
                                          ),
                                        ),

                                        child:
                                            IconButton(

                                          onPressed:
                                              () async {

                                            bool success =
                                                await productService
                                                    .deleteProduct(
                                              product.id,
                                            );

                                            if (success) {

                                              setState(() {

                                                loadProducts();
                                              });

                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(

                                                const SnackBar(

                                                  content:
                                                      Text(
                                                    "Book deleted successfully",
                                                  ),
                                                ),
                                              );
                                            }
                                          },

                                          icon:
                                              const Icon(

                                            Icons
                                                .delete_rounded,

                                            color:
                                                Color(
                                              0xff3C2A21,
                                            ),

                                            size:
                                                22,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}