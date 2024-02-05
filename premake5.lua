include "../../premake/common_premake_defines.lua"

project "Boost"
	kind "StaticLib"
	language "C++"
	cppdialect "C++latest"
	cdialect "C17"
	targetname "%{prj.name}"
	inlining "Auto"
	tags { "require_boost_includes" }

	files {
		-- not needed for including
		-- "./libs/*/include/boost/**.hpp",

		"./libs/json/src/**.cpp",
		"./libs/locale/src/**.cpp",
		"./libs/filesystem/src/**.cpp"
	}

	excludes {
		"./libs/locale/src/boost/locale/std/**.cpp",
		"./libs/locale/src/boost/locale/win32/**.cpp",
		"./libs/locale/src/boost/locale/posix/**.cpp",
	}

	includedirs {
		"%{IncludeDir.icu}",

		"./libs/locale/src"
	}

	defines {
		"BOOST_LOCALE_WITH_ICU"
	}

	filter "system:windows"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		excludes { "./libs/locale/src/boost/locale/posix/**.cpp" }
	filter "system:not windows"
		excludes { "./libs/locale/src/boost/locale/win32/**.cpp" }