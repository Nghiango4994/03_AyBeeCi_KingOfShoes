<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

  //Loại giảm giá
  use App\Http\Controllers\LoaiGiamGiaController;
    Route::get('loai-giam-gia', [LoaiGiamGiaController::class, 'index']);
    Route::post('loai-giam-gia', [LoaiGiamGiaController::class, 'store']);
    Route::get('loai-giam-gia/{id}', [LoaiGiamGiaController::class, 'show']);
    Route::put('loai-giam-gia/{id}', [LoaiGiamGiaController::class, 'update']);
    Route::delete('loai-giam-gia/{id}', [LoaiGiamGiaController::class, 'destroy']);

  // Dia Chi
  use App\Http\Controllers\DiaChiController;
    Route::get('diachi', [DiaChiController::class, 'getAll']);
    Route::get('diachi/{id}', [DiaChiController::class, 'getDiaChi']);
    Route::post('diachi', [DiaChiController::class, 'create']);
    Route::delete('diachi/{id}', [DiaChiController::class, 'delete']);
    Route::put('diachi/{id}', [DiaChiController::class, 'update']);

  //Bien The
  use App\Http\Controllers\BienTheSanPhamController;
    Route::get('bienthe', [BienTheSanPhamController::class, 'getAll']); // Danh sách sản phẩm
    Route::get('bienthe/{id}', [BienTheSanPhamController::class, 'getBienThe']); // Chi tiết sản phẩm
    //products
    use App\Http\Controllers\ProductController;
    Route::get('products', [ProductController::class, 'getAll']); // Danh sách sản phẩm
    Route::get('products/{id}', [ProductController::class, 'getProduct']); // Chi tiết sản phẩm
    Route::post('products', [ProductController::class, 'create']);
    Route::delete('products/{id}', [ProductController::class, 'delete']);
    Route::put('products/{id}', [ProductController::class, 'update']);
    // Invoices
    use App\Http\Controllers\InvoiceController;
    Route::get('hoadon', [InvoiceController::class, 'getAll']); // Danh sách đơn hàng
    Route::post('hoadon', [InvoiceController::class, 'create']); // Tạo đơn hàng mới
    Route::get('hoadon/{id}', [InvoiceController::class, 'getHoaDon']); // Chi tiết đơn hàng
    Route::delete('hoadon/{id}', [InvoiceController::class, 'delete']);
    // Cart Routes
    use App\Http\Controllers\CartController;
      //  Route::middleware('auth:sanctum')->group(function () { 
            Route::post('/giohang/thaydoisoluong', [CartController::class, 'thaydoisoluong']);
            Route::get('giohang', [CartController::class, 'getAll']); // Giỏ hàng của người dùng
            Route::post('giohang', [CartController::class, 'create']); // Thêm sản phẩm vào giỏ hàng
            Route::get('giohang/{id}', [CartController::class, 'getCart']); // Chi tiết sản phẩm
            Route::delete('giohang/{id}', [CartController::class, 'delete']); // Xóa sản phẩm khỏi giỏ hàng
    //   });
    // DetailInvoice Routes
    use App\Http\Controllers\DetailInvoiceController;
    Route::get('chitiethoadon', [DetailInvoiceController::class, 'getAll']); 
    Route::get('chitiethoadon/{code}', [DetailInvoiceController::class, 'getChiTietHoaDon']);
    Route::post('chitiethoadon', [DetailInvoiceController::class, 'create']);
    Route::delete('chitiethoadon/{code}', [DetailInvoiceController::class, 'delete']);
    Route::put('chitiethoadon/{id}', [DetailInvoiceController::class, 'update']);
    // Discount Routes
    use App\Http\Controllers\DiscountController;
    Route::get('magiamgia', [DiscountController::class, 'getAll']); 
    Route::get('magiamgia/{code}', [DiscountController::class, 'getDiscount']); 
    Route::post('magiamgia', [DiscountController::class, 'create']);
    Route::delete('magiamgia/{code}', [DiscountController::class, 'delete']);
    // Color Routes
    use App\Http\Controllers\ColorController;
    Route::get('colors', [ColorController::class, 'getAll']); 
    Route::get('colors/{code}', [ColorController::class, 'getColor']); 
    Route::post('colors', [ColorController::class, 'create']);
    Route::delete('colors/{code}', [ColorController::class, 'delete']);
    // Category Routes
    
use App\Http\Controllers\CategoryProductsController;
    Route::get('categorys', [CategoryProductsController::class, 'getAll']); 
    Route::get('categorys/{code}', [CategoryProductsController::class, 'getCategory']);
    Route::post('categorys', [CategoryProductsController::class, 'create']);
    Route::delete('categorys/{code}', [CategoryProductsController::class, 'delete']);
    // Size Routes
    use App\Http\Controllers\SizeProductsController;
    Route::get('sizes', [SizeProductsController::class, 'getAll']); 
    Route::get('sizes/{code}', [SizeProductsController::class, 'getSize']);
    Route::post('sizes', [SizeProductsController::class, 'create']);
    Route::delete('sizes/{code}', [SizeProductsController::class, 'delete']);
    // Picture Routes
    use App\Http\Controllers\PictureProductsController;
    Route::get('pictures', [PictureProductsController::class, 'getAll']); 
    Route::get('pictures/{code}', [PictureProductsController::class, 'getPicture']);
    Route::post('pictures', [PictureProductsController::class, 'create']);
    Route::delete('pictures/{code}', [PictureProductsController::class, 'delete']);
    //nhacungcap
    use App\Http\Controllers\NhaCungCapController;
    Route::get('nha-cung-cap', [NhaCungCapController::class, 'index']);
    Route::post('nha-cung-cap', [NhaCungCapController::class, 'store']);
    Route::get('nha-cung-cap/{id}', [NhaCungCapController::class, 'show']);
    Route::put('nha-cung-cap/{id}', [NhaCungCapController::class, 'update']);
    Route::delete('nha-cung-cap/{id}', [NhaCungCapController::class, 'destroy']);
    //trang-thai-van-chuyen
    use App\Http\Controllers\TrangThaiVanChuyenController;
    Route::get('trang-thai', [TrangThaiVanChuyenController::class, 'index']);
    Route::post('trang-thai', [TrangThaiVanChuyenController::class, 'store']);
    Route::get('trang-thai/{id}', [TrangThaiVanChuyenController::class, 'show']);
    //trang-thai-sanpham
    use App\Http\Controllers\TrangThaiSanPhamController;
    Route::get('trang-thai-sanpham', [TrangThaiSanPhamController::class, 'index']);
    Route::post('trang-thai-sanpham', [TrangThaiSanPhamController::class, 'store']);
    Route::get('trang-thai-sanpham/{id}', [TrangThaiSanPhamController::class, 'show']);
    //thong tin
    use App\Http\Controllers\ThongTinController;
    Route::get('thong-tin', [ThongTinController::class, 'index']);
    Route::get('thong-tin/{id}', [ThongTinController::class, 'show']);
    Route::post('thong-tin', [ThongTinController::class, 'store']);
    Route::put('thong-tin/{id}', [ThongTinController::class, 'update']);
    Route::delete('thong-tin/{id}', [ThongTinController::class, 'destroy']);
    Route::get('thong-tin/{id}/check-admin', [ThongTinController::class, 'checkAdmin']);
    Route::post('thong-tin/login', [ThongTinController::class, 'login']);
    Route::post('thong-tin/register', [ThongTinController::class, 'register']);

    // Thanh toán
    use App\Http\Controllers\TrangThaiThanhToanController;
    Route::get('trang-thai-thanh-toan', [TrangThaiThanhToanController::class, 'index']);
    Route::post('trang-thai-thanh-toan', [TrangThaiThanhToanController::class, 'store']);
    Route::get('trang-thai-thanh-toan/{id}', [TrangThaiThanhToanController::class, 'search']);
    Route::put('trang-thai-thanh-toan/{id}', [TrangThaiThanhToanController::class, 'update']);
    Route::delete('trang-thai-thanh-toan/{id}', [TrangThaiThanhToanController::class, 'destroy']);

    // Phương thức thanh toán
    use App\Http\Controllers\PhuongThucThanhToanController;
    Route::get('phuong-thuc-thanh-toan', [PhuongThucThanhToanController::class, 'index']);
    Route::post('phuong-thuc-thanh-toan', [PhuongThucThanhToanController::class, 'store']);
    Route::get('phuong-thuc-thanh-toan/{id}', [PhuongThucThanhToanController::class, 'show']);
    Route::put('phuong-thuc-thanh-toan/{id}', [PhuongThucThanhToanController::class, 'update']);
    Route::delete('phuong-thuc-thanh-toan/{id}', [PhuongThucThanhToanController::class, 'destroy']);
