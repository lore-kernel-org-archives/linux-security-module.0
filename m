From: dhowells@redhat.com (David Howells)
Date: Wed, 11 Apr 2018 17:27:09 +0100
Subject: [PATCH 23/24] Lock down perf
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
Message-ID: <152346402954.4030.7078270243543630603.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/events/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc1c330c6bd6..1922f2e0980a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10407,6 +10407,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR"))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
