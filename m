From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 8 Apr 2018 06:59:05 +0000
Subject: [PATCH v5 0/1] Safe LSM (un)loading, and immutable hooks
Message-ID: <20180408065902.GA2823@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The primary security benefit of this patchset is the introduction of read-only
hooks, even if some security modules have mutable hooks. Currently, if you have
any LSMs with mutable hooks it will render all heads, and list nodes mutable.
These are a prime place to attack because being able to manipulate those hooks
is a way to bypass all LSMs easily and to create a persistent, covert channel to
intercept nearly all calls.

If LSMs have a model to be unloaded or are compiled as modules, they should mark
themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable chain.

There is a shares SRCU between all security hooks to facilitate safe LSM-
unloading. This SRCU is very cheap for runtime overhead on reads, but there is
synchronization around it for unloads. There is only a cost to pay at unload
time, which is based on the execution time of longest chain of callbacks after
synchronization begins.

Because of all of this, we can now load LSMs at runtime, so those APIs are
exposed. It is up to the module author to check if
CONFIG_SECURITY_WRITABLE_HOOKS is enabled before trying to load. Even if this
flag is set to true at compile time, to unload modules, the
CONFIG_SECURITY_UNLOADABLE_MODULES flag must be enabled as well. This behaviour
of allowing modules to unload at runtime can be can be disabled either at boot
time or runtime by changing the security.allow_unload_hooks kernel parameter.
Once module unloading is disabled, no longer will users be able to call
delete_module on their LSM's LKM. It still allows LSMs themselves to trigger
unloading, as to not break the existing (SELinux-utilized) API.

Changes since:
v4:
	* Introduce the configuration flag "CONFIG_SECURITY_UNLOADABLE_MODULES"
	  to disable module unloading
	* Introduce the kernel parameter security.allow_unload_hooks
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

 include/linux/lsm_hooks.h |  36 ++--
 security/Kconfig          |  13 +-
 security/security.c       | 280 ++++++++++++++++++++++++++---
 security/selinux/hooks.c  | 448 ++++++++++++++++++++++++----------------------
 4 files changed, 518 insertions(+), 259 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
