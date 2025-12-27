project "FreeType"
    kind "StaticLib"
    language "C"
    staticruntime "on" -- Importante para que coincida con tu Engine
    warnings "Off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        -- Fuentes base (Coinciden con BASE_SRCS del CMake)
        "src/autofit/autofit.c",
        "src/base/ftbase.c",
        "src/base/ftbbox.c",
        "src/base/ftbdf.c",
        "src/base/ftbitmap.c",
        "src/base/ftcid.c",
        "src/base/ftfstype.c",
        "src/base/ftgasp.c",
        "src/base/ftglyph.c",
        "src/base/ftgxval.c",
        "src/base/ftinit.c",
        "src/base/ftmm.c",
        "src/base/ftotval.c",
        "src/base/ftpatent.c",
        "src/base/ftpfr.c",
        "src/base/ftstroke.c",
        "src/base/ftsynth.c",
        "src/base/fttype1.c",
        "src/base/ftwinfnt.c",
        "src/bdf/bdf.c",
        "src/bzip2/ftbzip2.c",
        "src/cache/ftcache.c",
        "src/cff/cff.c",
        "src/cid/type1cid.c",
        "src/gzip/ftgzip.c",
        "src/lzw/ftlzw.c",
        "src/pcf/pcf.c",
        "src/pfr/pfr.c",
        "src/psaux/psaux.c",
        "src/pshinter/pshinter.c",
        "src/psnames/psnames.c",
        "src/raster/raster.c",
        "src/sdf/sdf.c",         -- CRÍTICO para Game Engines (SDF rendering)
        "src/sfnt/sfnt.c",
        "src/smooth/smooth.c",
        "src/svg/svg.c",
        "src/truetype/truetype.c",
        "src/type1/type1.c",
        "src/type42/type42.c",
        "src/winfonts/winfnt.c",

        -- Headers para que aparezcan en tu IDE (Visual Studio/Rider)
        "include/freetype/*.h",
        "include/freetype/config/*.h"
    }


    externalincludedirs { "include" }

    defines {
        "FT2_BUILD_LIBRARY" -- Necesario para compilar la lib interna
    }

    -- Configuración específica de plataforma (Equivalente a la lógica del CMake)
    filter "system:windows"
        systemversion "latest"
        defines { "_CRT_SECURE_NO_WARNINGS", "_CRT_NONSTDC_NO_WARNINGS" }
        files {
            "builds/windows/ftsystem.c", -- Implementación Win32
            "builds/windows/ftdebug.c"
        }

    filter "system:linux"
        pic "on"
        files {
            "src/base/ftsystem.c", -- Usamos la genérica ANSI C para evitar líos de configuración en Linux sin autoconf
            "src/base/ftdebug.c"
        }

    filter "system:macosx"
        systemversion "latest"
        pic "on"
        
        files {
            "src/base/ftsystem.c",
            "src/base/ftdebug.c"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"