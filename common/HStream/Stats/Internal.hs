{-# LANGUAGE CPP       #-}
{-# LANGUAGE MagicHash #-}
{-# OPTIONS_GHC -pgmPcpphs -optP--cpp #-}

module HStream.Stats.Internal where

import           Data.Int
import           Data.Primitive
import           Data.Word
import           Foreign.Ptr

import           HStream.Foreign


-------------------------------------------------------------------------------
-- Considering as internal functions

data CStats
data CStatsHolder

foreign import ccall unsafe "hs_common.h &delete_stats"
  c_delete_stats_fun :: FunPtr (Ptr CStats -> IO ())

foreign import ccall unsafe "hs_common.h new_stats_holder"
  c_new_stats_holder :: IO (Ptr CStatsHolder)

foreign import ccall unsafe "hs_common.h &delete_stats_holder"
  c_delete_stats_holder_fun :: FunPtr (Ptr CStatsHolder -> IO ())

foreign import ccall unsafe "hs_common.h stats_holder_print"
  c_stats_holder_print :: Ptr CStatsHolder -> IO ()

foreign import ccall unsafe "hs_common.h new_aggregate_stats"
  c_new_aggregate_stats :: Ptr CStatsHolder -> IO (Ptr CStats)

#define STAT_DEFINE(name, _)                                                   \
foreign import ccall unsafe "hs_common.h stream_stat_add_##name"               \
  c_stream_stat_add_##name                                                     \
    :: Ptr CStatsHolder -> BA# Word8 -> Int64 -> IO ();                        \
foreign import ccall unsafe "hs_common.h stream_stat_get_##name"               \
  c_stream_stat_get_##name                                                     \
    :: Ptr CStats -> BA# Word8 -> IO Int64;                                    \
foreign import ccall unsafe "hs_common.h stream_stat_getall_##name"            \
  c_stream_stat_getall_##name                                                  \
    :: Ptr CStats                                                              \
    -> MBA# Int                                                                \
    -> MBA# (Ptr StdString)                                                    \
    -> MBA# (Ptr Int64)                                                        \
    -> MBA# (Ptr (StdVector StdString))                                        \
    -> MBA# (Ptr (StdVector Int64))                                            \
    -> IO ();
#include "../include/per_stream_stats.inc"

#define TIME_SERIES_DEFINE(name, _, __, ___)                                   \
foreign import ccall unsafe "hs_common.h stream_time_series_add_##name"        \
  c_stream_time_series_add_##name                                              \
    :: Ptr CStatsHolder -> BA# Word8 -> Int64 -> IO ();
#include "../include/per_stream_time_series.inc"

foreign import ccall unsafe "hs_common.h stream_time_series_getall_by_name"
  c_stream_time_series_getall_by_name
    :: Ptr CStatsHolder -> BA# Word8
    -> Int -> BA# Int
    -> MBA# Int
    -> MBA# (Ptr StdString)
    -> MBA# (Ptr (FollySmallVector Double))
    -> MBA# (Ptr (StdVector StdString))
    -> MBA# (Ptr (StdVector (FollySmallVector Double)))
    -> IO ()
