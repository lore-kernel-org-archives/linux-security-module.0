From: john.johansen@canonical.com (John Johansen)
Date: Fri, 23 Jun 2017 09:35:54 -0700
Subject: [PATCH] apparmor: uninitialized variable bugs
In-Reply-To: <20170623101705.3vmozsl5csrwieif@mwanda>
References: <20170623101705.3vmozsl5csrwieif@mwanda>
Message-ID: <dbc324b0-6faa-56e0-a94d-5bd986304f3b@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/23/2017 03:17 AM, Dan Carpenter wrote:
> We should be testing for "< 0" instead of "== -1" in case the return is
> -ENOMEM or some other error code.  Otherwise the string ponter we were
> expecting isn't initialized.
> 
yep

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Acked-by: John Johansen <john.johansen@canonical.com>

> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index e052eaba1cf6..c5887afb84ce 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1431,7 +1431,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
>  	if (label->hname || labels_ns(label) != ns)
>  		return res;
>  
> -	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) == -1)
> +	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) < 0)
>  		return res;
>  
>  	ls = labels_set(label);
> @@ -1715,7 +1715,7 @@ void aa_label_xaudit(struct audit_buffer *ab, struct aa_ns *ns,
>  
>  	if (!use_label_hname(ns, label) || display_mode(ns, label, flags)) {
>  		len  = aa_label_asxprint(&name, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}
> @@ -1746,7 +1746,7 @@ void aa_label_seq_xprint(struct seq_file *f, struct aa_ns *ns,
>  		int len;
>  
>  		len = aa_label_asxprint(&str, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}
> @@ -1772,7 +1772,7 @@ void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
>  		int len;
>  
>  		len = aa_label_asxprint(&str, ns, label, flags, gfp);
> -		if (len == -1) {
> +		if (len < 0) {
>  			AA_DEBUG("label print error");
>  			return;
>  		}
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
