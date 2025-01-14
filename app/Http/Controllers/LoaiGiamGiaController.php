<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\LoaiGiamGia;


class LoaiGiamGiaController extends Controller
{
    public function index()
    {
        $loaiGiamGias = LoaiGiamGia::all();
        return response()->json([
            'success' => true,
            'data' => $loaiGiamGias
        ]);
    }

    public function show($id)
    {
        $loaiGiamGia = LoaiGiamGia::find($id);
        if ($loaiGiamGia) {
            return response()->json([
                'success' => true,
                'data' => $loaiGiamGia
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'LoaiGiamGia not found'
            ], 404);
        }
    }

    public function store(Request $request)
    {
        $loaiGiamGia = new LoaiGiamGia();
        $loaiGiamGia->TenLoaiGiamGia = $request->TenLoaiGiamGia;
        $loaiGiamGia->save();
        return response()->json([
            'success' => true,
            'message' => 'LoaiGiamGia created successfully!',
            'data'    => $loaiGiamGia
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $loaiGiamGia = LoaiGiamGia::find($id);
        if ($loaiGiamGia) {
            $loaiGiamGia->TenLoaiGiamGia = $request->TenLoaiGiamGia;
            $loaiGiamGia->save();
            return response()->json([
               'success' => true,
               'message' => 'LoaiGiamGia updated successfully!',
                'data'    => $loaiGiamGia
            ]);
        } else {
            return response()->json([
               'success' => false,
               'message' => 'LoaiGiamGia not found'
            ], 404);
        }
    }

    public function destroy($id)
    {
        $loaiGiamGia = LoaiGiamGia::find($id);
        if ($loaiGiamGia) {
            $loaiGiamGia->delete();
            return response()->json([
               'success' => true,
               'message' => 'LoaiGiamGia deleted successfully'
            ]);
        } else {
            return response()->json([
               'success' => false,
               'message' => 'LoaiGiamGia not found'
            ], 404);
        }
    }
}