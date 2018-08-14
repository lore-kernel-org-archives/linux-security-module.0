From: paul@paul-moore.com (Paul Moore)
Date: Tue, 14 Aug 2018 16:45:24 -0400
Subject: [GIT PULL] SELinux patches for v4.19
Message-ID: <CAHC9VhT9X+OQEjE38iesRKtZm9w6V0qo=Cyf6kwQf3MnPP_NDw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

There are 16 patches in the SELinux PR for v4.19 but really only one
that is of any significance.  That one patch is by nixiaoming and
fixes a few places where we were not properly cleaning up dentry and
inode objects in the selinuxfs error handling code.  The rest are
either printk->pr_* conversions, constification tweaks, and a minor
tweak to MAINTAINERS.

Everything passes the selinux-testsuite and looks to merge cleanly
against your master branch.

Please pull, thanks.
-Paul
--
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

 Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180814

for you to fetch changes up to 7e4237faa7213c1cc1d0aa65a44c67ba4729ce9f:

 selinux: cleanup dentry and inodes on error in selinuxfs
   (2018-08-07 17:26:25 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180814

----------------------------------------------------------------
Eric Biggers (1):
     selinux: constify write_op[]

Paul Moore (1):
     MAINTAINERS: update the LSM and SELinux subsystems

nixiaoming (1):
     selinux: cleanup dentry and inodes on error in selinuxfs

peter enderborg (13):
     selinux: Cleanup printk logging in conditional
     selinux: Cleanup printk logging in ebitmap
     selinux: Cleanup printk logging in policydb
     selinux: Cleanup printk logging in hooks
     selinux: Cleanup printk logging in avtab
     selinux: Cleanup printk logging in services
     selinux: Cleanup printk logging in selinuxfs
     selinux: Cleanup printk logging in netlink
     selinux: Cleanup printk logging in sidtab
     selinux: Cleanup printk logging in netport
     selinux: Cleanup printk logging in netif
     selinux: Cleanup printk logging in avc
     selinux: Cleanup printk logging in netnode

MAINTAINERS                       |  1 +
security/selinux/avc.c            |  2 +-
security/selinux/hooks.c          | 68 ++++++++++++++---------------
security/selinux/netif.c          | 11 ++---
security/selinux/netlink.c        |  2 +-
security/selinux/netnode.c        |  5 +--
security/selinux/netport.c        |  5 +--
security/selinux/selinuxfs.c      | 45 +++++++++++++------
security/selinux/ss/avtab.c       | 51 +++++++++++-----------
security/selinux/ss/conditional.c | 16 +++----
security/selinux/ss/ebitmap.c     | 15 +++----
security/selinux/ss/policydb.c    | 91 ++++++++++++++++++-----------------
security/selinux/ss/services.c    | 71 +++++++++++++++---------------
security/selinux/ss/sidtab.c      |  5 +--
14 files changed, 199 insertions(+), 189 deletions(-)

--
paul moore
www.paul-moore.com
