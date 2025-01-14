import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
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

  bool _isLoading = true;
  File? _imageFile;
  String? _imageUrl;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    String? token = prefs.getString('token');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      _nameController.text = user['ten'].toString() == null
          ? "chưa cập nhật thông tin"
          : user['ten'].toString();
      _emailController.text = user['email'].toString() == null
          ? "chưa cập nhật thông tin"
          : user['email'].toString();
      _phoneController.text = user['sdt'].toString() == null
          ? "chưa cập nhật thông tin"
          : user['sdt'].toString();
      _addressController.text = user['dia_chi'].toString() == null
          ? "chưa cập nhật thông tin"
          : user['dia_chi'].toString();
    }

    if (token != null) {
      print('Token: $token');
    }
    setState(() {});
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
                        : _imageUrl != null
                            ? NetworkImage(_imageUrl!)
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
                textEditingController: _nameController,
                suffixIcon: const Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Email",
                hintText: "Email của bạn",
                textEditingController: _emailController,
                suffixIcon: const Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Số điện thoại",
                hintText: "Số điện thoại của bạn",
                textEditingController: _phoneController,
                suffixIcon: const Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Địa chỉ",
                hintText: "Địa chỉ của bạn",
                textEditingController: _addressController,
                suffixIcon: const Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 40),

            // Nút Đổi mật khẩu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  // Thêm logic đổi mật khẩu sau
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                ),
                child: Text(
                  "Đổi mật khẩu",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
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
