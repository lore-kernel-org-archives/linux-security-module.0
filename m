From: matt@nmatt.com (Matt Brown)
Date: Mon, 17 Apr 2017 02:07:02 -0400
Subject: Patchset to Restrict Unprivileged TIOCSTI TTY Command Injection
Message-ID: <20170417060706.28674-1-matt@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The following patchset reproduces GRKERNSEC_HARDEN_TTY functionality from the grsecurity project in-kernel. The purpose of this feature is to restrict unprivileged users from injecting commands into other processes in the same tty session by using the TIOCSTI ioctl.

It creates the kernel config SECURITY_TIOCSTI_RESTRICT and the sysctl kernel.tiocsti_restrict to control this feature. I modeled most of the code style and naming conventions off of SECURITY_DMESG_RESTRICT.

 drivers/tty/tty_io.c |  4 ++++
 include/linux/tty.h  |  2 ++
 kernel/sysctl.c      | 12 ++++++++++++
 security/Kconfig     | 12 ++++++++++++
 4 files changed, 30 insertions(+)

[PATCH 1/4] added SECURITY_TIOCSTI_RESTRICT kernel config
[PATCH 2/4] add tiocsti_restrict variable
[PATCH 3/4] restrict unprivileged TIOCSTI tty ioctl
[PATCH 4/4] added kernel.tiocsti_restrict sysctl
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
