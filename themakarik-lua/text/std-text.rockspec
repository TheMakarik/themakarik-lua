package = "themakariks-strings"
version = "2026.1.0"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      ["std-text"] = "string-extensions.lua"
      ["std-text-templates"] = "string-template.lua"
   }
}
