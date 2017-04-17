From: matt@nmatt.com (Matt Brown)
Date: Mon, 17 Apr 2017 02:07:05 -0400
Subject: [PATCH 3/4] restrict unprivileged TIOCSTI tty ioctl
In-Reply-To: <20170417060706.28674-1-matt@nmatt.com>
References: <20170417060706.28674-1-matt@nmatt.com>
Message-ID: <20170417060706.28674-4-matt@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

this patch depends on patch 1 and 2

enforces restrictions on unprivileged users injecting commands
into other processes in the same tty session using the TIOCSTI ioctl

Signed-off-by: Matt Brown <matt@nmatt.com>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e6d1a65..31894e8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2296,11 +2296,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *	FIXME: may race normal receive processing
  */
 
+int tiocsti_restrict = IS_ENABLED(CONFIG_SECURITY_TIOCSTI_RESTRICT);
+
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
 	struct tty_ldisc *ld;
 
+	if (tiocsti_restrict && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (get_user(ch, p))
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
