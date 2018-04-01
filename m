From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 1 Apr 2018 10:17:27 +0000
Subject: [PATCH 0/4] security: Split out hook definitions into lsm_hook_types.h
Message-ID: <cover.1522577650.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This moves all of the LSM hooks type information into a separate file,
lsm_hook_types.h. This enables us to use this file, along with macros
to generate the security_hook_heads struct, as well as the security
hooks union without having to duplicate definitions.

This will be useful for further datastructures which want to use
the set of security hooks in a completely unrolled way, along
with the type information there within.

A couple uses are already taken into account:
 * initialization of security_hook_heads
 * generation of the security_hook_heads datastructure

There are a few things we can follow up with, including:
 * generation of security.h
 * generation of datastructures such as static_keys for performance
   enhancement

Sargun Dhillon (4):
  security: Move hook definitions from lsm_hooks.h to lsm_hook_types.h
  security: Refactor security hooks into structured hooks
  security: Make security_hook_heads use definitions in lsm_hook_types.h
  security: generated security hook initialization based on
    lsm_hook_types.h

 include/linux/lsm_hook_types.h                | 1669 +++++++++++++++++++++
 include/linux/lsm_hooks.h                     | 1934 +------------------------
 scripts/gcc-plugins/randomize_layout_plugin.c |    2 -
 security/security.c                           |   17 +-
 4 files changed, 1691 insertions(+), 1931 deletions(-)
 create mode 100644 include/linux/lsm_hook_types.h

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
