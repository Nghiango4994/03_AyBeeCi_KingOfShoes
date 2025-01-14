<?php

namespace App\Http\Controllers;

use App\Models\TrangThaiVanChuyen;
use Illuminate\Http\Request;

class TrangThaiVanChuyenController extends Controller
{
    public function index()
    {
        return TrangThaiVanChuyen::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);
        return TrangThaiVanChuyen::create($request->all());
    }

    public function show($id)
    {
        return TrangThaiVanChuyen::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $trangThai = TrangThaiVanChuyen::findOrFail($id);
        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);
        $trangThai->update($request->all());
        return $trangThai;
    }

    public function destroy($id)
    {
        TrangThaiVanChuyen::findOrFail($id)->delete();
        return response(null, 204);
    }
}