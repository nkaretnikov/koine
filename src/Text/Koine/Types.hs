{-# LANGUAGE NoImplicitPrelude #-}

module Text.Koine.Types where

import Prelude (Double)

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

newtype String = String
  { unString :: Text
  }

newtype Number = Number
  { unNumber :: Double  -- XXX: for now
  }

newtype Object = Object
  { unObject :: Map String Value
  }

newtype Array = Array
  { unArray :: [Value]
  }
