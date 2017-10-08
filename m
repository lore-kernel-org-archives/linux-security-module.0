From: jmorris@namei.org (James Morris)
Date: Mon, 9 Oct 2017 09:24:53 +1100 (AEDT)
Subject: [PATCH] vfs: fix mounting a filesystem with i_version
In-Reply-To: <1507436901.5841.4.camel@linux.vnet.ibm.com>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1710090924410.3670@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cc: Al Viro.


On Sun, 8 Oct 2017, Mimi Zohar wrote:

> The mount i_version flag is not enabled in the new sb_flags.  This patch
> adds the missing SB_I_VERSION flag.
> 
> Fixes: e462ec5 "VFS: Differentiate mount flags (MS_*) from internal
>        superblock flags"
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3b601f115b6c..d18deb4c410b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2825,7 +2825,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
>  			    SB_MANDLOCK |
>  			    SB_DIRSYNC |
>  			    SB_SILENT |
> -			    SB_POSIXACL);
> +			    SB_POSIXACL |
> +			    SB_I_VERSION);
>  
>  	if (flags & MS_REMOUNT)
>  		retval = do_remount(&path, flags, sb_flags, mnt_flags,
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
