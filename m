From: jmorris@namei.org (James Morris)
Date: Fri, 8 Jun 2018 03:53:56 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: Smack updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080351390.27121@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull this bugfix for the Smack subsystem.

>From Casey: "It's one simple patch that fixes a memory leak in kernfs and 
labeled NFS."

---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to 2531a0cd2dd9dc2b0da9fabb950e2db308ce78b8:

  Merge branch 'smack-for-4.18' of https://github.com/cschaufler/next-smack into next-smack (2018-06-05 13:18:58 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Fix memory leak in smack_inode_getsecctx

James Morris (1):
      Merge branch 'smack-for-4.18' of https://github.com/cschaufler/next-smack into next-smack

 security/smack/smack_lsm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
