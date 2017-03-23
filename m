From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 16:28:05 -0400
Subject: [PATCH 02/46] selinux: Delete an unnecessary return statement in
	cond_compute_av()
In-Reply-To: <86979267-24ac-ce16-a150-43677ac78a0b@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<86979267-24ac-ce16-a150-43677ac78a0b@users.sourceforge.net>
Message-ID: <CAHC9VhTKBR-JPGKah6fgiPhcOG_6uXu6R4DO4Z7j03=sfHWzTw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 9:58 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 11:00:23 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/conditional.c | 1 -
>  1 file changed, 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index fcfab2635c11..4a3bf29f7565 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -664,5 +664,4 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>                                 (node->key.specified & AVTAB_XPERMS))
>                         services_compute_xperms_drivers(xperms, node);
>         }
> -       return;
>  }
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
