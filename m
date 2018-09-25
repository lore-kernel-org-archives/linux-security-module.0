From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 25 Sep 2018 08:16:56 -0700
Subject: [PULL] Smack: Changes for 4.20
Message-ID: <ad8a0bbf-ce0c-3474-a52d-3ddf0fe4a107@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James, I know it's on the early side, but I have a holiday coming up
so I figured better early than late. Here are three patches for Smack
for 4.20. Two clean up warnings and one is a rarely encountered ptrace
capability check.

Thank you.

The following changes since commit dbdb75bd087954aaf9b3248109cb85748b62c21d:

  security: tomoyo: Fix obsolete function (2018-09-04 11:56:25 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/next-smack smack-for-4.20

for you to fetch changes up to b1fed3edc82ae0d763d5c24769e4a0193da150c9:

  Smack: Mark expected switch fall-through (2018-09-18 16:28:54 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: ptrace capability use fixes

Gustavo A. R. Silva (1):
      Smack: Mark expected switch fall-through

YueHaibing (1):
      Smack: remove set but not used variable 'root_inode'

 security/smack/smack_lsm.c | 15 +++++++++++----
 security/smack/smackfs.c   |  3 ---
 2 files changed, 11 insertions(+), 7 deletions(-)
