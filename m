From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:31:38 -0400
Subject: [PATCH 35/46] selinux: Return directly after a failed kzalloc()
	in perm_read()
In-Reply-To: <b7648542-fcd6-6852-ddcd-0b88b842e1a8@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<b7648542-fcd6-6852-ddcd-0b88b842e1a8@users.sourceforge.net>
Message-ID: <CAHC9VhQ8LhDcwf-Nbrv7YT9XxCboUZZpmBfJ519=TzNhruuBtg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:35 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:20:13 +0100
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
> index 551685283399..9b595f2e0d9f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1116,10 +1116,9 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[2];
>         u32 len;
>
> -       rc = -ENOMEM;
>         perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
>         if (!perdatum)
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
