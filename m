From: tycho@docker.com (Tycho Andersen)
Date: Tue, 1 Aug 2017 11:17:02 -0600
Subject: [RFC PATCH 3/5] ima: mamespace audit status flags
In-Reply-To: <20170720225033.21298-4-mkayaalp@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-4-mkayaalp@linux.vnet.ibm.com>
Message-ID: <20170801171702.f2szj5huzbt7fdfl@docker>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mehmet,

On Thu, Jul 20, 2017 at 06:50:31PM -0400, Mehmet Kayaalp wrote:
> --- a/security/integrity/ima/ima_ns.c
> +++ b/security/integrity/ima/ima_ns.c
> @@ -301,3 +301,24 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>  
>  	return status;
>  }
> +
> +#define IMA_NS_STATUS_ACTIONS	IMA_AUDIT
> +#define IMA_NS_STATUS_FLAGS	IMA_AUDITED
> +

Seems like these are defined in ima.h above in the patch, and
re-defined here?

> +unsigned long iint_flags(struct integrity_iint_cache *iint,
> +			 struct ns_status *status)
> +{
> +	if (!status)
> +		return iint->flags;
> +
> +	return iint->flags & (status->flags & IMA_NS_STATUS_FLAGS);

Just to confirm, is there any situation where:

    iint->flags & IMA_NS_STATUS_FLAGS != status->flags & IMA_NS_STATUS_FLAGS

? i.e. can this line just be:

    return status->flags & IMA_NS_STATUS_FLAGS;

Tycho

> +}
> +
> +unsigned long set_iint_flags(struct integrity_iint_cache *iint,
> +			     struct ns_status *status, unsigned long flags)
> +{
> +	iint->flags = flags;
> +	if (status)
> +		status->flags = flags & IMA_NS_STATUS_FLAGS;
> +	return flags;
> +}
> -- 
> 2.9.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
