From: paul@paul-moore.com (Paul Moore)
Date: Tue, 16 May 2017 14:41:05 -0400
Subject: [PATCH 3/3] selinux: Use an other error code for an input
	validation failure in sidtab_insert()
In-Reply-To: <38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
	<38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
Message-ID: <CAHC9VhQY7-Ls5bX_wbna1S6PjV2Ck_1+AR5R8Pngn1tivXxCdg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 4, 2017 at 7:16 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 4 Apr 2017 12:23:41 +0200
>
> The error code "-ENOMEM" was also returned so far when the parameter "s"
> of this function contained a null pointer.
> Now I find that the code "-EINVAL" is more appropriate in this case.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Have you tested this to determine any impact it may have on the
SELinux userspace?  I would agree that EINVAL is probably more
appropriate in this case, but changing this return code has very
little value and may disrupt userspace if it assumes EINVAL means
something else when the policy load fails.  Without a demonstration
that all the code paths have been tested I'm not inclined to merge
this patch.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index c5f436b15d19..2eb2a54b88d2 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -36,7 +36,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>         struct sidtab_node *prev, *cur, *newnode;
>
>         if (!s)
> -               return -ENOMEM;
> +               return -EINVAL;
>
>         hvalue = SIDTAB_HASH(sid);
>         prev = NULL;
> --
> 2.12.2

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
