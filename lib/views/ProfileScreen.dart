import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/viewmodels/Profile_ViewModel.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/RecoveryPW_Screen.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel _viewModel = ProfileViewModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = true;
  bool _isEditing = false; // Biến để theo dõi trạng thái chỉnh sửa
  File? _imageFile;
  String? _imageUrl;
  String? anh;
  int? id_user;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await LoginService.getUserData();
    if (user != null) {
      setState(() {
        id_user = int.parse(user['id'].toString());
        _nameController.text = user['ten'] ?? "Bạn chưa nhập thông tin";
        _emailController.text = user['email'] ?? "Bạn chưa nhập thông tin";
        _phoneController.text = user['sdt'] ?? "Bạn chưa nhập thông tin";
        _addressController.text =
            user['dia_chi'] ?? "Bạn chưa nhập thông tin";
        anh = user['anh_user'] ?? "Bạn chưa nhập thông tin";
      });
    } else {
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login_Screen()),
                );
              },
            ),
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
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

  Future<void> _updateUserData() async {
    final updatedUser = ThongTin(
      id: _viewModel.user!.id,
      ten: _nameController.text,
      email: _emailController.text,
      sdt: _phoneController.text,
      diaChi: _addressController.text,
    );
    print(updatedUser);
    try {
      await _viewModel.updateUserData(updatedUser);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cập nhật thành công!')));
    } catch (e) {
      _showErrorDialog('Cập nhật thất bại.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = null;
      });
      await _saveImageToStorage(pickedFile);
    }
  }

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
              _isEditing == true ? Icons.check : Icons.edit,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                // if (_isEditing == true) {
                _updateUserData();
                // } // Chuyển đổi trạng thái chỉnh sửa
                _isEditing = !_isEditing;
              });
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
                textEditingController: _nameController,
                suffixIcon: const Icon(Icons.person),
                isEditing: _isEditing, // Truyền biến _isEditing
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
                isEditing: _isEditing, // Truyền biến _isEditing
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomTextformfield(
                labelText: "Số điện thoại",
                hintText: "Số điện thoại của bạn",
                textEditingController: _phoneController,
                suffixIcon: const Icon(Icons.phone),
                isEditing: _isEditing, // Truyền biến _isEditing
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
                isEditing: _isEditing, // Truyền biến _isEditing
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
                      builder: (context) => RecoveryPassword_Screen(),
                    ),
                  );
                },
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
  final bool isEditing; // Thêm tham số isEditing

  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.textEditingController,
    required this.isEditing, // Nhận tham số isEditing
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
            enabled: isEditing, // Sử dụng biến isEditing
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
