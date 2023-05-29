-- Build configuration

module = "nkuthesis"
typesetexe  = "xelatex"

demos = {
	bachelor = "nkuthesis.cls",
}

-- internal commands

builddir   = "./build"
typesetdir = builddir .. "/doc"
docfiledir = typesetdir

local newzip = require"l3build-zip"
local function zip(dir, zipname, zipdir)
    local zipfile = newzip(dir .. '/' .. zipname )
    for _, p in pairs(tree(dir .. '/' .. zipdir, "**")) do
      if not (lfs.attributes(p.cwd, "mode") == "directory") then
        zipfile:add(p.cwd, p.src:sub(3), false, false)
      end
    end
    return zipfile:close()
end

function typeset_demo_tasks()
	for demoname, democls in pairs(demos) do
		demotypesetdir = typesetdir .. "/" .. demoname
		cp(demoname, "example", typesetdir)
		cp(democls, localdir, demotypesetdir)
		zip(typesetdir,demoname .. ".zip", demoname)
		typeset("main.tex", typesetdir .. "/" .. demoname)
		cp("main.pdf", demotypesetdir, typesetdir)
		ren(typesetdir, "main.pdf", demoname .. ".pdf")
		table.insert(demofiles, demoname .. ".pdf")
		table.insert(demofiles, demoname .. ".zip")
	end
	return 0
end
