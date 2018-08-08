From: amir73il@gmail.com (Amir Goldstein)
Date: Wed, 8 Aug 2018 17:14:38 +0200
Subject: Fwd: [PATCH v3] cap_inode_getsecurity: use d_find_any_alias() instead
	of d_find_alias()
In-Reply-To: <1532071800.19245.5.camel@mtkswgap22>
References: <1532071800.19245.5.camel@mtkswgap22>
Message-ID: <CAOQ4uxg=Mf0OCXHnJzXen3L8UJw2gzQ2CzYq=YGBstoGY936_w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Eric,

Seems like you have been AFK for a while.
Will you be able to queue this v4.14 regression fix for 4.19?

Eddie is already working on upstreaming an LTP test for the regression.

The fix has been ACKed by Serge and myself.

Andrew,

If Eric fails to respond timely, could you pick up this fix via -mm?

Thanks,
Amir.


---------- Forwarded message ----------
From: Eddie.Horng <eddie.horng@mediatek.com>
Date: Fri, Jul 20, 2018 at 9:30 AM
Subject: [PATCH v3] cap_inode_getsecurity: use d_find_any_alias()
instead of d_find_alias()
To: LSM List <linux-security-module@vger.kernel.org>
Cc: stable at vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, "Eric
W. Biederman" <ebiederm@xmission.com>, "Serge E. Hallyn"
<serge@hallyn.com>, Eddie Horng <eddiehorng.tw@gmail.com>



The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
("Introduce v3 namespaced file capabilities"), should use
d_find_any_alias() instead of d_find_alias() do handle unhashed dentry
correctly. This is needed, for example, if execveat() is called with an
open but unlinked overlayfs file, because overlayfs unhashes dentry on
unlink.
This is a regression of real life application, first reported at
https://www.spinics.net/lists/linux-unionfs/msg05363.html

Below reproducer and setup can reproduce the case.
  const char* exec="echo";
  const char *newargv[] = { "echo", "hello", NULL};
  const char *newenviron[] = { NULL };
  int fd, err;

  fd = open(exec, O_PATH);
  unlink(exec);
  err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
AT_EMPTY_PATH);
  if(err<0)
    fprintf(stderr, "execveat: %s\n", strerror(errno));

gcc compile into ~/test/a.out
mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
none /mnt/m
cd /mnt/m
cp /bin/echo .
~/test/a.out

Expected result:
hello
Actually result:
execveat: Invalid argument
dmesg:
Invalid argument reading file caps for /dev/fd/3

The 2nd reproducer and setup emulates similar case but for
regular filesystem:
  const char* exec="echo";
  int fd, err;
  char buf[256];

  fd = open(exec, O_RDONLY);
  unlink(exec);
  err = fgetxattr(fd, "security.capability", buf, 256);
  if(err<0)
    fprintf(stderr, "fgetxattr: %s\n", strerror(errno));

gcc compile into ~/test_fgetxattr

cd /tmp
cp /bin/echo .
~/test_fgetxattr

Result:
fgetxattr: Invalid argument

On regular filesystem, for example, ext4 read xattr from
disk and return to execveat(), will not trigger this issue, however,
the overlay attr handler pass real dentry to vfs_getxattr() will.
This reproducer calls fgetxattr() with an unlinked fd, involkes
vfs_getxattr() then reproduced the case that d_find_alias() in
cap_inode_getsecurity() can't find the unlinked dentry.


Suggested-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Serge E. Hallyn <serge@hallyn.com>
Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Cc: <stable@vger.kernel.org> # v4.14
Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>
---
Changes in v2:
 - fix commit message wrapped at 74 chars
 - added previous acked-by

---
Changes in v3:
 - added original case report link
 - added 2nd reproducer for regular filesystems
 - added acked-by Serge E. Hallyn
 - add Cc

---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 1ce701fcb3f3..147f6131842a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -388,7 +388,7 @@ int cap_inode_getsecurity(struct inode *inode, const
char *name, void **buffer,
        if (strcmp(name, "capability") != 0)
                return -EOPNOTSUPP;

-       dentry = d_find_alias(inode);
+       dentry = d_find_any_alias(inode);
        if (!dentry)
                return -EINVAL;

--
2.12.5
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
