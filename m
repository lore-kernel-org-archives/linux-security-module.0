From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Tue, 20 Mar 2018 12:33:12 -0400
Subject: [Non-DoD Source] Re: [PATCH v3 14/15] selinux: allow setxattr on
	rootfs so initramfs code can set them
In-Reply-To: <alpine.LRH.2.00.1803101848580.24419@sjc-ads-6991.cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-17-git-send-email-takondra@cisco.com>
	<1519153284.14218.18.camel@tycho.nsa.gov>
	<alpine.LRH.2.00.1803101848580.24419@sjc-ads-6991.cisco.com>
Message-ID: <ab0b8e50-a92e-9f36-5493-ddbd295ed182@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/10/2018 10:07 PM, Victor Kamensky wrote:
> 
> 
> On Tue, 20 Feb 2018, Stephen Smalley wrote:
> 
>> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>>> From: Victor Kamensky <kamensky@cisco.com>
>>>
>>> initramfs code supporting extended cpio format have ability to
>>> fill extended attributes from cpio archive, but if SELinux enabled
>>> and security server is not initialized yet, selinux callback would
>>> refuse setxattr made by initramfs code.
>>>
>>> Solution enable SBLABEL_MNT on rootfs even if secrurity server is
>>> not initialized yet.
>>
>> What if we were to instead skip the SBLABEL_MNT check in
>> selinux_inode_setxattr() if !ss_initialized?? Not dependent on
>> filesystem type.
> 
> Stephen, thank you for looking into this. Sorry, for dealyed reponse -
> I needed to find time to require context about these changes.
> 
> As you suggested I've tried this and it works:
> 
>> From 6bf35bd055fdb12e94f3d5188eccfdbaa30dbcf4 Mon Sep 17 00:00:00 2001
> From: Victor Kamensky <kamensky@cisco.com>
> Date: Fri, 9 Mar 2018 23:01:20 -0800
> Subject: [PATCH 1/2] selinux: allow setxattr on file systems if policy is not
> ?loaded
> 
> initramfs code supporting extended cpio format have ability to
> fill extended attributes from cpio archive, but if SELinux enabled
> and security server is not initialized yet, selinux callback would
> refuse setxattr made by initramfs code because file system is not
> yet marked as one that support labeling (SBLABEL_MNT flag).
> 
> Solution do not refuse setxattr even if SBLABEL_MNT is not set
> for file systems when policy is not loaded yet.
> 
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> ---
> ?security/selinux/hooks.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 819fd68..31303ed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3120,7 +3120,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
> ???????? return selinux_inode_setotherxattr(dentry, name);
> 
> ???? sbsec = inode->i_sb->s_security;
> -??? if (!(sbsec->flags & SBLABEL_MNT))
> +??? if (!(sbsec->flags & SBLABEL_MNT) && ss_initialized)
> ???????? return -EOPNOTSUPP;
> 
> ???? if (!inode_owner_or_capable(inode))

I favor the first option.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
