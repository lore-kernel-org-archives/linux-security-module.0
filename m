From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:28:41 -0400
Subject: [PATCH 33/46] selinux: Move an assignment for the variable "rc"
	in class_read()
In-Reply-To: <d44c1a1e-fced-5dc5-f982-319d99f78b70@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<d44c1a1e-fced-5dc5-f982-319d99f78b70@users.sourceforge.net>
Message-ID: <CAHC9VhT26gqV6wY79TU3ZQyQnKzW-AhNNFUZ2tkGSUaCwEqJeQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:33 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:10:39 +0100
>
> A local variable was set to an error code in one case before a concrete
> error situation was detected. Thus move the corresponding assignment into
> an if branch to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Dropped for reasons already discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 3af2b0849495..9035e5329ceb 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1345,10 +1345,10 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>                 if (rc)
>                         goto bad;
>
> -               rc = -EINVAL;
>                 cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
>                 if (!cladatum->comdatum) {
>                         printk(KERN_ERR "SELinux:  unknown common %s\n", cladatum->comkey);
> +                       rc = -EINVAL;
>                         goto bad;
>                 }
>         }
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
