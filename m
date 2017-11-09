From: dhowells@redhat.com (David Howells)
Date: Thu,  9 Nov 2017 17:34:11 +0000
Subject: [PATCH 28/30] bpf: Restrict kernel image access functions when the
	kernel is locked down
In-Reply-To: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
Message-ID: <151024885109.28329.17425439521329322621.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program and kernel memory to be altered without
restriction.

Completely prohibit the use of BPF when the kernel is locked down.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netdev at vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
---

 kernel/bpf/syscall.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 25d074920a00..fa58ad74cde6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1458,6 +1458,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (!capable(CAP_SYS_ADMIN) && sysctl_unprivileged_bpf_disabled)
 		return -EPERM;
 
+	if (kernel_is_locked_down("BPF"))
+		return -EPERM;
+
 	err = check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
