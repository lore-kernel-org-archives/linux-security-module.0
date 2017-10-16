From: paul@paul-moore.com (Paul Moore)
Date: Mon, 16 Oct 2017 18:35:34 -0400
Subject: [PATCH] selinux: remove redundant assignment to str
In-Reply-To: <20171014124655.32438-1-colin.king@canonical.com>
References: <20171014124655.32438-1-colin.king@canonical.com>
Message-ID: <CAHC9VhRT8WRfc4MvHs_4bN-gi3L7b8kqiuJ9=rTX=zbLgtWoYA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Oct 14, 2017 at 8:46 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> str is being assigned to an empty string but str is never being
> read after that, so the assignment is redundant and can be removed.
> Moving the declaration of str to a more localised block, cleans up
> clang warning: "Value stored to 'str' is never read"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/hooks.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 07f35f3b4a13..3daf3369c3b4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3177,18 +3177,17 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>                 if (!has_cap_mac_admin(true)) {
>                         struct audit_buffer *ab;
>                         size_t audit_size;
> -                       const char *str;
>
>                         /* We strip a nul only if it is at the end, otherwise the
>                          * context contains a nul and we should audit that */
>                         if (value) {
> -                               str = value;
> +                               const char *str = value;
> +
>                                 if (str[size - 1] == '\0')
>                                         audit_size = size - 1;
>                                 else
>                                         audit_size = size;
>                         } else {
> -                               str = "";
>                                 audit_size = 0;
>                         }
>                         ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR);
> --
> 2.14.1
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
