From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 09:55:52 -0400
Subject: [PATCH 24/46] selinux: Return directly after a failed kzalloc()
	in cat_read()
In-Reply-To: <04142c87-5826-4796-c461-ec3e80f14928@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<04142c87-5826-4796-c461-ec3e80f14928@users.sourceforge.net>
Message-ID: <CAHC9VhRg20-ZvJCcq6SA+1RGBqwA1+btLy9WKw=+=t+o35eEJw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:24 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 21:20:43 +0100
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
> index 5101592ae172..eb898dcbe502 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1635,10 +1635,9 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[3];
>         u32 len;
>
> -       rc = -ENOMEM;
>         catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
>         if (!catdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof buf);
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
