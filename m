From: jmorris@namei.org (James Morris)
Date: Wed, 30 May 2018 08:54:06 +1000 (AEST)
Subject: [PATCH 1/2] security: Move LSM registration arguments to struct
	lsm_info
In-Reply-To: <20180517070052.GA22158@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180517070052.GA22158@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <alpine.LRH.2.21.1805300853590.14712@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 17 May 2018, Sargun Dhillon wrote:

>  struct security_hook_list {
> -	struct hlist_node		list;
> -	struct hlist_head		*head;
> -	union security_list_options	hook;
> -	char				*lsm;
> +	struct hlist_node			list;
> +	struct hlist_head			*head;
> +	const union security_list_options	hook;
> +	struct lsm_info				*info;

Kees asked if this field should be const in response to your 01 May 
posting.  Please address this.

Also, I'd love to see more folk review & ack these patches.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
