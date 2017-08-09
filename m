From: dhowells@redhat.com (David Howells)
Date: Wed, 09 Aug 2017 10:33:53 +0100
Subject: [PATCH 3/3] net: rxrpc: Replace time_t type with time64_t type
In-Reply-To: <CAK8P3a2WU5uYddGrkWhyfNB4qTEDYne_pyCVG6n5b1w+vb1-OQ@mail.gmail.com>
References: <CAK8P3a2WU5uYddGrkWhyfNB4qTEDYne_pyCVG6n5b1w+vb1-OQ@mail.gmail.com>
	<cover.1502246501.git.baolin.wang@linaro.org>
	<8ac57c96bf5a0695ecc67fd230440b0b9d15740f.1502246502.git.baolin.wang@linaro.org>
Message-ID: <6767.1502271233@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > @@ -533,8 +536,9 @@ static int rxrpc_preparse_xdr_rxk5(struct key_preparsed_payload *prep,
> >              pptoken = &(*pptoken)->next)
> >                 continue;
> >         *pptoken = token;
> > -       if (token->kad->expiry < prep->expiry)
> > -               prep->expiry = token->kad->expiry;
> ...
>
> I'm still slightly puzzled by what this function does: it does have four
> timestamps (authtime, starttime, endtime, renew_till) that are all
> transferred as 64-bit values and won't expire, but then it also uses the
> 32-bit expiry field in rxrpc_key_token->kad->expiry instead of the 64-bit
> rxrpc_key_token->k5 fields.

Good catch.  This is a cut'n'paste error.  It should be using
token->k5->expiry here not token->kad->expiry.

> This appears to overlay the first 32 bits of the
> rxrpc_key_token->k5->starttime field, which is also a time value on
> little-endian architectures by chance, but I would assume that it's always
> in the past, meaning the keys would already be expired.

Yeah - I'm not sure why it works.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
