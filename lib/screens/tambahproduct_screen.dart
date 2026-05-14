import 'package:flutter/material.dart';

// ignore: unused_import
import '../models/product_model.dart';
import '../services/product_service.dart';

class AddProductScreen
    extends StatefulWidget {

  const AddProductScreen({
    super.key,
  });

  @override
  State<AddProductScreen>
      createState() =>
          _AddProductScreenState();
}

class _AddProductScreenState
    extends State<AddProductScreen> {

  final titleController =
      TextEditingController();

  final authorController =
      TextEditingController();

  final priceController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final imageController =
      TextEditingController();

  final formKey =
      GlobalKey<FormState>();

  final productService =
      ProductService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF6F3EB),

      appBar: AppBar(

        backgroundColor:
            const Color(0xffF6F3EB),

        elevation: 0,

        title: const Text(

          "Tambah Buku",

          style: TextStyle(

            color: Color(0xff2F2F2F),

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              const Text(

                "Tambahkan detail buku",

                style: TextStyle(

                  fontSize: 26,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Color(0xff2F2F2F),
                ),
              ),

              const SizedBox(height: 8),

              const Text(

                "Lengkapi informasi buku di bawah ini.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              buildTextField(

                controller:
                    titleController,

                label:
                    "Judul Buku",

                icon:
                    Icons.menu_book_rounded,

                validator:
                    (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Judul wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              buildTextField(

                controller:
                    authorController,

                label:
                    "Penulis",

                icon:
                    Icons.person,

                validator:
                    (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Penulis wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              buildTextField(

                controller:
                    priceController,

                label:
                    "Harga",

                icon:
                    Icons.payments_rounded,

                keyboardType:
                    TextInputType.number,

                validator:
                    (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Harga wajib diisi";
                  }

                  if (!RegExp(
                    r'^[0-9]+$',
                  ).hasMatch(value)) {

                    return "Harga harus angka";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              buildTextField(

                controller:
                    descriptionController,

                label:
                    "Deskripsi",

                icon:
                    Icons.description_rounded,

                maxLines: 4,

                validator:
                    (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Deskripsi wajib diisi";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              buildTextField(

                controller:
                    imageController,

                label:
                    "URL Gambar (Optional)",

                icon:
                    Icons.image_rounded,
              ),

              const SizedBox(height: 35),

              SizedBox(

                width:
                    double.infinity,

                height: 55,

                child: ElevatedButton(

                  onPressed: () async {

                    if (!formKey
                        .currentState!
                        .validate()) {

                      return;
                    }

                    bool success =
                        await productService
                            .addProduct(

                      "${titleController.text} - ${authorController.text}",

                      int.parse(
                        priceController.text,
                      ),

                      descriptionController.text,
                    );

                    if (success) {

                      if (!mounted) return;

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(

                          backgroundColor:
                              const Color(
                            0xff869B7E,
                          ),

                          content: const Text(
                            "Buku berhasil ditambahkan",
                          ),
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);

                    } else {

                      if (!mounted) return;

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(

                          backgroundColor:
                              const Color(
                            0xff7F2020,
                          ),

                          content: const Text(
                            "Gagal menambahkan buku",
                          ),
                        ),
                      );
                    }
                  },

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                      0xff7F2020,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  child: const Text(

                    "Simpan Buku",

                    style: TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,

                      color:
                          Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({

    required TextEditingController
        controller,

    required String label,

    required IconData icon,

    TextInputType keyboardType =
        TextInputType.text,

    int maxLines = 1,

    String? Function(String?)?
        validator,
  }) {

    return TextFormField(

      controller: controller,

      keyboardType:
          keyboardType,

      maxLines: maxLines,

      validator: validator,

      decoration: InputDecoration(

        labelText: label,

        prefixIcon:
            Icon(icon),

        filled: true,

        fillColor:
            const Color(
          0xffFFFCF7,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide.none,
        ),

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}