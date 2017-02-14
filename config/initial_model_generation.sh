#!/bin/bash
rails generate model FoodGroup foodgroup_desc:string --no-migration

rails generate model Food foodgroup_code:string longdesc:string shortdesc:string common_name:string manufacturer_name:string survey:string refuse_description:string refuse:decimal scientific_name:string n_factor:decimal pro_factor:decimal fat_factor:decimal cho_factor:decimal --no-migration

rails generate model Language iso_code:string english_name:string native_name:string inserted_at:datetime --no-migration

rails generate model Meal name:string entree:string side_dish1:string side_dish2:string dessert:string calories:integer calories_from_fat:integer calcium:integer sodium:integer cholesterol:integer carbohydrate:integer sugars:integer fat:integer saturated_fat:integer protein:integer fiber:integer weight:decimal description:string inserted_at:datetime --no-migration

rails generate model Offer name:string description:string max_per_person:integer max_per_package:integer inserted_at:datetime --no-migration

rails generate model StockDistribution quantity:integer stock:references user_food_package:references inserted_at:datetime --no-migration

rails generate model Stock quantity:integer arrival:datetime expiration:datetime reorder_quantity:integer aisle:string row:string shelf:string packaging:string credits_per_package:integer food:references meal:references offer:references facility:references inserted_at:datetime --no-migration

rails generate model UserFoodPackage ready_for_pickup:boolean finalized:boolean user:references inserted_at:datetime --no-migration

rails generate model UserLanguage fluent:boolean user:references language:references inserted_at:datetime --no-migration

rails generate model User email:string name:string phone:string ok_to_text:boolean family_members:integer credits:jsonb facility:references primary_language:references inserted_at:datetime password_hash:string admin:boolean --no-migration