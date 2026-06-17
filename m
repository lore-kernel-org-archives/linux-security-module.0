Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0F3A0EA5
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690093; cv=pass; b=tEzdKD816m/jh4fRIFYwodM49n0O+XaqS0qXWf16jc/I4GGO6AYDM3zGtHYyehkzi7njSj/S4VpTxKwMoC1R8ogx56XcM/WCcm1wbcPqlY/NrIv4cuBgHGOVPwp72Pwkl+3SOJgeTmI8dZ3A9e10KA4JuSYkTikhciCyNkGyxhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690093; c=relaxed/simple;
	bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODzeDld0WEffQn9Kwmbsxs+5A+PpkVm7Vj1XthMZ7E7kHVIt5vs45WgijFw0wY2z1VU//xomS6TWa9yc5OT00jOfxnZhz9DFDgQfzS4ccpOU3Kz6HLvI38/P+V298LjaW1r/JvvSi+KM4A7vQbawz99ohXTiWpXvMbYUrFZmcrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uxNMeG; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uxNMeG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so2987437f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
        d=google.com; s=arc-20240605;
        b=I57wcWRpmg/N3A6kmSzlj6JxGDO4NmwUYt+X6pro97ZlNdbbDftRVqWCRY5X7TV4uS
         8FEECL0QgkrPLoSgjLXij9bTkyOu5e7uP0JYoGLRN+an4Ej7kvFmJwiA8HQCdhzf99YG
         0xf6QtEw1AuigoWJiMlKArbXthx/9LoeeS7issE9ydpYU/SJrEmdBfQ8BJXlku49sZNg
         517zrw+5dCenlr5nPyvFZQWfFByY63Jd8Juot6f25rnxDnlR3ACPCS0FYNvKeuVGz95f
         JA3bzikjzeO8fRlZBW5yuyqBVV9/7JutPkuLmu6/AYr7nJtS1N7P8KpHcPjCAT19PhT+
         FRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        fh=sPFSSeWZvgIVlbbaajsi/GAgSn6XnxfznfSMoL/XOII=;
        b=ZOY/iLf8beYdNQ6ZyUTf2xjFR31k6rKLqX6FFiQNQmRjts68lEf1CDumYtfR3tO3kZ
         mJ1fVJIHPLRONEZPO4VH78AUxnXY9mKRVvnKGHHMgFrZ8cV80zxUtJ75Vzjb6bf+KJt9
         6tpziL0S/LWzsOz99qaIQM1sXVIlo2urL0sCdJRWq8LtvKimzQIJ1+2ua75ekFR2Qi+Y
         5qA/KDmwoUr7d76x42hV+M+7oU3qHYWl5UVcVvwKuMrDVDCFXuKTfUXcJ6jV8m2HFDGh
         7vmfTVI/R8+KWFoI0AxjIBJV+1OmEwuE0QQKSRLhJSvrcdA6GkmLKYBzW1mkYoPHXYk4
         AXLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781690090; x=1782294890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=P5uxNMeGcDIN8llkO0LerOZseMvI0xoedivCJ9FZTvVkZQDpB2XH0vEThBBsXiWG9u
         sffI4uZumgWiX1nzBNMDek3/+k765xSl2pY7u/w/2RicT1DEfhmO3fV0tSyaaYwcGcUW
         sDIXq7Nca7LlV1xIEunZuyJ9m1LZ+oEW7N8dbZE1czoJgFmOXyNTjsG/v55Westq675s
         acUzZoCXnMYEzFXbS8+neVOK/fnhKQe+EzbGYwDbJeOrcvNmrqkC4agNzuQkCHFs6iTV
         ZeHsur1G/4T4lhO749KNW2vcfZXCrVawQX8QPjkJVWTDVb+5i/q9LvGGwrB4P6paWDbi
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690090; x=1782294890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=D9EpBUnckupxd11rro30dDtLf6DDveXp6A+t4QldAx5P4ofqPkIG+uZDqzay3hWQGZ
         uUSyLrLNcJT9vN8GXztlq0B4F68S8UTrlHoGkCHfdUZ7T+K7k+OQdvZJ2fQkbHTin9Ua
         ixpcPjQlZ5pM5bT3PvL3hplfQ6Z4dggx5GNbtrsFabo7o7dBSxQDgBcMynFfMsgZtz6S
         1bF8ftbHDGhkkTPAeveJA0DLJSNJjuL49I8M0OYrEP98gE43ZGlcJfst213iKyS9OSdU
         jERedh60mHD9XquEoy/+mWctqUWoXa3k/ZhRphhO2RUlibA+mkZ2OEEHM3MaXf9TAx/L
         9iXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fOgFsejIlHUxeaion7yUHQjV1LklakKwp2cHe8Z5jeaWQDdEOtZi+14Hz/vgg8ZEM1q9fsyIM6wGcBpjr1ZSRfQkvo4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlj+0MCywHJyQ68C7n6srwYi1DspYcNhmnXjsqZwZDssin7WyB
	7+2X+xH1JcqYpvJ61eox/rLoiS0pVk6uZBYEgqfO54JKFmyGZEbxpGQQWDwEyYouOvrjZs200rc
	5fc+iBrsKr0KmDwethiXuT6zPxApNd24NYO0T9CGd
X-Gm-Gg: AfdE7ckmiGSWNQvr0AP97aF0gRK5TGl9SkT61PvqxbwlbB8d5C2gyAK2g/zymkOJo00
	5HkZ5CHSBFCQ2lSTgUzEY2WBIB/diL41skPdBR9F0buCWxteKnUXSK1Z8jlSVJ6J9o/SQxcUdCP
	DopFndPGQe3SE4INZhVSAE92aRY0rl3sOtOhXyj42N6JtvIzbNV8c7cbxVAFV8ZpZc8UXbF31eP
	ud3pIF6rbwdFkeL/RZtT5yUdlvpb9vatHeTlwLh0/5eMmoxngxntuihVP+LAgTDtQ+vOl8cxC8x
	9JM8oxE6/I0TvqQFNAZ84yuE9jT2nUufLMccu+HcLWEhUCibJoAKQifdJkE=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice
