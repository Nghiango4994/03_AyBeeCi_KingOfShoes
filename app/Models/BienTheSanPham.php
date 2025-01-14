<?php 
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Facades\Session;
use App\Models\KichThuocSanPham;
use App\Models\MauSanPham;
use App\Models\AnhSanPham;
use App\Models\TrangThai;
use App\Models\Magiamgia;
class BienTheSanPham extends Model{
    use HasFactory;
    public $timestamps =  false;
    protected $table = 'bien_the_san_pham';
    protected $primaryKey = 'id';
    protected $fillable = ['id','ten_bien_the','san_pham_id','mau_id','kich_thuoc_id','so_luong','gia_ban','id_anh','trang_thai','ma_giam_gia','gia_nhap'];
    public function anh()
    {
        return $this->belongsTo(AnhSanPham::class, 'id_anh');
    }
     public function mau()
    {
        return $this->belongsTo(MauSanPham::class, 'mau_id');
    }
      public function kichthuoc()
    {
        return $this->belongsTo(KichThuocSanPham::class, 'kich_thuoc_id');
    }
     public function trangthai()
    {
        return $this->belongsTo(TrangThaiSanPham::class, 'trang_thai');
    }
       public function magiamgia()
    {
        return $this->belongsTo(Magiamgia::class, 'ma_giam_gia');
    }
}
