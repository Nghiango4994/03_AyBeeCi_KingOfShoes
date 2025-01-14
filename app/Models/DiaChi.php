<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;

class DiaChi extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'dia_chi';
    protected $fillable = ["id",'id_Khach_Hang', 'DiaChi', 'sdt', 'isDefault'];
}