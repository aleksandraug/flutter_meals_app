import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/drawer.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filter_provider.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget{

  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }

}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _selectedPageIndex = 0;


  void _selectPage(int index){
    setState((){
      _selectedPageIndex=index;
    });
  }

  void _getScreen(String identifier) async{
    Navigator.of(context).pop();
    if(identifier=='filters'){
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const  FiltersScreen()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final availableMeals = ref.watch(filteredMealsProvided);

    Widget activePage =  CategoriesScreen(availableMeals: availableMeals,);
    var activePageTitle ='Categories';

    if (_selectedPageIndex == 1 ){
      final favouriteMeals = ref.watch(favouritesMealsProvider);
      activePage = MealsScreen( meals: favouriteMeals);
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:  MainDrawer(onSelectScreen: _getScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal), 
            label: 'Categories' ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), 
            label: 'Favourites'),
        ],
      ),
    );
  }

}