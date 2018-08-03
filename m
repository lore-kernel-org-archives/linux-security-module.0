From: jannh@google.com (Jann Horn)
Date: Fri,  3 Aug 2018 11:36:04 +0200
Subject: [PATCH] selinux: stricter parsing in mls_context_to_sid()
Message-ID: <20180803093604.38254-1-jannh@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

mls_context_to_sid incorrectly accepted MLS context strings that are
followed by a dash and trailing garbage.

Before this change, the following command works:

# mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
none mount

After this change, it fails with the following error message in dmesg:

SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
failed for (dev tmpfs, type tmpfs) errno=-22

This is not an important bug; but it is a small quirk that was useful for
exploiting a vulnerability in fusermount.

This patch does not change the behavior when the policy does not have MLS
enabled.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/ss/mls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 39475fb455bc..2c73d612d2ee 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
 					break;
 			}
 		}
-		if (delim == '-') {
+		if (delim == '-' && l == 0) {
 			/* Extract high sensitivity. */
 			scontextp = p;
 			while (*p && *p != ':')
-- 
2.18.0.597.ga71716f1ad-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
