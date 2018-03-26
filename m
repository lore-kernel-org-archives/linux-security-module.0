From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 19:24:03 +0000
Subject: [RFC PATCH 0/2] Add mechanism to write protect all unloadable
	security modules
Message-ID: <cover.1522091329.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset consists of three features:
1) Not using a circular list for security hook heads.
   This has the benefit of allowing us to remove hooks at the tail of the
   chain, without interfering with the head. In turn, this allows us to always
   mark the head as read-only.

   This also saves space, as there is only one pointer, not two.

2) Adding an intermediate set of mutable hooks.
   In the linked-list of hooks, there will be the:
   head->write protected hooks->noop mutable hook->mutable hooks

   This intermediate hook makes it so that we can prevent built-in
   LSMs from being modified.

3) Making it so you can load modules after boot time.

Sargun Dhillon (2):
  security: convert security hooks to use hlist
  security: Add mechanism to (un)load LSMs after boot time

 include/linux/lsm_hooks.h  | 435 +++++++++++++++++++++++----------------------
 security/apparmor/lsm.c    |   2 +-
 security/commoncap.c       |   2 +-
 security/security.c        | 105 +++++++++--
 security/selinux/hooks.c   |   5 +-
 security/smack/smack_lsm.c |   3 +-
 security/tomoyo/tomoyo.c   |   3 +-
 security/yama/yama_lsm.c   |   2 +-
 8 files changed, 315 insertions(+), 242 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
