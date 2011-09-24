module Paths_AutoComplete (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/satvik/.cabal/bin"
libdir     = "/home/satvik/.cabal/lib/AutoComplete-0.1/ghc-7.0.3"
datadir    = "/home/satvik/.cabal/share/AutoComplete-0.1"
libexecdir = "/home/satvik/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "AutoComplete_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "AutoComplete_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "AutoComplete_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "AutoComplete_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
