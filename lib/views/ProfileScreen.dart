import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

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
  String _errorMessage = "";
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // Gọi API khi màn hình được khởi tạo
  }

  // Chọn ảnh từ thư viện hoặc camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Lưu ảnh vào bộ nhớ trong thiết bị
      await _saveImageToStorage(pickedFile); // Truyền pickedFile là XFile
    }
  }

  // Lưu ảnh vào bộ nhớ trong của thiết bị
  Future<void> _saveImageToStorage(XFile pickedFile) async {
    // Sử dụng XFile thay vì PickedFile
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${path.basename(pickedFile.path)}';
    await File(pickedFile.path).copy(imagePath);
    print('Image saved to: $imagePath');
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/thong-tin/1'), // API URL
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _nameController.text = data['ten'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['sdt'] ?? '';
          _addressController.text = data['dia_chi'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load profile data.";
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = "An error occurred: $error";
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
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
                              backgroundImage: _imageFile == null
                                  ? NetworkImage(
                                      'https://via.placeholder.com/150')
                                  : FileImage(_imageFile!) as ImageProvider,
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
