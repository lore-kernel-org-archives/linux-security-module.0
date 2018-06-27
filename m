From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Wed, 27 Jun 2018 23:02:18 +0300
Subject: [PATCH] proc: save 2 atomic ops on write to "/proc/*/attr/*"
Message-ID: <20180627200218.GF18113@avx2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Code checks if write is done by current to its own attributes.
For that get/put pair is unnecessary as it can be done under RCU.

Note: rcu_read_unlock() can be done even earlier since pointer to a task
is not dereferenced. It depends if /proc code should look scary or not:

	rcu_read_lock();
	task = pid_task(...);
	rcu_read_unlock();
	if (!task)
		return -ESRCH;
	if (task != current)
		return -EACCESS:

P.S.: rename "length" variable.	Code like this

	length = -EINVAL;

should not exist.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2517,47 +2517,47 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 				   size_t count, loff_t *ppos)
 {
 	struct inode * inode = file_inode(file);
+	struct task_struct *task;
 	void *page;
-	ssize_t length;
-	struct task_struct *task = get_proc_task(inode);
-
-	length = -ESRCH;
-	if (!task)
-		goto out_no_task;
+	int rv;
 
+	rcu_read_lock();
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
 	/* A task may only write its own attributes. */
-	length = -EACCES;
-	if (current != task)
-		goto out;
+	if (current != task) {
+		rcu_read_unlock();
+		return -EACCES;
+	}
+	rcu_read_unlock();
 
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
 	/* No partial writes. */
-	length = -EINVAL;
 	if (*ppos != 0)
-		goto out;
+		return -EINVAL;
 
 	page = memdup_user(buf, count);
 	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
+		rv = PTR_ERR(page);
 		goto out;
 	}
 
 	/* Guard against adverse ptrace interaction */
-	length = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
-	if (length < 0)
+	rv = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
+	if (rv < 0)
 		goto out_free;
 
-	length = security_setprocattr(file->f_path.dentry->d_name.name,
-				      page, count);
+	rv = security_setprocattr(file->f_path.dentry->d_name.name, page, count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
 	kfree(page);
 out:
-	put_task_struct(task);
-out_no_task:
-	return length;
+	return rv;
 }
 
 static const struct file_operations proc_pid_attr_operations = {
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
