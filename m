Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75037D12E
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429469; cv=pass; b=hU0HrnaW+Doc8mEEqmYCU08YBPY4SGhxPL0grVzJpv27FJpI+oH5foc3A00uyxYj53p03tE8Y5d+swNDvsrCTwuAYzmYsjSKS/Fz/qPGqtuON1gSIL1dYYcXwYhze6JzFAh3WW6YgrlE6u6aIxX3c6Dlx8rluUlCZ6B0AtX21Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429469; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBiSzo8zEIsgUNsqu24t4Wd7Grq3Zo5W5RLws6KYYfW+qWHidAp9c4LRlBsZ/EiXVozDHrlzcpXt02/qBTHRrhPv1Y/mkSa2j/cHnxLlx+ZMYeEZRNVWj8HVwKSf6KnPAstbiQ7QcS/BIcP9GI2/kIgoRpqanUBeG2362+x1GP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nts12kSM; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nts12kSM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso41401555e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 06:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429466; cv=none;
        d=google.com; s=arc-20260327;
        b=rQaPxZbqiWDsWLibHk78TT2OqoHzCQJOLNv2h3MS5ZZB2KVdTnolaa5PpjaIG1DPRz
         /NQOCsR+xCKy4t64qUC08tRQ75oBNiAt6aR9GWg2RdvHLzy6HAbHaeodIPpr746MO7/7
         EbtLTAAVXi76XnMC+gjcQaZs9dBHrW8/oVacyZj157MgzLsjw1suapcqr5OjSsi9zd5F
         JYmwGnreWhvEFpa5GzSJd8CbTt9Ds7FixZOjmR6Z0TzNQ3RG92UWppkbnPrb45sn+mxU
         ++DIrD9TVdKbNj3L2ov9H+xJtfIyXP0d5I3NuYGw/+bvE3tR9kaMnaSRpi+VEEsjnpbW
         gZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=5cSxTn1FB+iPxToa2sVmljnMAvo6VSVwUYt9SujERFI=;
        b=T1hix4tc2u5yF4mjLye2euIqyue8FpprltoKgICQud8hf9VJdbeZZLhOFbPeHFO5NG
         LmDElnleg+vajtCtMdzAie9Nqohk/LhKZfc8Fa8J5rjR0vNnQzIHaCVGKmKGRwqESvj+
         vni4r0IjJVuu0CjZZK5YrscCW2bs3UrKzG6OP9ZlnAzMZI6l3lHDKvzR9cNBZDyOdgxX
         9EqZ+nSIY1O6MX7fusDWGHoaNt8b6THRZxvjBAH4ZbtBOnAAq8VLwrUmv4ZH5jHw0eE2
         gubPshDtQf8y8GGbdNSXBFPgYBMJbWwqxHk51TI0pl7pNhcqpPSZ8lOs0ENm4d5w3VMv
         kvtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429466; x=1784034266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=Nts12kSMv14kT3Mm7Kxs1r2f7tWqlEGnFU6tFoIeMP51PoarIMC4pShI/bvjl76EtK
         eT3KNRKzth5yyVfwhc+J3Og2gPsHACsw6eydKUS5ZEXruyJhPCzRGdCZ5eoisZKHSJY1
         oMlspWCeU2jv5eRZ6PZLiMuG7a3rpEE6QmJ2pvzGxrOvoe8aefU7t91JcO/P6Lun1uI8
         U5OMIwYqYtEHjG59SmrqN3VhGNEwmI5aLMpg6GP+FLSH63i6poR2wbERKVFFH90DEG/a
         cSbPa49XXsG5KTzY0dPmu5qDvEdnmS1UNrUq2X1hTNzhd/REC6s0q2GpWCJNnzPRejHJ
         XDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429466; x=1784034266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=V/u0QsXWoeKQmr5hXxZlOuaBxIULBTAC2Vya4qb/0j3XAM1zl5BOYBALB8i9OUgfIA
         zfyYndHhzLx6mV5D6KtIkqRsGy0aePiEf++ULtvfLqB7OlI1Xl9466YYzKZvVREKaw9+
         w7PKtPRh2vjkpXjU6BG7eoEpf+1hORlfNmGnI3bTPTellU6NOpUsL/pJ562Q6AXqqP1v
         qf21/pyA79gOv8zsObll/qMXxDhwnEEN0NA8ydxfaRDAoKdOH2AbJ1WbfBem1ic+pH0T
         l1KAF8OMOVC1+JEJbEK68XhLx0aEK9m1TrWGf/5kbAttYAGDn6gvlh1xOgzOWLtR/DjO
         /hxg==
X-Forwarded-Encrypted: i=1; AHgh+RoZQUx2OqnTLP5kpNcxudzpEzsnmmbO1y26Rjd0yYVi+QEwJK1rtNcLS+VAEr0zwHjJt7pNqDRpbOJtKy/PYJqRzXuhsrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0085/LLtmWiTkMUec7G00tWRNlSusVEA1TrJX0Ai3ZRtG27Dw
	/GX6OM2VKA+PB3+5m6nNdn0kBt1urNEZFafc4z808UX/8YYuQpppO2SNd+X3tlKnwRqrFNybUoR
	zoA8lOkancfDMmCVW01h8+6dCed1baqNl8qazE8Tg
X-Gm-Gg: AfdE7ck70sdKSR6ubkTP28Bz7FI6p6AdPCA5+sZJweLHlsoqqluE1rIA5DNYXJCS//N
	rJ1K3KWzVA6fgN/KP3RIjsPs6cBwP0NGzog9uCCC2LPlEgxlI+1dNvYMZO7ZiYfXZFX7XBK6c/j
	pmEiW+K1thketvnTJQ8kTgwqNVnJpLKgygWtCiVPybsoJA0zUCRgGLKMFA63QhQ2ZIK0f3RJ5oF
	jH5IrYzkL0gsfuwCOryAGShvlLMLcEUPSpmrJ9x96P7+jKeSN5OPvaqtKsshv+pP1RYRMbI77jr
	bCj4r4qsfTz9+QTJRveLsQtGtPI=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice
