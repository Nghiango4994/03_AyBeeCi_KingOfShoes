<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AnhSanPham;

class PictureProductsController extends Controller
{
    // Lấy tất cả màu
    public function getAll()
    {
        $items = AnhSanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }
    
    // Tạo giỏ hàng mới
    public function create(Request $request) 
    {
        if (empty($request->id)) {
            return response()->json([
                'success' => false,
                'message' => "Please input ten_duong_dan!"
            ]);
        }

        $ten_duong_dan = AnhSanPham::create([
            'id'=> $request->id,
            'duong_dan_anh' => $request->duong_dan_anh,
            'id_SanPham'=> $request->id_SanPham,
            'id_mauSP' => $request->id_mauSP
        ]);

        if (!empty($ten_duong_dan)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new duong_dan_anh successfully!',
                'data'    => $ten_duong_dan
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new duong_dan_anh!'
        ]);
    }

    // Lấy giỏ hàng theo ID
    public function getPicture($id)
    {
        $ten_duong_dan = AnhSanPham::find($id);

        if (empty($ten_duong_dan)) {
            return response()->json([
                'success' => false,
                'message' => "Not found ten_duong_dan with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $ten_duong_dan
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $ten_duong_dan = AnhSanPham::find($id);

        if (empty($ten_duong_dan)) {
            return response()->json([
                'success' => false,
                'message' => "Not found ten_duong_dan with ID: $ten_duong_dan"
            ]);
        }

        $ten_duong_dan->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete ten_duong_dan ID: $ten_duong_dan successfully!"
        ]);
    }
}
