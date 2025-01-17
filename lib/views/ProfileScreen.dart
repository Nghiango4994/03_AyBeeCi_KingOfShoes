import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/viewmodels/Profile_ViewModel.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/RecoveryPW_Screen.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _viewModel = ProfileViewModel();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isEditing = false;
  int id_user = 1; // Example user ID
  String? _base64Avatar; // Lưu chuỗi Base64 của ảnh đại diện

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
        _nameController.text = user['ten'] ?? "";
        _emailController.text = user['email'] ?? "";
        _phoneController.text = user['sdt'] ?? "";
        _addressController.text = user['dia_chi'] ?? "";
        _base64Avatar = user['anh_user'] ?? "";
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

  final ImagePicker _picker = ImagePicker(); // Image Picker instance

  // Chọn ảnh từ bộ nhớ
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();

      // Thực hiện nén ảnh
      img.Image originalImage = img.decodeImage(bytes)!;
      img.Image resizedImage =
          img.copyResize(originalImage, width: 600); // Thay đổi kích thước ảnh

      // Chuyển đổi sang Base64
      final compressedBytes = img.encodeJpg(resizedImage,
          quality: 80); // Nén ảnh với chất lượng 80%
      setState(() {
        _base64Avatar = base64Encode(compressedBytes);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã chọn ảnh đại diện!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chưa chọn ảnh!')),
      );
    }
  }

  // Cập nhật dữ liệu người dùng
  Future<void> _updateUserData() async {
    final updatedUser = ThongTin(
      id: id_user,
      ten: _nameController.text,
      email: _emailController.text,
      sdt: _phoneController.text,
      diaChi: _addressController.text,
      anh_user: _base64Avatar, // Gửi chuỗi Base64
    );

    try {
      await _viewModel.updateUserData(updatedUser);
      await LoginService.saveUserData(updatedUser.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thành công!')),
      );
      setState(() {
        _isEditing = false; // Kết thúc chế độ chỉnh sửa
      });
    } catch (e) {
      print(e);
      _showErrorDialog('Cập nhật thất bại');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông Tin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  print(_base64Avatar);
                  _updateUserData(); // Gọi cập nhật dữ liệu
                } else {
                  _isEditing = true; // Bắt đầu chỉnh sửa
                }
              });
            },
          ),
        ],
        leading: IconButton(
            onPressed: () {
              _loadUserData();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _isEditing
                    ? _pickImage
                    : null, // Chọn ảnh nếu đang chỉnh sửa
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _base64Avatar != null
                      ? MemoryImage(base64Decode(
                          _base64Avatar!)) // Hiển thị ảnh từ Base64
                      : null,
                  child: _base64Avatar == null
                      ? Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextformfield(
                labelText: 'Họ và Tên',
                hintText: 'Tên của bạn',
                textEditingController: _nameController,
                isEditing: _isEditing,
                suffixIcon: null,
              ),
              const SizedBox(height: 16),
              CustomTextformfield(
                labelText: 'Email',
                hintText: 'example@gmail.com',
                textEditingController: _emailController,
                isEditing: _isEditing,
                suffixIcon: null,
              ),
              const SizedBox(height: 16),
              CustomTextformfield(
                labelText: 'Số điện thoại',
                hintText: '0123456789',
                textEditingController: _phoneController,
                isEditing: _isEditing,
                suffixIcon: null,
              ),
              const SizedBox(height: 16),
              CustomTextformfield(
                labelText: 'Địa chỉ',
                hintText: 'Địa chỉ của bạn',
                textEditingController: _addressController,
                isEditing: _isEditing,
                suffixIcon: null,
              ),
              const SizedBox(height: 16),
              CustomButton(
                  text: "Đổi mật khẩu",
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecoveryPassword_Screen()));
                  })
            ],
          ),
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
            ),
          ),
        ],
      ),
    );
  }
}
