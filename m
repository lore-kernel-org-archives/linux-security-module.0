From: fw@strlen.de (Florian Westphal)
Date: Sun, 23 Sep 2018 15:55:55 +0200
Subject: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
In-Reply-To: <20180923091611.19815-1-cgzones@googlemail.com>
References: <20180923091611.19815-1-cgzones@googlemail.com>
Message-ID: <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Christian G?ttsche <cgzones@googlemail.com> wrote:
> Add the ability to set the security context of packets within the nf_tables framework.
> Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.
> 
> Convert the security context strings at rule addition time to security identifiers.
> This is the same behavior like in xt_SECMARK and offers better performance than computing it per packet.
> 
> Set the maximum security context length to 256.

Looks good, one minor suggestion.

> +#ifdef CONFIG_NETWORK_SECMARK
> +
> +struct nft_secmark {
> +	char ctx[NFT_SECMARK_CTX_MAXLEN];
> +	int len;
> +	u32 secid;
> +};

Can you change this to:

struct nft_secmark {
	u32 secid;
	char *ctx;
};

?
We don't need ctx in the packetpath, so better to keep
the struct size small.

> +	nla_strlcpy(priv->ctx, tb[NFTA_SECMARK_CTX], NFT_SECMARK_CTX_MAXLEN);

You can change this to
	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL);
	if (!priv->ctx)
		return -ENOMEM;

> +	err = nft_secmark_secconversion(priv);
> +	if (err) {
		kfree(priv->ctx);

> +static void nft_secmark_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
> +{
	kfree(priv->ctx);

But other than this i think this is ready to be applied,
thanks a lot for making this happen.
