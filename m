From: dhowells@redhat.com (David Howells)
Date: Thu, 09 Nov 2017 15:31:10 +0000
Subject: [RFC][PATCH] Lock down kprobes
In-Reply-To: <20171108163148.GA8882@in.ibm.com>
References: <20171108163148.GA8882@in.ibm.com>
	<14323.1510158093@warthog.procyon.org.uk>
Message-ID: <26979.1510241470@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

So this?

Thanks,
David
---
commit b5bb759d5e7f99c357b82b8066a9106b817de965
Author: David Howells <dhowells@redhat.com>
Date:   Wed Nov 8 16:14:12 2017 +0000

    Lock down kprobes
    
    Disallow the creation of kprobes when the kernel is locked down by
    preventing their registration.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

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
