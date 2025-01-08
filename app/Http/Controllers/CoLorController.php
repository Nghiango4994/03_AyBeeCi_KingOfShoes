<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\MauSanPham;

class ColorController extends Controller
{
    // Lấy tất cả màu
    public function getAll()
    {
        $items = MauSanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    // Tạo giỏ hàng mới
    public function create(Request $request)
    {
        if (empty($request->ten_mau)) {
            return response()->json([
                'success' => false,
                'message' => "Please input ten mau!"
            ]);
        }

        $mausanpham = MauSanPham::create([
            'ten_mau' => $request->ten_mau,
        ]);

        if (!empty($mausanpham)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new color successfully!',
                'data'    => $mausanpham
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new color!'
        ]);
    }

    // Lấy giỏ hàng theo ID
    public function getColor($id)
    {
        $color = MauSanPham::find($id);

        if (empty($color)) {
            return response()->json([
                'success' => false,
                'message' => "Not found color with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $color
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $color = MauSanPham::find($id);

        if (empty($color)) {
            return response()->json([
                'success' => false,
                'message' => "Not found color with ID: $id"
            ]);
        }

        $color->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete color ID: $id successfully!"
        ]);
    }
}
