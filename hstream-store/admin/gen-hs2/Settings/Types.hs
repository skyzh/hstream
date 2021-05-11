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
module Settings.Types
       (SettingSource(SettingSource_CLI, SettingSource_CONFIG,
                      SettingSource_ADMIN_OVERRIDE, SettingSource__UNKNOWN),
        Setting(Setting, setting_currentValue, setting_defaultValue,
                setting_sources),
        SettingsResponse(SettingsResponse, settingsResponse_settings),
        SettingsRequest(SettingsRequest, settingsRequest_settings),
        ApplySettingOverrideRequest(ApplySettingOverrideRequest,
                                    applySettingOverrideRequest_name,
                                    applySettingOverrideRequest_value,
                                    applySettingOverrideRequest_ttl_seconds),
        RemoveSettingOverrideRequest(RemoveSettingOverrideRequest,
                                     removeSettingOverrideRequest_name))
       where
import qualified Control.DeepSeq as DeepSeq
import qualified Control.Exception as Exception
import qualified Control.Monad as Monad
import qualified Control.Monad.ST.Trans as ST
import qualified Control.Monad.Trans.Class as Trans
import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import qualified Data.Default as Default
import qualified Data.Function as Function
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Hashable as Hashable
import qualified Data.Int as Int
import qualified Data.List as List
import qualified Data.Map.Strict as Map
import qualified Data.Ord as Ord
import qualified Data.Set as Set
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import qualified Prelude as Prelude
import qualified Thrift.Binary.Parser as Parser
import qualified Thrift.CodegenTypesOnly as Thrift
import Control.Applicative ((<|>), (*>), (<*))
import Data.Aeson ((.:), (.:?), (.=), (.!=))
import Data.Monoid ((<>))
import Prelude ((.), (++), (>), (==))
import Prelude ((.), (<$>), (<*>), (>>=), (==), (/=), (<), (++))

data SettingSource = SettingSource_CLI
                   | SettingSource_CONFIG
                   | SettingSource_ADMIN_OVERRIDE
                   | SettingSource__UNKNOWN Prelude.Int
                     deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON SettingSource where
  toJSON = Aeson.toJSON . Thrift.fromThriftEnum

instance DeepSeq.NFData SettingSource where
  rnf __SettingSource = Prelude.seq __SettingSource ()

instance Default.Default SettingSource where
  def = SettingSource_CLI

instance Hashable.Hashable SettingSource where
  hashWithSalt _salt _val
    = Hashable.hashWithSalt _salt (Thrift.fromThriftEnum _val)

instance Thrift.ThriftEnum SettingSource where
  toThriftEnum 0 = SettingSource_CLI
  toThriftEnum 1 = SettingSource_CONFIG
  toThriftEnum 2 = SettingSource_ADMIN_OVERRIDE
  toThriftEnum val = SettingSource__UNKNOWN val
  fromThriftEnum SettingSource_CLI = 0
  fromThriftEnum SettingSource_CONFIG = 1
  fromThriftEnum SettingSource_ADMIN_OVERRIDE = 2
  fromThriftEnum (SettingSource__UNKNOWN val) = val
  allThriftEnumValues
    = [SettingSource_CLI, SettingSource_CONFIG,
       SettingSource_ADMIN_OVERRIDE]
  toThriftEnumEither 0 = Prelude.Right SettingSource_CLI
  toThriftEnumEither 1 = Prelude.Right SettingSource_CONFIG
  toThriftEnumEither 2 = Prelude.Right SettingSource_ADMIN_OVERRIDE
  toThriftEnumEither val
    = Prelude.Left
        ("toThriftEnumEither: not a valid identifier for enum SettingSource: "
           ++ Prelude.show val)

data Setting = Setting{setting_currentValue :: Text.Text,
                       setting_defaultValue :: Text.Text,
                       setting_sources :: Map.Map SettingSource Text.Text}
               deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON Setting where
  toJSON
    (Setting __field__currentValue __field__defaultValue
       __field__sources)
    = Aeson.object
        ("currentValue" .= __field__currentValue :
           "defaultValue" .= __field__defaultValue :
             "sources" .= Map.mapKeys Thrift.keyToStr __field__sources :
               Prelude.mempty)

instance Thrift.ThriftStruct Setting where
  buildStruct _proxy
    (Setting __field__currentValue __field__defaultValue
       __field__sources)
    = Thrift.genStruct _proxy
        (Thrift.genField _proxy "currentValue"
           (Thrift.getStringType _proxy)
           1
           0
           (Thrift.genText _proxy __field__currentValue)
           :
           Thrift.genField _proxy "defaultValue" (Thrift.getStringType _proxy)
             2
             1
             (Thrift.genText _proxy __field__defaultValue)
             :
             Thrift.genField _proxy "sources" (Thrift.getMapType _proxy) 3 2
               ((Thrift.genMap _proxy (Thrift.getI32Type _proxy)
                   (Thrift.getStringType _proxy)
                   Prelude.False
                   (Thrift.genI32 _proxy . Prelude.fromIntegral .
                      Thrift.fromThriftEnum)
                   (Thrift.genText _proxy)
                   . Map.toList)
                  __field__sources)
               : [])
  parseStruct _proxy
    = ST.runSTT
        (do Prelude.return ()
            __field__currentValue <- ST.newSTRef ""
            __field__defaultValue <- ST.newSTRef ""
            __field__sources <- ST.newSTRef Default.def
            let
              _parse _lastId
                = do _fieldBegin <- Trans.lift
                                      (Thrift.parseFieldBegin _proxy _lastId _idMap)
                     case _fieldBegin of
                       Thrift.FieldBegin _type _id _bool -> do case _id of
                                                                 1 | _type ==
                                                                       Thrift.getStringType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseText
                                                                                      _proxy)
                                                                        ST.writeSTRef
                                                                          __field__currentValue
                                                                          _val
                                                                 2 | _type ==
                                                                       Thrift.getStringType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseText
                                                                                      _proxy)
                                                                        ST.writeSTRef
                                                                          __field__defaultValue
                                                                          _val
                                                                 3 | _type ==
                                                                       Thrift.getMapType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Map.fromList <$>
                                                                                      Thrift.parseMap
                                                                                        _proxy
                                                                                        (Thrift.parseEnum
                                                                                           _proxy
                                                                                           "SettingSource")
                                                                                        (Thrift.parseText
                                                                                           _proxy)
                                                                                        Prelude.False)
                                                                        ST.writeSTRef
                                                                          __field__sources
                                                                          _val
                                                                 _ -> Trans.lift
                                                                        (Thrift.parseSkip _proxy
                                                                           _type
                                                                           (Prelude.Just _bool))
                                                               _parse _id
                       Thrift.FieldEnd -> do !__val__currentValue <- ST.readSTRef
                                                                       __field__currentValue
                                             !__val__defaultValue <- ST.readSTRef
                                                                       __field__defaultValue
                                             !__val__sources <- ST.readSTRef __field__sources
                                             Prelude.pure
                                               (Setting __val__currentValue __val__defaultValue
                                                  __val__sources)
              _idMap
                = HashMap.fromList
                    [("currentValue", 1), ("defaultValue", 2), ("sources", 3)]
            _parse 0)

instance DeepSeq.NFData Setting where
  rnf
    (Setting __field__currentValue __field__defaultValue
       __field__sources)
    = DeepSeq.rnf __field__currentValue `Prelude.seq`
        DeepSeq.rnf __field__defaultValue `Prelude.seq`
          DeepSeq.rnf __field__sources `Prelude.seq` ()

instance Default.Default Setting where
  def = Setting "" "" Default.def

instance Hashable.Hashable Setting where
  hashWithSalt __salt (Setting _currentValue _defaultValue _sources)
    = Hashable.hashWithSalt
        (Hashable.hashWithSalt (Hashable.hashWithSalt __salt _currentValue)
           _defaultValue)
        ((Prelude.map (\ (_k, _v) -> (_k, _v)) . Map.toAscList) _sources)

newtype SettingsResponse = SettingsResponse{settingsResponse_settings
                                            :: Map.Map Text.Text Setting}
                           deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON SettingsResponse where
  toJSON (SettingsResponse __field__settings)
    = Aeson.object ("settings" .= __field__settings : Prelude.mempty)

instance Thrift.ThriftStruct SettingsResponse where
  buildStruct _proxy (SettingsResponse __field__settings)
    = Thrift.genStruct _proxy
        (Thrift.genField _proxy "settings" (Thrift.getMapType _proxy) 1 0
           ((Thrift.genMap _proxy (Thrift.getStringType _proxy)
               (Thrift.getStructType _proxy)
               Prelude.True
               (Thrift.genText _proxy)
               (Thrift.buildStruct _proxy)
               . Map.toList)
              __field__settings)
           : [])
  parseStruct _proxy
    = ST.runSTT
        (do Prelude.return ()
            __field__settings <- ST.newSTRef Default.def
            let
              _parse _lastId
                = do _fieldBegin <- Trans.lift
                                      (Thrift.parseFieldBegin _proxy _lastId _idMap)
                     case _fieldBegin of
                       Thrift.FieldBegin _type _id _bool -> do case _id of
                                                                 1 | _type ==
                                                                       Thrift.getMapType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Map.fromList <$>
                                                                                      Thrift.parseMap
                                                                                        _proxy
                                                                                        (Thrift.parseText
                                                                                           _proxy)
                                                                                        (Thrift.parseStruct
                                                                                           _proxy)
                                                                                        Prelude.True)
                                                                        ST.writeSTRef
                                                                          __field__settings
                                                                          _val
                                                                 _ -> Trans.lift
                                                                        (Thrift.parseSkip _proxy
                                                                           _type
                                                                           (Prelude.Just _bool))
                                                               _parse _id
                       Thrift.FieldEnd -> do !__val__settings <- ST.readSTRef
                                                                   __field__settings
                                             Prelude.pure (SettingsResponse __val__settings)
              _idMap = HashMap.fromList [("settings", 1)]
            _parse 0)

instance DeepSeq.NFData SettingsResponse where
  rnf (SettingsResponse __field__settings)
    = DeepSeq.rnf __field__settings `Prelude.seq` ()

instance Default.Default SettingsResponse where
  def = SettingsResponse Default.def

instance Hashable.Hashable SettingsResponse where
  hashWithSalt __salt (SettingsResponse _settings)
    = Hashable.hashWithSalt __salt
        ((Prelude.map (\ (_k, _v) -> (_k, _v)) . Map.toAscList) _settings)

newtype SettingsRequest = SettingsRequest{settingsRequest_settings
                                          :: Prelude.Maybe (Set.Set Text.Text)}
                          deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON SettingsRequest where
  toJSON (SettingsRequest __field__settings)
    = Aeson.object
        (Prelude.maybe Prelude.id ((:) . ("settings" .=)) __field__settings
           Prelude.mempty)

instance Thrift.ThriftStruct SettingsRequest where
  buildStruct _proxy (SettingsRequest __field__settings)
    = Thrift.genStruct _proxy
        (case __field__settings of
           Prelude.Just _val -> Thrift.genField _proxy "settings"
                                  (Thrift.getSetType _proxy)
                                  1
                                  0
                                  ((Thrift.genList _proxy (Thrift.getStringType _proxy)
                                      (Thrift.genText _proxy)
                                      . Set.toList)
                                     _val)
                                  : []
           Prelude.Nothing -> [])
  parseStruct _proxy
    = ST.runSTT
        (do Prelude.return ()
            __field__settings <- ST.newSTRef Prelude.Nothing
            let
              _parse _lastId
                = do _fieldBegin <- Trans.lift
                                      (Thrift.parseFieldBegin _proxy _lastId _idMap)
                     case _fieldBegin of
                       Thrift.FieldBegin _type _id _bool -> do case _id of
                                                                 1 | _type ==
                                                                       Thrift.getSetType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Set.fromList .
                                                                                      Prelude.snd
                                                                                      <$>
                                                                                      Thrift.parseList
                                                                                        _proxy
                                                                                        (Thrift.parseText
                                                                                           _proxy))
                                                                        ST.writeSTRef
                                                                          __field__settings
                                                                          (Prelude.Just _val)
                                                                 _ -> Trans.lift
                                                                        (Thrift.parseSkip _proxy
                                                                           _type
                                                                           (Prelude.Just _bool))
                                                               _parse _id
                       Thrift.FieldEnd -> do !__val__settings <- ST.readSTRef
                                                                   __field__settings
                                             Prelude.pure (SettingsRequest __val__settings)
              _idMap = HashMap.fromList [("settings", 1)]
            _parse 0)

instance DeepSeq.NFData SettingsRequest where
  rnf (SettingsRequest __field__settings)
    = DeepSeq.rnf __field__settings `Prelude.seq` ()

instance Default.Default SettingsRequest where
  def = SettingsRequest Prelude.Nothing

instance Hashable.Hashable SettingsRequest where
  hashWithSalt __salt (SettingsRequest _settings)
    = Hashable.hashWithSalt __salt (Prelude.fmap Set.elems _settings)

data ApplySettingOverrideRequest = ApplySettingOverrideRequest{applySettingOverrideRequest_name
                                                               :: Text.Text,
                                                               applySettingOverrideRequest_value ::
                                                               Text.Text,
                                                               applySettingOverrideRequest_ttl_seconds
                                                               :: Int.Int32}
                                   deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON ApplySettingOverrideRequest where
  toJSON
    (ApplySettingOverrideRequest __field__name __field__value
       __field__ttl_seconds)
    = Aeson.object
        ("name" .= __field__name :
           "value" .= __field__value :
             "ttl_seconds" .= __field__ttl_seconds : Prelude.mempty)

instance Thrift.ThriftStruct ApplySettingOverrideRequest where
  buildStruct _proxy
    (ApplySettingOverrideRequest __field__name __field__value
       __field__ttl_seconds)
    = Thrift.genStruct _proxy
        (Thrift.genField _proxy "name" (Thrift.getStringType _proxy) 1 0
           (Thrift.genText _proxy __field__name)
           :
           Thrift.genField _proxy "value" (Thrift.getStringType _proxy) 2 1
             (Thrift.genText _proxy __field__value)
             :
             Thrift.genFieldPrim _proxy "ttl_seconds" (Thrift.getI32Type _proxy)
               3
               2
               (Thrift.genI32Prim _proxy)
               __field__ttl_seconds
               : [])
  parseStruct _proxy
    = ST.runSTT
        (do Prelude.return ()
            __field__name <- ST.newSTRef ""
            __field__value <- ST.newSTRef ""
            __field__ttl_seconds <- ST.newSTRef Default.def
            let
              _parse _lastId
                = do _fieldBegin <- Trans.lift
                                      (Thrift.parseFieldBegin _proxy _lastId _idMap)
                     case _fieldBegin of
                       Thrift.FieldBegin _type _id _bool -> do case _id of
                                                                 1 | _type ==
                                                                       Thrift.getStringType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseText
                                                                                      _proxy)
                                                                        ST.writeSTRef __field__name
                                                                          _val
                                                                 2 | _type ==
                                                                       Thrift.getStringType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseText
                                                                                      _proxy)
                                                                        ST.writeSTRef __field__value
                                                                          _val
                                                                 3 | _type ==
                                                                       Thrift.getI32Type _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseI32
                                                                                      _proxy)
                                                                        ST.writeSTRef
                                                                          __field__ttl_seconds
                                                                          _val
                                                                 _ -> Trans.lift
                                                                        (Thrift.parseSkip _proxy
                                                                           _type
                                                                           (Prelude.Just _bool))
                                                               _parse _id
                       Thrift.FieldEnd -> do !__val__name <- ST.readSTRef __field__name
                                             !__val__value <- ST.readSTRef __field__value
                                             !__val__ttl_seconds <- ST.readSTRef
                                                                      __field__ttl_seconds
                                             Prelude.pure
                                               (ApplySettingOverrideRequest __val__name __val__value
                                                  __val__ttl_seconds)
              _idMap
                = HashMap.fromList [("name", 1), ("value", 2), ("ttl_seconds", 3)]
            _parse 0)

instance DeepSeq.NFData ApplySettingOverrideRequest where
  rnf
    (ApplySettingOverrideRequest __field__name __field__value
       __field__ttl_seconds)
    = DeepSeq.rnf __field__name `Prelude.seq`
        DeepSeq.rnf __field__value `Prelude.seq`
          DeepSeq.rnf __field__ttl_seconds `Prelude.seq` ()

instance Default.Default ApplySettingOverrideRequest where
  def = ApplySettingOverrideRequest "" "" Default.def

instance Hashable.Hashable ApplySettingOverrideRequest where
  hashWithSalt __salt
    (ApplySettingOverrideRequest _name _value _ttl_seconds)
    = Hashable.hashWithSalt
        (Hashable.hashWithSalt (Hashable.hashWithSalt __salt _name) _value)
        _ttl_seconds

newtype RemoveSettingOverrideRequest = RemoveSettingOverrideRequest{removeSettingOverrideRequest_name
                                                                    :: Text.Text}
                                       deriving (Prelude.Eq, Prelude.Show, Prelude.Ord)

instance Aeson.ToJSON RemoveSettingOverrideRequest where
  toJSON (RemoveSettingOverrideRequest __field__name)
    = Aeson.object ("name" .= __field__name : Prelude.mempty)

instance Thrift.ThriftStruct RemoveSettingOverrideRequest where
  buildStruct _proxy (RemoveSettingOverrideRequest __field__name)
    = Thrift.genStruct _proxy
        (Thrift.genField _proxy "name" (Thrift.getStringType _proxy) 1 0
           (Thrift.genText _proxy __field__name)
           : [])
  parseStruct _proxy
    = ST.runSTT
        (do Prelude.return ()
            __field__name <- ST.newSTRef ""
            let
              _parse _lastId
                = do _fieldBegin <- Trans.lift
                                      (Thrift.parseFieldBegin _proxy _lastId _idMap)
                     case _fieldBegin of
                       Thrift.FieldBegin _type _id _bool -> do case _id of
                                                                 1 | _type ==
                                                                       Thrift.getStringType _proxy
                                                                     ->
                                                                     do !_val <- Trans.lift
                                                                                   (Thrift.parseText
                                                                                      _proxy)
                                                                        ST.writeSTRef __field__name
                                                                          _val
                                                                 _ -> Trans.lift
                                                                        (Thrift.parseSkip _proxy
                                                                           _type
                                                                           (Prelude.Just _bool))
                                                               _parse _id
                       Thrift.FieldEnd -> do !__val__name <- ST.readSTRef __field__name
                                             Prelude.pure (RemoveSettingOverrideRequest __val__name)
              _idMap = HashMap.fromList [("name", 1)]
            _parse 0)

instance DeepSeq.NFData RemoveSettingOverrideRequest where
  rnf (RemoveSettingOverrideRequest __field__name)
    = DeepSeq.rnf __field__name `Prelude.seq` ()

instance Default.Default RemoveSettingOverrideRequest where
  def = RemoveSettingOverrideRequest ""

instance Hashable.Hashable RemoveSettingOverrideRequest where
  hashWithSalt __salt (RemoveSettingOverrideRequest _name)
    = Hashable.hashWithSalt __salt _name