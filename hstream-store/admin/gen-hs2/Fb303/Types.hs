-----------------------------------------------------------------
-- Autogenerated by Thrift
--
-- DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
--  @generated
-----------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-overlapping-patterns#-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns#-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Fb303.Types
       (Fb_status(Fb_status_DEAD, Fb_status_STARTING, Fb_status_ALIVE,
                  Fb_status_STOPPING, Fb_status_STOPPED, Fb_status_WARNING,
                  Fb_status__UNKNOWN))
       where
import qualified Control.DeepSeq as DeepSeq
import qualified Control.Exception as Exception
import qualified Data.Aeson as Aeson
import qualified Data.Default as Default
import qualified Data.Function as Function
import qualified Data.Hashable as Hashable
import qualified Data.Int as Int
import qualified Prelude as Prelude
import qualified Thrift.CodegenTypesOnly as Thrift
import Prelude ((.), (++), (>), (==))

data Fb_status = Fb_status_DEAD
               | Fb_status_STARTING
               | Fb_status_ALIVE
               | Fb_status_STOPPING
               | Fb_status_STOPPED
               | Fb_status_WARNING
               | Fb_status__UNKNOWN Prelude.Int
                 deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON Fb_status where
  toJSON = Aeson.toJSON . Thrift.fromThriftEnum

instance DeepSeq.NFData Fb_status where
  rnf __Fb_status = Prelude.seq __Fb_status ()

instance Default.Default Fb_status where
  def = Fb_status_DEAD

instance Hashable.Hashable Fb_status where
  hashWithSalt _salt _val
    = Hashable.hashWithSalt _salt (Thrift.fromThriftEnum _val)

instance Thrift.ThriftEnum Fb_status where
  toThriftEnum 0 = Fb_status_DEAD
  toThriftEnum 1 = Fb_status_STARTING
  toThriftEnum 2 = Fb_status_ALIVE
  toThriftEnum 3 = Fb_status_STOPPING
  toThriftEnum 4 = Fb_status_STOPPED
  toThriftEnum 5 = Fb_status_WARNING
  toThriftEnum val = Fb_status__UNKNOWN val
  fromThriftEnum Fb_status_DEAD = 0
  fromThriftEnum Fb_status_STARTING = 1
  fromThriftEnum Fb_status_ALIVE = 2
  fromThriftEnum Fb_status_STOPPING = 3
  fromThriftEnum Fb_status_STOPPED = 4
  fromThriftEnum Fb_status_WARNING = 5
  fromThriftEnum (Fb_status__UNKNOWN val) = val
  allThriftEnumValues
    = [Fb_status_DEAD, Fb_status_STARTING, Fb_status_ALIVE,
       Fb_status_STOPPING, Fb_status_STOPPED, Fb_status_WARNING]
  toThriftEnumEither 0 = Prelude.Right Fb_status_DEAD
  toThriftEnumEither 1 = Prelude.Right Fb_status_STARTING
  toThriftEnumEither 2 = Prelude.Right Fb_status_ALIVE
  toThriftEnumEither 3 = Prelude.Right Fb_status_STOPPING
  toThriftEnumEither 4 = Prelude.Right Fb_status_STOPPED
  toThriftEnumEither 5 = Prelude.Right Fb_status_WARNING
  toThriftEnumEither val
    = Prelude.Left
        ("toThriftEnumEither: not a valid identifier for enum Fb_status: "
           ++ Prelude.show val)