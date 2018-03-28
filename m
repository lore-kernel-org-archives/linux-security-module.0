From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 28 Mar 2018 01:30:01 +0000
Subject: [PATCH v2 0/2] Separate out mutable security hooks, and enable
	runtime (un)loading
Message-ID: <cover.1522185596.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


This patchset includes a couple features, as well as security features.

Security Features
The biggest security benefit of this patchset is the introduction of
read-only heads. Currently, if you have any LSMs with mutable hooks
it will render all heads, and list nodes mutable. This is a prime
place to attack, because being able to manipulate those hooks is a
way to bypass all LSMs easily.

By moving to hlist_head, it keeps a singly-linked, non-circular list.
This can always be marked as read only because we add a mutable "null"
hook. All immutable LSMs should be installed as immutable hooks and
sit before the null hook.

+------+   +-----------+   +-----------+   +-----------+   +------------------+
|      |   |           |   |           |   |           |   |                  |
| HEAD +---> Immutable +---> Immutable +---> Null hook +--->   Mutable Hook   |
|      |   |  Hook 1   |   |  Hook 2   |   |           |   |                  |
+------+   +-----------+   +-----------+   +-----------+   +------------------+
                 |               |                                  |
                 v               v                                  v
             Callback        Callback                           Callback

If LSMs have a model to be unloaded, or are compled as modules,
they should mark themselves mutable at runtime.

In order to provide safe code-unloading, there is a shared SRCU between
all security hooks. This SRCU is very cheap for runtime overhead on
reads, but there is synchronization around it for unloads. There is
only a cost to pay at unload time, which is based on the execution time
of longest chain of callbacks after synchronization begins.

Because of all of this, we can now load LSMs at runtime, so those APIs
are exposed. It is up to the module author to check if
CONFIG_SECURITY_WRITABLE_HOOKS is enabled prior to trying to load.


Changes since:
v1:
	* Add SRCU to allow for code-unloading
	* Add concurrency control around hook mutation

Sargun Dhillon (2):
  security: convert security hooks to use hlist
  security: Add mechanism to safely (un)load LSMs after boot time

 include/linux/lsm_hooks.h  | 449 ++++++++++++++++++++++-----------------------
 security/Kconfig           |   2 +-
 security/apparmor/lsm.c    |   2 +-
 security/commoncap.c       |   2 +-
 security/security.c        | 286 ++++++++++++++++++++++++++---
 security/selinux/hooks.c   |   5 +-
 security/smack/smack_lsm.c |   3 +-
 security/tomoyo/tomoyo.c   |   3 +-
 security/yama/yama_lsm.c   |   2 +-
 9 files changed, 494 insertions(+), 260 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
