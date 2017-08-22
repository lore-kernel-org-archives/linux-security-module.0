From: colin.king@canonical.com (Colin King)
Date: Tue, 22 Aug 2017 22:58:32 +0100
Subject: [PATCH] apparmor: fix off-by-one comparison on MAXMAPPED_SIG
Message-ID: <20170822215832.5504-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a an off-by-one comparision on sig against MAXMAPPED_SIG
that can lead to a read outside the sig_map array if sig
is MAXMAPPED_SIG. Fix this.

Detected with cppcheck:
"Either the condition 'sig<=35' is redundant or the array 'sig_map[35]'
is accessed at index 35, which is out of bounds."

Fixes: c6bf1adaecaa ("apparmor: add the ability to mediate signals")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index 66fb9ede9447..5091c78062e4 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -128,7 +128,7 @@ static inline int map_signal_num(int sig)
 		return SIGUNKNOWN;
 	else if (sig >= SIGRTMIN)
 		return sig - SIGRTMIN + 128;	/* rt sigs mapped to 128 */
-	else if (sig <= MAXMAPPED_SIG)
+	else if (sig < MAXMAPPED_SIG)
 		return sig_map[sig];
 	return SIGUNKNOWN;
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
