From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 21:17:34 +0100
Subject: [PATCH 21/24] scsi: Lock down the eata driver
In-Reply-To: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
Message-ID: <149142345473.5101.9422205244390193240.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

The eata driver takes a single string parameter that contains a slew of
settings, including hardware resource configuration.  Prohibit use of the
parameter if the kernel is locked down.

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dario Ballabio <ballabio_dario@emc.com>
cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
cc: "Martin K. Petersen" <martin.petersen@oracle.com>
cc: linux-scsi at vger.kernel.org
---

 drivers/scsi/eata.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
index 227dd2c2ec2f..5c036d10c18b 100644
--- a/drivers/scsi/eata.c
+++ b/drivers/scsi/eata.c
@@ -1552,8 +1552,13 @@ static int eata2x_detect(struct scsi_host_template *tpnt)
 
 	tpnt->proc_name = "eata2x";
 
-	if (strlen(boot_options))
+	if (strlen(boot_options)) {
+		if (kernel_is_locked_down()) {
+			pr_err("Command line-specified device addresses, irqs and dma channels are not permitted when the kernel is locked down\n");
+			return -EPERM;
+		}
 		option_setup(boot_options);
+	}
 
 #if defined(MODULE)
 	/* io_port could have been modified when loading as a module */

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
