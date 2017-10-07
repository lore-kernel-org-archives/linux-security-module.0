From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 7 Oct 2017 11:05:41 +0800
Subject: [PATCH v8 01/20] crypto: change transient busy return code to
	-EAGAIN
In-Reply-To: <1504615144-29770-2-git-send-email-gilad@benyossef.com>
References: <1504615144-29770-1-git-send-email-gilad@benyossef.com>
	<1504615144-29770-2-git-send-email-gilad@benyossef.com>
Message-ID: <20171007030541.GA29421@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 05, 2017 at 03:38:40PM +0300, Gilad Ben-Yossef wrote:
>
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 5e92bd2..3b3c154 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -39,6 +39,20 @@ struct algif_hash_tfm {
>  	bool has_key;
>  };
>  
> +/* Previous versions of crypto_* ops used to return -EBUSY
> + * rather than -EAGAIN to indicate being tied up. The in
> + * kernel API changed but we don't want to break the user
> + * space API. As only the hash user interface exposed this
> + * error ever to the user, do the translation here.
> + */
> +static inline int crypto_user_err(int err)
> +{
> +	if (err == -EAGAIN)
> +		return -EBUSY;
> +
> +	return err;

I don't see the need to carry along this baggage.  Does anyone
in user-space actually rely on EBUSY?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
