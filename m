From: jmorris@namei.org (James Morris)
Date: Sun, 8 Apr 2018 09:34:43 +1000 (AEST)
Subject: [GIT PULL][SECURITY] Smack updates for v4.17
Message-ID: <alpine.LRH.2.21.1804080930060.1486@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull this update for Smack, via Casey:

"One small change for Automotive Grade Linux."


The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to d54d27c9571245e4990bb8d020b109b92115683b:

  Merge branch 'smack-for-4.17' of git://github.com/cschaufler/next-smack into next-smack (2018-03-27 09:16:31 +1100)

----------------------------------------------------------------
James Morris (1):
      Merge branch 'smack-for-4.17' of git://github.com/cschaufler/next-smack into next-smack

Jos? Bollo (1):
      Smack: Handle CGROUP2 in the same way that CGROUP

 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

---
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index feada26..432e5ca 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3429,6 +3429,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (opt_dentry->d_parent == opt_dentry) {
 		switch (sbp->s_magic) {
 		case CGROUP_SUPER_MAGIC:
+		case CGROUP2_SUPER_MAGIC:
 			/*
 			 * The cgroup filesystem is never mounted,
 			 * so there's no opportunity to set the mount
@@ -3472,6 +3473,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	switch (sbp->s_magic) {
 	case SMACK_MAGIC:
 	case CGROUP_SUPER_MAGIC:
+	case CGROUP2_SUPER_MAGIC:
 		/*
 		 * Casey says that it's a little embarrassing
 		 * that the smack file system doesn't do
