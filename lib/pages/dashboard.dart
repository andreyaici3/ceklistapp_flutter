import 'package:flutter/material.dart';
import 'package:frontend_test/pages/addItems.dart';
import 'package:frontend_test/pages/edititems.dart';
import 'package:frontend_test/utils/provider/ceklistprovider.dart';
import 'package:provider/provider.dart';

class DashboardPages extends StatefulWidget {
  const DashboardPages({super.key});

  @override
  State<DashboardPages> createState() => _DashboardPagesState();
}

class _DashboardPagesState extends State<DashboardPages> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddItemsPages(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: cekList.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: snapshot.data!.data[index]
                                                .checklistCompletionStatus,
                                            onChanged: (value) {},
                                          ),
                                          Text(snapshot.data!.data[index].name),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditItemsPages(
                                              id: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cekList
                                            .deleteItem(
                                                snapshot.data!.data[index].id)
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(value["message"])));
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const DashboardPages(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text("Hapus"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ...[
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    snapshot.data!.data[index].items!.length,
                                itemBuilder: (context, indexs) => Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, right: 8),
                                  child: Card(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: false,
                                                onChanged: (value) {},
                                              ),
                                              Text(snapshot.data!.data[index]
                                                  .items![indexs].name),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text("Edit"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            cekList
                                                .deleteSubItem(
                                                    snapshot
                                                        .data!.data[index].id,
                                                    snapshot.data!.data[index]
                                                        .items![index].id)
                                                .then((value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          value["message"])));
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DashboardPages(),
                                                ),
                                              );
                                            });
                                          },
                                          child: Text("Hapus"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                shrinkWrap: true,
                              )
                            ],
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ));
              }
            },
          ),
        ));
  }
}
