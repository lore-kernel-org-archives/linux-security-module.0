Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7012DDA1;
	Sun, 17 Aug 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450079; cv=none; b=TJ7B5KC6/3bQc3QMhA6qvKdeHMhy9Tjh7s/fdRfKxWs4d63uKloRdZ2Oz1h3TGUYtjwQ5tAM6ZOj67VK4fAh2FxsBxCBVAprUz/kLch27F5/o/4NCGfcEL061d4BqNcBoqzYAC4OT1DR4xON5cFe7+seZHI4djIyNRBlWyqvGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450079; c=relaxed/simple;
	bh=JUPTTUn0KXfbpVRv4o9mY1HiKJYgIteNrTvI4IwPrsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xkv/zg7d64HCYvYT9AW0WznFjTpBE2Q3fwHOKd4mZtvhbairZ3plcBxo1HltXLMY8dGf/i0pRPgBtlFAPtY0HwNH3/+hl1vmGnQt2NEO/gC7/NzSU1dibje6rvnc2wVdIAVTdyFFM5Nio0q+heZfFaV8Dqp0Y+d0kQKeCR/Xo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfcF9xsR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfcF9xsR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4716f9a467so674254a12.0;
        Sun, 17 Aug 2025 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755450077; x=1756054877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUPTTUn0KXfbpVRv4o9mY1HiKJYgIteNrTvI4IwPrsM=;
        b=QfcF9xsRC7HoM5Ro5o8oobxBpTI0Gmclql+xdfb+EglawUaIlh1ShqT4+NdFZYWyZX
         einA7UzqDQJCTQJldu2rF+sy8YU/b/W+Hevz96SK0PDpU2TrPkXCN49pJh63vRnT15PL
         N/PFo7L1t0v8I7jKZKUgYngkyTHLH17UNPezyVM6avAKhNuUTAoh7zecTufcFoIRyw0M
         9K9VRmVQszYrESDA4b/uwrmQpEzvsIcWUX4OUl7DT2ZJYEUbum32m4+ETp60R1Jl2Igj
         LLcWt0H3H6wj+USux4aiKossFFdA32MDld23rIQ3tsvDA0YKDnUtgBPhjb3j3ILwWbJ6
         3x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755450077; x=1756054877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUPTTUn0KXfbpVRv4o9mY1HiKJYgIteNrTvI4IwPrsM=;
        b=Hy3E4gg3Gn6k3QLDWR+DlW8qDTnbxEhqk2F9HZp9gut8bEtApJcne55zkIQN8tGppT
         pMH1ZRGZPTEwV326hsZJY5p0wUosO1frivN65LYJV1TiL/3QTAev+kRdPAIIeU+bhMg7
         MkEdsCo0E/ZI6eVMGEROVYZaIcSt1f/c7SjoptbVPu82L6Glj+05466nsHeEcLjt4ulu
         4irx05j0J3pwNomI3ZUmnAbsw7gmzu2AT9vwYULzMCl4gFD77O0s6vjWe+JImAepcciA
         hO7MkPUILwwVtqXtbO4VlO8av8/agfpQVIbrhz3VX2KhWPapV0yFwuZ0SMlyzpHUx7fa
         8igA==
X-Forwarded-Encrypted: i=1; AJvYcCWyI5V6dnb1mDQUox3OsypJSH3S98CXCW4QHy6mrBC2mzFLxnOfkLZWVElCVf62vmwaoxCwND8vMA+4Sb88W4zZNDjkVYyw@vger.kernel.org, AJvYcCX/6K2MeKuqwjPr3SKaciuND/SuNipq0OBA1a2aX4wdOLcqFC2L3qFkeVVneodssB/d9MmiXkOAouKwrlQ=@vger.kernel.org, AJvYcCXOZtMZXXKN/w9nRC0QPL4Ym25Um7oQUr4W84FlU3xF/SvX0eNYpn2sAj7FdikhoT/dWzkNqGjECcUGTLi2onQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiVy7e35jok6+8FXtAHLio88xl+Z+tTybyNk491CuOVni00FR
	Xcg1wAZP8crNC+60JYm+URM8yjnjgPdcUNYmR6NbrnxNM5dIgLD/NW4Ae9a617dOq9djxhXWvJi
	zDInwagvtBfdlOLuXuXLvu7yTNUdrC8J07Onz0yc=
X-Gm-Gg: ASbGncvgloeTnTBX31uiBMtBlwxOeH+lyFzg2BdzbX46SrioJO548g4BLeTFSTuxmuE
	BliuxHiZxfnpflqeP3PfJMqyszFgGt5JC5q7f5nHpmIOEQkbhElYsGa+EFB6F5c4AwsI0ILCJai
	r+Z716OZV4AHDY/PGyGqtW9RqKEUS6fKCO62QOjJmyvvUHjFNOxO/sfaFGgFn7N7ZUdKKlAIdvM
	EWm3xAS05iVwPZ6pbY=
X-Google-Smtp-Source: AGHT+IGKuRXX5XxUCrYMkh6Y6IIFGsYXsZ+LMd+uj1/CYW8e6UkGJYOPJj90YChvvkoUSgUKVjNJ8Dq2C6pu9BYUCEU=
X-Received: by 2002:a17:902:e751:b0:240:8a87:a187 with SMTP id
 d9443c01a7336-2446cbc7d83mr61282075ad.0.1755450077467; Sun, 17 Aug 2025
 10:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250816114409.10107-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 17 Aug 2025 19:01:06 +0200
X-Gm-Features: Ac12FXySPQHHYs0oPoSuusmeEBRhH524XE58geQtNcmIv6wcCOujPpn1FGAKe-4
Message-ID: <CANiq72=qd1E62b1xxXg6_5ihgKG1-ii-6UaM5Gr9M68X+PTccQ@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 1:44=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref`
> instead of `types`.
>
> This is part of the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to the `sync` module for better modularity.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.

Cc'ing Paul, Serge and -security, just in case.

Thanks!

Cheers,
Miguel
