From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 17:57:08 +0100
Subject: [PATCH 02/38] Annotate hardware config module parameters in
	arch/x86/mm/
In-Reply-To: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
Message-ID: <149141142839.29162.10470212173396183651.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in arch/x86/mm/.

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86 at kernel.org
cc: linux-kernel at vger.kernel.org
cc: nouveau at lists.freedesktop.org
---

 arch/x86/mm/testmmiotrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index 38868adf07ea..f6ae6830b341 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -9,7 +9,7 @@
 #include <linux/mmiotrace.h>
 
 static unsigned long mmio_address;
-module_param(mmio_address, ulong, 0);
+module_param_hw(mmio_address, ulong, iomem, 0);
 MODULE_PARM_DESC(mmio_address, " Start address of the mapping of 16 kB "
 				"(or 8 MB if read_far is non-zero).");
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
