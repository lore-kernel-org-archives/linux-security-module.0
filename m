From: dingxiang@cmss.chinamobile.com (Ding Xiang)
Date: Tue,  4 Sep 2018 16:41:39 +0800
Subject: [PATCH] security: tomoyo: Fix obsolete function
Message-ID: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

simple_strtoul is obsolete, and use kstrtouint instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 security/tomoyo/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 03923a1..9b38f94 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1660,7 +1660,8 @@ static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
 	head->r.eof = true;
 	if (tomoyo_str_starts(&buf, "global-pid "))
 		global_pid = true;
-	pid = (unsigned int) simple_strtoul(buf, NULL, 10);
+	if (kstrtouint(buf, 10, &pid))
+		return;
 	rcu_read_lock();
 	if (global_pid)
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
-- 
1.9.1
