<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\ChiTietGioHang;
class GioHang extends Model {
    use HasFactory;
    protected $table = 'gio_hang';
    protected $fillable = ['id_khach_hang', 'id_sanpham','SoLuong','tong_don_gia'];
     public function chi_tiet_gio_hang()
    {
        return $this->hasMany(ChiTietGioHang::class, 'id_gio_hang', 'id_gio_hang');
    }
}