import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/dark_mode.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  final _myBox = Hive.box("mybox");
  final _controller = TextEditingController();
  ToDoDatabase b = ToDoDatabase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create a default data.
    if (_myBox.get("TODOLIST") == null) {
      b.createInitialData();
    } else {
      // there already exist  data
      b.loadData();
    }
    super.initState();
    // _initBannerAd();
  }

 
  // _initBannerAd() {
  //   _bannerAd = BannerAd(
  //       size: AdSize.banner,
  //     adUnitId: 'ca-app-pub-4666091420175161/3506203960',
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             _isAdLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {},
  //       ),
  //       request: AdRequest());
  //   _bannerAd.load();
  // }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      b.toDoList[index][1] = !b.toDoList[index][1];
    });
    b.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      b.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    b.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      b.toDoList.removeAt(index);
    });
    b.updateDatabase();
  }

  void onEditPressed(int index) {
    _controller.text = b.toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () => onEdit(index),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void onEdit(int index) {
    setState(() {
      b.toDoList[index][0] = _controller.text;
    });
    Navigator.of(context).pop(); // Close the edit dialog
    b.updateDatabase();
    _controller.clear(); // Clear the controller after saving
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<darkMode>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color(0xFF2C2A2A)
          : Colors.yellow[200],
      appBar: AppBar(
        title: const Text("𝑻𝒐 𝒅𝒐"),
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.toggleDarkMode();
              },
              icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: b.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: b.toDoList[index][0],
            taskCompeleted: b.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            onEdit: () => onEditPressed(index),
          );
        },
      ),
      // bottomNavigationBar: _isAdLoaded
      //     ?  Container(
      //         height: _bannerAd.size.height.toDouble(),
      //         width: _bannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bannerAd),
      //       )
      //     : null, // Show bottom navigation bar only if the ad is loaded
    );
  }
}
