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
import Prelude hiding (null, head, tail, length, and, or, (++))

----
---- TUTORIAL ON LISTS and PATTERN MATCHING
---- https://www.haskelltutorials.com/guides/haskell-lists-ultimate-guide.html
--- Subtle difference between : and [] when pattern-matching
--- With : you can pattern-match a list with any number of elements. This is \
--- because the last : matches the remainder of the list. Whereas, with [], 
--- you can only pattern match a list with an exact number of elements.

-- CODELAB 03: Lists and recursion
--
-- The default list is ubiquitous in the Prelude; the default String type
-- is but a type alias to [Char] after all. Though they have limitations,
-- they're always useful.
--
-- As a reminder, a list is either:
--   * []     the empty list
--   * (x:xs) a cell containing the value x, followed by the list xs
--
-- There is no looping construct in Haskell. To go through a list, we use
-- recursion instead. Here are a some common functions for you to reimplement!

-- null tells you whether a list is empty or not
null :: [a] -> Bool
-- I couldn't do this by myself... the pattern is there, but it's not so clear initially about the syntax
null [] = True
-- I had to look for the underline patter again, which takes "anything else" on the pattern matching
null  _ = False

-- head returns the first element of the list.
--
-- On an empty list, head panics: functions that can panic are "partial"
head :: [a] -> a
head []      = error "head: empty list"
head (h: _)  = h

-- tail returns everything but the first element.
-- If the list is empty it panics
tail :: [a] -> [a]
tail  [] = error "tail: empty list"
tail (_: t) = t

-- Do you remember it from the slides?
length :: [a] -> Int
length    []  = 0
length (_: t) = 1 + length t

-- "and" returns True if all the boolean values in the list are True.
-- What do you think it returns for an empty list?
and :: [Bool] -> Bool
and    []      = True
and (h:t)      = h && and t

-- "or" returns True if at least one value in the list is True.
-- What do you think it returns for an empty list?
or :: [Bool] -> Bool
or []         = False
or (h:t)      = h || or t

-- "(++)" is the concatenation operator.  To concatenate two linked lists
-- you have to chain the second one at the end of the first one.
(++) :: [a] -> [a] -> [a]
l1 ++ l2 = codelab
