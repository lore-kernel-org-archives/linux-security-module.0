From: mtk.manpages@gmail.com (Michael Kerrisk (man-pages))
Date: Sun, 14 Jan 2018 10:40:04 +0100
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <20180109185218.GA21753@mail.hallyn.com>
References: <20180109185218.GA21753@mail.hallyn.com>
Message-ID: <5e434a9c-8ea9-afb1-700a-65f08f6e88fe@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello Serge,

On 01/09/2018 07:52 PM, Serge E. Hallyn wrote:
> Update the capabilities(7)  manpage with a description of the
> new-ish namespaced file capability support.

Thanks for this patch. I'm trying to craft a modified version
based on your text, so no need to send a new version at this
stage, but I do have some questions below.

> A note on userspace tools:  since the kernel will automatically
> convert between v2 and v3 xattrs, and translate nsroot between
> v3 xattrs, we can make do with the current getcap(8) and setcap(8)
> tools. I.e. a user on the host can create a transient user namespace
> with the appropriate mappings and run setcap(8) there.  The kernel
> will automatically write a v3 xattr with the transient namespace's
> root user as nsroot.
>
> Signed-off-by: Serge Hallyn <shallyn@cisco.com>
> ---
>  man7/capabilities.7 | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/man7/capabilities.7 b/man7/capabilities.7
> index 166eaaf..76e7e02 100644
> --- a/man7/capabilities.7
> +++ b/man7/capabilities.7
> @@ -936,6 +936,50 @@ if we specify the effective flag as being enabled for any capability,
>  then the effective flag must also be specified as enabled
>  for all other capabilities for which the corresponding permitted or
>  inheritable flags is enabled.
> +.PP
> +Until 4.13, only VFS_CAP_REVISION_2 xattrs were supported.  These store only
> +the capabilities to be applied to the file, with no record of the writer's
> +credentials.  Therefore only privileged users can be trusted to write them, and
> +.BR CAP_SETFCAP
> +over the user namespace which mounted the filesystem (usually the initial user
> +namespace) is required.  This makes it impossible to write file capabilities
> +from a user namespaced container, which causes some package updates to fail.
> +.PP
> +In order to support setting file capabilities in containers, the
> +kernel must be able to identify whether the task executing the
> +file will be constrained to a subset of the resources over which
> +the writer of the file capabilities has privilege.  To this end,
> +since 4.13, VFS_CAP_REVISION_3 capabilities store the user ID
> +of the root user in the writer's namespace ("nsroot").

Here, "nsroot" means the UID 0 in the namespace as it would be mapped
into the initial userns, right?

> Hence the writer only
> +requires
> +.IP 1.
> +.BR CAP_SETFCAP
> +over the file inode, meaning the writing task must have
> +.BR CAP_SETFCAP
> +over a user namespace into which the inode's owning user ID is mapped.

I don't understand the above line. Could you explain with an example?

Cheers,

Michael

> +.PP
> +and
> +.IP 2.
> +.BR CAP_SETFCAP
> +over the writer's own user namespace.
> +.PP
> +A VFS_CAP_REVISION_3 file capability will take effect only when run in a user namespace
> +whose UID 0 maps to the saved "nsroot", or a descendant of such a namespace.
> +.PP
> +Users with the required privilege may use
> +.BR setxattr(2)
> +to request either a VFS_CAP_REVISION_2 or VFS_CAP_REVISION_3 write.
> +The kernel will automatically convert a VFS_CAP_REVISION_2 to a
> +VFS_CAP_REVISION_3 extended attribute with the "nsroot"
> +set to the root user in the writer's user namespace, or, if a VFS_CAP_REVISION_3
> +extended attribute is specified, then the kernel will map the
> +specified root user ID (which must be a valid user ID mapped in the caller's
> +user namespace) into the initial user namespace.  Likewise,
> +.BR getxattr(2)
> +results will be converted and simplified to show a VFS_CAP_REVISION_2
> +extended attribute, if a VFS_CAP_REVISION_3 applies to the caller's
> +namespace, or to map the VFS_CAP_REVISION_3 root user ID into the
> +caller's namespace.


>  .\"
>  .SS Transformation of capabilities during execve()
>  .PP
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
