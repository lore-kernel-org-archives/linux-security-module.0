From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 09:23:22 -0700
Subject: [PATCH security-next v2 10/26] LSM: Don't ignore initialization
	failures
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Message-ID: <20180920162338.21060-11-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ee49b921d750..1f055936a746 100644
--- a/security/security.c
+++ b/security/security.c
@@ -55,10 +55,12 @@ static bool debug __initdata;
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
+	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		init_debug("initializing %s\n", lsm->name);
-		lsm->init();
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
 	}
 }
 
-- 
2.17.1
