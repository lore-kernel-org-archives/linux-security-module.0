From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 17:33:52 -0400
Subject: [PATCH 09/46] selinux: Delete an error message for a failed
	memory allocation in policydb_read()
In-Reply-To: <c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
Message-ID: <CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:07 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 14:20:41 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

I'm not going to remove an error message without some better reasoning
in the patch description.  Providing a link to slides is fine, but
your commit message needs to convey the important information and I
don't think that is the case here (what happens when that URL dies?).

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index fe8992382a71..53e6d06e772a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2269,11 +2269,8 @@ int policydb_read(struct policydb *p, void *fp)
>
>         rc = -ENOMEM;
>         policydb_str = kmalloc(len + 1, GFP_KERNEL);
> -       if (!policydb_str) {
> -               printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
> -                      "string of length %d\n", len);
> +       if (!policydb_str)
>                 goto bad;
> -       }
>
>         rc = next_entry(policydb_str, fp, len);
>         if (rc) {
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
