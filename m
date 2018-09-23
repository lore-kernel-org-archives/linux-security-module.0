From: cgzones@googlemail.com (=?UTF-8?Q?Christian_G=C3=B6ttsche?=)
Date: Sun, 23 Sep 2018 17:31:16 +0200
Subject: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
In-Reply-To: <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
References: <20180923091611.19815-1-cgzones@googlemail.com>
	<20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
Message-ID: <CAJ2a_DfCmbFmpTngFnXzYy07gvEzN5UhAhrE8Cd8PowevrLUNw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> > +struct nft_secmark {
> > +     char ctx[NFT_SECMARK_CTX_MAXLEN];
> > +     int len;
> > +     u32 secid;
> > +};
>
> Can you change this to:
>
> struct nft_secmark {
>         u32 secid;
>         char *ctx;
> };

Does the nla_policy struct needs an update too? (regarding then .len member)

+static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
+        [NFTA_SECMARK_CTX] = { .type = NLA_STRING, .len =
NFT_SECMARK_CTX_MAXLEN },
+}

NFT_SECMARK_CTX_MAXLEN might be dropped then..
