From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 17:57:30 +0100
Subject: [PATCH 05/38] Annotate hardware config module parameters in
	drivers/char/
In-Reply-To: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
Message-ID: <149141145086.29162.10390009355486163950.stgit@warthog.procyon.org.uk>
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

This patch annotates drivers in drivers/char/.

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Arnd Bergmann <arnd@arndb.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 drivers/char/applicom.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index e770ad977472..b67263d6e34b 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -94,9 +94,9 @@ static struct applicom_board {
 static unsigned int irq = 0;	/* interrupt number IRQ       */
 static unsigned long mem = 0;	/* physical segment of board  */
 
-module_param(irq, uint, 0);
+module_param_hw(irq, uint, irq, 0);
 MODULE_PARM_DESC(irq, "IRQ of the Applicom board");
-module_param(mem, ulong, 0);
+module_param_hw(mem, ulong, iomem, 0);
 MODULE_PARM_DESC(mem, "Shared Memory Address of Applicom board");
 
 static unsigned int numboards;	/* number of installed boards */

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
