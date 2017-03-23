From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 16:38:21 -0400
Subject: [PATCH 05/46] selinux: Adjust four checks for null pointers
In-Reply-To: <44727e74-99ac-b0bd-2d7b-e5928d77ea75@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<44727e74-99ac-b0bd-2d7b-e5928d77ea75@users.sourceforge.net>
Message-ID: <CAHC9VhTef4bBy2VKR1m=fJ3z4RMJWj6UitkijB34w5zh4GwB5g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:02 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 12:36:59 +0100
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> The script "checkpatch.pl" pointed information out like the following.
>
> Comparison to NULL could be written !?
>
> Thus fix affected source code places.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/hashtab.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I'm not generally in favor of style changes like this, but I'll accept
it since there is something to be said for better compliance with
checkpatch.pl.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index dc99fff64ecb..3858706a29fb 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -17,7 +17,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>         u32 i;
>
>         p = kzalloc(sizeof(*p), GFP_KERNEL);
> -       if (p == NULL)
> +       if (!p)
>                 return p;
>
>         p->size = size;
> @@ -25,7 +25,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>         p->hash_value = hash_value;
>         p->keycmp = keycmp;
>         p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
> -       if (p->htable == NULL) {
> +       if (!p->htable) {
>                 kfree(p);
>                 return NULL;
>         }
> @@ -58,7 +58,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
>                 return -EEXIST;
>
>         newnode = kzalloc(sizeof(*newnode), GFP_KERNEL);
> -       if (newnode == NULL)
> +       if (!newnode)
>                 return -ENOMEM;
>         newnode->key = key;
>         newnode->datum = datum;
> @@ -87,7 +87,7 @@ void *hashtab_search(struct hashtab *h, const void *key)
>         while (cur && h->keycmp(h, key, cur->key) > 0)
>                 cur = cur->next;
>
> -       if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
> +       if (!cur || (h->keycmp(h, key, cur->key) != 0))
>                 return NULL;
>
>         return cur->datum;
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
