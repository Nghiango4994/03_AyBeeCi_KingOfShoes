import 'package:flutter/material.dart';

class AccountsettingScreen extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountsettingScreen> {
  bool enableFaceID = false;
  bool enablePushNotifications = true;
  bool enableLocationServices = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Account & Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          ListTile(
            title: Text('Notification Setting'),
            leading: Icon(Icons.notifications_active),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          ListTile(
            title: Text('Shipping Address'),
            leading: Icon(Icons.shopping_cart),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          ListTile(
            title: Text('Payment Info'),
            leading: Icon(Icons.payment),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          ListTile(
            title: Text('Delete Account'),
            leading: Icon(Icons.delete),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('App Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SwitchListTile(
            title: Text('Enable Face ID For Log In'),
            value: enableFaceID,
            onChanged: (value) {
              setState(() {
                enableFaceID = value;
              });
            },
            activeColor: Colors.white, // Màu khi Switch được bật
            activeTrackColor: Colors.blue, // Màu track khi Switch được bật
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          SwitchListTile(
            title: Text('Enable Push Notifications'),
            value: enablePushNotifications,
            onChanged: (value) {
              setState(() {
                enablePushNotifications = value;
              });
            },
            activeColor: Colors.white, // Màu khi Switch được bật
            activeTrackColor: Colors.blue, // Màu track khi Switch được bật
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          SwitchListTile(
            title: Text('Enable Location Services'),
            value: enableLocationServices,
            onChanged: (value) {
              setState(() {
                enableLocationServices = value;
              });
            },
            activeColor: Colors.white, // Màu khi Switch được bật
            activeTrackColor: Colors.blue, // Màu track khi Switch được bật
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5), // Màu sắc
            thickness: 1, // Độ dày
            indent: 16, // Khoảng cách bên trái
            endIndent: 16, // Khoảng cách bên phải
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
            activeColor: Colors.white, // Màu khi Switch được bật
            activeTrackColor: Colors.blue, // Màu track khi Switch được bật
          ),
        ],
      ),
    );
  }
}
