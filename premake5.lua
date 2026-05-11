workspace "VCMPLua"
    architecture "x86_64"
    startproject "LuaPlugin"

    targetname "%{prj.name}"
    targetprefix "" 
    targetsuffix "_x64" 

    pic "On" 
    
    configurations { "Release32", "Release" }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

    filter "configurations:*32"
        architecture "x86"
        targetsuffix "_x86"
        defines {"_x32"}

    filter "system:windows"
        systemversion "latest"
        staticruntime "on"
        defines {
            "CURL_STATICLIB",
            "ZLIB_WINAPI"
        }

    filter "configurations:Release*"
        runtime "Release"
        optimize "On"
        symbols "Off"

        filter "system:windows"
            flags { "LinkTimeOptimization" }

        filter "system:linux"
            -- buildoptions { "-flto" }
            -- linkoptions { "-flto" }
    
    flags { "multiprocessorcompile" }

filter {} 

-- Includes
include "VCMP-LUA/vendor/Lua"
include "VCMP-LUA/vendor/spdlog"
include "VCMP-LUA/vendor/asyncplusplus"
include "VCMP-LUA/vendor/lanes"
include "VCMP-LUA/modules/crypto"
include "VCMP-LUA/modules/sqlite3"
include "VCMP-LUA/modules/requests"
include "VCMP-LUA/modules/postgresql"

-- Core
include "VCMP-LUA"