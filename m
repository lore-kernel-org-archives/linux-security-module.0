From: dhowells@redhat.com (David Howells)
Date: Thu,  9 Nov 2017 17:34:03 +0000
Subject: [PATCH 27/30] Lock down kprobes
In-Reply-To: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
Message-ID: <151024884369.28329.1118657718685892825.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Disallow the creation of kprobes when the kernel is locked down by
preventing their registration.  This prevents kprobes from being used to
access kernel memory, either to make modifications or to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/kprobes.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a1606a4224e1..f06023b0936c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1530,6 +1530,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
