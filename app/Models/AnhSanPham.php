<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;

class AnhSanPham extends Model
{
    use HasFactory;
    public $timestamps = false;
    public $incrementing = false;
    protected $keyType = 'string';
    protected $table = 'anh_sp';
    protected $primaryKey = 'id';
    protected $fillable = ['id','duong_dan_anh','id_BienThe'];

    
}