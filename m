Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA46AA9A
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117715; cv=pass; b=PhmZNzBvcBj5MMC8eurhnCOLQbyrA49jgTDPQ/0y/pwc/JE3+B/lZBKdsAvLkzAqrjEs44xwmOa+kml8wAM26A4rjLCZXRvz5nQ0lCPv/jVvDAF3Yvi+3FRjO/q8MLrBb5l+1e4Do04ZwrxrnrFYfnBx6ryj1uapU3fLkW9qvTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117715; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibKZDplQCe13cibloq9Vuz8KjIw4/54fgsFqnsXCphj6LgfRaAGvHBIWhSTcbiPbYUsHNoVIAqZUpg2Nz6oIGbSEqK1UfzRgbJ9KFtKiuJkcRF2S8eUGaOATQ1k912SMJp4oIaVWaV3v15zIuS0oV4mnYnRFL+CaYFXVtcSNFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843e397f74so406042f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=Lt6UgL/KM4nhQQuaiBHZ1nwhGU4upU8Lsz4Qa40AHk2PzwfZGPbLvx//HQw1YTo5lr
         iV2FZSaOKTwOErAJ6hFoNoi0p6Fkh9W44d828aW2H5LBL+ZBKug6ldeUDlFQJdVSsrC/
         xVopq6J4dnld013d3BZM7HFQmB1T2zmXrBuORUrjjCGZCjD4/5cA7uQhTNkUfMGdDp+f
         6QZj72qeqkqlt94tRD08iDFyva4mQXH9/BwWecKwbw4ByUO6IbX+QWFv+bH5nCoC42Zr
         VwBM0kOE0AdK1smK+NYWVQncVW4ZwdzRPqBIySGAnFjwEzdT3io+avYmZJYK2E0MWz5W
         vIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=oCNzh24qpAf8tmsDoZHJdQt2Ok9DlQsjauSggZQWq3s=;
        b=LBDzvnY1fVS8vCoaVs86q6tXqG/RIreKS6qtX2AFWBYDCyvXICi71vvShFm/cdIGzR
         MEw/pKd2YDVAOfy6ev29l/NjZIJgghBJmoe4geA49/p/MTw/fqFjSo8fFujDYZlfdpHo
         8nnPDrvgquNiPj+Wtctg/qGjKyQ12SyTsiTLgFq1ecJWatqyJb0rMPX16p7w0Spiybii
         BSy2YngGE9ba6lCGZHltPbzi8xbx16T3ny1K0u51MGqxXoYxzv5+vedXGmXXafSJ1ETy
         lkJjLk5pY6qg/IwLRXpV4OgkUFMwOrsoP9OOyK71M/8rz5UaZMlBYZu+0ZCOxOuW0j1d
         TgZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=jBM+scFM98O93KorJ48OHnSKaa/r+ToCNFc/EPv/wlRHBbRhHVZbJRjgnmV+NrnFz3
         gM1Z6FtCK5LY+YhWEmLsd+lf5RYj9J9motZJ0v9kMA8att5gjpEB2m+EryOVSYhpdy+W
         PT4jMpim0LIM8pWMG8Tm1DZSqji3KDfbb3Cy6Bt4lXnXw2KO4WM1uoDwskS1nD9ejSRw
         BSsTbjaQwhR6NMJ00d0D6ktHu6X5OxjKK//Wmcl0WHO1a+f4UEqguklJ+VefRf4A3bcl
         PoqlqCVcvHCDr7L2pA+2KY5ski0Gpcn1/bVitEBC3wmf81FsighXQH52ijRevr844JDy
         LrMg==
X-Forwarded-Encrypted: i=1; AKwUvBwvAQwKe4YlwtPuzlpisCU/MPQvl5If3eU5Q2oPZ0B2UwwFyBpQVbnfHNbse++8bDMJuVTZHy/+dz0+/rFNphA5kHoN9nw=@vger.kernel.org
X-Gm-Message-State: AFuF++mAVX/BUsJIP/KGDwyVIXYGGkBeIIy7q3VLjL0x36PXYe1OrpIn
	p7oF8JeV7mjJdqS2Vv6mW8bRgj4os9pHH6fjZCRXkOhA7yx1pDkGYK5kvBmHv3dc/Z1qOHW70sB
	TzxpUqIy7DIYXHU4JfAqL5P/22PZfskry9zdkbrnT
X-Gm-Gg: AYBFou3CKmcgib2OFa/8IJ3UppjFUnBZ4PoepxJbXjm4F7gktdm9pxnfRmgi5t2E8OY
	Gl+s5UVzTqfvg6Lhn5DZ8s5ZFZgXtW1VcrToaiFHtTzoZvuw4I59FfYdipPxv0FKdsYCApAUxFF
	v3ktMKpdF1odvA4l2QyXOUOI+PIifvuH/p8QCnBWuYpG1I96FTF+ILsqMoRfWHlAj56hm6s26dC
	yADR3n8uLYV8GNI7YTWqqgGD5ZdN2ChNqUSxRl21qGB58Youu4iRsTkM2Uw9TKSNkCh0ioV5iFU
	9IVfiT1/mfR4fmvoRfX5DMGal5yXFCIwfdwUtM3Uo4kyFUOtKy7MZgAwH/0GF5WM3pqxveTfHvF
	NoOzRLpO7HRqOqVMsd/I/YcJ+ZkLkzaQHEARKDP1IE7QeUG75fGAjA57yd4Srgob9
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
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
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
