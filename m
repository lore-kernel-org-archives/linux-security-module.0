From: amir73il@gmail.com (Amir Goldstein)
Date: Wed, 18 Jul 2018 13:38:43 +0300
Subject: [PATCH v2] cap_inode_getsecurity: use d_find_any_alias() instead
	of d_find_alias()
In-Reply-To: <1530157637.30361.22.camel@mtkswgap22>
References: <1530157637.30361.22.camel@mtkswgap22>
Message-ID: <CAOQ4uxjtgPqgfS9euFfcpO_v8p17AYFrqCEsYVrHQUG1ueq4Ew@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric,

Ping for your attention.

On Thu, Jun 28, 2018 at 6:47 AM, Eddie.Horng <eddie.horng@mediatek.com> wrote:
>
> The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
> ("Introduce v3 namespaced file capabilities"), should use
> d_find_any_alias() instead of d_find_alias() do handle unhashed dentry
> correctly. This is needed, for example, if execveat() is called with an
> open but unlinked overlayfs file, because overlayfs unhashes dentry on
> unlink.
>
> Below reproducer and setup can reproduce the case.
>   const char* exec="echo";
>   const char *newargv[] = { "echo", "hello", NULL};
>   const char *newenviron[] = { NULL };
>   int fd, err;
>
>   fd = open(exec, O_PATH);
>   unlink(exec);
>   err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
>                 AT_EMPTY_PATH);
>   if(err<0)
>     fprintf(stderr, "execveat: %s\n", strerror(errno));
>
> gcc compile into ~/test/a.out
> mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
>   none /mnt/m
>
> cd /mnt/m
> cp /bin/echo .
> ~/test/a.out
>
> Expected result:
> hello
> Actually result:
> execveat: Invalid argument
> dmesg:
> Invalid argument reading file caps for /dev/fd/3
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>
> ---

Eddie,

Please post v3 with changes:
- Add acked-by Serge
- Add Cc: <stable@vger.kernel.org> # v4.14
- Reproducer without overlayfs

Thanks,
Amir.

> Changes in v2:
>  - fix commit message wrapped at 74 chars
>  - added previous acked-by
>
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 1ce701fcb3f3..147f6131842a 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -388,7 +388,7 @@ int cap_inode_getsecurity(struct inode *inode, const
> char *name, void **buffer,
>         if (strcmp(name, "capability") != 0)
>                 return -EOPNOTSUPP;
>
> -       dentry = d_find_alias(inode);
> +       dentry = d_find_any_alias(inode);
>         if (!dentry)
>                 return -EINVAL;
>
> --
> 2.12.5
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
