From: colin.king@canonical.com (Colin King)
Date: Fri,  4 May 2018 15:15:11 +0100
Subject: [PATCH][next] apparmor: fix error return check with a u32 being less
	than zero
Message-ID: <20180504141511.19793-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for *seclen being less than zero for an error condtion check
is never true as it is a u32 and hence cannot be less than zero. Fix
this by using an int ret for error return checking and assigning *seclen
to this.

Detected by CoverityScan, CID#1468514 ("Unsigned comparison against 0")

Fixes: c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/secid.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 502924853986..9c431e9a9836 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -142,6 +142,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
 	struct aa_label *label = aa_secid_to_label(secid);
+	int ret;
 
 	AA_BUG(!secdata);
 	AA_BUG(!seclen);
@@ -150,16 +151,17 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 		return -EINVAL;
 
 	if (secdata)
-		*seclen = aa_label_asxprint(secdata, root_ns, label,
-					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-					    FLAG_HIDDEN_UNCONFINED |
-					    FLAG_ABS_ROOT, GFP_ATOMIC);
+		ret = aa_label_asxprint(secdata, root_ns, label,
+					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
+					FLAG_HIDDEN_UNCONFINED |
+					FLAG_ABS_ROOT, GFP_ATOMIC);
 	else
-		*seclen = aa_label_snxprint(NULL, 0, root_ns, label,
-					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-					    FLAG_HIDDEN_UNCONFINED |
-					    FLAG_ABS_ROOT);
-	if (*seclen < 0)
+		ret = aa_label_snxprint(NULL, 0, root_ns, label,
+					FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
+					FLAG_HIDDEN_UNCONFINED |
+					FLAG_ABS_ROOT);
+	*seclen = ret;
+	if (ret < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
