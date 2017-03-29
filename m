From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:40:58 -0400
Subject: [PATCH 41/46] selinux: Move two assignments for the variable "rc"
	in roles_init()
In-Reply-To: <aa7a9b62-1016-2e22-6104-d992d6b556bf@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<aa7a9b62-1016-2e22-6104-d992d6b556bf@users.sourceforge.net>
Message-ID: <CAHC9VhQEWP=+wM1tXrXaWW0rfzB1Kh5JMJUGksM+ahZQNuevmg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:41 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 12:40:35 +0100
>
> One local variable was set to an error code in two cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Dropped for reasons previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index ccc146bfd4c2..be445abf047b 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -182,15 +182,17 @@ static int roles_init(struct policydb *p)
>         if (!role)
>                 return -ENOMEM;
>
> -       rc = -EINVAL;
>         role->value = ++p->p_roles.nprim;
> -       if (role->value != OBJECT_R_VAL)
> +       if (role->value != OBJECT_R_VAL) {
> +               rc = -EINVAL;
>                 goto out;
> +       }
>
> -       rc = -ENOMEM;
>         key = kstrdup(OBJECT_R, GFP_KERNEL);
> -       if (!key)
> +       if (!key) {
> +               rc = -ENOMEM;
>                 goto out;
> +       }
>
>         rc = hashtab_insert(p->p_roles.table, key, role);
>         if (rc)
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
