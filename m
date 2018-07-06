From: tyhicks@canonical.com (Tyler Hicks)
Date: Fri,  6 Jul 2018 05:25:01 +0000
Subject: [PATCH 2/2] apparmor: Fully initialize aa_perms struct when answering
	userspace query
In-Reply-To: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
References: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
Message-ID: <1530854701-7348-3-git-send-email-tyhicks@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Fully initialize the aa_perms struct in profile_query_cb() to avoid the
potential of using an uninitialized struct member's value in a response
to a query from userspace.

Detected by CoverityScan CID#1415126 ("Uninitialized scalar variable")

Fixes: 4f3b3f2d79a4 ("apparmor: add profile permission query ability")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 security/apparmor/apparmorfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 949dd8a48164..e09fe4d7307c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -603,7 +603,7 @@ static const struct file_operations aa_fs_ns_revision_fops = {
 static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 			     const char *match_str, size_t match_len)
 {
-	struct aa_perms tmp;
+	struct aa_perms tmp = { };
 	struct aa_dfa *dfa;
 	unsigned int state = 0;
 
@@ -613,7 +613,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 		dfa = profile->file.dfa;
 		state = aa_dfa_match_len(dfa, profile->file.start,
 					 match_str + 1, match_len - 1);
-		tmp = nullperms;
 		if (state) {
 			struct path_cond cond = { };
 
@@ -627,8 +626,6 @@ static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
 					 match_str, match_len);
 		if (state)
 			aa_compute_perms(dfa, state, &tmp);
-		else
-			tmp = nullperms;
 	}
 	aa_apply_modes_to_perms(profile, &tmp);
 	aa_perms_accum_raw(perms, &tmp);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
