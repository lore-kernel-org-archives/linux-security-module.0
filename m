From: dhowells@redhat.com (David Howells)
Date: Wed, 11 Apr 2018 17:27:03 +0100
Subject: [PATCH 22/24] bpf: Restrict kernel image access functions when the
	kernel is locked down
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
Message-ID: <152346402306.4030.13915529680179697046.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program.

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
index 0244973ee544..7457f2676c6d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2031,6 +2031,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
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
