From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 22 Jun 2018 10:54:45 -0700
Subject: [PATCH] Smack: Mark inode instant in smack_task_to_inode
In-Reply-To: <20180622145259.GZ30522@ZenIV.linux.org.uk>
References: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
	<20180622145259.GZ30522@ZenIV.linux.org.uk>
Message-ID: <b1bccdb2-032f-cdd6-5303-be8412629d4d@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Smack: Mark inode instant in smack_task_to_inode

/proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
resulted in smack_task_to_inode() being called before smack_d_instantiate.
This resulted in the smk_inode value being ignored, even while present
for files in /proc/self. Marking the inode as instant here fixes that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7ad226018f51..19de675d4504 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2296,6 +2296,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 	struct smack_known *skp = smk_of_task_struct(p);
 
 	isp->smk_inode = skp;
+	isp->smk_flags |= SMK_INODE_INSTANT;
 }
 
 /*

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
