import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealsDetailsScreen extends ConsumerWidget{

  const MealsDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favouriteMeals = ref.watch(favouritesMealsProvider);

    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: (){
            final wasAdded = ref
            .read(favouritesMealsProvider.notifier)
            .toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(wasAdded ? 'Meal added to favourites' : 'Meal removed.'),
              )
            );
            }, 
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return RotationTransition(turns: Tween(begin: 0.5, end: 1.0).animate(animation), child: child,);
              },
              child: Icon(isFavourite ? Icons.star : Icons.star_border, key: ValueKey(isFavourite),),
            ) 
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 14,),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for( final ingredients in meal.ingredients)
              Text(ingredients, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),),
            const SizedBox(height: 24,),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for( final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),),
              ),
          ],
        ),
      ),
    );
  }

}