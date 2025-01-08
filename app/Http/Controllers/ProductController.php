<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SanPham;

class ProductController extends Controller
{
    public function getAll()
    {
        $products = SanPham::all();

        return response()->json([
            'success' => true,
            'data'    => $products
        ]);
    }

    public function getProduct($id)
    {
        $product = SanPham::find($id);

        if (empty($product)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $product
        ]);
    }

    public function create(Request $request)
    {
        if (empty($request->ten)) {
            return response()->json([
                'success' => false,
                'message' => "Please input product's name!"
            ]);
        }

        $product = SanPham::create([
            'ten'           => $request->ten,
            'loai_id'       => $request->loai_id,
            'mau_id'        => $request->mau_id,
            'kich_thuoc_id' => $request->kich_thuoc_id,
            'gia'           => $request->gia,
            'so_luong'      => $request->so_luong,
            'mo_ta'         => $request->mo_ta,
            'ma_giam_gia' => $request->ma_giam_gia,
            'GiaSauGiam'  =>$request->GiaSauGiam,
            'nhacungcap_id'    =>$request->nhacungcap_id,
            'id_anh'   =>$request->id_anh,
            'trang_thai_sp' =>$request->trang_thai_sp,
        ]);

        if (!empty($product)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new product successfully!',
                'data'    => $product
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new product!'
        ]);
    }

    public function update(Request $request, $id)
    {
        $product = SanPham::find($id);

        if (empty($product)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        $product->ten           = $request->ten;
        $product->loai_id       = $request->loai_id;
        $product->mau_id        = $request->mau_id;
        $product->kich_thuoc_id = $request->kich_thuoc_id;
        $product->gia           = $request->gia;
        $product->so_luong      = $request->so_luong;
        $product->mo_ta         = $request->mo_ta;
        $product->save();

        return response()->json([
            'success' => true,
            'message' => "Update product ID: $id successfully!",
            'data'    => $product
        ]);
    }

    public function delete($id)
    {
        $product = SanPham::find($id);

        if (empty($product)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        $product->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete product ID: $id successfully!"
        ]);
    }

    public function restore($id)
    {
        $product = SanPham::onlyTrashed()->find($id);

        if (empty($product)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        $product->restore();

        return response()->json([
            'success' => true,
            'message' => "Restore product ID: $id successfully!"
        ]);
    }
}
