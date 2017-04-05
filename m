From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 21:16:26 +0100
Subject: [PATCH 13/24] x86: Lock down IO port access when the kernel is
	locked down
In-Reply-To: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
Message-ID: <149142338597.5101.14728426552744019377.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Matthew Garrett <matthew.garrett@nebula.com>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: x86 at kernel.org
---

 arch/x86/kernel/ioport.c |    4 ++--
 drivers/char/mem.c       |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 9c3cf0944bce..4a613fed94b6 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -30,7 +30,7 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) || kernel_is_locked_down()))
 		return -EPERM;
 
 	/*
@@ -120,7 +120,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) || kernel_is_locked_down())
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f8144049bda3..9afebb60550f 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -741,6 +741,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down())
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
