From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 10 Jun 2017 11:43:37 +0800
Subject: [PATCH v2 01/11] crypto: introduce crypto wait for async op
In-Reply-To: <1496046180-21962-2-git-send-email-gilad@benyossef.com>
References: <1496046180-21962-1-git-send-email-gilad@benyossef.com>
	<1496046180-21962-2-git-send-email-gilad@benyossef.com>
Message-ID: <20170610034336.GB14206@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 29, 2017 at 11:22:48AM +0300, Gilad Ben-Yossef wrote:
>
> +static inline int crypto_wait_req(int err, struct crypto_wait *wait)
> +{
> +	switch (err) {
> +	case -EINPROGRESS:
> +	case -EBUSY:
> +		wait_for_completion(&wait->completion);
> +		reinit_completion(&wait->completion);
> +		err = wait->err;
> +		break;
> +	};
> +
> +	return err;
> +}

This assumes that the request is used with backlog.  For non-backlog
requests this would result in a memory leak as EBUSY in that case is
a fatal error.

So this API can't be used without backlog.

We could introduce a flag to indicate whether we want backlog or not,
or maybe we should change our API so that in the non-backlog case we
return something other than EBUSY.

Opinions?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
