From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 28 Jun 2018 10:01:52 -0500
Subject: [PATCH] cap_inode_getsecurity: use d_find_any_alias() instead of
	d_find_alias()
In-Reply-To: <1530082758.30361.7.camel@mtkswgap22>
References: <1530082758.30361.7.camel@mtkswgap22>
Message-ID: <20180628150152.GA10398@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Eddie.Horng (eddie.horng at mediatek.com):
> 
> The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
> ("Introduce v3 namespaced file capabilities"), should use
> d_find_any_alias()
> instead of d_find_alias() do handle unhashed dentry correctly. This is
> needed,
> for example, if execveat() is called with an open but unlinked overlayfs
> file, because overlayfs unhashes dentry on unlink.
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
> AT_EMPTY_PATH);
>   if(err<0)
>     fprintf(stderr, "execveat: %s\n", strerror(errno));
> 
> gcc compile into ~/test/a.out
> mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
> none /mnt/m
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
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")

Did 8db6c34f1dbc actually introduce a regression?

Note this does seem to potentially introduce an attack where a
user fetches an open fd to any file with filecaps, waits for a
CVE publication, then after the admin has updated the package
causing the file to be deleted, then does execveat to run the
deleted package with privs.

> Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>
> ---
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
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
