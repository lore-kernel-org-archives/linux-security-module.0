From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Oct 2017 01:58:40 -0700
Subject: [PATCH] vfs: fix mounting a filesystem with i_version
In-Reply-To: <1507436901.5841.4.camel@linux.vnet.ibm.com>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
Message-ID: <20171008085840.GA6825@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 08, 2017 at 12:28:21AM -0400, Mimi Zohar wrote:
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

The problem is that the whole masking there is a piece of crap.

It assumes that MS_* and SB_* flags have the same numeric values,
which is bound to create a major problem rather sooner than later.

What we need is a separate __bitwise type for SB_*, translated them
here and treat them as a separate namespaces.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
