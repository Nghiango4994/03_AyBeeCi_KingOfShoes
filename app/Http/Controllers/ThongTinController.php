<?php

namespace App\Http\Controllers;

use App\Models\ThongTin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
class ThongTinController extends Controller
{   
public function login(Request $request)
{
    // Xác thực dữ liệu đầu vào
    $validator = Validator::make($request->all(), [
        'email' => 'required|email',
        'mat_khau' => 'required|String',
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 422);
    }

    // Tìm người dùng theo email
    $user = ThongTin::where('email', $request->email)->first();

    // Kiểm tra xem người dùng có tồn tại
    if (!$user || !Hash::check($request->mat_khau, $user->mat_khau)) {
        return response()->json([
            'message' => 'Invalid credentials',
            'rq_email' => $request->email,
        ], 401);
    }

    // Tạo token với Laravel Passport
    $token = $user->createToken('Personal Access Token')->accessToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ]);
}
public function logout(Request $request)
{
    $request->user()->token()->revoke();

    return response()->json([
        'message' => 'Successfully logged out'
    ]);
}

public function register(Request $request)
{
    $validator = Validator::make($request->all(), [
        'ten' => 'required|string|max:255', // Thêm điều kiện cho trường tên
        'email' => 'required|email|unique:thong_tin,email',
        'mat_khau' => 'required|string|min:6',
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 422);
    }

    // Tạo người dùng mới
    $user = ThongTin::create([
        'ten' => $request->ten, // Lưu tên vào cơ sở dữ liệu
        'email' => $request->email,
        'mat_khau' => bcrypt($request->mat_khau), // Mã hóa mật khẩu
    ]);

    // Tạo token với Laravel Passport
    $token = $user->createToken('Personal Access Token')->accessToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ], 201); // Trả về mã trạng thái 201 cho việc tạo mới thành công
}

    public function index()
    {
        return response()->json(ThongTin::all());
    }

    public function show($id)
    {
        $thongTin = ThongTin::find($id);
        if ($thongTin) {
            return response()->json($thongTin);
        } else {
            return response()->json(['message' => 'Not Found'], 404);
        }
    }

    public function store(Request $request)
    {
       if (empty($request->id)) {
            return response()->json([
                'success' => false,
                'message' => "Please input ten mau!"
            ]);
        }

        $account = ThongTin::create([
            'id' => $request->id,
            'ten' => $request->ten,
            'email' => $request->email,
            'ngay_sinh' => $request->ngay_sinh,
            'dia_chi' => $request->dia_chi,
            'sdt' => $request->sdt,
            'mat_khau' => $request->mat_khau,
            'locked' => $request->locked,
            'isAdmin' => $request->isAdmin,
            'deleteAt' => $request->deleteAt,
            'hinh_anh' => $request->hinh_anh
        ]);

        if (!empty($account)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new account successfully!',
                'data'    => $account
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new account!'
        ]);
    }

    public function update(Request $request, $id)
    {
        $thongTin = ThongTin::find($id);
        if (!$thongTin) {
            return response()->json(['message' => 'Not Found'], 404);
        }

        $thongTin->update($request->all());

        return response()->json($thongTin);
    }

    public function destroy($id)
    {
        $thongTin = ThongTin::fxind($id);
        if ($thongTin) {
            $thongTin->delete();
            return response()->json(['message' => 'Deleted Successfully']);
        } else {
            return response()->json(['message' => 'Not Found'], 404);
        }
    }
    
    public function ChangePassWord($id, Request $request){
    $user = ThongTin::find($id);
    if (!$user) {
        return response()->json(['message' => 'Not Found'], 404);
    }
    $user->update([
        'mat_khau' => bcrypt($request->mat_khau) // Mã hóa mật khẩu
    ]);
    return response()->json($user); // Trả về thông tin người dùng sau khi cập nhật 
}
}

