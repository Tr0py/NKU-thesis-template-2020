-- Build configuration

module = "nkuthesis"
typesetexe  = "xelatex"
ctanzip = module .. "-all"

demos = {
	bachelor = "nkuthesis.cls",
}

-- internal commands

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
		cp("README.md", ".", demotypesetdir)
		zip(typesetdir, demoname .. ".zip", demoname)
		cp(demoname .. ".zip", typesetdir, docfiledir)
		typeset("main.tex", demotypesetdir)
		cp("main.pdf", demotypesetdir, docfiledir)
		ren(docfiledir, "main.pdf", demoname .. ".pdf")
		table.insert(demofiles, demoname .. ".pdf")
		table.insert(demofiles, demoname .. ".zip")
	end
	return 0
end
