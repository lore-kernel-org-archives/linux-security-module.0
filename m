Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AB1A2632
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481844; cv=none; b=Yil8+0Pt6q2phPn5t3VmNOmUBxlG3KLliNhqwEWw3O8Z4MN7XdsPOz7RQU6NCabRRtrAxzPct71aJjoVZnMS3WmgjDAdKeLyy3qvHQlW44cbE41W3YQS4BLBOQZBBCal056tWIzYTVQfevVsA96/yyE69IYClLgns8UvEFO42Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481844; c=relaxed/simple;
	bh=5Ze0oMVpd7esn17n48EUZ828ncrIkV3f/lwhsAsJY8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1WLb6R0yrNLNhpPe8I3gEsHMp5abMM/YDDDYMPtGLbnt4QBOZuAq4QvUHx4TfmjHR0DkUq6BlVQK433qoLn7aqLyWyDWnvfdSEa8CdgtGmTcq/A/GxFq11aFR0qRTe8IeQTEPLisvpJ8w9keqFZV0sLmeSpVMm9/fGHtrtCiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcMkgBSZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcMkgBSZ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1384418f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730481841; x=1731086641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U8boQju9UD7cMDd+o8Hz/4j/OEfee/wZzmom4khjls=;
        b=BcMkgBSZSGzjSA2aSwlo3a+/hkzsuQgtY+yjss8JyTLJtojWDcYLW1ySgiPnTzHVU8
         rMEUUW/aaSS+T1lDTJnZwCDOGVJ8Z03+Ps5Olpn016y8fVnaMNzqi+1kTtplusk/ahCT
         mYm00Bom+TFW+lKaePe7aktNPcU0WTT85yau6SGeuZwhqP3dEkVk3TyN9db1KVPmhVuR
         EEM8p4pyObROAHzz/2f/OUj6N8m1q1vxIq59rsDTQNQ8J94wwt0m0/7HUdHquYTNCt8H
         MHVjJ8ZeLBdPRzRuRgu1hH72TamdTDQnTR2JlHJmvKmHw+d1OteqAiXTQazDBxgBCqz3
         UKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481841; x=1731086641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U8boQju9UD7cMDd+o8Hz/4j/OEfee/wZzmom4khjls=;
        b=TXNI4tQf6NfySTrV2ub2mIQIf+s13SC2kzMYqWvw4ckaF38JinQuIk+GUZFwCbSYDA
         6v4N2AKqTR0Q7044J49CJfCmmrZ2dzoGwDr9yGGZZhYEEZBTBRE+VhJRzovqvDfw8U1c
         E3rn1uvJWWUaZKJMTOExzGLxJXTYfqRPzSuNjn/QQniX65nKr3shmXWhiV/fejTv39ND
         ymjBismc6DLt0pOs2WW0h3W11HuFdCyJ9m2VlMjWPl+Uq6DO9n+KR/gqcqUiS04ASbeg
         rpkZ4AQ/UyKxaKXL1eNgaHl2NeM3KCCS0MD7hSWvvBzBiRIQFqWPnCVgi8wT0yOl9RS3
         5HZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2T5rgFKexKGgvkXlDyGJtEq5y24xGlEgCD/tuAsm3/WI4U0/Ayilst1pH+zI+U8xis3R709Y7Ni51doqcYVCTOF7m2pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LaFyB2RT6hogQxNrxDzKQvX7Dm+kzcLoj6qBcCO+QUgiLTbD
	V3/iBC3vFXFc1qQW8H4fCm2YivDmYvP83eREYs1qD/vTXrzhCkb3XYoB9XlftiYs3+EMgn7W4BZ
	N4ud1ycIy+6uasIAZTXXcIBI9i3mOAD9Hw04Y
X-Google-Smtp-Source: AGHT+IF4hcxyedLIMOPn8nMy7+F641Gd27skBE/RYnN0eX7rdXQ6YzSyerup1MTKbgeibRz0uXbWgXKA/vaNrfr5FlE=
X-Received: by 2002:adf:f18c:0:b0:374:c621:3d67 with SMTP id
 ffacd0b85a97d-38061137930mr17910173f8f.24.1730481841156; Fri, 01 Nov 2024
 10:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
 <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com> <CAHC9VhTQMo11s7mWg=zzDusJompOp01uJat-q9HjQCoEWzHRRQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTQMo11s7mWg=zzDusJompOp01uJat-q9HjQCoEWzHRRQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Nov 2024 18:23:47 +0100
Message-ID: <CAH5fLgi+JJHCA_XTPC0-kaacZC6=aGSa-+DiNt06GSJNFhKc3w@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Paul Moore <paul@paul-moore.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, naresh.kamboju@linaro.org, 
	casey@schaufler-ca.com, anders.roxell@linaro.org, arnd@arndb.de, 
	brauner@kernel.org, dan.carpenter@linaro.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, ojeda@kernel.org, 
	regressions@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Fri, Nov 1, 2024 at 5:56=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > Thanks Alice.  Would you like me to pull this in via the LSM tree wit=
h
> > > the associated LSM changes, or would you prefer to do this some other
> > > way?
> > >
> > > I'm going to merge this into lsm/dev for now so that we fix the issue
> > > in linux-next, but I'm happy to drop it or do something else, let me
> > > know.
> >
> > Christian has the VFS side, and both are needed for this -- do you
> > mean you will cross-merge vfs' branch too?
>
> I think our last emails crossed paths.  I'm not going to merge this
> via the LSM tree as we don't have the Rust security.c helpers.
> Ideally it would have been better to have the Rust LSM/security
> helpers in the LSM tree for reasons like this, but it looks like it's
> too late for that now.

If Christian is okay with rewriting the vfs.rust.file tree, we can
drop commit 94d356c0335f ("rust: security: add abstraction for
secctx") from there and I'll update it and send it for inclusion in
the LSM tree instead. I'll need to drop the piece that ties together
`struct cred` and `secctx` from the patch, but I can follow up with a
small patch for that for the 6.14 merge window.

Alice
