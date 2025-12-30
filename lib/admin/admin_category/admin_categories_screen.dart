import 'package:flutter/material.dart';
import 'package:remindbless/admin/common/admin_common_header.dart';
import 'package:remindbless/admin/common/common_background_scaffold.dart';
import 'package:remindbless/admin/common/common_input_field.dart';
import 'package:remindbless/admin/exceptions/exceptions.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  State<AdminCategoriesScreen> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryKeyController = TextEditingController();
  Category? selectedCategory;


  @override
  Widget build(BuildContext context) {
    return CommonBackgroundScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AdminCommonHeader(title: "Danh Mục Sản Phẩm"),
            ),

            const SizedBox(height: 20),

            CommonInputField(
              label: "Tên danh mục sản phẩm",
              controller: categoryNameController,
              hintText: "Nhập tên danh mục",
              maxLength: 100,
              textCapitalization: TextCapitalization.words,
            ),

            const SizedBox(height: 20),

            CommonInputField(
              label: "Category Key",
              controller: categoryKeyController,
              hintText: "VD: CA_PHE",
              onChanged:(value){
                final apiKey = convertToApiKey(value);
                print('Value post lên API: $apiKey');
              },
              inputFormatters: [
                UpperCaseFormatter(),
              ],
            ),

            /// chừa khoảng trống để không bị che bởi bottom bar
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: CommonGlass(
          height: 50,
          colorBlur: Colors.lightBlueAccent,
          child: const UnitText(
            text: "Thêm danh mục",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
