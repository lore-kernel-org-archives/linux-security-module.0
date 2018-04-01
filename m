From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 1 Apr 2018 05:41:01 +0000
Subject: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
Message-ID: <cover.1522560550.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The biggest security benefit of this patchset is the introduction of
read-only hooks, even if some security modules have mutable hooks.
Currently, if you have any LSMs with mutable hooks it will render all heads, and
list nodes mutable. These are a prime place to attack, because being able to
manipulate those hooks is a way to bypass all LSMs easily, and to create a
persistent, covert channel to intercept nearly all calls.


If LSMs have a model to be unloaded, or are compled as modules, they should mark
themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
chain.

In order to provide safe code-unloading, there is a shared SRCU between
all security hooks. This SRCU is very cheap for runtime overhead on
reads, but there is synchronization around it for unloads. There is
only a cost to pay at unload time, which is based on the execution time
of longest chain of callbacks after synchronization begins.

Because of all of this, we can now load LSMs at runtime, so those APIs
are exposed. It is up to the module author to check if
CONFIG_SECURITY_WRITABLE_HOOKS is enabled prior to trying to load.

Thanks to Casey to providing great feedback on the patchset.

Changes since:
v3:
	* Instead of taking the approach of a "null hook", using the approach of
	  a second set of hooks -- this was mostly done through the
	  FOR_EACH_SECURITY_HOOK_MUTABLE macro, which gets compiled out if
	  CONFIG_SECURITY_WRITABLE_HOOKS is disabled.
v2:
	* Split out hlist_head patch
	* Apply Tetsuo's changes to clean up functions which are not
      covered by call_int_hook / call_void_hook
	* Disable NULL hook checking when uneeded
v1:
	* Add SRCU to allow for code-unloading
	* Add concurrency control around hook mutation


Sargun Dhillon (1):
  security: Add mechanism to safely (un)load LSMs after boot time

 include/linux/lsm_hooks.h |  24 +--
 security/Kconfig          |   2 +-
 security/security.c       | 206 ++++++++++++++++++---
 security/selinux/hooks.c  | 451 ++++++++++++++++++++++++----------------------
 4 files changed, 424 insertions(+), 259 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
