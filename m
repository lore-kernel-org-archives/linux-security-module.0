From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 10 Oct 2017 16:19:46 -0700
Subject: [PATCH] selinux: Fix bool initialization/comparison
In-Reply-To: <1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
	<1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
Message-ID: <9b5f9458-ac5f-621b-ff0c-677de365c216@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/7/2017 7:02 AM, Thomas Meyer wrote:
> Bool initializations should use true and false. Bool tests don't need
> comparisons.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
> diff -u -p a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -550,7 +550,7 @@ int mls_compute_sid(struct context *scon
>  
>  		/* Fallthrough */
>  	case AVTAB_CHANGE:
> -		if ((tclass == policydb.process_class) || (sock == true))
> +		if ((tclass == policydb.process_class) || (sock))

How about

	+	if ((tclass == policydb.process_class) || sock)

>  			/* Use the process MLS attributes. */
>  			return mls_context_cpy(newcontext, scontext);
>  		else
> diff -u -p a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1656,7 +1656,7 @@ static int security_compute_sid(u32 ssid
>  	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
>  		newcontext.role = tcontext->role;
>  	} else {
> -		if ((tclass == policydb.process_class) || (sock == true))
> +		if ((tclass == policydb.process_class) || (sock))

Excessive ()

>  			newcontext.role = scontext->role;
>  		else
>  			newcontext.role = OBJECT_R_VAL;
> @@ -1668,7 +1668,7 @@ static int security_compute_sid(u32 ssid
>  	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
>  		newcontext.type = tcontext->type;
>  	} else {
> -		if ((tclass == policydb.process_class) || (sock == true)) {
> +		if ((tclass == policydb.process_class) || (sock)) {

Excessive ()

>  			/* Use the type of process. */
>  			newcontext.type = scontext->type;
>  		} else {
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
