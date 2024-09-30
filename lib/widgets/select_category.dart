import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/category_provider.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:to_do_list/widgets/circle_container.dart';

class SelectCategory extends ConsumerWidget{
  const SelectCategory({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values.toList();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final category = categories[index];

                    return InkWell(
                      onTap: (){
                        ref.read(categoryProvider.notifier).state = category;
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: CircleContainer(
                        color: category.color.withOpacity(0.3),
                        child: Icon(
                          category.icon,
                          color: selectedCategory == category
                          ? context.colorScheme.primary
                          : category.color.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => const Gap(8),
              ),
          ),
        ],
      ),
    );
  }
}