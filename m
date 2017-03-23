From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 16:32:02 -0400
Subject: [PATCH 04/46] selinux: Use kmalloc_array() in hashtab_create()
In-Reply-To: <66451d7e-f9ff-1d53-e919-d237a24ca8a2@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<66451d7e-f9ff-1d53-e919-d237a24ca8a2@users.sourceforge.net>
Message-ID: <CAHC9VhRq053_HBeUnSLE6XutcrZDTj_YJpzTh9U0hW6jkExCJQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:01 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 12:06:13 +0100
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index 2cc496149842..dc99fff64ecb 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -24,7 +24,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>         p->nel = 0;
>         p->hash_value = hash_value;
>         p->keycmp = keycmp;
> -       p->htable = kmalloc(sizeof(*(p->htable)) * size, GFP_KERNEL);
> +       p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
>         if (p->htable == NULL) {
>                 kfree(p);
>                 return NULL;
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
