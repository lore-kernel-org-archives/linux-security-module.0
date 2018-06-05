From: jmorris@namei.org (James Morris)
Date: Wed, 6 Jun 2018 04:21:25 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: general updates for v4.18
Message-ID: <alpine.LRH.2.21.1806060415150.9942@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these general security subsystem updates for v4.18.

Summary:

- Incorporate new socketpair() hook into LSM and wire up the SELinux and 
  Smack modules.  From David Herrmann:

   "The idea is to allow SO_PEERSEC to be called on AF_UNIX sockets 
    created via socketpair(2), and return the same information as if you 
    emulated socketpair(2) via a temporary listener socket. Right now 
    SO_PEERSEC will return the unlabeled credentials for a socketpair, 
    rather than the actual credentials of the creating process."

- Sargun Dhillon removed the unused security_settime LSM hook.

- Tycho Andersen removed some stack allocated arrays from the keys code.

---

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

----------------------------------------------------------------
David Herrmann (3):
      security: add hook for socketpair()
      net: hook socketpair() into LSM
      selinux: provide socketpair callback

James Morris (2):
      Merge tag 'v4.17-rc2' into next-general
      Merge tag 'v4.17-rc3' into next-general

Sargun Dhillon (1):
      security: remove security_settime

Tom Gundersen (1):
      smack: provide socketpair callback

Tycho Andersen (3):
      big key: get rid of stack array allocation
      dh key: get rid of stack allocated array
      dh key: get rid of stack allocated array for zeroes

 include/linux/lsm_hooks.h  |  7 +++++++
 include/linux/security.h   | 21 +++++++--------------
 net/socket.c               |  7 +++++++
 security/keys/big_key.c    | 11 ++++++++++-
 security/keys/dh.c         | 35 +++++++++++++----------------------
 security/security.c        |  6 ++++++
 security/selinux/hooks.c   | 13 +++++++++++++
 security/smack/smack_lsm.c | 22 ++++++++++++++++++++++
 8 files changed, 85 insertions(+), 37 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
