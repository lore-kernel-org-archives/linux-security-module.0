From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 16:24:34 -0400
Subject: [PATCH 01/46] selinux: Use kmalloc_array() in
	cond_init_bool_indexes()
In-Reply-To: <68a423a9-2f89-55f9-fb4c-97dd4df4bb1d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<68a423a9-2f89-55f9-fb4c-97dd4df4bb1d@users.sourceforge.net>
Message-ID: <CAHC9VhSmRJzKZnGCiytijY-wuZqPGFOdEfecPgy5D3TciPCCgA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 9:56 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 10:48:28 +0100
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
>   This issue was detected by using the Coccinelle software.
>
> * Replace the specification of a data type by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/conditional.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged, thanks.  Sorry for the delay.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 34afeadd9e73..fcfab2635c11 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -176,8 +176,9 @@ void cond_policydb_destroy(struct policydb *p)
>  int cond_init_bool_indexes(struct policydb *p)
>  {
>         kfree(p->bool_val_to_struct);
> -       p->bool_val_to_struct =
> -               kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum *), GFP_KERNEL);
> +       p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
> +                                             sizeof(*p->bool_val_to_struct),
> +                                             GFP_KERNEL);
>         if (!p->bool_val_to_struct)
>                 return -ENOMEM;
>         return 0;
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
