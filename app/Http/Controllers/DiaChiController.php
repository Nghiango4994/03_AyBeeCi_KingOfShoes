<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DiaChi;

class DiaChiController extends Controller
{
    // Lấy tất cả màu
    public function getAll()
    {
        $items = DiaChi::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }
     public function update(Request $request, $id)
    {
        $diachi = DiaChi::find($id);

        if (empty($diachi)) {
            return response()->json([
                'success' => false,
                'message' => "Not found dia chi with ID: $id"
            ]);
        }

        $diachi->id_Khach_Hang           = $request->id_Khach_Hang;
        $diachi->DiaChi       = $request->DiaChi;
        $diachi->sdt        = $request->sdt;
        $diachi->isDefault = $request->isDefault;
        $diachi->save();

        return response()->json([
            'success' => true,
            'message' => "Update dia chi ID: $id successfully!",
            'data'    => $diachi
        ]);
    }
    
    // Tạo giỏ hàng mới
    public function create(Request $request) 
    {
        if (empty($request->id)) {
            return response()->json([
                'success' => false,
                'message' => "Please input diachi!"
            ]);
        }

        $diachi = DiaChi::create([
            'id_Khach_Hang' => $request->id_Khach_Hang,
            'DiaChi'=> $request->DiaChi,
            'sdt' => $request->sdt,
            'isDefault' => $request->isDefault
        ]);

        if (!empty($diachi)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new dia chi successfully!',
                'data'    => $diachi
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new dia chi!'
        ]);
    }

    // Lấy Ảnh hàng theo ID
    public function getDiaChi($id)
    {
        $diachi = DiaChi::where('id',$id)->first();

        if (empty($diachi)) {
            return response()->json([
                'success' => false,
                'message' => "Not found dia chi with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $diachi
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $diachi = DiaChi::find($id);

        if (empty($diachi)) {
            return response()->json([
                'success' => false,
                'message' => "Not found diachi with ID: $diachi"
            ]);
        }

        $diachi->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete diachi ID: $diachi successfully!"
        ]);
    }
}
