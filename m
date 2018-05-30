From: paul@paul-moore.com (Paul Moore)
Date: Wed, 30 May 2018 12:28:14 -0400
Subject: [GIT PULL] SELinux fixes for v4.17 (#2)
Message-ID: <CAHC9VhT3tXt3PaUHtt9MmocVocXu7t3A-zey=UOVufi8vZ_=LA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

One more small fix for SELinux: a small string length fix found by
KASAN.  I dislike sending patches this late in the release cycle, but
this patch fixes a legitimate problem, is very small, limited in
scope, and well understood.  There are two threads with more
information on the problem, the latest is linked below:

* https://marc.info/?t=152723737400001&r=1&w=2

If you're hesitant to pull this into v4.17 at such a late stage, it
probably isn't going to cause major problems as Stephen points out in
the thread linked above:

 "Such a setxattr() call can only be performed by a process
  with CAP_MAC_ADMIN that is also allowed mac_admin permission
  in SELinux policy. Consequently, this is never possible on
  Android (no process is allowed mac_admin permission, always
  enforcing) and is only possible in Fedora/RHEL for a few
  domains (if enforcing)."

Thanks,
-Paul

--
The following changes since commit 4152dc91b5932e7fe49a5afed62a068b2f31d196:

 selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()
   (2018-05-14 15:20:59 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180530

for you to fetch changes up to efe3de79e0b52ca281ef6691480c8c68c82a4657:

 selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
   (2018-05-29 20:11:19 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180530

----------------------------------------------------------------
Sachin Grover (1):
     selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

security/selinux/ss/services.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
