From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2018 16:09:02 +0200
Subject: [PATCH] apparmor: remove unused label
Message-ID: <20180823140917.3060915-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

After the corresponding 'goto' was removed, we get a warning
for the 'fail' label:

security/apparmor/policy_unpack.c: In function 'unpack_dfa':
security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]

Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3647b5834ace..96d8cf68ce65 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
 
 	return dfa;
 
-fail:
 	aa_put_dfa(dfa);
 	return ERR_PTR(-EPROTO);
 }
-- 
2.18.0
