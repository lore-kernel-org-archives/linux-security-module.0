From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 26 Jul 2017 21:42:17 -0500
Subject: [PATCH v2] security: fix description of values returned by
	cap_inode_need_killpriv
In-Reply-To: <1501122425-12250-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1501122425-12250-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170727024217.GA12236@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 26, 2017 at 10:27:05PM -0400, Stefan Berger wrote:
> cap_inode_need_killpriv returns 1 if security.capability exists and
> has a value and inode_killpriv() is required, 0 otherwise. Fix the
> description of the return value to reflect this.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Thanks, Stefan.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 7abebd7..1234269 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -300,10 +300,10 @@ static inline void bprm_clear_caps(struct linux_binprm *bprm)
>   *
>   * Determine if an inode having a change applied that's marked ATTR_KILL_PRIV
>   * affects the security markings on that inode, and if it is, should
> - * inode_killpriv() be invoked or the change rejected?
> + * inode_killpriv() be invoked or the change rejected.
>   *
> - * Returns 0 if granted; +ve if granted, but inode_killpriv() is required; and
> - * -ve to deny the change.
> + * Returns 1 if security.capability has a value, meaning inode_killpriv()
> + * is required, 0 otherwise, meaning inode_killpriv() is not required.
>   */
>  int cap_inode_need_killpriv(struct dentry *dentry)
>  {
> -- 
> 2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
