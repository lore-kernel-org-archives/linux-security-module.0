From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 27 Mar 2017 19:26:12 +0900
Subject: [RFC PATCH] smack: Use __GFP_NOFAIL than panic()
Message-ID: <201703271926.JJI69202.MJVQFSFLOFtOOH@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>From dbdac6060ac1a741cb95f370121339bcc4176aea Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 27 Mar 2017 14:06:52 +0900
Subject: [RFC PATCH] smack: Use __GFP_NOFAIL than panic()

smk_cipso_doi() is called by two locations; upon boot up and upon writing
to /smack/doi interface.

It is theoretically possible that kmalloc(GFP_KERNEL) for the latter fails
due to being killed by the OOM killer or memory allocation fault injection.
Although use of __GFP_NOFAIL is not recommended, is it tolerable to use
__GFP_NOFAIL when adding a recovery path for unlikely failure is not
worthwhile but allocation is single-shot and amount of memory to allocate
is known to be small enough?

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/smack/smackfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 366b835..4e45a77 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -721,9 +721,7 @@ static void smk_cipso_doi(void)
 		printk(KERN_WARNING "%s:%d remove rc = %d\n",
 		       __func__, __LINE__, rc);
 
-	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
-	if (doip == NULL)
-		panic("smack:  Failed to initialize cipso DOI.\n");
+	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
 	doip->map.std = NULL;
 	doip->doi = smk_cipso_doi_value;
 	doip->type = CIPSO_V4_MAP_PASS;
-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
