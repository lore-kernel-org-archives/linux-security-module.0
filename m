From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 7 Mar 2018 07:22:55 +0000
Subject: [PATCH v4 0/3] Safe, dynamically loadable LSM hooks
Message-ID: <cover.1520407240.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset introduces safe dynamic LSM support. These are currently
not unloadable, until we figure out a use case that needs that. Adding
an unload hook is trivial given the way the patch is written.

This exposes a second mechanism of loading hooks which are in modules.
These hooks are behind static keys, so they should come at low performance
overhead. The built-in hook heads are read-only, whereas the dynamic hooks
are mutable.

Not all hooks can be loaded into. Some hooks are blacklisted, and therefore
trying to load a module which plugs into those hooks will fail.

One of the big benefits with loadable security modules is to help with
"unknown unknowns". Although, livepatch is excellent, sometimes, a
surgical LSM is simpler.

It includes an example LSM that prevents specific time travel.

Changes since v3:
  * readded hook blacklisted
  * return error, rather than panic if unable to allocate memory

Changes since v2:
  * inode get/set security is readded
  * xfrm singleton hook readded
  * Security hooks are turned into an array
  * Security hooks and dynamic hooks enum is collapsed

Changes since v1:
  * It no longer allows unloading of modules
  * prctl is fixed
  * inode get/set security is removed
  * xfrm singleton hook removed


Sargun Dhillon (3):
  security: Refactor LSM hooks into an array and enum
  security: Expose a mechanism to load lsm hooks dynamically at runtime
  security: Add an example sample dynamic LSM

 include/linux/lsm_hooks.h | 459 ++++++++++++++++++++++++----------------------
 samples/Kconfig           |   6 +
 samples/Makefile          |   2 +-
 samples/lsm/Makefile      |   4 +
 samples/lsm/lsm_example.c |  33 ++++
 security/Kconfig          |   9 +
 security/inode.c          |  13 +-
 security/security.c       | 222 ++++++++++++++++++++--
 8 files changed, 508 insertions(+), 240 deletions(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
