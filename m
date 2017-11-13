From: paul@paul-moore.com (Paul Moore)
Date: Mon, 13 Nov 2017 16:58:35 -0500
Subject: [GIT PULL] SELinux patches for v4.15
Message-ID: <CAHC9VhTHcp7DyX0n19F0ZS__ZwoL3KeouBsmsjc0UZ68fP9OXw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Linus,

Seven SELinux patches for v4.15, although five of the seven are small
build fixes and cleanups.  Of the remaining two patches, the only one
worth really calling out is Eric's fix for the SELinux filesystem
xattr set/remove code; the other patch simply converts the SELinux
hash table implementation to use kmem_cache.  Eric's
setxattr/removexattr tweak converts SELinux back to calling the
commoncap implementations when the xattr is not SELinux related.  The
immediate win is to fixup filesystem capabilities in user namespaces,
but it makes things a bit saner overall; more information in the
commit description.

Please merge for v4.15.

Thanks,
-Paul

---
The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

 Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
  tags/selinux-pr-20171113

for you to fetch changes up to 5794ed762ac2125299644494766704da94168ec0:

 selinux: remove extraneous initialization of slots_used and max_chain_len
  (2017-10-16 18:40:09 -0400)

----------------------------------------------------------------
selinux/stable-4.15 PR 20171113

----------------------------------------------------------------
Colin Ian King (3):
     selinux: remove redundant assignment to str
     selinux: remove redundant assignment to len
     selinux: remove extraneous initialization of slots_used and max_chain_len

Corentin LABBE (2):
     selinux: fix build warning by removing the unused sid variable
     selinux: fix build warning

Eric W. Biederman (1):
     selinux: Perform both commoncap and selinux xattr checks

Kyeongdon Kim (1):
     selinux: Use kmem_cache for hashtab_node

security/selinux/hooks.c          | 55 ++++++++++++++---------------------
security/selinux/ss/conditional.c |  1 -
security/selinux/ss/hashtab.c     | 19 +++++++++++---
security/selinux/ss/hashtab.h     |  4 +++
security/selinux/ss/services.c    |  4 +++
5 files changed, 47 insertions(+), 36 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
