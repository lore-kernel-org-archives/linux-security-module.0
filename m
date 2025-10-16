Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05F2DFF1D
	for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647885; cv=none; b=Vu8pJURrcl5PqJYQPkHV9GFejIINi2T3XPC3Jt3jgPlkG8sSYLbnm+5YNoIYFvPeGMl8yxm3nJB5AdJjhFFkNe6101Dv6W62XHcMrj8k9vDlobQKOUzFZ3NHE63QRS9rOzgfJxx+QjkDZvUuka0Gde95qTeE1eSgQ2WUTbLsSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647885; c=relaxed/simple;
	bh=ZnvMvv3Uyc9J3C8aWBzZjwlgOw6eIgWOGxBQRkiX5pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpNM2hXHfVkPyeGCMV9i8n93Tyoxj53fJ7aLM+NZ4iGq4VL+qGp++Zp+NPE9eWwpNP6sqlW+Qgrgz5cGbCNl/eCvXaeKvLQvOPwjFewZJqwzf6XoBpJLTPbiqvPH+B/JYhx3Ii3s5oxcmlqV1S0SHGP2EeYGm0LdxQy/fTL4vTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jdz2QpcY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jdz2QpcY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bb0472889so1250608a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760647883; x=1761252683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3slFqNAkYoyM4phFl5MHIcyAdrPRdCqrsNsGFA+mZ0E=;
        b=Jdz2QpcY4OpiPz3kkXPLHz+stKntk/gBksswr+3BgEjD5xsnx/mCjFzes8rHkvvygI
         MDPQ9ykYU6Rz2G+Qe9zqf0RZNpGxlWd5kk7IQjzoQA7rSPDhZtrcgohKo8Ba6tUb1BP8
         mUo96v6IzNns2GlDRzCpDjdoqVtWa3yT2NKNcNjsJfwedozmGu0ec1gvZMAlf0M5RgpE
         X0psJolrWqGC5CAhNR0FiYS5ilfXzYYy+8iUCwC5/yqe01SL2fFR9ztXEvcXpwqSLo4W
         gmbXemxzV6wFll52/AFvT612vZmjSD0lhLWVo4fHqrNgs4nb8dnuY/5Mp1WU4NM95WRQ
         a8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647883; x=1761252683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3slFqNAkYoyM4phFl5MHIcyAdrPRdCqrsNsGFA+mZ0E=;
        b=m5uNKzD8hU8jvfbTxiwd80C05fiTowBr3Kre/SSx0AXY+sEsFTNbbUaSpt4W64INIS
         xzckhPwgb8g29Pi5gIt2LH0XESVJ3m8bRIS8mTjoxdBlnIpT+iKs5+Xs4927PbQ0AwnE
         8arY5lw8aC6bgZRfTDVe9Au1FNUOa+U2lyrlnzEDxEfLEBfUjWwqIlxBAjWcuN/vLt69
         SuMtbTmbKu0f/jkoaxqY06Z3T0EAbMfUI/kToHJH9h5Vap/6OveUaMvZdUK1wRN3TrQd
         W+/yZ4jaV3mGUhuedcjxczTxlzeoMoezrhOoYS8l5B8PcWkn0llZ1tF7q3alKMgQIdsi
         RoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYXutxNqkfaN5uepbkRBaUWCRcxwUEQEIBaL3Gk4xpnZkCRzavWIrtRoZp5XoqWxWsPsJX99VvUooZ3s5/CpVi5AZRNA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1hzno5rEUI6jbwEtRRpzZXQ9UQBWO5r3IpmWnGXyFswTofDx
	YFTdLWlFVl8wl0882U+7DhVbQ6g7SKyocp/aXcv/D0UChI3n4rnnUVsjuIQqEL9QIywIcnNZAQV
	Cu5qSr2oCoAuN07M4m9eCLJw2IU12aMBDsls0eCpm
X-Gm-Gg: ASbGncutaFQuEkb/JsvBwLFP0pf+1FxidFTZMEQRszpcXe0a5tDnFkGJBWi3vOwZt6q
	o9w2Lck/FmalF9c2yYc0TmT71YHikydkN0zSuOlKCrl78EhNoT7MWmUFPeWCOET+mSPdJywMQpO
	Ftl+eiz67d39y2mVDITN+uroTw+rDsQj4MPDr5jWcHC5wd1FjV84vVgTsTiIshbitFTEML597rt
	G8XftMB2j+A8SaePtuP4PJU6KwmNjtHeWtlrHusPj2FJhZuSOElBTvyIHRPjdf54H8qqRc=
X-Google-Smtp-Source: AGHT+IGFIpKOlM2KUWDCAFw2XNXedYO+QecNe/SHAxRhF4qF1dGBt4GgYLt1H/17WGv0giFrM1LZJhri7d5LlfFp9Ws=
X-Received: by 2002:a17:90b:2887:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-33bcf8fa1aamr1286108a91.23.1760647882993; Thu, 16 Oct 2025
 13:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com> <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
In-Reply-To: <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Oct 2025 16:51:11 -0400
X-Gm-Features: AS18NWCQabATt66LFXD87ybMXRR70yXNmQjQY1MqvhEq_Lvy7iGwxN8QWoiencU
Message-ID: <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > It doesn't need to, once we check both the loader and the map, the
> > > > integrity is verified and the loader can be trusted to run and
> > > > relocate the map into the bpf program
> > >
> > > You should read KP's cover letter again and then research trusted
> > > hash chains. Here is a quote from the first googled link:
> > >
> > > "A trusted hash chain is a cryptographic process used to verify the
> > > integrity and authenticity of data by creating a sequence of hash
> > > values, where each hash is linked to the next".
> > >
> > > In addition KP's algorithm was vetted by various security teams.
> > > There is nothing novel here. It's a classic algorithm used
> > > to verify integrity and that's what was implemented.
> >
> > Both KP and Blaise's patch sets are implementations of trusted hash
> > chains.  The security argument isn't about whether the hash chain
> > algorithm works, it's about where, in relation to the LSM hook, the
> > hash chain verification completes.
>
> Alexei, considering the discussion from the past few days, and the
> responses to all of your objections, I'm not seeing a clear reason why
> you are opposed to sending Blaise's patchset up to Linus.  What is
> preventing you from sending Blaise's patch up to Linus?

With the merge window behind us, and the link tag discussion winding
down ;) , I thought it might be worthwhile to bubble this thread back
up to the top of everyone's inbox.

--=20
paul-moore.com
