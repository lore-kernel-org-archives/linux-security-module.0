From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 16 Oct 2017 17:00:20 -0400
Subject: [GIT PULL]  vfs i_version fix for Linus
Message-ID: <1508187620.5464.13.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Al,

This pull request contains a single patch that allows file systems to
be mounted with i_version. ?I would really appreciate your forwarding
this patch to Linus.

thanks,

Mimi

---
The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git for-linus

for you to fetch changes up to 6363f8d51cdbb392fbf9cb6e1fbf779c435f8015:

  vfs: fix mounting a filesystem with i_version (2017-10-16 16:38:58 -0400)

----------------------------------------------------------------
Mimi Zohar (1):
      vfs: fix mounting a filesystem with i_version

 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
