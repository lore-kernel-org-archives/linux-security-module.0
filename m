Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAC31D375
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571398; cv=pass; b=mCrCbcGkYLmlnujuUps+K0t1N1jDKXYBKyhVWWENzJCBgbXHsDRiM4oRi2YlutqVdm83VBAj7RH9Dn+4EgSUE5tso5DpZOQnWw2olsThIHPN/6HFxQUibRiVwCILQ/j8MhNo0HLwvTitXBbszM1KwlsSCMmlVw4Rd6yMmLM0hJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571398; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T01Wj1Fd+gSGubz3WlKxMMwx41I7+tI/fQAPzhpD6zIq7HTaU33lJHAp3jSvtH0rDeHonFAsbZsOZvv/t41BJrBwCmcw0EFfaIO231CqIY9ob291sZ5c5jHidbWMi0tcqOG6NhKF5wIZBG5iaxl4MDYQTV17cf4UDgL1gWF0U7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cffd93cdedso2806865ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=VX+t6aVoHaPQs1YOLRxa9H43naYmxGYV259ojZ6dAk3UelP1RkfaeqxTiUoxhdHoE6
         DGQP2bYCRhMuEm6Zt0PnXdWuiWWT96erX0ocDcofPXPwfSIlwl7q4EQEgjPx0dfaedjw
         nhhybPINSGL+5FDjVQt9DJ90vqXpWHDDyift5iC3BVgZXG6zNFYyeAq8JBupcrO+dLe+
         j50nr9H7uxKgJXM+HN3bfOQO5yrohU0aWgtC6Cbzbz/H23kxIiTWd0oRgXCMD+VrakUi
         eCzxW62dC1Aj3gm6tcPPsF3hcS+tH5HRFfTyRBSTKn9/6iTRjFI5wyVepnhtDz0rzSP9
         cM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=3lOHFXiAMvM2msOxLiFA8qax78wCLT0MazjIWtepxRE=;
        b=El7pQPAaAPiBLInYTWTY6ZDzq0l233VH8wT6qkXzXQK22h1+AHsfZIyGK9wZx0jzOt
         AOxrapJF+YddZwoIDmZWRTxAjPXkHFF0ud9YLHdYE+VPzGnC5PvhYmRoFPxWDH/VH+eC
         FiN1X9DbS6OJFSNPNMEsEwvW09rVh6Snb1iSFfeKkgF5F7DDBFTYlcq1qvyWvXxMrYXl
         skmTNOtEYlcNO5jIgAd0+l/x+0qmnAxP/k0eMJ6HhX22c9o18GafVRg4xFwIs8LLgnKT
         8OhPZTuzxix7aEbB3J/Oo8YImD+jjqQetmNTUHQqaAvjA3qg76XltVtyKm9ei3Zi3OX+
         l8Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=QPRFoPO3+SCVwf91DD0WRDrTjAMLoUbi13dEZvJaeT4P9Ha4crJCghZkB+7Yshp8f3
         TX9IbB/8+Ks6Sm+fx36oNHS89u2J1Je2303AjPdSRNC1GPkJyibFBbzNlfipHr6hpG8+
         CZ/s1DFziI+bLdXBu4MaCs5IwG6sVcuLI1gCXrXlCIAcBdKXU07JatNt+mjrSlWiKK55
         q2DzoRxccJsPCMm2yMkcx5kFkmUrS513K3OwXrNwagevqdIORwAS5LjsA75k0V7keO/g
         8zO+31YADINngq/KklDRM3w+AJM3s2OgYObL9nIFCqoVuNfdRbWq58qDRzGepXVhxcms
         C++w==
X-Forwarded-Encrypted: i=1; AHgh+Rqx38z3cf5cPEUCgNpAXUKKPS0S+/BjvTWidD6a7Nqkdgu7iFBYJF9U9w7yyIZPB/6DmGpSQgi1OrpqtsowhY4kRKAnfFE=@vger.kernel.org
X-Gm-Message-State: AFuF++lmyUB6obxKrm2FzvtH92+C0SHGgk2EfNjyi2uqnUZj2lt88Bp+
	w+hDNwsFiPm2uj426tAQyGf1byczcLkoVuu5YX8LwVazuEzFxkOhacFblP6pGsTkf/Bt/iaQO+H
	cHxbM3/bSTvHi1zJ/Q7mfcpRxh2W4fwY=
X-Gm-Gg: AR+sD10d8wOM02fRUGTaM1HxcQUn5eYkSV/PnjKCnoZCMZwCsY7wZmiVtJh31AJ0jdl
	2kTgCo0iMzNVLW7sxI/OXQ34UY4J7WkSC+R08C3EhvuMmQp++ZdY7TXg9XUTxCgxBNv4spYGG9P
	T0DED9L/afTMmgXSIQvJinKA3MxoccSDsXjsNuIOjlLD3VEsWl66n7kWEdYLwM/4ZbbNU7rBe8G
	FZ4Vid7y2lym4Brsr966JKsxHRzkZLuszd74QGCnfMo5R3g7dbMnKKW6cYZ2fNAmK5iZgdp2VLF
	gphkaZea6TL2kPpRBHm/cqavcxppBxYrplHfRv+i6Cjn91kAnhw88nMB83+cFfZPMRcoDMKQ4bJ
	+nYW903PeVpYfLELEsG8pFyh+UQTCQbWwk5hUVkKiBexxMx0HbPYOq22dEcGFkowjtvRZcAM=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
