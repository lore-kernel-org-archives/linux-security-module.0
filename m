From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:38:32 -0400
Subject: [PATCH 39/46] selinux: Move two assignments for the variable "rc"
	in ocontext_read()
In-Reply-To: <1f2cc0bf-0904-0c9d-22f2-ee851214252e@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<1f2cc0bf-0904-0c9d-22f2-ee851214252e@users.sourceforge.net>
Message-ID: <CAHC9VhStnBYKyiY8__7C-txRMj=XqLkDDmvhMdUkr9qnpyrA1A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:39 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:30:12 +0100
>
> One local variable was set to an error code in two cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Dropped as previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 88730b372277..8b9ed3f1b132 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2121,10 +2121,11 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>
>                 l = NULL;
>                 for (j = 0; j < nel; j++) {
> -                       rc = -ENOMEM;
>                         c = kzalloc(sizeof(*c), GFP_KERNEL);
> -                       if (!c)
> +                       if (!c) {
> +                               rc = -ENOMEM;
>                                 goto out;
> +                       }
>                         if (l)
>                                 l->next = c;
>                         else
> @@ -2186,13 +2187,13 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                 if (rc)
>                                         goto out;
>
> -                               rc = -EINVAL;
>                                 c->v.behavior = le32_to_cpu(buf[0]);
>                                 /* Determined at runtime, not in policy DB. */
> -                               if (c->v.behavior == SECURITY_FS_USE_MNTPOINT)
> -                                       goto out;
> -                               if (c->v.behavior > SECURITY_FS_USE_MAX)
> +                               if (c->v.behavior == SECURITY_FS_USE_MNTPOINT ||
> +                                   c->v.behavior > SECURITY_FS_USE_MAX) {
> +                                       rc = -EINVAL;
>                                         goto out;
> +                               }
>
>                                 len = le32_to_cpu(buf[1]);
>                                 rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
