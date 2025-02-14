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

-- CODELAB 02: Simple pattern matching.
--
-- Now that we can define simple data structures, let's try using them.

data Minutes = Minutes Int

-- Integer division is called "div".  If you want, you can use a function
-- of two arguments as an infix operator, by surrounding it with
-- backquotes. For example, this
--
--     a `div` b
--
-- is the same as
--
--     div a b
hours :: Minutes -> Int
hours (Minutes m) = m `div` 60

-- Pattern matching for the seconds is just a multiplier
seconds :: Minutes -> Int
seconds (Minutes m) = m * 60

-- Pattern matching for the minutes is an identity function
minutes :: Minutes -> Int
minutes (Minutes m) = m

-- In case you need some mathematical functions, you can use
--
--     Hoogle     https://hoogle.haskell.org
--
-- to search for anything supported by the standard library and beyond. You
-- can search by name, or even by type signature!
--
-- Distance here means the number of minutes to get from m1 to m2.  For
-- example, for 15 and 25, distance is 10.
--timeDistance :: Minutes -> Minutes -> Minutes
--timeDistance (Minutes m) (Minutes n) = if n > m
--  then (Minutes (n - m))
--  else (Minutes (m - n))

-- Also having the absolute function when the values are inverted
-- https://hackage.haskell.org/package/base-4.16.0.0/docs/Prelude.html#v:abs
-- timeDistance (Minutes m) (Minutes n) = (Minutes ( abs (n - m) ))

-- This is using the $ expression, that helps removing the ()
timeDistance (Minutes m) (Minutes n) = Minutes $ abs (n - m)

type Point = (Int, Int)

-- Do not forget about Hoogle (see above), should you need a new function.
--
-- Notice that when you declare a new type with the "data" keyword, you
-- also declare new constructor(s) that you can use to pattern match.  But
-- when you are declaring a type alias with the "type" keyword, no
-- constructors are declared.  You will pattern match on the original type
-- you are aliasing - a tuple in this case. For example:
--
--     f :: Point -> Int
--     f (x, y) = abs x + abs y
pointDistance :: Point -> Point -> Double

-- Distance between 2 points is https://www.calculatorsoup.com/calculators/geometry-plane/distance-two-points.php
-- point distance is sqrt [ (x2 - x1)^2 + (y2 - y1)^2 ]
-- sqrt = https://hackage.haskell.org/package/numeric-prelude-0.4.3.3/docs/Algebra-Algebraic.html#v:sqrt
-- power = https://hackage.haskell.org/package/numeric-prelude-0.4.3.3/docs/Number-Complex.html#v:power
-- Instead of power, we an use the same operator in languages
-- also, removing the parenthesis with the $ operator
pointDistance (x1, y1) (x2, y2) = sqrt . fromIntegral $ (x2 - x1)^2 + (y2 - y1)^2
