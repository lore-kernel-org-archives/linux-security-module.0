From: paul@paul-moore.com (Paul Moore)
Date: Wed, 16 May 2018 16:56:07 -0400
Subject: [GIT PULL] SELinux fixes for v4.17 (#1)
Message-ID: <CAHC9VhQfFXGXqx9seQy-EdTHauyqarYnCVChjd3s6BexQ+tE6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

A small pull request to fix a few regressions in the SELinux/SCTP code
with applications that call bind() with AF_UNSPEC/INADDR_ANY.  The
individual commit descriptions have more information, but the commits
themselves should be self explanatory.  Please merge.

Thanks,
-Paul

--
The following changes since commit 6b6bc6205d98796361962ee282a063f18ba8dc57:

 selinux: wrap AVC state (2018-03-20 16:58:17 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180516

for you to fetch changes up to 4152dc91b5932e7fe49a5afed62a068b2f31d196:

 selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()
   (2018-05-14 15:20:59 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180516

----------------------------------------------------------------
Alexey Kodanev (3):
     selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()
     selinux: fix address family in bind() and connect() to match address/port
     selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()

security/selinux/hooks.c | 50 +++++++++++++++++++++++++++---------------------
1 file changed, 28 insertions(+), 22 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
