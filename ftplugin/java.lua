local jdtls = require("jdtls")

local config = {
  cmd = { "jdtls" },
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml"}),
}

jdtls.start_or_attach(config)
