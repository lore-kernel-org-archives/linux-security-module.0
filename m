From: dhowells@redhat.com (David Howells)
Date: Thu, 19 Oct 2017 15:53:42 +0100
Subject: [PATCH 25/27] Lock down /proc/kcore
In-Reply-To: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
Message-ID: <150842482228.7923.9630520914833154257.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/kcore.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 45629f4b5402..176cf749e650 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -549,6 +549,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore"))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
