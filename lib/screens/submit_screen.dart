import 'package:flutter/material.dart';

import '../services/product_service.dart';

class SubmitScreen
    extends StatefulWidget {

  const SubmitScreen({
    super.key,
  });

  @override
  State<SubmitScreen>
      createState() =>
          _SubmitScreenState();
}

class _SubmitScreenState
    extends State<SubmitScreen> {

  final nameController =
      TextEditingController();

  final priceController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final githubController =
      TextEditingController(

    text:
        'https://github.com/isalgoritma/tugas-pbm',
  );

  final productService =
      ProductService();

  final formKey =
      GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffEFE8DD),

      appBar: AppBar(

        backgroundColor:
            const Color(0xffEFE8DD),

        elevation: 0,

        title: const Text(

          'Submit Tugas',

          style: TextStyle(

            color:
                Color(0xff3C2A21),

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(24),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              buildField(

                controller:
                    nameController,

                label:
                    'Nama Produk',
              ),

              const SizedBox(
                height: 18,
              ),

              buildField(

                controller:
                    priceController,

                label:
                    'Harga',

                number: true,
              ),

              const SizedBox(
                height: 18,
              ),

              buildField(

                controller:
                    descriptionController,

                label:
                    'Deskripsi',

                maxLines: 4,
              ),

              const SizedBox(
                height: 18,
              ),

              buildField(

                controller:
                    githubController,

                label:
                    'GitHub URL',

                maxLines: 2,
              ),

              const SizedBox(
                height: 35,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 58,

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                      0xff3C2A21,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed:
                      () async {

                    if (!formKey
                        .currentState!
                        .validate()) {

                      return;
                    }

                    bool success =
                        await productService
                            .submitTask(

                      nameController
                          .text,

                      int.parse(
                        priceController
                            .text,
                      ),

                      descriptionController
                          .text,

                      githubController
                          .text,
                    );

                    if (success) {

                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(
                        // ignore: use_build_context_synchronously
                        context,
                      ).showSnackBar(

                        const SnackBar(

                          content: Text(
                            'Tugas berhasil disubmit',
                          ),
                        ),
                      );

                      Navigator.pop(
                        // ignore: use_build_context_synchronously
                        context,
                      );

                    } else {

                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(
                        // ignore: use_build_context_synchronously
                        context,
                      ).showSnackBar(

                        const SnackBar(

                          content: Text(
                            'Submit gagal',
                          ),
                        ),
                      );
                    }
                  },

                  child: const Text(

                    'Submit Tugas',

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,
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

  Widget buildField({

    required TextEditingController
        controller,

    required String label,

    bool number = false,

    int maxLines = 1,

  }) {

    return TextFormField(

      controller: controller,

      keyboardType:
          number

              ? TextInputType
                  .number

              : TextInputType
                  .text,

      maxLines: maxLines,

      validator: (value) {

        if (value == null ||
            value.isEmpty) {

          return '$label wajib diisi';
        }

        return null;
      },

      decoration: InputDecoration(

        labelText: label,

        filled: true,

        fillColor:
            const Color(
          0xffFFFDF8,
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
      ),
    );
  }
}