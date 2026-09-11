Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA17471CF5
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117801; cv=pass; b=f4dB7CzukfpJj1HG5IOIvc2wEqo6zNlRHNjMLRNc/TY0bgThv16B8eeIWmLGuWVhQVlbqdIhFD7JmnGI+R/n5NaGvcQdSPPqXSsEMt4Fsuzj2FJ+R+WO3rawezn+crK/vEZYKWnqWJaJ+v0IW9HwgdhjbmCuA5kPHJoKPPw64yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117801; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpMCgxIEA4gdg/WMCX09KM8KvvO9Zmzt3KmJO1LtlaPDHL1p5xSqHW6xiZlHedmaSHNq7wRgLXX0EmA1H7DdunLetqCJiYI3HuKefwYwx2WolrebwqbwgEWJg7U3FDm0YDyY12Rrmxts/yDJr0f7BjWJyM6NGkOBzyuRpmF/nzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSlPe9Et; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSlPe9Et"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47de0093c42so599197f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 02:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117793; cv=none;
        d=google.com; s=arc-20260327;
        b=A/JaBNSyPXJQ8FXQunDNBchgqUXQxQ+TvFwQI/0gmbR5E3DXGuuBk/hdWjA/6FeC23
         sAz1NlNFCCQH3pRZACkK29+1T57xBo7U5mp1bepLwEKa2Vy5rSwA3hyJvdsVMaf0VS1j
         KqxImbJt54IBYy2Ge6xaNbKhNK0mckvTPGq/vti7ieQPKDvTmXs6qmCOB22wKh3e5qj7
         sm/DCmsls6iw26a5gfvAWOZFlCC056ELfXpv/qQrwGYDz74zeEdaMljlFSrdhTSntySt
         hUMucgpZdhGsoQstQJFqYjM892GpEecJlPwPQLOJXVQnyUykfZ17Vrui77zLSu2TsgLD
         x8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=XK0Ifhrl/6/u6BPwKrvOOrngRI39HElBQfGOXlhBSWM=;
        b=HwJ7P7uEqqiXLqw0AwbzoSgiyptgLnrwy23qL+lMnScr4UbSTlEnR/29b5N+hGGev0
         ORh/uBGAZ1LaN4MrXIktMRJHABMyQivqPc1jJFyj0CCQ+LYjg+xGGxAKswfJvZziqvcy
         JMplkUB+vI8JuWw6g6pp99j3NBvE4phMbrWbfbv1MXspFN/RTXOBC1h1XepxYNOB+JOW
         D1XUiinU5hF8ceFUwX7no6K66yUCl/7y1ykHnCQDY0dVLUBKu5UFmmevJ6egMyEPDsBL
         U6bIdlX9b6Pjm5wxYuUar1HasqElRRycrPeynvgT35gtW/2E2izMrHFZ9Fa1IrLKq33Q
         pDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117793; x=1789722593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=MSlPe9Et/aYooxs+mmr25pr80uFZG23i1Ff+HYNwoUYblRVkid0l2inKFKvyYhCHpA
         74RMEIvUI+LYnoLKLKfOmV3XsO+idJkaF0kKg+yth0rRQtl5E2y2iqZ2+BzrV44esGe9
         Gfqu0/0FtTeTt/gj1nMdkeGllp4GG8/dPMW6SAduAajB2PJTTh0EyTtISUFtDK6olxs/
         iuCpPN7ycYnpIx1qtI10WS4KO12IM90KAskYtoHYQeaRXYEsRQKGp3BGi7i/JLvOBusZ
         K3RJXi816wGUGyT/m2NeekI8C+6tI9P5dFmWFfKhpigFYWlsVGwnGy/m0LuueQHmrlvX
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117793; x=1789722593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=TFcIt8lIynuW1hNspPwCaM66mV51Nu5ZL7fG3TJ2SFuh4y4ss89H6mNxgKGZLYBxuy
         sj1amtAmZ1BT50Z9KeEC5ob5q2HQEIA1ySJhJuc9Ge85huCrJ18jRDwk48IypA1ioBcf
         r0st+w6wbeQ1CnZe+oU8YC6Dpny21pTrmv6vVKv3HZzlX/BaGFtpUr+HXbUtzCVwpf/4
         L/aTCylaGnYbegFCeSNB+dh3Jt8vcY6Iq/PWe+CG47BYn5X5FC7HUU+JAAduBfywsUGx
         8rhB6wMdh7YZHLzf2OGta15xMdpUzswjl+yKcZh03fM6/LQda1XW6y8RELEnmOPivarm
         dBjg==
X-Forwarded-Encrypted: i=1; AKwUvBx19yDyptCE1J+/MpSuD0BNUGPh7FQl3UJ+qQ+Scak/FzGOLkFxM8srn8O94j14a/1o7Gq/OwYcfwXgjQyjiPKlfVfVtWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mCxeTM6dC57Vaa0rxFGDhHJJzPlAMBGhRFMOjnIKzGUJRC2Ver
	y3AaN1E0pMjxPOWFbEbJZys9XgMOVtBhcXHDUnNdu9qetGXLLJMA6/BTqBLnQ0RmppwXZ2gQGXY
	rb7WU+DWE3N9TQfb4PDrCnnwD0KW431bhZPzoQxk8
X-Gm-Gg: AYBFou2lzyxjJR6lr2zIMLlCpjSgyob+w0zjZ5y20fQb+Q9+UeDptlplHtYGndfVUvi
	RqqkM10NwHmGx6lyJWsQ38dEw7kKf4rdftAXXnaicJcNg9D+OFnvc9w4fUDSFhc/6aE9/EnUngF
	eqVYdlHdpZqMN9EBtpDSEGERUfFULRiaqmTh9kDVsGBOwDEWNc5bS70yQMVjLGwPfEBvdKa70lJ
	S1/b+APMZ/G2voz1WqQ65ILpe9tbSyaQIWykrYr/aF2oW8Uf+i0nRxpu1i5bW8pIGtJ1R5sIMTi
	NL69Qmwb+EsXdWf92sZiGX1M6xa9CMzhVUpbB1FfYzKJcuno9R7evONyuo3JnmbADoK1aWsXYWi
	W0ZDT9sGT2u292v1R0Z8XGSzEEiytWM5E71kjLtu/CYp9U8XnBKem
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
