From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 18:10:59 +0100
Subject: [PATCH 07/24] kexec: Disable at runtime if the kernel is locked down
In-Reply-To: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
References: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
Message-ID: <149141225975.31282.16979443562841170389.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Matthew Garrett <matthew.garrett@nebula.com>

kexec permits the loading and execution of arbitrary code in ring 0, which
is something that lock-down is meant to prevent. It makes sense to disable
kexec in this situation.

This does not affect kexec_file_load() which can check for a signature on the
image to be booted.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/kexec.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 980936a90ee6..46de8e6b42f4 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -194,6 +194,13 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		return -EPERM;
 
 	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down())
+		return -EPERM;
+
+	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
 	 */

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
