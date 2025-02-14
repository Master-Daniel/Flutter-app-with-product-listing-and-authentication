import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/screens/products/controllers/ProductsCubit.dart';
import 'package:products/screens/products/controllers/product_state.dart';
import 'package:products/screens/products/model/product_model.dart';
import 'package:products/themes/colors.dart';
import 'package:products/utils/app_drawer.dart';
import 'package:products/widgets/products.dart';

class ProductScreenView extends StatelessWidget {
  const ProductScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary2,
        title: Text("Products")
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<ProductCubit>().fetchProducts();
            },
            child: state is ProductLoading
                ? _buildLoadingState()
                : state is ProductError
                    ? buildErrorState(state.message, context)
                    : state is ProductLoaded
                        ? _buildProductLists(state.products)
                        : _buildEmptyState(),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("No products available", style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildProductLists(List<Product> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        int crossAxisCount = screenWidth > 600 ? 3 : 2;

        return ListView(
          padding: EdgeInsets.all(10),
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            _buildSectionTitle("Grid View"),
            _buildGridList(products, crossAxisCount),
            _buildSectionTitle("Horizontal Scroll"),
            _buildHorizontalList(products),
            _buildSectionTitle("List View"),
            buildListView(products),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGridList(List<Product> products, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return buildProductBox(products[index], context);
      },
    );
  }

  Widget _buildHorizontalList(List<Product> products) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildHorizontalProductBox(products[index], context),
          );
        },
      ),
    );
  }
}
