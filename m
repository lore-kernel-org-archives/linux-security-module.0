From: paul@paul-moore.com (Paul Moore)
Date: Mon, 16 Oct 2017 18:42:19 -0400
Subject: [PATCH][V2] selinux: remove extraneous initialization of
	slots_used and max_chain_len
In-Reply-To: <20171014153856.3539-1-colin.king@canonical.com>
References: <20171014153856.3539-1-colin.king@canonical.com>
Message-ID: <CAHC9VhSzWMuYU4QbE_8rFGJFVaQhNVyQMKd1xcs5BrDj0NrmCQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Oct 14, 2017 at 11:38 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variables slots_used and max_chain_len are being initialized to zero
> twice. Remove the second set of initializations in the for loop.
> Cleans up the clang warnings:
>
> Value stored to 'slots_used' is never read
> Value stored to 'max_chain_len' is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also merged, thanks.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index bef7577d1270..e0443f4afea5 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -150,7 +150,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
>
>         slots_used = 0;
>         max_chain_len = 0;
> -       for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
> +       for (i = 0; i < h->size; i++) {
>                 cur = h->htable[i];
>                 if (cur) {
>                         slots_used++;
> --
> 2.14.1

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
