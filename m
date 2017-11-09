From: dhowells@redhat.com (David Howells)
Date: Thu, 09 Nov 2017 16:42:12 +0000
Subject: [RFC][PATCH] Lock down ftrace
Message-ID: <11100.1510245732@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

I (may) need to lock down ftrace under secure boot conditions as part of the
patch series that can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=efi-lock-down

Can you tell me that if the attached patch is sufficient to the cause?

Thanks,
David
---
commit 3fb4590c0ad0a751b2090c489df79193510e6aaa
Author: David Howells <dhowells@redhat.com>
Date:   Wed Nov 8 15:41:02 2017 +0000

    Lock down ftrace
    
    Disallow the use of ftrace when the kernel is locked down.  This patch
    turns off ftrace_enabled late in the kernel boot so that the selftest can
    still be potentially be run.
    
    The sysctl that controls ftrace_enables is also disallowed when the kernel
    is locked down.  If the lockdown is lifted, then the sysctl can be used to
    reenable ftrace - if ftrace was compiled with CONFIG_DYNAMIC_FTRACE, that
    is; if it wasn't then it won't be possible to reenable it.
    
    This prevents crypto data theft by analysis of execution patterns, and, if
    in future ftrace also logs the register contents at the time, will prevent
    data theft by that mechanism also.
    
    Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6abfafd7f173..9c7135963d80 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6508,6 +6508,9 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 {
 	int ret = -ENODEV;
 
+	if (kernel_is_locked_down("Use of ftrace"))
+		return -EPERM;
+
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
@@ -6896,3 +6899,22 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	kfree(ret_stack);
 }
 #endif
+
+#ifdef CONFIG_LOCK_DOWN_KERNEL
+static int __init ftrace_lock_down(void)
+{
+	mutex_lock(&ftrace_lock);
+
+	if (!ftrace_disabled && ftrace_enabled &&
+	    kernel_is_locked_down("Use of ftrace")) {
+		ftrace_enabled = false;
+		last_ftrace_enabled = false;
+		ftrace_trace_function = ftrace_stub;
+		ftrace_shutdown_sysctl();
+	}
+
+	mutex_unlock(&ftrace_lock);
+	return 0;
+}
+late_initcall(ftrace_lock_down);
+#endif
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
