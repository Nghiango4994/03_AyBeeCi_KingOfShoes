<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BienTheSanPham;

class BienTheSanPhamController extends Controller
{
    // Lấy tất cả biến thể
    public function getAll()
    {
        $items = BienTheSanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }
    // Lấy biến thể theo ID
    public function getBienThe($id)
    {
        $bien_the_san_pham = BienTheSanPham::where('id',$id)->first();

        if (empty($bien_the_san_pham)) {
            return response()->json([
                'success' => false,
                'message' => "Not found bien_the_san_pham with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $bien_the_san_pham
        ]);
    }
}
