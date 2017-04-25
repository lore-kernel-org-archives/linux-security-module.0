From: tixxdz@gmail.com (Djalal Harouni)
Date: Tue, 25 Apr 2017 14:23:57 +0200
Subject: [PATCH RFC v2 5/6] proc: instantiate only pids that we can ptrace on
	'limit_pids=1' mount option
In-Reply-To: <1493123038-30590-1-git-send-email-tixxdz@gmail.com>
References: <1493123038-30590-1-git-send-email-tixxdz@gmail.com>
Message-ID: <1493123038-30590-6-git-send-email-tixxdz@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If "limit_pids=1" mount option is set then do not instantiate pids that
we can not ptrace. "limit_pids=1" means that procfs should only contain
pids that the caller can ptrace.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 fs/proc/base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2e0f661..a663284 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3149,6 +3149,7 @@ struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsign
 	unsigned tgid;
 	struct proc_fs_info *fs_info = proc_sb(dir->i_sb);
 	struct pid_namespace *ns = fs_info->pid_ns;
+	int limit_pids = proc_fs_limit_pids(fs_info);
 
 	tgid = name_to_int(&dentry->d_name);
 	if (tgid == ~0U)
@@ -3162,7 +3163,15 @@ struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsign
 	if (!task)
 		goto out;
 
+	/* Limit procfs to only ptracable tasks */
+	if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
+		cond_resched();
+		if (!has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS))
+			goto out_put_task;
+	}
+
 	result = proc_pid_instantiate(dir, dentry, task, NULL);
+out_put_task:
 	put_task_struct(task);
 out:
 	return ERR_PTR(result);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
