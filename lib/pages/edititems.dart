import 'package:flutter/material.dart';
import 'package:frontend_test/pages/dashboard.dart';
import 'package:frontend_test/utils/provider/ceklistprovider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditItemsPages extends StatefulWidget {
  int id;
  EditItemsPages({super.key, required this.id});

  @override
  State<EditItemsPages> createState() => _EditItemsPagesState();
}

class _EditItemsPagesState extends State<EditItemsPages> {
  TextEditingController item = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cekList = Provider.of<CekListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ceklist App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Silahkan Tunggu"),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "Tambah Sub Item",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextField(
                      controller: item,
                      decoration: const InputDecoration(
                        hintText: "Masukan Nama Item",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          cekList
                              .saveSubItem(widget.id, item.text)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value["message"])));
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DashboardPages(),
                              ),
                            );
                          });
                        },
                        child: const Text("Tambah"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
