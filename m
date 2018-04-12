From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 12 Apr 2018 18:41:43 +0000
Subject: [PATCH v6 0/1] Safe LSM (un)loading, and immutable hooks
Message-ID: <cover.1523558422.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The primary security benefit of this patchset is the introduction of
read-only hooks, even if some security modules have mutable hooks.
Currently, if you have any LSMs with mutable hooks it will render all
heads, and list nodes mutable. These are a prime place to attack because
being able to manipulate those hooks is a way to bypass all LSMs easily
and to create a persistent, covert channel to intercept nearly all
calls.

There is a shares SRCU between all security hooks to facilitate safe
LSM- unloading. This SRCU is very cheap for runtime overhead on reads,
but there is synchronization around it for unloads. There is only a cost
to pay at unload time, which is based on the execution time of longest
chain of callbacks after synchronization begins.

If CONFIG_SECURITY_WRITABLE_HOOKS is enabled, then hooks can be loaded
at runtime. The module can check the return code of security_add_hooks
to determine whether or not they can install their hooks, independently
of checking for the Kconfig value. In the future, we may make it so that
runtime hook loading is also disabled, after boot. We can do that in a
follow-up patch.

If CONFIG_SECURITY_UNREGISTRABLE_HOOKS is enabled, then hooks can be
unloaded at runtime. This behaviour can be disabled by setting
security.allow_unregister_hooks to 0. Once set, it requires a reboot
to be reset.

SELinux is exempt from the CONFIG_SECURITY_UNREGISTRABLE_HOOKS
rule, and can unregister at any time. SELinux exposes a mechanism
to disable itself, prior to policy loading. This can be disabled
at compilation time, and it depends on CONFIG_SECURITY_WRITABLE_HOOKS.
Changing this behaviour would require breaking the uapi.

This patch can allow for a new style of LSMs. There are many cases
where LSM "policies" would be better defined in some formal
programming language, like C. This is either due to flexibility,
or performance, for functions in the hot path.

It also unlocks development usecases, but those come as a secondary
benefit to the earlier feature. There has been an appetite for
out-of-tree LSMs:
http://kernsec.org/pipermail/linux-security-module-archive/2017-March/000119.html
Casey's work has been great enabling minor LSM stacking, and a variety
of LSMs have been proposed on list that haven't made it into the kernel
but fit into the minor LSM stacking model.

Thanks to Tetsuo for their review, and feedback.

Changes since:
v5:
	* Rename "CONFIG_SECURITY_UNLOADABLE_MODULES" to
	  "CONFIG_SECURITY_UNREGISTRABLE_HOOKS" which enables arbitrary hook
	  deregistration. If disabled, hooks are not allowed to deregister.
	  SELinux is exempt.
	* Rename security.allow_unload_hooks to
	  security.allow_unregister_hooks
	* Make it so that both security_add_hooks, and security_delete_hooks
	  return errors upon being unsuccessful, allowing module authors to
	  make the best decision for their use case.
	* Get rid of LSM_HOOK_INIT_MUTABLE
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

 include/linux/lsm_hooks.h  |  51 +++----
 security/Kconfig           |  18 ++-
 security/apparmor/lsm.c    |   6 +-
 security/commoncap.c       |   7 +-
 security/loadpin/loadpin.c |   2 +-
 security/security.c        | 370 ++++++++++++++++++++++++++++++++++++++++-----
 security/selinux/hooks.c   |  22 ++-
 security/smack/smack_lsm.c |   5 +-
 security/tomoyo/tomoyo.c   |   5 +-
 security/yama/yama_lsm.c   |   5 +-
 10 files changed, 413 insertions(+), 78 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
