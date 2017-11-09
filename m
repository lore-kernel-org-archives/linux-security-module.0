From: dhowells@redhat.com (David Howells)
Date: Thu,  9 Nov 2017 17:31:15 +0000
Subject: [PATCH 05/30] Restrict /dev/{mem, kmem,
	port} when the kernel is locked down
In-Reply-To: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
References: <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
Message-ID: <151024867560.28329.4487974949092492884.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Matthew Garrett <matthew.garrett@nebula.com>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
---

 drivers/char/mem.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 593a8818aca9..0ce5ac0a5c6b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -762,6 +762,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
