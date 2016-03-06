{-# LANGUAGE NoImplicitPrelude #-}

module Text.Koine.Types where

import Prelude (Double, Eq, Ord, Show)

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as Text

data Value
  = VString String
  | VNumber Number
  | VObject Object
  | VArray  Array
  | VTrue
  | VFalse
  | VNull
  deriving (Eq, Ord, Show)

newtype String = String
  { unString :: Text
  } deriving (Eq, Ord, Show)

newtype Number = Number
  { unNumber :: Double  -- XXX: for now
  } deriving (Eq, Ord, Show)

newtype Object = Object
  { unObject :: Map String Value
  } deriving (Eq, Ord, Show)

newtype Array = Array
  { unArray :: [Value]
  } deriving (Eq, Ord, Show)
