<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\BienTheSanPham;
class GioHang extends Model {
    use HasFactory;
    protected $table = 'gio_hang';
    protected $primaryKey = 'id_gio_hang';
    public $timestamps = false;
    protected $fillable = ['id_gio_hang','id_khach_hang','so_luong', 'ngay_tao','id_bien_the_san_pham'];
    public function bienthesanpham()
    {
        return $this->hasMany(BienTheSanPham::class, 'id','id_bien_the_san_pham');
    }
}