From: bfields@redhat.com (J. Bruce Fields)
Date: Wed, 29 Mar 2017 17:34:40 -0400
Subject: [PATCH] selinux: Fix SBLABEL_MNT for NFS mounts
In-Reply-To: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
References: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
Message-ID: <20170329213439.GC19617@parsley.fieldses.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 29, 2017 at 05:27:23PM +0200, Tomeu Vizoso wrote:
> Labelling of files in a NFSv4.2 currently fails with ENOTSUPP because
> the mount point doesn't have SBLABEL_MNT.
> 
> Add specific condition for NFS4 filesystems so it gets correctly
> labeled.

Huh.  Looking at the code, I think this is meant to be handled by the
SECURITY_FS_USE_NATIVE case--there was a similar failure fixed some time
ago by 9fc2b4b436cf.  What kernel are you seeing this on?  Is it a
recent regression (in which case, what's the latest kernel that worked
for you)?

--b.

> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: J. Bruce Fields <bfields@redhat.com>
> 
> ---
> 
> Hi,
> 
> cannot remotely say that I currently understand how selinux is expected
> to work within NFS mounts, but this change allowed me to fully boot AOSP
> with its rootfs and ramdisk on a single NFS share.
> 
> Thanks,
> 
> Tomeu
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0c2ac318aa7f..71cd1d8c67c2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -485,6 +485,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  		!strcmp(sb->s_type->name, "debugfs") ||
>  		!strcmp(sb->s_type->name, "tracefs") ||
>  		!strcmp(sb->s_type->name, "rootfs") ||
> +		!strcmp(sb->s_type->name, "nfs4") ||
>  		(selinux_policycap_cgroupseclabel &&
>  		 (!strcmp(sb->s_type->name, "cgroup") ||
>  		  !strcmp(sb->s_type->name, "cgroup2")));
> -- 
> 2.9.3
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
