From: tyhicks@canonical.com (Tyler Hicks)
Date: Wed,  2 May 2018 15:53:17 +0000
Subject: [PATCH v2 1/4] seccomp: Separate read and write code for
	actions_logged sysctl
In-Reply-To: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
Message-ID: <1525276400-7161-2-git-send-email-tyhicks@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Break the read and write paths of the kernel.seccomp.actions_logged
sysctl into separate functions to maintain readability. An upcoming
change will need to audit writes, but not reads, of this sysctl which
would introduce too many conditional code paths on whether or not the
'write' parameter evaluates to true.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 kernel/seccomp.c | 60 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index dc77548..f4afe67 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1199,48 +1199,64 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
 	return true;
 }
 
-static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
-					  void __user *buffer, size_t *lenp,
-					  loff_t *ppos)
+static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
+			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
 	struct ctl_table table;
+
+	memset(names, 0, sizeof(names));
+
+	if (!seccomp_names_from_actions_logged(names, sizeof(names),
+					       seccomp_actions_logged))
+		return -EINVAL;
+
+	table = *ro_table;
+	table.data = names;
+	table.maxlen = sizeof(names);
+	return proc_dostring(&table, 0, buffer, lenp, ppos);
+}
+
+static int write_actions_logged(struct ctl_table *ro_table, void __user *buffer,
+				size_t *lenp, loff_t *ppos)
+{
+	char names[sizeof(seccomp_actions_avail)];
+	struct ctl_table table;
+	u32 actions_logged;
 	int ret;
 
-	if (write && !capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	memset(names, 0, sizeof(names));
 
-	if (!write) {
-		if (!seccomp_names_from_actions_logged(names, sizeof(names),
-						       seccomp_actions_logged))
-			return -EINVAL;
-	}
-
 	table = *ro_table;
 	table.data = names;
 	table.maxlen = sizeof(names);
-	ret = proc_dostring(&table, write, buffer, lenp, ppos);
+	ret = proc_dostring(&table, 1, buffer, lenp, ppos);
 	if (ret)
 		return ret;
 
-	if (write) {
-		u32 actions_logged;
-
-		if (!seccomp_actions_logged_from_names(&actions_logged,
-						       table.data))
-			return -EINVAL;
-
-		if (actions_logged & SECCOMP_LOG_ALLOW)
-			return -EINVAL;
+	if (!seccomp_actions_logged_from_names(&actions_logged, table.data))
+		return -EINVAL;
 
-		seccomp_actions_logged = actions_logged;
-	}
+	if (actions_logged & SECCOMP_LOG_ALLOW)
+		return -EINVAL;
 
+	seccomp_actions_logged = actions_logged;
 	return 0;
 }
 
+static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
+					  void __user *buffer, size_t *lenp,
+					  loff_t *ppos)
+{
+	if (write)
+		return write_actions_logged(ro_table, buffer, lenp, ppos);
+	else
+		return read_actions_logged(ro_table, buffer, lenp, ppos);
+}
+
 static struct ctl_path seccomp_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "seccomp", },
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
