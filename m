From: dhowells@redhat.com (David Howells)
Date: Thu, 22 Feb 2018 14:21:53 +0000
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <8846.1519309243@warthog.procyon.org.uk>
References: <8846.1519309243@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
Message-ID: <8887.1519309313@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I'm intending on inserting the attached patch before this one.

And replacing this patch with the attached.

David
---
commit ed0424c531d7dd25adebdec0ee6a78a5784f207a
Author: David Howells <dhowells@redhat.com>
Date:   Thu Feb 22 14:01:49 2018 +0000

    kexec_file: Restrict at runtime if the kernel is locked down
    
    When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through
    kexec_file systemcall if the kernel is locked down unless IMA can be used
    to validate the image.
    
    [Modified by David Howells to fit with modifications to the previous patch
     and to return -EPERM if the kernel is locked down for consistency with
     other lockdowns]
    
    Signed-off-by: Jiri Bohac <jbohac@suse.cz>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Cc: Matthew Garrett <mjg59@srcf.ucam.org>
    cc: Chun-Yi Lee <jlee@suse.com>
    cc: kexec at lists.infradead.org

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d5931e392050..c47c4de604cd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -167,6 +167,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+		if (is_ima_appraise_enabled())
+			break;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
