From: serge@hallyn.com (Serge E. Hallyn)
Date: Mon, 13 Aug 2018 11:11:11 -0500
Subject: [PATCH 1/9] cap_file: use v3 xattr macros
In-Reply-To: <20180810161335.27036-2-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
	<20180810161335.27036-2-christian@brauner.io>
Message-ID: <20180813161111.GA26763@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Christian Brauner (christian at brauner.io):
> On kernels supporting VFS_CAP_REVISION_3 we should make use the new
> macros.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Hi Andrew,

are you open to taking this patchset (or one like it) in
libcap2?

thanks,
-serge

> ---
>  libcap/cap_file.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/libcap/cap_file.c b/libcap/cap_file.c
> index 76aac8c..228d806 100644
> --- a/libcap/cap_file.c
> +++ b/libcap/cap_file.c
> @@ -59,6 +59,13 @@ static cap_t _fcaps_load(struct vfs_cap_data *rawvfscap, cap_t result,
>  	break;
>  #endif
>  
> +#ifdef VFS_CAP_REVISION_3
> +    case VFS_CAP_REVISION_3:
> +	tocopy = VFS_CAP_U32_3;
> +	bytes -= XATTR_CAPS_SZ_3;
> +	break;
> +#endif
> +
>      default:
>  	cap_free(result);
>  	result = NULL;
> @@ -125,9 +132,15 @@ static int _fcaps_save(struct vfs_cap_data *rawvfscap, cap_t cap_d,
>  
>  #ifdef _LINUX_CAPABILITY_VERSION_3
>      case _LINUX_CAPABILITY_VERSION_3:
> +#ifdef VFS_CAP_REVISION_3
> +	magic = VFS_CAP_REVISION_3;
> +	tocopy = VFS_CAP_U32_3;
> +	*bytes_p = XATTR_CAPS_SZ_3;
> +#else
>  	magic = VFS_CAP_REVISION_2;
>  	tocopy = VFS_CAP_U32_2;
>  	*bytes_p = XATTR_CAPS_SZ_2;
> +#endif
>  	break;
>  #endif
>  
> -- 
> 2.17.1
