From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:18:00 -0400
Subject: [PATCH 22/46] selinux: Delete an unnecessary variable
	initialisation in range_read()
In-Reply-To: <d5af857a-d19d-265a-2378-3e98b176c5ec@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<d5af857a-d19d-265a-2378-3e98b176c5ec@users.sourceforge.net>
Message-ID: <CAHC9VhTU=f3bDy5o0PBnrcHHfQTMh6E=Ut=o6SO_72UtqGHsUg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:22 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 20:40:12 +0100
>
> The local variable "rt" will be set to an appropriate pointer a bit later.
> Thus omit the explicit initialisation at the beginning which became
> unnecessary with a previous update step.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 0d2f64558c0a..6121a26ada64 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1839,7 +1839,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
>
>  static int range_read(struct policydb *p, void *fp)
>  {
> -       struct range_trans *rt = NULL;
> +       struct range_trans *rt;
>         struct mls_range *r = NULL;
>         int i, rc;
>         __le32 buf[2];
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
