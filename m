From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 7 May 2017 14:03:09 +0200
Subject: [PATCH 2/2] apparmorfs: Use seq_putc() in two functions
In-Reply-To: <b58df574-97f1-dbc5-2198-fe4734f24b8e@users.sourceforge.net>
References: <b58df574-97f1-dbc5-2198-fe4734f24b8e@users.sourceforge.net>
Message-ID: <22def82a-4cd8-a673-f35f-012cc36fe797@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 May 2017 13:50:28 +0200

Two single characters (line breaks) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/apparmor/apparmorfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index b4d83e0bc651..41e427a4f051 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -494,7 +494,7 @@ static int aa_fs_seq_hash_show(struct seq_file *seq, void *v)
 	if (profile->hash) {
 		for (i = 0; i < size; i++)
 			seq_printf(seq, "%.2x", profile->hash[i]);
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 	}
 	aa_put_profile(profile);
 
@@ -602,7 +602,7 @@ static int aa_fs_seq_raw_hash_show(struct seq_file *seq, void *v)
 	if (profile->rawdata->hash) {
 		for (i = 0; i < size; i++)
 			seq_printf(seq, "%.2x", profile->rawdata->hash[i]);
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 	}
 	aa_put_profile(profile);
 
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
