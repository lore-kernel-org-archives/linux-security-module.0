From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 18:11:21 +0100
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
References: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
Message-ID: <149141228170.31282.6899985667525868658.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Chun-Yi Lee <joeyli.kernel@gmail.com>

When KEXEC_VERIFY_SIG is not enabled, kernel should not loads image
through kexec_file systemcall if securelevel has been set.

This code was showed in Matthew's patch but not in git:
https://lkml.org/lkml/2015/3/13/778

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/kexec_file.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b118735fea9d..f6937eecd1eb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -268,6 +268,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Don't permit images to be loaded into trusted kernels if we're not
+	 * going to verify the signature on them
+	 */
+	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_down())
+		return -EPERM;
+
 	/* Make sure we have a legal set of flags */
 	if (flags != (flags & KEXEC_FILE_FLAGS))
 		return -EINVAL;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
