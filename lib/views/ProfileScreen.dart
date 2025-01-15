import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/RecoveryPW_Screen.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _Default = TextEditingController();

  bool _isLoading = true;
  File? _imageFile;
  String? _imageUrl;
  String? anh;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _Default.text = "Bạn chưa nhập thông tin";
    final user = await LoginService.getUserData();
    _Default.text = _Default.text;
    if (user != null) {
      setState(() {
        _nameController.text =
            user['ten'] == null ? _Default.text : user['ten'].toString();
        _emailController.text =
            user['email'] == null ? _Default.text : user['email'].toString();
        _phoneController.text =
            user['sdt'] == null ? _Default.text : user['sdt'].toString();
        _addressController.text = user['dia_chi'] == null
            ? _Default.text
            : user['dia_chi'].toString();
        anh = user['anh_user'] == null
            ? _Default.text
            : user['anh_user'].toString();
      });
    } else {
      // Hiển thị dialog thông báo
      _showLoginDialog();
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn cần đăng nhập để sử dụng chức năng này.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đăng nhập'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login_Screen()),
                );
              },
            ),
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home_Screen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();

  // Chọn ảnh từ thư viện hoặc camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = null; // Reset _imageUrl khi chọn ảnh mới
      });

      // Lưu ảnh vào bộ nhớ trong thiết bị
      await _saveImageToStorage(pickedFile);
    }
  }

  // Lưu ảnh vào bộ nhớ trong của thiết bị
  Future<void> _saveImageToStorage(XFile pickedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${path.basename(pickedFile.path)}';
    await File(pickedFile.path).copy(imagePath);
    print('Image saved to: $imagePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            onPressed: () {
              // Hàm sửa hồ sơ sau này
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Avatar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : anh != null
                            ? NetworkImage(anh == null ? "" : anh.toString())
                            : NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ48JWGkSOWJegd_jiLj6C5cz-Ityd6OMLR-w&s'),
                  ),
                  Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Các TextFormField
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Họ và Tên",
                hintText: "Tên của bạn",
                textEditingController:
                    _nameController == null ? _Default : _nameController,
                suffixIcon: const Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Email",
                hintText: "Email của bạn",
                textEditingController:
                    _emailController == null ? _Default : _emailController,
                suffixIcon: const Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Số điện thoại",
                hintText: "Số điện thoại của bạn",
                textEditingController:
                    _phoneController == null ? _Default : _phoneController,
                suffixIcon: const Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Địa chỉ",
                hintText: "Địa chỉ của bạn",
                textEditingController:
                    _addressController == null ? _Default : _addressController,
                suffixIcon: const Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 40),

            // Nút Đổi mật khẩu
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomButton(
                    text: "Đổi Mật Khẩu",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecoveryPassword_Screen()));
                    })),
          ],
        ),
      ),
    );
  }
}

class CustomTextformfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;

  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextFormField(
            controller: textEditingController,
            enabled: false,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: suffixIcon,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
