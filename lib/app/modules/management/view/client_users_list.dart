import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../resources/app_strings.dart';

class ClientUserList extends StatefulWidget {
  @override
  State<ClientUserList> createState() => _ClientUserListState();
}

class _ClientUserListState extends State<ClientUserList> {
  int limit = 20;
  bool location = false;
  final List<Map<String, dynamic>> _allUsers = [];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilterName(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) &&
              user['age'] > 30)
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  void _runFilterLocation(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["location"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users_folder/folder/client_users')
                .limit(limit)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                snapshot.data!.docs.forEach((element) {
                  _allUsers.add({
                    'id': '${element.get('client_uid')}',
                    'name': '${element.get('client_name')}',
                    'age': element.get('client_age'),
                    'location': element.get('client_location'),
                    'number': element.get('client_mobile_number') ?? '',
                    'email': element.get('client_email') ?? ''
                  });
                });
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            if (location == true) {
                              setState(() {
                                location = false;
                              });
                            }
                            setState(() {
                              location = true;
                            });
                          },
                          icon: Icon(LineIcons.search),
                          label: Text(location
                              ? "Search by name"
                              : "Search by location")),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              limit = limit + 10;
                            });
                          },
                          icon: Icon(LineIcons.plus),
                          label: Text("Icrement by 10")),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          onChanged: (value) => location
                              ? _runFilterLocation(value)
                              : _runFilterName(value),
                          decoration: const InputDecoration(
                            labelText: 'Search',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: _foundUsers.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(_foundUsers[index]["id"]),
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                onTap: (){
                                   Get.toNamed('/home/${AppStrings.MANAGEMENT}/client_users');
                                },
                                // leading: Text(
                                //   _foundUsers[index]["id"].toString(),
                                //   style: const TextStyle(fontSize: 24),
                                // ),
                                isThreeLine: true,
                                title: Text(
                                  _foundUsers[index]['name'],
                                  style: context.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Age: ${_foundUsers[index]["age"].toString()} years old'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Number: ${_foundUsers[index]["number"].toString()}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Mail: ${_foundUsers[index]["email"].toString()}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Location: ${_foundUsers[index]["location"].toString()}'),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Text(
                            'No results found',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
