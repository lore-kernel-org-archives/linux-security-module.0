From: dhowells@redhat.com (David Howells)
Date: Thu, 09 Nov 2017 16:44:42 +0000
Subject: [RFC][PATCH] Lock down kprobes
Message-ID: <11290.1510245882@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

I need to lock down kprobes under secure boot conditions as part of the patch
series that can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=efi-lock-down

Can you tell me that if the attached patch is sufficient to the cause?

Thanks,
David
---
commit ffb3484d6e0f1d625f8e84a6a19c139a28a52499
Author: David Howells <dhowells@redhat.com>
Date:   Wed Nov 8 16:14:12 2017 +0000

    Lock down kprobes
    
    Disallow the creation of kprobes when the kernel is locked down by
    preventing their registration.  This prevents kprobes from being used to
    access kernel memory, either to make modifications or to steal crypto data.
    
    Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
