import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../all.dart';

class CategoryList extends StatelessWidget {
  final String id;
  CategoryList(this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Marked')
        .child(id)
        .child('Categories')
        .onValue;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appbarwithicon(
        size,
        ConstantValue().categories,
        () {
          Customized().naviagt(
            context,
            CategoryAddScreen(id),
          );
        },
      ),
      body: StreamBuilder(
        stream: api,
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snap,
        ) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              List<String> _categoryid = [];
              data.forEach(
                (key, value) {
                  _categoryid.add(value['Id']);
                },
              );
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _categoryid.length,
                itemBuilder: (context, i) => StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('Categories')
                      .child(_categoryid[i])
                      .onValue,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<dynamic> snap,
                  ) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Customized().categoryshimmer(size);
                    } else {
                      if (snap.hasData &&
                          !snap.hasError &&
                          snap.data.snapshot.value != null) {
                        Category? _category;
                        _category = Category(
                          id: snap.data.snapshot.key,
                          name: snap.data.snapshot.value['Name'],
                          parent: snap.data.snapshot.value['Parent'],
                        );
                        return Customized().singlecategory(
                          size,
                          _category.name,
                          () {
                            Customized().naviagt(
                              context,
                              CategoryUpdate(_category!),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              );
            } else {
              return Center(
                child: Customized().datanot(size),
              );
            }
          }
        },
      ),
    );
  }
}
