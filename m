From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 1 Sep 2017 11:52:25 +0300
Subject: [PATCH] apparmor: Fix harmless off by one in map_signal_num()
Message-ID: <20170901085225.dpuirzpj7aq3yyim@mwanda>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch has no effect on runtime.

The sig_map[] array has MAXMAPPED_SIG (35) members so my static checker
complains that the <= should be <.  But in this case it's not possible
for "sig" to be more than 31 because of the "else if (sig >= SIGRTMIN)"
condition since SIGRTMIN is 32.  The last three elements, 32-34, of
sig_map[] are empty so this code works as designed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
