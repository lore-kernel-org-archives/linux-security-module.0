From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 09:57:53 -0400
Subject: [PATCH 25/46] selinux: Return directly after a failed kzalloc()
	in sens_read()
In-Reply-To: <8f253493-ae7f-ca02-a6f3-333e896eeb7d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<8f253493-ae7f-ca02-a6f3-333e896eeb7d@users.sourceforge.net>
Message-ID: <CAHC9VhRf77mdk40jjQciLxbZ+x=R9ZhS9HANJigEG=ZKAyCV_A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:25 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 21:42:02 +0100
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
> index eb898dcbe502..5caa1fa5ea80 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1593,10 +1593,9 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[2];
>         u32 len;
>
> -       rc = -ENOMEM;
>         levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
>         if (!levdatum)
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
