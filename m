From: dhowells@redhat.com (David Howells)
Date: Thu, 19 Oct 2017 15:52:49 +0100
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when the
	kernel is locked down
In-Reply-To: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
Message-ID: <150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Chun-Yi Lee <jlee@suse.com>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program.  Prohibit those functions when the kernel is
locked down.

Signed-off-by: Chun-Yi Lee <jlee@suse.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netdev at vger.kernel.org
---

 kernel/trace/bpf_trace.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dc498b605d5d..35e85a3fdb37 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -65,6 +65,11 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	if (kernel_is_locked_down("BPF")) {
+		memset(dst, 0, size);
+		return -EPERM;
+	}
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -84,6 +89,9 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	if (kernel_is_locked_down("BPF"))
+		return -EPERM;
+
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -143,6 +151,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (fmt[--fmt_size] != 0)
 		return -EINVAL;
 
+	if (kernel_is_locked_down("BPF"))
+		return __trace_printk(1, fmt, 0, 0, 0);
+
 	/* check format string for allowed specifiers */
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
