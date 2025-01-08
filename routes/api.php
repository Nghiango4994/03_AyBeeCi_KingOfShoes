<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\DetailCartController;
use App\Http\Controllers\DiscountController;
use App\Http\Controllers\ColorController;
use App\Http\Controllers\CategoryProductsController;
use App\Http\Controllers\SizeProductsController;
use App\Http\Controllers\PictureProductsController;
use App\Http\Controllers\DetailInvoiceController;
use App\Http\Controllers\TrangThaiController;
use App\Http\Controllers\ThongTinController;
use App\Http\Controllers\TrangThaiSanPham;

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


    //products
    Route::get('products', [ProductController::class, 'getAll']); // Danh sách sản phẩm
    Route::get('products/{id}', [ProductController::class, 'getProduct']); // Chi tiết sản phẩm
    Route::post('products', [ProductController::class, 'create']);
    Route::delete('products/{id}', [ProductController::class, 'delete']);
    Route::put('products/{id}', [ProductController::class, 'update']);
    // Invoices
    Route::get('invoices', [InvoiceController::class, 'getAll']); // Danh sách đơn hàng
    Route::post('invoices', [InvoiceController::class, 'create']); // Tạo đơn hàng mới
    Route::get('invoices/{id}', [InvoiceController::class, 'getOrder']); // Chi tiết đơn hàng
    Route::delete('invoices/{id}', [InvoiceController::class, 'delete']);
    // Cart Routes
      //  Route::middleware('auth:sanctum')->group(function () {
            Route::get('carts', [CartController::class, 'getAll']); // Giỏ hàng của người dùng
            Route::post('carts', [CartController::class, 'create']); // Thêm sản phẩm vào giỏ hàng
            Route::get('carts/{id}', [CartController::class, 'getCart']); // Chi tiết sản phẩm
            Route::delete('carts/{id}', [CartController::class, 'delete']); // Xóa sản phẩm khỏi giỏ hàng
    //   });
    // DetailCart Routes
    Route::get('detailcarts', [DetailInvoiceController::class, 'getAll']); 
    Route::get('detailcarts/{code}', [DetailInvoiceController::class, 'getDetailCart']);
    Route::post('detailcarts', [DetailInvoiceController::class, 'create']);
    Route::delete('detailcarts/{code}', [DetailInvoiceController::class, 'delete']);
    Route::put('detailcarts/{id}', [DetailInvoiceController::class, 'update']);
    // DetailInvoice Routes
    Route::get('detailInvoices', [DetailInvoiceController::class, 'getAll']); 
    Route::get('detailInvoices/{code}', [DetailInvoiceController::class, 'getDetailOrder']);
    Route::post('detailInvoices', [DetailInvoiceController::class, 'create']);
    Route::delete('detailInvoices/{code}', [DetailInvoiceController::class, 'delete']);
    Route::put('detailInvoices/{id}', [DetailInvoiceController::class, 'update']);
    // Discount Routes
    Route::get('discounts', [DiscountController::class, 'getAll']); 
    Route::get('discounts/{code}', [DiscountController::class, 'getDiscount']); 
    Route::post('discounts', [DiscountController::class, 'create']);
    Route::delete('discounts/{code}', [DiscountController::class, 'delete']);
    // Color Routes
    Route::get('colors', [ColorController::class, 'getAll']); 
    Route::get('colors/{code}', [ColorController::class, 'getColor']); 
    Route::post('colors', [ColorController::class, 'create']);
    Route::delete('colors/{code}', [ColorController::class, 'delete']);
    // Category Routes
    Route::get('categorys', [CategoryProductsController::class, 'getAll']); 
    Route::get('categorys/{code}', [CategoryProductsController::class, 'getCategory']);
    Route::post('categorys', [CategoryProductsController::class, 'create']);
    Route::delete('categorys/{code}', [CategoryProductsController::class, 'delete']);
    // Size Routes
    Route::get('sizes', [SizeProductsController::class, 'getAll']); 
    Route::get('sizes/{code}', [SizeProductsController::class, 'getSize']);
    Route::post('sizes', [SizeProductsController::class, 'create']);
    Route::delete('sizes/{code}', [SizeProductsController::class, 'delete']);
    // Picture Routes
    Route::get('pictures', [PictureProductsController::class, 'getAll']); 
    Route::get('pictures/{code}', [PictureProductsController::class, 'getPicture']);
    Route::post('pictures', [PictureProductsController::class, 'create']);
    Route::delete('pictures/{code}', [PictureProductsController::class, 'delete']);
    //nhacungcap
    Route::get('nha-cung-cap', [NhaCungCapController::class, 'index']);
    Route::post('nha-cung-cap', [NhaCungCapController::class, 'store']);
    Route::get('nha-cung-cap/{id}', [NhaCungCapController::class, 'show']);
    Route::put('nha-cung-cap/{id}', [NhaCungCapController::class, 'update']);
    Route::delete('nha-cung-cap/{id}', [NhaCungCapController::class, 'destroy']);
    //trang-thai
    Route::get('trang-thai', [TrangThaiController::class, 'index']);
    Route::post('trang-thai', [TrangThaiController::class, 'store']);
    Route::get('trang-thai/{id}', [TrangThaiController::class, 'show']);
    //trang-thai-sanpham
    Route::get('trang-thai-sanpham', [TrangThaiSanPhamController::class, 'index']);
    Route::post('trang-thai-sanpham', [TrangThaiSanPhamController::class, 'store']);
    Route::get('trang-thai-sanpham/{id}', [TrangThaiSanPhamController::class, 'show']);
    //thong tin 
    Route::get('thong-tin', [ThongTinController::class, 'index']);
    Route::get('thong-tin/{id}', [ThongTinController::class, 'show']);
    Route::post('thong-tin', [ThongTinController::class, 'store']);
    Route::put('thong-tin/{id}', [ThongTinController::class, 'update']);
    Route::delete('thong-tin/{id}', [ThongTinController::class, 'destroy']);
    Route::get('thong-tin/{id}/check-admin', [ThongTinController::class, 'checkAdmin']);
    Route::post('thong-tin/login', [ThongTinController::class, 'login']);
    Route::post('thong-tin/register', [ThongTinController::class, 'register']);

