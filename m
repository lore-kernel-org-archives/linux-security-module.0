From: john.johansen@canonical.com (John Johansen)
Date: Thu, 6 Sep 2018 09:20:06 -0700
Subject: [GIT PULL] apparmor fix for v4.19-rc3
Message-ID: <4139cc4d-3402-aaaf-a43b-7804a983820a@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

Please pull this fix for an issue syzbot discovered last week

thanks
- John


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2018-09-06

for you to fetch changes up to edf4e7b7b9104b58fddfcd073bd7dcc1585d5326:

  apparmor: fix bad debug check in apparmor_secid_to_secctx() (2018-09-03 11:15:29 -0700)

----------------------------------------------------------------
- Fix for bad debug check when converting secids to secctx

----------------------------------------------------------------
John Johansen (1):
      apparmor: fix bad debug check in apparmor_secid_to_secctx()

 security/apparmor/secid.c | 1 -
 1 file changed, 1 deletion(-)
