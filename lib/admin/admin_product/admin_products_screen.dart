import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remindbless/admin/admin_models/create_product_request.dart';
import 'package:remindbless/admin/common/admin_common_header.dart';
import 'package:remindbless/admin/common/common_background_scaffold.dart';
import 'package:remindbless/admin/common/common_input_field.dart';
import 'package:remindbless/admin/common/common_select_field.dart';
import 'package:remindbless/admin/exceptions/exceptions.dart';
import 'package:remindbless/admin/viewmodel/admin_viewmodel.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/base_screen.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class AdminProductsScreen extends BaseScreen<AdminViewModel> {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends BaseScreenState<AdminViewModel, AdminProductsScreen> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceSaleController = TextEditingController();
  Category? selectedCategory;
  CreateProductRequest? createProductRequest;

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  final ValueNotifier<bool> isFormValid = ValueNotifier(false);
  final ValueNotifier<bool> isPriceSaleError = ValueNotifier(false);

  Future<void> _pickImages() async {
    await Permission.photos.request();

    /// Chọn nhiều ảnh
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 10);

    if (images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
      _validateForm();
    }
  }

  @override
  void initState() {
    super.initState();

    categoryNameController.addListener(_validateForm);
    priceController.addListener(_validateForm);
    priceSaleController.addListener(_validateForm);
  }

  @override
  Widget buildChild(BuildContext context) {
    return CommonBackgroundScaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AdminCommonHeader(title: "Sản Phẩm", showBack: true)),

              const SizedBox(height: 20),

              CommonInputField(
                label: "Tên sản phẩm",
                controller: categoryNameController,
                hintText: "Nhập tên sản phẩm",
                maxLength: 100,
                textCapitalization: TextCapitalization.words,
              ),

              const SizedBox(height: 20),

              CommonSelectField<Category>(
                label: "Danh mục sản phẩm",
                value: selectedCategory,
                displayText: selectedCategory?.categoryName,
                hintText: "Chọn danh mục",
                onTap: () async {
                  final result = await _showCategoryBottomSheet(context);
                  if (result != null) {
                    setState(() {
                      selectedCategory = result;
                    });
                    _validateForm();
                  }
                },
              ),

              const SizedBox(height: 20),

              CommonInputField(
                label: "Giá bán",
                maxLength: 12,
                controller: priceController,
                keyboardType: TextInputType.number,
                hintText: "Nhập giá",
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, ThousandsFormatter()],
              ),

              const SizedBox(height: 20),

              ValueListenableBuilder<bool>(
                valueListenable: isPriceSaleError,
                builder: (_, hasError, __) {
                  return CommonInputField(
                    label: "Giá khuyến mãi",
                    controller: priceSaleController,
                    keyboardType: TextInputType.number,
                    hintText: "Nhập giá khuyến mãi",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsFormatter(),
                    ],
                    onError: hasError,
                    errorText: "Giá khuyến mãi phải nhỏ hơn giá bán",
                  );
                },
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: UnitText(text: "Hình ảnh", fontSize: 15, fontFamily: Assets.sfProBold),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: _pickImages,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// MAIN BOX
                      CommonGlass(
                        radius: 10,
                        blur: 20,
                        colorBlur: Colors.white24,
                        height: 150,
                        width: 300,
                        child: selectedImages.isEmpty
                            ? const Center(
                                child: UnitText(text: "Danh sách hình ảnh", fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: selectedImages.length,
                                itemBuilder: (_, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(File(selectedImages[index].path), fit: BoxFit.cover),
                                  );
                                },
                              ),
                      ),

                      /// CLEAR BUTTON
                      if (selectedImages.isNotEmpty)
                        Positioned(
                          top: -8,
                          right: -8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImages.clear();
                              });
                              _validateForm();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                              child: const Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// chừa chỗ cho bottomNavigationBar
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: ValueListenableBuilder<bool>(
          valueListenable: isFormValid,
          builder: (_, isEnabled, _) {
            return GestureDetector(
              onTap: isEnabled ? _onSubmit : null,
              child: Opacity(
                opacity: isEnabled ? 1.0 : 0.4,
                child: CommonGlass(
                  height: 50,
                  colorBlur: isEnabled ? Colors.blue : Colors.grey,
                  child: UnitText(
                    text: "Thêm sản phẩm",
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Category?> _showCategoryBottomSheet(BuildContext context, {Category? selectedCategory}) {
    final int itemCount = provider.categoriesWithoutFirst.length;

    return showModalBottomSheet<Category>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: itemCount,
              itemBuilder: (_, index) {
                final item = provider.categoriesWithoutFirst[index];
                final bool isSelected = selectedCategory?.categoryId == item.categoryId;

                return ListTile(
                  title: UnitText(text: item.categoryName, fontSize: 15, fontFamily: Assets.sfProLight),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green, size: 20) : null,
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _validateForm() {
    final name = categoryNameController.text.trim();
    final priceText = priceController.text.replaceAll(',', '');
    final priceSaleText = priceSaleController.text.replaceAll(',', '');

    final double price =
    priceText.isEmpty ? 0.0 : double.tryParse(priceText) ?? 0.0;

    final double priceSale =
    priceSaleText.isEmpty ? 0.0 : double.tryParse(priceSaleText) ?? 0.0;

    isPriceSaleError.value = priceSale > 0 && priceSale > price;

    final bool isValid =
        name.isNotEmpty &&
            selectedCategory != null &&
            price > 0 &&
            selectedImages.isNotEmpty &&
            !isPriceSaleError.value;

    isFormValid.value = isValid;
  }

  void _onSubmit() {
    final price =
    double.parse(priceController.text.replaceAll(',', ''));

    final priceSaleText = priceSaleController.text.replaceAll(',', '');
    final double? priceSale =
    priceSaleText.isEmpty ? null : double.parse(priceSaleText);

    int salePercent = 0;
    if (priceSale != null && priceSale < price) {
      salePercent = ((1 - (priceSale / price)) * 100).round();
    }

    final request = CreateProductRequest(
      productName: categoryNameController.text.trim(),
      categoryKey: selectedCategory!.categoryKey,
      price: price,
      priceSale: priceSale,
      salePercent: salePercent,
      soldCount: 0,
      location: "STORE",
      primaryIndex: 0,
      images: selectedImages,
    );

    print("REQUEST: ${request.toJson()}");

    // TODO: call API

    provider.createProduct(request);
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    priceController.dispose();
    priceSaleController.dispose();
    isFormValid.dispose();
    super.dispose();
  }
}
