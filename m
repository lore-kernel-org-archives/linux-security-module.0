Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6621D3CC
	for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763813888; cv=none; b=ewxqQ1rssBBcn02HUzXZQzvdVtbEe6uYgIBNSbgZ7rqW0OHTi/1hh6IVCWOQ5tcY6yOhP4Mky++fUj6P/P6vp4PZQ0nUdUnWRv+hdb8lYlyeq/AyGeMPBZqR5dTQoJ0/4+wbTtFw8S2T1Y3FnunPyZLe3X5v7nLlyxpb9JuYWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763813888; c=relaxed/simple;
	bh=HTgIUGiLDQqggKOjDSgjwSIFLJZnuTP1u0eT8ENTtXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxfeIgds2YCfDcwDCCwLKv6Om+w9OFo2qPgkNIgbonpbH3hQAp334BL5jGbul3Qi5voVyKdBM0kmD55s3QKO/2JvlNB357u2p7A4TjrGhOgLY4cTs/1CZ6ZZ3BinyNB90CzX6jKkkaOMz8NtdbzudfzWpPNjfF++nUI4QbZv/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyUYy0l7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyUYy0l7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b739ef3f739so521362166b.1
        for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 04:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763813883; x=1764418683; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=girrHLR0m/g+NWHZBv9P/L4+mIbz6FyO5z2W/emw3pQ=;
        b=SyUYy0l7lKQQPxTkZRwzcSLyxQevz0G2SwyjZmoGjZvhayqI9hu3BJ9NWGQo+zz+Jf
         iPN2n6L4c/FFUBwZ7Fyw7viNxGEzJ8W9WSP22r/GUkiKzO/jx8ehqY7MMIvHIz6tLVt1
         wEaTZLhbFgGcfuKSF0sfPFUbRsuVtJ7ddrwxzXWhLOE4nUQ1coZNGdSKSA9ZgDv3YwQV
         hlOZaQvV/93ldXpLDUUDRIFq9WVey5vZyBUCAfsPMgE9oDeNocRvcCDGumU3vOVAKuTJ
         pwmiUj6WaJkfoIhX79yq6o+5c+hINstQOkDj770ApBCtyKxoW1H1qC451uESYoIUXe6i
         qSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763813883; x=1764418683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=girrHLR0m/g+NWHZBv9P/L4+mIbz6FyO5z2W/emw3pQ=;
        b=k74Cii4v4sYn+OL2W+ckgDectXuW1o3Ku8OKuzfSAkPtFYpCKVTd660JBFOOqzUxFg
         uCq/whtX7DwnPp8oQ34bATXDPE9mIuoijnO3BgP5En04i8achCq50mOmugBcFTEavzlG
         n9n+CedXEK7satmanhxvJIoxGqBAnutSK3MGKeSkvyZEraqSKoYuzNr465SLnbGq94pN
         XdKoNXRV9ogXu+KCBo0Kve5S3y15mAg3BYp87ZcynB3+wPb38+9L9YTNfLLRSmHnPJGS
         txGr90M3qmB5pMHjiCGTovYOZpAB4zJkqwvBk4Fv+SagbvkbxZ7egxcS97OSQfJr5DI0
         xsBg==
X-Forwarded-Encrypted: i=1; AJvYcCWKaoi10OOqj2uOTjFSepRnAY6ybtBH9CWWwMzgBC/fXoMTbBRn68KI7X2L+P6yx4Edvpot4NQnhIYNKXlerfFaGdubdnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuRw1WulKAKWjbDos5QGXJ+gprgwL/eOm3CkREuSW0Kcw5sah
	CEbjbjP6Ne+cS3MdKZsAYDSI8xylNa5e5h7kV+zqN9GoOOyWVAl3TOxs
X-Gm-Gg: ASbGncswOMZ+j0MUC5gapLTmle7QEyGoiuId1hAuVo6+YgGKjdGK6RuPEzy9AaHsrKP
	M2xJSls1Qz9cwg4OsbAERzbCyjnVy5u1MM55PU/sHcbDJNjI+yS/JRuP1dlMWsDPJr7H9qrw2cy
	ho0t3dyDvXdzpt5i2ozup+tN+WmhNA6VsA5CUjwdveNkPZpHdldnS6BgtuQtIYbreHdgFUQtEWp
	b7dYuETDg3yFCpWKrcFrq6w38hxKPDULxEsIUH5yZ3uwK0thpZ2aWXSWMzNdmq5ggpHzCBZMFmE
	JfQe42pBVTGNox8PjmTm9R69BbT44ncicbA+9qItccnJ3AxvSi5LHLec+9w7qyrFnxSg/sl7hsX
	rvMg3v96Yrd2p02G3vyM8uS2IsbBstR7gVqMgXW/ZqMH5RyliJW8RLZyPsiFr/mWrgsBwJ6MhE1
	+Ub6OvFdu22uJfa3pt1+J+/AUTO5Uh1ccz4wNH
X-Google-Smtp-Source: AGHT+IE1t/vYxPaVE9MtZnSqtzCrYqsVun7IMMceLZS07i4Tk93Hq5JwelP81Ii7m2d2DMmluIXGaA==
X-Received: by 2002:a17:907:1b28:b0:b73:8b79:a31a with SMTP id a640c23a62f3a-b767156fe02mr661099966b.16.1763813883115;
        Sat, 22 Nov 2025 04:18:03 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5bfsm729743866b.9.2025.11.22.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 04:18:02 -0800 (PST)
Date: Sat, 22 Nov 2025 13:18:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, mic@digikod.net
Cc: mic@digikod.net, gnoack@google.com, willemdebruijn.kernel@gmail.com,
	matthieu@buffet.re, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	yusongping@huawei.com, artem.kuzin@huawei.com,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v4 01/19] landlock: Support socket access-control
Message-ID: <20251122.d391a246d7dd@gnoack.org>
References: <20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com>
 <20251118134639.3314803-2-ivanov.mikhail1@huawei-partners.com>
 <20251122.e645d2f1b8a1@gnoack.org>
 <af464773-b01b-f3a4-474d-0efb2cfae142@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af464773-b01b-f3a4-474d-0efb2cfae142@huawei-partners.com>

On Sat, Nov 22, 2025 at 02:13:08PM +0300, Mikhail Ivanov wrote:
> On 11/22/2025 1:49 PM, Günther Noack wrote:
> > (Remark, should those be exposed as constants?)
> 
> I thought it could overcomplicate socket rules definition and Landlock
> API. Do you think introducing such constants will be better decision?

No, I am not convinced either.  FWIW, there is a bit of prior art for
"wildcard-like" -1 constants (grepping include/uapi for 'define.*-1'),
but then again, the places where people did the opposite are hard to
grep for.  I would also be OK if we documented "-1" in that place and
left out the constant.

Mickaël, maybe you have a preference for the API style here?


> > > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > > index 33eafb71e4f3..e9f500f97c86 100644
> > > --- a/security/landlock/syscalls.c
> > > +++ b/security/landlock/syscalls.c
> > > @@ -407,6 +458,8 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
> > >    *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
> > >    *   handled accesses)
> > >    * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
> > > + * - %EINVAL: &landlock_socket_attr.{family, type} are greater than 254 or
> > > + *   &landlock_socket_attr.protocol is greater than 65534;
> > 
> > Hmm, this is a bit annoying that these values have such unusual
> > bounds, even though the input parameters are 32 bit.  We are exposing
> > a little bit that we are internally storing this with only 8 and 16
> > bits...  (I don't know a better solution immediately either, though. I
> > think we discussed this on a previous version of the patch set as well
> > and ended up with permitting larger values than the narrower SOCK_MAX
> > etc bounds.)
> 
> I agree, one of the possible solutions may be to store larger values in
> socket keys (eg. s32), but this would require to make a separate
> interface for storing socket rules (in order to not change key size for
> other type of rules which is currently 32-64 bit depending on virtual
> address size).

Yes, I'd be OK with it.

Do I remember this correctly that we settled on enforcing the looser
UINT8_MAX and UINT16_MAX instead of SOCK_MAX, AF_MAX, which we used in
v3 and before?  I tried to find the conversation but could not find it
any more.  (Or did you have other reasons why you switched the
implementation to use these larger bounds?)

Thanks,
–Günther
