From: jmorris@namei.org (James Morris)
Date: Sun, 24 Sep 2017 15:12:59 +1000 (AEST)
Subject: [GIT PULL] security: general update for v4.14
Message-ID: <alpine.LRH.2.21.1709241501150.3941@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This is the remaining "general" change in the security tree for v4.14, 
following the direct merging of SELinux (+ TOMOYO), AppArmor, and seccomp. 

That's everything now for the security tree except IMA, which will follow 
shortly (I've been traveling for the past week with patchy internet).


Please pull.

---

The following changes since commit 53a2ebaaabc1eb8458796fec3bc1e0e80746b642:

  sync to Linus v4.13-rc2 for subsystem developers to work against (2017-07-25 10:44:18 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to ab5348c9c23cd253f5902980d2d8fe067dc24c82:

  security: fix description of values returned by cap_inode_need_killpriv (2017-09-23 21:15:41 -0700)

----------------------------------------------------------------
Stefan Berger (1):
      security: fix description of values returned by cap_inode_need_killpriv

 security/commoncap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
