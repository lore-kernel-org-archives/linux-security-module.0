From: colin.king@canonical.com (Colin King)
Date: Tue, 27 Mar 2018 14:35:58 +0100
Subject: [PATCH][next] apparmor: fix memory leak on buffer on error exit path
Message-ID: <20180327133558.13072-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently on the error exit path the allocated buffer is not free'd
causing a memory leak. Fix this by kfree'ing it.

Detected by CoverityScan, CID#1466876 ("Resource leaks")

Fixes: 1180b4c757aa ("apparmor: fix dangling symlinks to policy rawdata after replacement")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/apparmorfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 96bb6b73af65..949dd8a48164 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1497,8 +1497,10 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
 	}
 
 	error = snprintf(s, size, "raw_data/%s/%s", dirname, fname);
-	if (error >= size || error < 0)
+	if (error >= size || error < 0) {
+		kfree(buffer);
 		return ERR_PTR(-ENAMETOOLONG);
+	}
 
 	return buffer;
 }
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
