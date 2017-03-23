From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 16:30:01 -0400
Subject: [PATCH 03/46] selinux: Improve size determinations in four
	functions
In-Reply-To: <f36c8dc9-0d90-6eee-9229-fb02d6b27708@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<f36c8dc9-0d90-6eee-9229-fb02d6b27708@users.sourceforge.net>
Message-ID: <CAHC9VhTH2OViD2+az0g9_w4x9c7hY0pxTT4B9qZrk8P0yv8-jw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:00 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 11:22:12 +0100
>
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/conditional.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 4a3bf29f7565..771c96afe1d5 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -227,7 +227,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
>         u32 len;
>         int rc;
>
> -       booldatum = kzalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
> +       booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
>         if (!booldatum)
>                 return -ENOMEM;
>
> @@ -332,7 +332,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>                 goto err;
>         }
>
> -       list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
> +       list = kzalloc(sizeof(*list), GFP_KERNEL);
>         if (!list) {
>                 rc = -ENOMEM;
>                 goto err;
> @@ -421,7 +421,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>                         goto err;
>
>                 rc = -ENOMEM;
> -               expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
> +               expr = kzalloc(sizeof(*expr), GFP_KERNEL);
>                 if (!expr)
>                         goto err;
>
> @@ -472,7 +472,7 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         for (i = 0; i < len; i++) {
>                 rc = -ENOMEM;
> -               node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
> +               node = kzalloc(sizeof(*node), GFP_KERNEL);
>                 if (!node)
>                         goto err;
>
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
