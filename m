From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:40:13 -0400
Subject: [PATCH 40/46] selinux: Return directly after a failed kzalloc()
	in roles_init()
In-Reply-To: <2c370330-a80c-9879-2013-3a99a21dc06d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<2c370330-a80c-9879-2013-3a99a21dc06d@users.sourceforge.net>
Message-ID: <CAHC9VhStS59YiUoBhKqWPgN17wQ_5iXGfDgY2QTQPdUkWip3EA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:40 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 12:10:09 +0100
>
> Return directly after a call of the function "kzalloc" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 8b9ed3f1b132..ccc146bfd4c2 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -178,10 +178,9 @@ static int roles_init(struct policydb *p)
>         int rc;
>         struct role_datum *role;
>
> -       rc = -ENOMEM;
>         role = kzalloc(sizeof(*role), GFP_KERNEL);
>         if (!role)
> -               goto out;
> +               return -ENOMEM;
>
>         rc = -EINVAL;
>         role->value = ++p->p_roles.nprim;
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
