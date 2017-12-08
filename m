From: sargun@sargun.me (Sargun Dhillon)
Date: Fri, 8 Dec 2017 04:23:49 +0000
Subject: [RFC v2 0/3] Safe, dynamically loadable LSM
Message-ID: <cover.1512702006.git.sargun@netflix.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset introduces safe dynamic LSM support. These are currently
not unloadable, until we figure out a use case that needs that. Adding
an unload hook is trivial given the way the patch is written.

Currently, this maintains an entirely separate mechanism to attach hooks
because the hooks are behind managed static_keys to prevent overhead.
This is also done so sealable memory support could be added at a later
point. The callbacks currently include a percpu_counter, but that could
sit outside of the struct itself. This may also have a benefit that these
counters, could have __cacheline_aligned_in_smp. Although, in my testing
I was unable to find much performance delta with percpu_counters that
were not aligned.

The point of this security feature is to resolve "unknown unknowns"
as well. Although, livepatch is excellent, sometimes, a surgical
LSM is simpler.

It includes an example LSM that prevents specific time travel.

Changes since v1:
  * It no longer allows unloading of modules
  * prctl is fixed
  * inode get/set security is removed
  * xfrm singleton hook removed

Sargun Dhillon (3):
  security: Add safe, dynamic (runtime-loadable) hook support
  LSM: Add statistics about the invocation of dynamic hooks
  LSM: Add an example sample dynamic LSM

 include/linux/lsm_hooks.h | 254 ++++++++++++++++++++++++++++++++++++++++
 samples/Kconfig           |   6 +
 samples/Makefile          |   2 +-
 samples/lsm/Makefile      |   4 +
 samples/lsm/lsm_example.c |  39 +++++++
 security/Kconfig          |  16 +++
 security/Makefile         |   2 +
 security/dynamic.c        | 291 ++++++++++++++++++++++++++++++++++++++++++++++
 security/dynamic.h        |  32 +++++
 security/dynamicfs.c      | 109 +++++++++++++++++
 security/inode.c          |   2 +
 security/security.c       | 114 ++++++++++++++++--
 12 files changed, 863 insertions(+), 8 deletions(-)
 create mode 100644 samples/lsm/Makefile
 create mode 100644 samples/lsm/lsm_example.c
 create mode 100644 security/dynamic.c
 create mode 100644 security/dynamic.h
 create mode 100644 security/dynamicfs.c

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
