<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrangThaiSanPham extends Model
{
    use HasFactory;

    protected $table = 'trang_thai_sanpham';
    protected $fillable = ['ten_trang_thai'];
    public $timestamps = false;
}
