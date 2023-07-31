import 'package:flutter/material.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:partners_leads/view_model/user_view_model.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    print(MyStaticValue.groupAccess);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: Text(
                  MyStaticValue.login_name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 35, color: Color.fromARGB(213, 255, 255, 255)),
                ),
              ),
              accountName: Text(
                MyStaticValue.login_name,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(224, 255, 255, 255)),
              ),
              accountEmail: Text(MyStaticValue.email,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(224, 255, 255, 255)))),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 111, 115, 116),
            ),
            onTap: (() {
              Navigator.pushNamed(context, RoutesName.profile);
            }),
            title: const Text(
              "My Profile",
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Color.fromARGB(255, 111, 115, 116),
            ),
            onTap: () {
              if (MyStaticValue.valid || (MyStaticValue.emp_type != 4)) {
                Navigator.pushNamed(context, RoutesName.createLeads);
              } else {
                Utils.flushBarErrorMessageForAddClient(
                    "Your 6 month subscription plan has been Expired", context);
              }
            },
            title: const Text(
              "Add Leads",
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              color: Color.fromARGB(255, 111, 115, 116),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.leadsList);
            },
            title: const Text(
              "Lead List",
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.checklist_outlined,
              color: Color.fromARGB(255, 111, 115, 116),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, RoutesName.dealDoneView);
            },
            title: const Text(
              "Deal Done",
            ),
          ),
          // (MyStaticValue.emp_type == "1" || MyStaticValue.emp_type == "2" || MyStaticValue.id == "9" || MyStaticValue.id == "53")
             MyStaticValue.groupAccess=="1" ? ExpansionTile(
                  leading: const Icon(
                    Icons.groups_outlined,
                    color: Color.fromARGB(255, 111, 115, 116),
                  ),
                  title: const Text(
                    "Group Filter",
                  ),
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.groups_outlined,
                        color: Color.fromARGB(255, 111, 115, 116),
                      ),
                      onTap: (() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Map data = {'group': 'A'};
                        Navigator.pushNamed(context, RoutesName.groupList,
                            arguments: ScreenArguments(data));
                      }),
                      title: const Text(
                        "Group A",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.groups_outlined,
                        color: Color.fromARGB(255, 111, 115, 116),
                      ),
                      onTap: (() {
                        Map data = {'group': 'B'};
                        Navigator.pushNamed(context, RoutesName.groupList,
                            arguments: ScreenArguments(data));
                      }),
                      title: const Text(
                        "Group B",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.groups_outlined,
                        color: Color.fromARGB(255, 111, 115, 116),
                      ),
                      onTap: (() {
                        Map data = {'group': 'C'};
                        Navigator.pushNamed(context, RoutesName.groupList,
                            arguments: ScreenArguments(data));
                      }),
                      title: const Text(
                        "Group C",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.groups_outlined,
                        color: Color.fromARGB(255, 111, 115, 116),
                      ),
                      onTap: (() {
                        Map data = {'group': 'D'};
                        Navigator.pushNamed(context, RoutesName.groupList,
                            arguments: ScreenArguments(data));
                      }),
                      title: const Text(
                        "Group D",
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const Divider(
            thickness: 2.0,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 111, 115, 116),
            ),
            onTap: () {
              UserViewModel.remove();
              Navigator.pushReplacementNamed(context, RoutesName.splash);
            },
            title: const Text(
              "Log Out",
            ),
          ),
        ],
      ),
    );
  }
}
