From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 25 Jun 2018 09:41:22 -0700
Subject: [PULL] Smack: Mark inode instant in smack_task_to_inode
Message-ID: <813ecc0b-4a9e-22c9-b893-504936bab342@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James, would you please pull this change for 4.18.

Al Viro's /proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
created a regression in Smack xattr behavior in /proc. This fixes that problem
with a minimum of fuss.


The following changes since commit 0f8983cf97d3327531b7843c831517cac3a1b9ed:

  Smack: Fix memory leak in smack_inode_getsecctx (2018-06-05 12:16:01 -0700)

are available in the Git repository at:

  git://github.com/cschaufler/next-smack smack-for-4.18

for you to fetch changes up to aabfe8e2d9f49153bafefc82d10bcb6e1e12828d:

  Smack: Mark inode instant in smack_task_to_inode (2018-06-22 13:55:28 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

 security/smack/smack_lsm.c | 1 +
 1 file changed, 1 insertion(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
