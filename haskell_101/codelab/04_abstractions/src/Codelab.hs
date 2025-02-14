-- Copyright 2021 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-type-defaults  #-}

module Codelab where

import Internal (codelab)
import Prelude hiding (map, filter, foldr, foldl)

-- CODELAB 04: Abstractions 
--
-- Have you noticed that we keep using the same pattern?  If the list is
-- empty we return a specific value.  If it is not, we call a function to
-- combine the element with the result of the recursive calls.
--
-- This is Haskell: if there is a pattern, it can (must) be abstracted!
-- Fortunately, some useful functions are here for us.
--
-- To understand the difference between foldr and foldl, remember that the
-- last letter indicates if the "reduction" function is left associative or
-- right associative: foldr goes from right to left, foldl goes from left
-- to right.
--
-- foldl :: (a -> x -> a) -> a -> [x] -> a
-- foldr :: (x -> a -> a) -> a -> [x] -> a
-- foldl (-) 0 [1,2,3,4]   ==   (((0 - 1) - 2) - 3) - 4   ==   -10
-- foldr (-) 0 [1,2,3,4]   ==   1 - (2 - (3 - (4 - 0)))   ==    -2

-- You probably remember this one?  Nothing extraordinary here.
map :: (a -> b) -> [a] -> [b]
-- Transforming the empty list in empty list returns the empty list
map _ []     = []
-- Applying a function to a non-empty list 
-- F is a transformational function that takes an A, transforming into B
-- If we apply f on an A element, we don't do anything in place, we have
-- to create a new list. The way to create a new list is to use the ":"
-- operator, which appends values at the beginning of lists: "f a :"
-- Now we use the same transformation funcion on the tail: f a : map as
-- As "f a :" is of higher priority, the function will be executed first,
-- as function application binds first. That is:
-- f a is the result of that operation, appened to the new list of map
-- on the tail of the list (which recursively will execute the same).
map f (a:as) = f a : map f as

-- USING FOLDR, TODO: map f l foldr (\a z -> f a : z) [] l

-- Same thing here for filter, except that we use it to introduce a new
-- syntax: those | are called "guards". They let you specify different
-- implementations of your function depending on some Boolean
-- value. "otherwise" is not a keyword but simply a constant whose value is
-- True! Try to evaluate "otherwise" in GHCI.
-- Prelude> otherwise
-- True
--
-- Simple example of guard usage:
--   abs :: Int -> Int
--   abs x
--     | x < 0     = -x

-- Presentation explation: https://youtu.be/cTN1Qar4HSw?t=5892
--     | otherwise =  x
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter f (x:xs)
-- when the predicate is evaluated to true, then we apend x to the filtered list, concatenated
-- First, it evaluates the values of x, which uses a new list to return
-- If the predicate is False, it will apply the list f to the tail of xs
  | f x       = x : filter f xs
  | otherwise = filter f xs

-- foldl: fold from left
-- foldl (-) 0 [1,2,3,4]   ==   (((0 - 1) - 2) - 3) - 4   ==   -10
-- That is, pass the acumulator to the function, and the result of it,
-- is applied to the rest of the list. 
-- (0 - 1), (-1 - 2), (-3 - 3), (-6 - 4) = -10 
foldl :: (a -> x -> a) -> a -> [x] -> a
-- When re reach the end of the list, we just return th eacumulator,
-- which is the first element of the reasoning list above
foldl _ a []     = a
-- We need to start with f a x, as it will always be called. However, we need to use it
-- as the new accumulator for the next element of the list: foldl f (f a x) xs
foldl f a (x:xs) = foldl f (f a x) xs
-- Using the concept of ``, which transforms the function in infix notaiton
--foldl f a (x:xs) = foldl f (a `f` x) xs
-- We can't remove the parenthesis with $ 

-- foldr: fold from right
-- foldr (-) 0 [1,2,3,4]   ==   1 - (2 - (3 - (4 - 0)))   ==    -2
-- In this case, the accumulator proces the  last element 
foldr :: (x -> a -> a) -> a -> [x] -> a
foldr _ a []     = a
-- Now for this, we can use $ to remove the following
--foldr f a (x:xs) = f x (fold f a xs)
foldr f a (x:xs) = f x $ foldr f a xs

-- #####################################################################
-- BONUS STAGE!
--
-- For fun, you can try reimplementing the functions in previous codelab with
-- foldr or foldl! For length, remember that the syntax for a lambda function
-- is (\arg1 arg2 -> value).
--
-- You can replace your previous implementation if you want. Otherwise, you can
-- add new functions (such as andF, orF), and test them by loading your file in
-- GHCI.
--
-- To go a bit further, you can also try QuickCheck:
--
-- > import Test.QuickCheck
-- > quickCheck $ \anyList -> and anyList == andF anyList
--
-- QuickCheck automatically generates tests based on the types expected
-- (here, list of boolean values).
--
-- It is also worth noting that there is a special syntax for list
-- comprehension in Haskell, which is at a first glance quite similar to
-- the syntax of Python's list comprehension
--
-- Python:  [transform(value) for value in container if test(value)]
-- Haskell: [transform value  |   value <- container ,  test value ]
--
-- This allows you to succinctly write your map / filters.
