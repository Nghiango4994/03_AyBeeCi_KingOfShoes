<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\KichThuocSanPham;

class SizeProductsController extends Controller
{
    // Lấy tất cả màu
    public function getAll()
    {
        $items = KichThuocSanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    // Tạo giỏ hàng mới
    public function create(Request $request)
    {
        if (empty($request->ten_kich_thuoc)) {
            return response()->json([
                'success' => false,
                'message' => "Please input ten_kich_thuoc!"
            ]);
        }

        $tenloai = KichThuocSanPham::create([
            'ten_kich_thuoc' => $request->ten_kich_thuoc,
        ]);

        if (!empty($tenloai)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new ten_kich_thuoc successfully!',
                'data'    => $ten_kich_thuoc
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new ten_kich_thuoc!'
        ]);
    }

    // Lấy giỏ hàng theo ID
    public function getSize($id)
    {
        $ten_kich_thuoc = KichThuocSanPham::find($id);

        if (empty($ten_kich_thuoc)) {
            return response()->json([
                'success' => false,
                'message' => "Not found ten_kich_thuoc with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $ten_kich_thuoc
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $ten_kich_thuoc = KichThuocSanPham::find($id);

        if (empty($ten_kich_thuoc)) {
            return response()->json([
                'success' => false,
                'message' => "Not found ten_kich_thuoc with ID: $ten_kich_thuoc"
            ]);
        }

        $ten_kich_thuoc->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete ten_kich_thuoc ID: $ten_kich_thuoc successfully!"
        ]);
    }
}
