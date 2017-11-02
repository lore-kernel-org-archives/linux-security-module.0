From: dhowells@redhat.com (David Howells)
Date: Thu, 02 Nov 2017 17:29:55 +0000
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1508774083.3639.124.camel@linux.vnet.ibm.com>
References: <1508774083.3639.124.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
Message-ID: <8969.1509643795@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

I've adjusted the patch as below.

David
---
commit bf33218ad2bf04f1b92f5c32499ab906f107864c
Author: Chun-Yi Lee <joeyli.kernel@gmail.com>
Date:   Wed May 24 14:56:03 2017 +0100

    kexec_file: Restrict at runtime if the kernel is locked down
    
    When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through
    kexec_file systemcall if the kernel is locked down unless IMA can be used
    to validate the image.
    
    This code was showed in Matthew's patch but not in git:
    https://lkml.org/lkml/2015/3/13/778
    
    Cc: Matthew Garrett <mjg59@srcf.ucam.org>
    Signed-off-by: Chun-Yi Lee <jlee@suse.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Reviewed-by: James Morris <james.l.morris@oracle.com>
    cc: kexec at lists.infradead.org

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9f48f4412297..3ba28fc3fab0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -255,6 +255,14 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Don't permit images to be loaded into trusted kernels if we're not
+	 * going to verify the signature on them
+	 */
+	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) &&
+	    !is_ima_appraise_enabled() &&
+	    kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/* Make sure we have a legal set of flags */
 	if (flags != (flags & KEXEC_FILE_FLAGS))
 		return -EINVAL;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
