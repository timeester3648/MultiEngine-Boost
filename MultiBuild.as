void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	properties.name("Boost");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	properties.project_includes("icu");
	project.license("./LICENSE_1_0.txt");

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./libs/*/include",
		"./libs/numeric/**/include"
	});

	properties.defines({
		"BOOST_LOCALE_WITH_ICU"
	});

	properties.files({
		// Note: not needed for including
		// "./libs/*/include/boost/**.hpp",

		"./libs/json/src/**.cpp",
		"./libs/locale/src/**.cpp",
		"./libs/filesystem/src/**.cpp",
		"./libs/program_options/src/**.cpp"
	});

	properties.include_directories({
		"./libs/locale/src"
	});

	{
		MultiBuild::ScopedFilter _(workspace, "config.platform:Windows");
		properties.excluded_files({
			"./libs/locale/src/boost/locale/posix/**.cpp"
		});

		properties.defines({
			"_CRT_SECURE_NO_WARNINGS"
		});
	}

	{
		MultiBuild::ScopedFilter _(workspace, "!config.platform:Windows");
		properties.excluded_files({
			"./libs/locale/src/boost/locale/win32/**.cpp"
		});
	}
}