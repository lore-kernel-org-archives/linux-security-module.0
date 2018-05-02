From: tyhicks@canonical.com (Tyler Hicks)
Date: Wed,  2 May 2018 15:53:18 +0000
Subject: [PATCH v2 2/4] seccomp: Configurable separator for the actions_logged
	string
In-Reply-To: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
Message-ID: <1525276400-7161-3-git-send-email-tyhicks@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The function that converts a bitmask of seccomp actions that are
allowed to be logged is currently only used for constructing the display
string for the kernel.seccomp.actions_logged sysctl. That string wants a
space character to be used for the separator between actions.

A future patch will make use of the same function for building a string
that will be sent to the audit subsystem for tracking modifications to
the kernel.seccomp.actions_logged sysctl. That string will need to use a
comma as a separator. This patch allows the separator character to be
configurable to meet both needs.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 kernel/seccomp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f4afe67..b36ac1e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1135,10 +1135,11 @@ static const struct seccomp_log_name seccomp_log_names[] = {
 };
 
 static bool seccomp_names_from_actions_logged(char *names, size_t size,
-					      u32 actions_logged)
+					      u32 actions_logged,
+					      const char *sep)
 {
 	const struct seccomp_log_name *cur;
-	bool append_space = false;
+	bool append_sep = false;
 
 	for (cur = seccomp_log_names; cur->name && size; cur++) {
 		ssize_t ret;
@@ -1146,15 +1147,15 @@ static bool seccomp_names_from_actions_logged(char *names, size_t size,
 		if (!(actions_logged & cur->log))
 			continue;
 
-		if (append_space) {
-			ret = strscpy(names, " ", size);
+		if (append_sep) {
+			ret = strscpy(names, sep, size);
 			if (ret < 0)
 				return false;
 
 			names += ret;
 			size -= ret;
 		} else
-			append_space = true;
+			append_sep = true;
 
 		ret = strscpy(names, cur->name, size);
 		if (ret < 0)
@@ -1208,7 +1209,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
 	memset(names, 0, sizeof(names));
 
 	if (!seccomp_names_from_actions_logged(names, sizeof(names),
-					       seccomp_actions_logged))
+					       seccomp_actions_logged, " "))
 		return -EINVAL;
 
 	table = *ro_table;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
