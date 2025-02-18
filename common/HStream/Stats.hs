{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP          #-}
{-# LANGUAGE MagicHash    #-}
{-# OPTIONS_GHC -pgmPcpphs -optP--cpp #-}

-- To dump CPP output, do
--
-- > cabal exec -- ghc -E common/HStream/Stats.hs
--
-- And then you can @cat common/HStream/Stats.hspp@

module HStream.Stats where

import           Data.Int
import qualified Data.Map.Strict          as Map
import           Data.Primitive.ByteArray
import           Foreign.ForeignPtr
import           Z.Data.CBytes            (CBytes, withCBytesUnsafe)

import           HStream.Foreign
import           HStream.Stats.Internal

-------------------------------------------------------------------------------

newtype Stats = Stats { unStats :: ForeignPtr CStats }
newtype StatsHolder = StatsHolder { unStatsHolder :: ForeignPtr CStatsHolder }

newStatsHolder :: IO StatsHolder
newStatsHolder = StatsHolder <$>
  (newForeignPtr c_delete_stats_holder_fun =<< c_new_stats_holder)

newAggregateStats :: StatsHolder -> IO Stats
newAggregateStats (StatsHolder holder) = withForeignPtr holder $ \holder' ->
  Stats <$> (newForeignPtr c_delete_stats_fun =<< c_new_aggregate_stats holder')

-- TODO: add Show instance for StatsHolder
printStatsHolder :: StatsHolder -> IO ()
printStatsHolder (StatsHolder holder) = withForeignPtr holder c_stats_holder_print

#define STREAM_STAT_ADD(PERFIX, STATS_NAME) \
PERFIX##_##STATS_NAME :: StatsHolder -> CBytes -> Int64 -> IO ();              \
PERFIX##_##STATS_NAME (StatsHolder holder) stream_name val =                   \
  withForeignPtr holder $ \holder' ->                                          \
  withCBytesUnsafe stream_name $ \stream_name' ->                              \
    c_##PERFIX##_##STATS_NAME holder' (BA# stream_name') val;

-- TODO: Error while return value is a negative number.
#define STREAM_STAT_GET(PERFIX, STATS_NAME)                                    \
PERFIX##_##STATS_NAME :: Stats -> CBytes -> IO Int64;                          \
PERFIX##_##STATS_NAME (Stats stats) stream_name =                              \
  withForeignPtr stats $ \stats' ->                                            \
  withCBytesUnsafe stream_name $ \stream_name' ->                              \
    c_##PERFIX##_##STATS_NAME stats' (BA# stream_name');

#define STREAM_STAT_GETALL(perfix, stats_name)                                 \
perfix##_##stats_name :: Stats -> IO (Map.Map CBytes Int64);                   \
perfix##_##stats_name (Stats stats) =                                          \
  withForeignPtr stats $ \stats' ->                                            \
    peekCppMap                                                                 \
      (c_##perfix##_##stats_name stats')                                       \
      peekStdStringToCBytesN c_delete_vector_of_string                         \
      peekN c_delete_vector_of_int64;

#define STAT_DEFINE(name, _)                                                   \
STREAM_STAT_ADD(stream_stat_add, name)                                         \
STREAM_STAT_GET(stream_stat_get, name)                                         \
STREAM_STAT_GETALL(stream_stat_getall, name)
#include "../include/per_stream_stats.inc"

#define TIME_SERIES_DEFINE(name, _, __, ___)                                   \
STREAM_STAT_ADD(stream_time_series_add, name)
#include "../include/per_stream_time_series.inc"

stream_time_series_getall_by_name
  :: StatsHolder -> CBytes -> [Int] -> IO (Map.Map CBytes [Double])
stream_time_series_getall_by_name (StatsHolder holder) name intervals =
  withForeignPtr holder $ \holder' ->
  withCBytesUnsafe name $ \name' -> do
    let interval_len = length intervals
    -- NOTE only for unsafe ffi
    let !(ByteArray intervals') = byteArrayFromListN interval_len intervals
    peekCppMap
      (c_stream_time_series_getall_by_name holder' (BA# name') interval_len (BA# intervals'))
      peekStdStringToCBytesN c_delete_vector_of_string
      peekFollySmallVectorDoubleN c_delete_std_vec_of_folly_small_vec_of_double
