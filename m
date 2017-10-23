From: dhowells@redhat.com (David Howells)
Date: Mon, 23 Oct 2017 15:34:18 +0100
Subject: [PATCH 04/27] Restrict /dev/mem and /dev/kmem when the kernel is
	locked down
In-Reply-To: <150842466261.7923.14359746674406637357.stgit@warthog.procyon.org.uk>
References: <150842466261.7923.14359746674406637357.stgit@warthog.procyon.org.uk>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
Message-ID: <18778.1508769258@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I think I should replace this patch with the attached.  This will prevent
/dev/mem, /dev/kmem and /dev/port from being *opened*, and thereby preventing
read, write and ioctl.

David
---
commit e68daa2256986932b9a7d6709cf9e24b30d93583
Author: Matthew Garrett <matthew.garrett@nebula.com>
Date:   Wed May 24 14:56:02 2017 +0100

    Restrict /dev/{mem,kmem,port} when the kernel is locked down
    
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
