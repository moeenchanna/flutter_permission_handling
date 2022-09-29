import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission Handler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Permission Handler"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: requestStoragePermission,
                  child: const Text(
                    "Request Storage Permission",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: requestMultiplePermissions,
                  child: const Text(
                    "Request Multiple Permissions",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: requestPermissionWithOpenSettings,
                  child: const Text(
                    "Open Permission Settings",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.storage.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        print("Permission was granted");
      }
    }

    // You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
    //   // The OS restricts access, for example because of parental controls.
    // }
  }

  /// Request multiple permissions at once.
  /// In this case location & storage
  void requestMultiplePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();
    print("location permission: ${statuses[Permission.location]}, "
        "storage permission: ${statuses[Permission.camera]}");
  }

  /// The user opted to never again see the permission request dialog for this
  /// app. The only way to change the permission's status now is to let the
  /// user manually enable it in the system settings.
  void requestPermissionWithOpenSettings() async {
    //if (await Permission.speech.isPermanentlyDenied) {
    openAppSettings();
    //}
  }
}
