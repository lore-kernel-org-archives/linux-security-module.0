From: christian@brauner.io (Christian Brauner)
Date: Sun, 19 Aug 2018 20:44:03 +0200
Subject: [PATCH] security/capabilities: remove check for -EINVAL
Message-ID: <20180819184403.5343-1-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

bprm_caps_from_vfs_caps() does not return -EINVAL anymore so remove the rc
== -EINVAL check.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 security/commoncap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4c33abd9959..6012f0cd8157 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -684,9 +684,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	}
 
 	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
-	if (rc == -EINVAL)
-		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
-		       __func__, rc, bprm->filename);
 
 out:
 	if (rc)
-- 
2.17.1
