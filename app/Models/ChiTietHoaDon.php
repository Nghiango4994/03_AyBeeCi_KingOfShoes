<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;

class ChiTietHoaDon extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'chi_tiet_hoa_don';
    protected $fillable = ["CTHD_Id",'HoaDon_Id', 'BienThe_Id', 'SoLuong',];
}