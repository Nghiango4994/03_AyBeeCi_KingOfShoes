import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _shoeData = [
    "Nike Air Max Shoes",
    "Nike Jordan Shoes",
    "Nike Air Force Shoes",
    "Nike Club Max Shoes",
    "Snakers Nike Shoes",
    "Regular Shoes",
  ];

  List<String> _filteredShoeData = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredShoeData = _shoeData;
  }

  void _searchShoes() {
    final searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredShoeData = _shoeData
          .where((shoe) => shoe.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tìm kiếm",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 234, 233, 233),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Trở về",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200], // Màu nền cho body
        constraints:
            BoxConstraints.expand(), // Đảm bảo body chiếm toàn bộ không gian
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: Colors.white, // Thiết lập màu nền trắng
                  filled: true, // Kích hoạt việc sử dụng màu nền
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Tìm kiếm giày của bạn....',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchShoes,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Lịch sử tìm kiếm",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredShoeData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.access_time, color: Colors.grey),
                      title: Text(_filteredShoeData[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
