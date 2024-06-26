import 'package:flutter/material.dart';
import 'package:frontend_test/pages/dashboard.dart';
import 'package:frontend_test/utils/provider/ceklistprovider.dart';
import 'package:provider/provider.dart';

class AddItemsPages extends StatefulWidget {
  const AddItemsPages({super.key});

  @override
  State<AddItemsPages> createState() => _AddItemsPagesState();
}

class _AddItemsPagesState extends State<AddItemsPages> {
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
                        "Tambah Ceklist Item Baru",
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
                        hintText: "Masukan Item Baru",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          cekList.saveItem(item.text).then(
                            (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(value.data["message"])));
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardPages(),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text("Tambah Baru"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
