From: christophe.leroy@c-s.fr (Christophe LEROY)
Date: Tue, 17 Oct 2017 12:50:41 +0200
Subject: [PATCH v9 17/20] crypto: talitos: move to generic async completion
In-Reply-To: <1508059209-25529-18-git-send-email-gilad@benyossef.com>
References: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
	<1508059209-25529-18-git-send-email-gilad@benyossef.com>
Message-ID: <b75d3b02-2aba-124c-ccf5-7241775c004c@c-s.fr>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Le 15/10/2017 ? 11:20, Gilad Ben-Yossef a ?crit?:
> The talitos driver starts several async crypto ops and  waits for their
> completions. Move it over to generic code doing the same.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   drivers/crypto/talitos.c | 38 +++++---------------------------------
>   1 file changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index 5bd8191..9c80e0c 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -2160,22 +2160,6 @@ static int ahash_import(struct ahash_request *areq, const void *in)
>   	return 0;
>   }
>   
> -struct keyhash_result {
> -	struct completion completion;
> -	int err;
> -};
> -
> -static void keyhash_complete(struct crypto_async_request *req, int err)
> -{
> -	struct keyhash_result *res = req->data;
> -
> -	if (err == -EINPROGRESS)
> -		return;
> -
> -	res->err = err;
> -	complete(&res->completion);
> -}
> -
>   static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
>   		   u8 *hash)
>   {
> @@ -2183,10 +2167,10 @@ static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
>   
>   	struct scatterlist sg[1];
>   	struct ahash_request *req;
> -	struct keyhash_result hresult;
> +	struct crypto_wait wait;
>   	int ret;
>   
> -	init_completion(&hresult.completion);
> +	crypto_init_wait(&wait);
>   
>   	req = ahash_request_alloc(tfm, GFP_KERNEL);
>   	if (!req)
> @@ -2195,25 +2179,13 @@ static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
>   	/* Keep tfm keylen == 0 during hash of the long key */
>   	ctx->keylen = 0;
>   	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> -				   keyhash_complete, &hresult);
> +				   crypto_req_done, &wait);
>   
>   	sg_init_one(&sg[0], key, keylen);
>   
>   	ahash_request_set_crypt(req, sg, hash, keylen);
> -	ret = crypto_ahash_digest(req);
> -	switch (ret) {
> -	case 0:
> -		break;
> -	case -EINPROGRESS:
> -	case -EBUSY:
> -		ret = wait_for_completion_interruptible(
> -			&hresult.completion);
> -		if (!ret)
> -			ret = hresult.err;
> -		break;
> -	default:
> -		break;
> -	}
> +	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
> +
>   	ahash_request_free(req);
>   
>   	return ret;
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
