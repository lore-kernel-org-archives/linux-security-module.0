From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 10:13:16 +1000 (AEST)
Subject: [PATCH v7 2/9] IB/core: Enforce PKey security on QPs
In-Reply-To: <1495198139-69993-3-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-3-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705220959450.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> security/security.c                  | 385 ++++++++++++++++++++++

This looks wrong -- merge problem?


> +	if (pps->alt.state != IB_PORT_PKEY_NOT_VALID) {
> +		get_pkey_and_subnet_prefix(&pps->alt,
> +					   &pkey,
> +					   &subnet_prefix);
> +
> +		ret = enforce_qp_pkey_security(pkey,
> +					       subnet_prefix,
> +					       sec);
> +	}
> +
> +	if (ret)
> +		goto out;

The above if/goto is unnecessary.

> +
> +out:
> +	return ret;
> +}



-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
