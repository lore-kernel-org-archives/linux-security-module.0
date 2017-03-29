From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 10:53:24 -0400
Subject: [PATCH 27/46] selinux: Move an assignment for the variable "rc"
	in sens_read()
In-Reply-To: <6b93ee88-d4c0-b5e3-6f7e-fc74acfddd43@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<6b93ee88-d4c0-b5e3-6f7e-fc74acfddd43@users.sourceforge.net>
Message-ID: <CAHC9VhRstKMJOiyVN3mOv870=vpZQ=YDMnnREF9DGNO-ML=aLg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:27 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:02:14 +0100
>
> A local variable was set to an error code in one case before a concrete
> error situation was detected. Thus move the corresponding assignment into
> an if branch to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Dropped for reasons previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index edfcfd3bbc60..3e43556e67b8 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1608,10 +1608,11 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -ENOMEM;
>         levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
> -       if (!levdatum->level)
> +       if (!levdatum->level) {
> +               rc = -ENOMEM;
>                 goto bad;
> +       }
>
>         rc = mls_read_level(levdatum->level, fp);
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
