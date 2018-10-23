# Get the current date.
# include(WebClientVariables)
string(TIMESTAMP CURRENT_DATE "%Y-%m-%d")

# Get git revision version
include(GetGitRevisionDescription)
get_git_head_revision(REFSPEC FULL_GIT_REVISION)
if(FULL_GIT_REVISION STREQUAL "GITDIR-NOTFOUND")
  set(GIT_REVISION "git")
else(FULL_GIT_REVISION STREQUAL "GITDIR-NOTFOUND")
  string(SUBSTRING ${FULL_GIT_REVISION} 0 8 GIT_REVISION)
endif(FULL_GIT_REVISION STREQUAL "GITDIR-NOTFOUND")

# Get the build number if available
if(DEFINED ENV{BUILD_NUMBER})
  set(VERSION_BUILD "$ENV{BUILD_NUMBER}")
  set(VERSION_BUILD_NR "$ENV{BUILD_NUMBER}")
else()
  set(VERSION_BUILD "dev")
  set(VERSION_BUILD_NR "0")
endif()

set(VERSION_MAJOR 2)
set(VERSION_MINOR 21)
set(VERSION_NANO 0)

option(UPGRADE_DEBUG "" OFF)

if(UPGRADE_DEBUG)
  set(VERSION_STRING "1.0.4.177-195ef65f")
  set(VERSION_STRING_SHORT "1.0.4")
  set(CANONICAL_VERSION_STRING "1.0.4-195ef65f")
else()
  set(VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_NANO}.${VERSION_BUILD}-${GIT_REVISION}")
  set(VERSION_STRING_SHORT "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_NANO}")
  set(CANONICAL_VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_NANO}-${GIT_REVISION}")
endif()

configure_file(src/core/Version.cpp.in src/core/Version.cpp)
