Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA608462
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768810; cv=none; b=CSyzyVAHKSs2Pns5yNfK9P5OQerBzzFFIUWqGXBocYT2iXiL3fyw+YDhIyRNFLRi6efgSAYer++p62HkLmBtmcmHJebWnAS2OfbF+sjxxU//SmM1KdIMVhn2eDYn4fEuHndZKwaxpKqYRXQriZ/Erlws1YvPt+UFLKqP8n1TB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768810; c=relaxed/simple;
	bh=jrkPuDGTiolihR/vEo6Q8QqA0Opl6OIz6h59jIk7vJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6oDjtALyis4YhwTzurXuZJ4Vix5kTxK9Q9qyXmRrsdE4lrFS/NRu0GMYUpTXju50pMJ5+6f9dqXQEFEpIAp2/xD0cRVfIvv3LFNb8T5V1M9NM1/cZRMctILuchiyhtyCI3FrytMoSa1QJbUCoFYsLBFpEQxpVTQrN/VysJmY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SpBXkFh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SpBXkFh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so1185351f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767768807; x=1768373607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftMrkjbLTkMIJ1Is6EUKDchzlG6OICkmtkENXfbqQsM=;
        b=1SpBXkFhwbMJ3zo/YfWodZl+h4F7s9jg7BAc7LaoU6VCw/qzT10fiwzh3+V3KRyHVj
         iDsgAlRe1K1FMKuaCYCKsmzuPsKC6oBOmvllPo17xb14wEfMRCXhjMAJUX4j+ZRamxvh
         zbJUFPg6mJb+8rzOfnRRTtcRvS7dH010zp2fRMR+e7WTfv4V1PvOm4dcBLK13bekLsvY
         Kf5xg7Xv1wo8F13i2Da0dsq5euFK+eSH2yuqTP6bUfRbev7nP9KFxtDXKHoh+FsV7mcM
         efrTsJjIm5RSs1rA51pHne30gZLh/HsEvAZWWYykXm5Kp9yUGA2gO18H5KtWaegsF3Q0
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768807; x=1768373607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftMrkjbLTkMIJ1Is6EUKDchzlG6OICkmtkENXfbqQsM=;
        b=WurOAocAniYUw+R5MPh2hkI0C0GULOMllsplpoLy3Mb5dbYnh/gjMdLr+OzGjivdeM
         FSW0MOik7cdtASsUpHxBvzMak3tR+7Fp6sbmUvhdtcFaio/LGeVFThykio/Vcl/CXKJB
         xesYNZ+FqHUHxdkebtFtO7yVPMSTJZkUvsaCS8fwMh4pQnHGHJU+Iok4FsxScrQFqtPe
         BhM6devrC3FL7eVMvP/aWo7MdHeB5cTIfllsSt8gz9/brEbIWVSfQmMDCiUk7vaoJN/N
         gxfdI5BPwR+2eNqoXw0Qb8lXNuAOSPgRYX/w9rCtb0VMbrK38sfMNyDcCN6HXxlHQeGA
         rc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG6f9SxsfD8ELMql3KnYOXZVlfN8WtQxfYthbQ4IXE+WZAPLXw31i8+EyPGA07lluksQdoO81Cft/LxwHNjl8FU2q35Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLUILUL7CAOb9+lvI2zuP0kExUoML0m9kv2dmJ3XlA3mkvlWU
	aA6MTZCO2MSFPM18dQTSiyGb7bHruYRNQRmAJMm4YHhqhZv9T/R/5AUgNplUCaAEB5iWy9aPpEM
	aWfIozakMUe6NSqRk8lJN8MnN+58PSUUBCZYeTne3
X-Gm-Gg: AY/fxX5UQSFNcoE16DhVts2riTMdUEGG+CWRfdVQpSO/txqaGuZCSpGasu9jO1begiW
	TPe2rog1GBRBD8NBspB9qnaXsGqbdLfN0UIiuRCOexaiKTqt5KcNNqKyFNPuyo+7+Dvb9cHP4Wc
	nake5+LR9S0BCWbLCM+Z4jgeLrO5cqFDLeIfRarzqSeLoWJhDGQkM7ddhIxttEWvykyGJYgNbei
	6xJXhtNIVzPaKZwPK79Sp3xblF5Iz0Y2xefA0YngDjBsD/5/poDLefDhMjdlBvdXXws5vp0ZaM7
	7fDYr52X3IkS3nggTWg+vkoaOQ==
X-Google-Smtp-Source: AGHT+IEjAhqtoONLv/iwA0CFBn+Uwj5PihwOj87nJUWY/sVKgH68AkQ1t3GnlUdng6bIfpv4YqxXHEhAlQKOrqGevUs=
X-Received: by 2002:adf:f08e:0:b0:431:5d2:4526 with SMTP id
 ffacd0b85a97d-432c379090dmr1314740f8f.19.1767768806936; Tue, 06 Jan 2026
 22:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-7-51da5f454a67@google.com>
 <CAHC9VhQthnDRi3yXxnD8W_vAsxKOJPh8Zd1YxpF_fU5YGkj3SQ@mail.gmail.com> <CAHC9VhTqptD8_QWsUehss27AEhQq8oi6=rtA+dQTCAO1VoEYbQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTqptD8_QWsUehss27AEhQq8oi6=rtA+dQTCAO1VoEYbQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Jan 2026 07:53:15 +0100
X-Gm-Features: AQt7F2p5Et4_k3ESiLdsgvFvqpKALHmLYipgva6urpkNVC2TaPrSBtZC-xQiqyQ
Message-ID: <CAH5fLgi2XBLpyJhUvM4-ry4ZKbBKtheHyH0w-1B5hNySqj_Tpg@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] rust: cred: add __rust_helper to helpers
To: Paul Moore <paul@paul-moore.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 2:29=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jan 6, 2026 at 8:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Mon, Jan 5, 2026 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > >
> > > This is needed to inline these helpers into Rust code.
> > >
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > > Reviewed-by: Gary Guo <gary@garyguo.net>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge Hallyn <sergeh@kernel.org>
> > > Cc: linux-security-module@vger.kernel.org
> > > ---
> > >  rust/helpers/cred.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> Ooops, sorry, I just saw that these were okay to merge into the
> various subsystem trees.  Merged into lsm/dev, thanks.

Thanks!
