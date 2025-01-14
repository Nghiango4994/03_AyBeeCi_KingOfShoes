<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class ThongTin extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $table = 'thong_tin';
    public $timestamps = false;
    protected $fillable = [
        'id',
        'ten',
        'email',
        'ngay_sinh',
        'dia_chi',
        'sdt',
        'mat_khau',
        'locked',
        'isAdmin',
        'deleteAt',
        'image'
    ];

    // protected $hidden = [
    //     'mat_khau' // Ẩn mật khẩu khi trả về thông tin
    // ];

}
