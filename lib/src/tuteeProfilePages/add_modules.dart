import 'package:flutter/material.dart';
import 'package:tutor_me/services/services/group_services.dart';
import 'package:tutor_me/services/services/module_services.dart';
import 'package:tutor_me/services/services/user_services.dart';
import 'package:tutor_me/src/colorpallete.dart';
import 'package:tutor_me/src/tuteeProfilePages/tutee_profile.dart';

import '../../services/models/groups.dart';
import '../../services/models/modules.dart';
import '../../services/models/users.dart';
import '../../services/services/tutee_services.dart';
import 'add_modules.dart';

// ignore: must_be_immutable
class AddModulesPage extends StatefulWidget {
  final Users user;
  List<Modules> currentModules;
  AddModulesPage({Key? key, required this.user, required this.currentModules})
      : super(key: key);

  @override
  _AddModulesPageState createState() => _AddModulesPageState();
}

class _AddModulesPageState extends State<AddModulesPage> {
  List<Modules> modulesToRemove = List<Modules>.empty(growable: true);
  List<Modules> modulesToAdd = List<Modules>.empty(growable: true);
  List<Modules> confirmedModules = List<Modules>.empty();
  List<Groups> tutorGroups = List<Groups>.empty();
  final textControl = TextEditingController();
  List<Modules> moduleList = List<Modules>.empty();
  List<Modules> saveModule = List<Modules>.empty();
  String query = '';
  bool isCurrentOpen = true;
  bool isAllOpen = false;
  bool isConfirming = false;

  void inputCurrent() {
    confirmedModules = widget.currentModules;
    for (int i = 0; i < widget.currentModules.length; i++) {
      updateModules(widget.currentModules[i]);
    }
  }

  void updateModules(Modules cModule) {
    String cName = cModule.getModuleName;
    String cCode = cModule.getCode;
    final modules = moduleList.where((module) {
      final nameToLower = module.getModuleName.toLowerCase();
      final codeToLower = module.getCode.toLowerCase();
      final cNameToLower = cName.toLowerCase();
      final cCodeToLower = cCode.toLowerCase();

      return !nameToLower.contains(cNameToLower) &&
          !codeToLower.contains(cCodeToLower);
    }).toList();
    setState(() {
      moduleList = modules;
    });
    getTutorGroups();
  }

  void search(String search) {
    if (search == '') {
      moduleList = saveModule;
    }
    final modules = moduleList.where((module) {
      final nameToLower = module.getModuleName.toLowerCase();
      final codeToLower = module.getCode.toLowerCase();
      final query = search.toLowerCase();

      return nameToLower.contains(query) || codeToLower.contains(query);
    }).toList();

    setState(() {
      moduleList = modules;
      query = search;
    });
  }

  getModules() async {
    final modules = await ModuleServices.getModules();
    setState(() {
      moduleList = modules;
      saveModule = modules;
    });
  }

  getTutorGroups() async {
    final groups =
        await GroupServices.getGroupByUserID(widget.user.getId, 'tutor');

    tutorGroups = groups;
  }

  @override
  void initState() {
    super.initState();
    getModules();

    inputCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Modules"),
        backgroundColor: colorOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                margin: const EdgeInsets.all(15),
                height: 50,
                child: TextField(
                  onChanged: (value) => search(value),
                  controller: textControl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                      suffixIcon: query.isNotEmpty
                          ? GestureDetector(
                              child: const Icon(
                                Icons.close,
                                color: Colors.black45,
                              ),
                              onTap: () {
                                textControl.clear();
                                setState(() {
                                  moduleList = saveModule;
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: colorOrange, width: 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      hintText: "Search for a module..."),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                // padding: const EdgeInsets.all(10),
                itemCount: moduleList.length,
                itemBuilder: _cardBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addModule(Modules newModule) {
    setState(() {
      widget.currentModules.add(newModule);
    });
  }

  void deleteModule(int i) {
    setState(() {
      widget.currentModules.removeAt(i);
      getModules();
      inputCurrent();
    });
  }

  Widget _cardBuilder(BuildContext context, int i) {
    String name = moduleList[i].getModuleName;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.book,
              color: colorTurqoise,
            ),
            title: Text(name),
            subtitle: Text(moduleList[i].getCode),
            trailing: IconButton(
              onPressed: () {
                addModule(moduleList[i]);
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }

  showConfirmUpdate(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: (() async => false),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                  title: const Text("Alert"),
                  content: const Text(
                      'New Groups will be created for the newly added modules'),
                  actions: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 2, color: colorTurqoise)),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: colorTurqoise),
                        )),
                  ]);
            }),
          );
        });
  }

  Widget topDesign() {
    return const Scaffold(
      body: Text('Edit Module List'),
    );
  }

  Widget buildAddButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddModulesPage(
                      user: widget.user,
                      currentModules: widget.currentModules,
                    ))).then((value) {
          if (value != null) {
            setState(() {
              widget.currentModules = value;
            });
          }
        });
      },
      icon: const Icon(Icons.add),
      label: const Text('Add Modules'),
      backgroundColor: colorTurqoise,
    );
  }
}
