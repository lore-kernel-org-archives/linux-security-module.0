From: paul@paul-moore.com (Paul Moore)
Date: Fri, 29 Jun 2018 17:47:15 -0400
Subject: [GIT PULL] SELinux fixes for v4.18 (#1)
Message-ID: <CAHC9VhQZ+zRQ+LER=BCx1_Z-Z+LQuYaeEUxQ8YMQoNdNgt=cwg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

One fairly straightforward patch to fix a longstanding issue where a
process could stall while accessing files in selinuxfs and block
everyone else due to a held mutex.  The patch passes all our tests and
looks to apply cleanly to your current tree.  Please pull this as a
fix for v4.18.

Thanks,
-Paul
--
The following changes since commit d141136f523a3a6372d22981bdff7a8906f36fea:

 audit: normalize MAC_POLICY_LOAD record (2018-04-17 17:54:11 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180629

for you to fetch changes up to 0da74120c5341389b97c4ee27487a97224999ee1:

 selinux: move user accesses in selinuxfs out of locked regions
   (2018-06-28 20:39:54 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180629

----------------------------------------------------------------
Jann Horn (1):
     selinux: move user accesses in selinuxfs out of locked regions

security/selinux/selinuxfs.c | 78 +++++++++++++++++-----------------------
1 file changed, 33 insertions(+), 45 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
