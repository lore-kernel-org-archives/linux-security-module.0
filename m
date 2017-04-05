From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 18:07:41 +0100
Subject: [PATCH 05/24] Restrict /dev/mem and /dev/kmem when the kernel is
	locked down
In-Reply-To: <149141201983.30815.1240162780237131881.stgit@warthog.procyon.org.uk>
References: <149141201983.30815.1240162780237131881.stgit@warthog.procyon.org.uk>
Message-ID: <149141206156.30815.14041270799898366372.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Matthew Garrett <matthew.garrett@nebula.com>

Allowing users to write to address space makes it possible for the kernel to
be subverted, avoiding module loading restrictions.  Prevent this when the
kernel has been locked down.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/mem.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 6d9cc2d39d22..f8144049bda3 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -163,6 +163,9 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 	if (p != *ppos)
 		return -EFBIG;
 
+	if (kernel_is_locked_down())
+		return -EPERM;
+
 	if (!valid_phys_addr_range(p, count))
 		return -EFAULT;
 
@@ -513,6 +516,9 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 	int err = 0;
 
+	if (kernel_is_locked_down())
+		return -EPERM;
+
 	if (p < (unsigned long) high_memory) {
 		unsigned long to_write = min_t(unsigned long, count,
 					       (unsigned long)high_memory - p);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
