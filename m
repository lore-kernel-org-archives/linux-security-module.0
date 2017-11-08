From: dhowells@redhat.com (David Howells)
Date: Wed, 08 Nov 2017 16:21:33 +0000
Subject: [RFC][PATCH] Lock down kprobes
Message-ID: <14323.1510158093@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

I need to lock down kprobes under secure boot conditions as part of the patch
series that can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=efi-lock-down

Can you tell me that if the attached patch is sufficient to the cause?

---
commit 9b736b76fbd7b23b54b4340e80c66f87df54016c
Author: David Howells <dhowells@redhat.com>
Date:   Wed Nov 8 16:14:12 2017 +0000

    Lock down kprobes
    
    Disallow the creation of kprobes when the kernel is locked down.  This
    patch restricts writing to /sys/kernel/debug/tracing/kprobe_events; writing
    to /sys/kernel/debug/kprobes/enabled is disabled by the patch that locks
    down debugfs.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8a907e12b6b9..b44f046d2582 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -907,6 +907,9 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	return traceprobe_probes_write(file, buffer, count, ppos,
 			create_trace_kprobe);
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
