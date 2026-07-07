Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF0414A11
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429501; cv=pass; b=U0UcyRTXJHDJkXC31R43liTXj1pRzU3OaarNOonTW6VQjHnAOA95Q7r5wWmWxEsJuxR/GPAwPEb+o9qE8gD27CXsFJidA+Uqj64CB3qi0JORgvYUDAxA3smhJNdvMwxUQkKPIJ2m63Jk5MFEL4yk3bbvomtj/A3vvQh0rfhZU6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429501; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrrGfTVPqJHUz5nT4xCj+Eqxrx9XudmeaZ2mMk2Ut+KSl79D+CD7hK/+D9ZDhdjcexHVzaicNy68W9kAcABGZN7vx7iIQIF9abfW/kxzKsmt+pzOF4asdPY4M+BsQ5nguTcwIAZ2AD2RABQI1kUvV8Zy4904IN1kgFfFlqY0kyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwFqpWQm; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwFqpWQm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so22847245e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 06:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429498; cv=none;
        d=google.com; s=arc-20260327;
        b=G6fp+uLJQeJFZImnoBpfxwal34P/yzh8IsiDLqunb2544+5pbAwjI1j6s7TeeDNgnO
         2uRZfAzrLUm2Jo3GJg4EFPhoPhVCBfUxfZqF/atCAC8ZNAeojlhAXKiGjsbNuzzKfAwH
         PqRvJK+P/J2+pfRXpwy9wAKs5HUACijvdYlKGU89h2PjT+PqhWJz+YWZ70Qj9OY2owO+
         h+T3sR7B2oZj54F4Otuz7P95uTA4z9yuD8H4ShU0TIagxqIYkV86712nOMVnoZxaLpJ3
         4xMCxuJSUGcR5+EM1QKL/FiOM6q1FlhP1EzibJgQhILXW54oFAn3NIQfJ2T918JvS/VE
         MM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=E+/gFmz4qNqqCWmq9Merxh9m5PPpn6IoqN57caAK9Wk=;
        b=CIS75UnItiaTySgBSXTPlE/8bEb+5LA7YTfMJz/qmdfxvoDbUR7Num5pE1UhOGMPe4
         fDAZhGDVHOmefZOjBqRU8k7JVu05zw5oZQteel4aIBXIQYUhu8iBvIdrXHdW1wFVWcXH
         B4RQ0qUT7EXTeteOZ5cyCnag3oXEJprGY9kyeKjUy1VldPUwoJHzAltCwTdvvy2naJrY
         evqYtPviQfnJEEC+6tQuztdUeMQdhtpF+usto9nnLvP5JVOp0zfT9KUo1ArMqczk/0gu
         6IX7AybL99ibvRpVHZ3107jxu5JXz+9V/t1CtjKpCTfGGK8c4zW2oblskODaVuT2TSWu
         8nOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429498; x=1784034298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nwFqpWQmjpkhT5N166ROjlsHRUNBKTRpXMHaTMJhkX1rzisW+j8ZNBgqb0gt0uMyFK
         kJBGogIRdGOCv+IfwKTap7nCADTIGP8KSe2axCh/K7UPtN3Y/fPn4dG6mxglUfb5sjDe
         z9wuNw/bh4mOjkdHneFd2IGooWxjn53QI3Stm22mJIjhjpbdYFfbUmPDdJ+o5ujoCGZU
         Eb2D+u6aPJP/dPUUL3BCwxU8hiDgJqf3hxk/zmzS8CtdaNnPAk27A0y9mKwZuZGJ8UZk
         RsXJ0igYAos9Lsjb5CO7DSUU9QppF9kBmRG78Ibkhp9dKy3x75qDooky2A3617Q50Udn
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429498; x=1784034298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=eo9ato2w8mqEpndKd/mpnKVbpma6LKVvZC3OdH0VUj/6HiEAm+JE7NoYDMRk8/LuXK
         oFGRWUf023ixajaoufusgXiloEUna0TUH/VfEUbOpskakVX9nK/DkWtEBcG4KQD8Mihx
         OH8J83WG/0MRgLbWFqHiSBgJgWQKWQnTG5HkarWqdV9Z3BXDMvxY1bBNFymBvMcthwu3
         O5VocQs+8zm5/hUniPLjPa59aBwEVDJbcaTIWXqec6BZosFt8oYyiWNXWu5BKQjKy3Xy
         xy7HjeDzTbB5lfKoblzvzFmF+Cfjq++oZB5beUCCqrb/4wqPPe8jaqRn/kV7I1K3SSmS
         j21w==
X-Forwarded-Encrypted: i=1; AHgh+RqPABH7cIdwUXvMtAjHeJC4CDj+wkYu3mIGsdmytuUwad2ATmWiq9CPfVyZ2q2f/9wG/HSiRrU39C6QA9bKo0RQ2YhMhW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNiGOBhkGwpwTZaDFZsRkOPuXTxj2gyeeCkgw4qfvxoAgR0/J
	ecMnKjd3njh5kEY/CYPknS6mG+Os2DGA+aE59hh6J4E9TZid3s0gtHDv+arvEcM0xU85tovpPTS
	VlL5aA9I8aPOHBk0hMgXSK5WYZzHCikMpCrGJ+0rb
X-Gm-Gg: AfdE7clizK1iMwjzA1DDxwgDO9CH00nvytL3vKxyoe0P1xnE1Bu66U/NIMlpevHGNyL
	z+svFkkGOk4SqPhPq8txx/GLhp00wPNJ9LFbctex2AozK+4rDt22s12XNpq3PnQBBPnKjEftiH/
	ViAWPja1hRmRnT+uI4oNbkHq2tOaLPLGW/P25S0jCp2EtPZhwYevH0QjyZBpNB7u6PWAf9Ztz9i
	Sl3Kk0VATdCetiutrL+KGEXXOjdSJIdif7vcmLl+66MQa/5ICetQfwmLrBWYY5P0fKWV6k9+rXM
	HnSktJkpK+doW/x5dey6+QkBWwg=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
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
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
