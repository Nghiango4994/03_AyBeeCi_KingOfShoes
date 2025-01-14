<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\LoaiSanPham;

class CategoryProductsController extends Controller
{
    // Lấy tất cả màu
    public function getAll()
    {
        $items = LoaiSanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    // Tạo giỏ hàng mới
    public function create(Request $request)
    {
        if (empty($request->ten_loai)) {
            return response()->json([
                'success' => false,
                'message' => "Please input tenloai!"
            ]);
        }

        $tenloai = LoaiSanPham::create([
            'ten_loai' => $request->ten_loai,
        ]);

        if (!empty($tenloai)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new tenloai successfully!',
                'data'    => $tenloai
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new tenloai!'
        ]);
    }

    // Lấy giỏ hàng theo ID
    public function getCategory($id)
    {
        $category = LoaiSanPham::find($id);

        if (empty($category)) {
            return response()->json([
                'success' => false,
                'message' => "Not found category with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $category
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $category = LoaiSanPham::find($id);

        if (empty($category)) {
            return response()->json([
                'success' => false,
                'message' => "Not found color with ID: $category"
            ]);
        }

        $category->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete color ID: $category successfully!"
        ]);
    }
}
