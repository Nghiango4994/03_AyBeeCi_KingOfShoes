<?php
namespace App\Http\Controllers;

use App\Models\TrangThaiSanPham;
use Illuminate\Http\Request;

class TrangThaiSanPhamController extends Controller
{
    public function index()
    {
        return TrangThaiSanPham::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'ten_trang_thai' => 'required|string|max:50'
        ]);
        return TrangThaiSanPham::create($request->all());
    }

    public function show($id)
    {
        return TrangThaiSanPham::findOrFail($id);
    }
}