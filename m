From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 19 Sep 2018 17:20:10 -0700
Subject: [PATCH v3 04/16] SELinux: Remove cred security blob poisoning
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Message-ID: <de3681aa-3e2e-a3dc-bc1d-9c7edb2f12a6@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

SELinux: Remove cred security blob poisoning

The SELinux specific credential poisioning only makes sense
if SELinux is managing the credentials. As the intent of this
patch set is to move the blob management out of the modules
and into the infrastructure, the SELinux specific code has
to go. The poisioning could be introduced into the infrastructure
at some later date.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/cred.c            | 13 -------------
 security/selinux/hooks.c |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..fa2061ee4955 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
 {
 	if (cred->magic != CRED_MAGIC)
 		return true;
-#ifdef CONFIG_SECURITY_SELINUX
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
-			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
-		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
-			return true;
-	}
-#endif
 	return false;
 }
 EXPORT_SYMBOL(creds_are_invalid);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9d6cdd21acb6..80614ca25a2b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3920,12 +3920,6 @@ static void selinux_cred_free(struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
 	kfree(tsec);
 }
 
-- 
2.17.1
