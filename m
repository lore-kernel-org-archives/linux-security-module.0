From: paul@paul-moore.com (Paul Moore)
Date: Thu, 6 Jul 2017 14:57:25 -0400
Subject: [GIT PULL] SELinux fixes for v4.13 (#1)
Message-ID: <CAHC9VhS6WHrQLw6iOm-FOZ5SGTKLY8WSz_U0WDFuKOO+u-H4vg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Two small patches from Daniel Jurgens to fix problems found with the
new SELinux/IB code, please apply and send up to Linus during the
v4.13-rcX series.

Thanks,
-Paul

---
The following changes since commit 6a3911837da0a90ed599fd0a9836472f5e7ddf1b:

 selinux: enable genfscon labeling for tracefs (2017-06-20 15:53:34 -0400)

are available in the git repository at:

 git://git.infradead.org/users/pcmoore/selinux stable-4.13

for you to fetch changes up to 074a492d7bc53902f0ed5a41c74ae008caf1822b:

 IB/core: Fix static analysis warning in ib_policy_change_task
          (2017-07-05 10:05:24 -0400)

----------------------------------------------------------------
Daniel Jurgens (2):
     IB/core: Fix uninitialized variable use in check_qp_port_pkey_settings
     IB/core: Fix static analysis warning in ib_policy_change_task

drivers/infiniband/core/device.c   |  3 ++-
drivers/infiniband/core/security.c | 20 ++++++++++++--------
2 files changed, 14 insertions(+), 9 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
