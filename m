Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BD1F4720;
	Tue,  4 Mar 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130199; cv=none; b=aYUo23dJtGXLScFxbjTYfv5JgmZKQBp2twrG2Nzah3Y2EJxiLtOys0nF7ccBk63lR4vub04/rC9GmivFExVg6141d1yf9tl9PTckBiKw/JefnZsgGB2L2haFTPPNKesNsc8C/L8dTksrPWvhI3HAPYnyfJcFATFuGCHccKjRb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130199; c=relaxed/simple;
	bh=cb9OSta6wF5whj/MA918wbXvOH75hCeZNhIQYP08PEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIkOKDA78jyX/rOlAMOWuw02sQ+YWyndeUP+BIdk6w0+RqA/XBvodpCF2WcFwuaUIbf9bWJ15IG98W3+97pN9KwUvSYKdwuoGFaTxOkpp+Akxooo/w4wXFrpPbasmIgDa4l6D7G6FWI9nFQ8RD102DbkNPB8F9iJV7SioEo8qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFnmBLVg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFnmBLVg"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so1623176a91.1;
        Tue, 04 Mar 2025 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741130198; x=1741734998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkzGzrZgrbl+n5aUkotTUf87Rh6O+fNtBv0KfcpAk8E=;
        b=cFnmBLVgdGU4Z6o703obx/5LR+MF80YLavPZelTOxvMfz7+jYvv5Jcx5Rcy0+yBm6I
         b9AZWOsSG5hN6HM2rr2b0ojHOs6MdXyK212iIHcdPQXsa3XWLj71/pmmPzHgwxaV7vCB
         lwZ4mBEXO2OzIy/VsxCn3hspBFNVtBVCwaq2VCsMeE6u5rJg7eiPIe58y1rsdiCDst2G
         ZPCi4AAa8RMmlTb+QJqjRX7x9wmOPlqMmd30nlgDJTchJQK6ou/xCcgsyH4so7cN3Vo3
         H+0BRyN3yE2nkOjl3zkFMJvrISrCzFHhL8YZEfewgCDyB3Z+IKxeK/arsWyuWK/tUyxP
         owpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130198; x=1741734998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkzGzrZgrbl+n5aUkotTUf87Rh6O+fNtBv0KfcpAk8E=;
        b=rvUoP2SC1zlMXsFyTm6/IZqlHMuXj8eter83RG34cifF+IDg55dra2PiX7cTTX9YVG
         5Dj9Xm6Cgf1ocJNwEGKb0AkK23j1KAodcPRKs1CNo7m/ObWccJPO28IV8+ZzLeo4MAFX
         tekga/6SqDlkkfOSJmUqvN+Ah08x7Skgx5IxFnp9Xlmad3JC5qhiowzMyH5XgWM7B2RH
         6RLHBD0LCVyqFIQKw7XXTOh9TTZ6ejC84l5y1y1+Mc97yJsnOhDxfM8XhBZMZKDfh4AR
         H/MYqlKicCdOai0zCDPtQKbwnymb0b+ilydhX9pP4Tm69RAQ/qO5VJcSxZhzM7+lCZaP
         Q+ng==
X-Forwarded-Encrypted: i=1; AJvYcCUkaqEAHBm1cZlcnApVXGteJpZbiaffTXQDoqTMh7WQPkOT2RMKYzDoeUKFAEIp478RkIiH8E8pyI+yJnsykgHOSE21mKlt@vger.kernel.org, AJvYcCUnTTz2dRQXb7S0p8N/DQCVGZ938jGQ/YFtDNMZWttzp4vZk2Z+A2KXI0aSJt7Sxdo57G7MmZiAouXpwkk=@vger.kernel.org, AJvYcCX1BBHUAeCzcPxk3v15ujlS/JrAX1vDUiYKq1KeNIirB3SU8TshNqshVgwzkvqKEtolSnraHFTKHyrv1eDfWGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29W1BdporbKAgGl6cuquG9x4BLOccFG37+K+Mz2zJrqH8R3/v
	AnKxh4+BCd3zVm32MH21RnWkHZ6eSPGSne46Dnb7HApqq0/Ak53PU8EMsG+Cl2OBuL2LCLV03l4
	sE6/auvmB6AZc3gKNLAw6AiBZnSI=
X-Gm-Gg: ASbGnctZx59M9R8OPxmV8GE85/vvQ1q6RiXCOXYH2/TTKBeKUIsAxwvPpYLE+dF8FIJ
	eDivCVi3dzq2pdH63TYMGn1leSog/iuQa4ED/JHFMO1PIdVM04gQfbqgORSEI4ORTHKDp0fvF3b
	OtUCkzm8lvwQCt7+cDe5gt36xCTA==
X-Google-Smtp-Source: AGHT+IHW0Mlhxk0bv+5F7LLd/ZgwlqGpqgiebP8yIolkA5CTewQSv22twBSnzC50H8c/gL5JZsFsDcBwzD4LEPfXaMg=
X-Received: by 2002:a17:90b:4d05:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-2ff49718182mr722680a91.1.1741130197642; Tue, 04 Mar 2025
 15:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
 <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
 <CANiq72=n_cGmrb6+6CH1AbGePy5dRMMFyzAFv6O1VEp8EgKR8w@mail.gmail.com> <CAHC9VhT3DqOeYbC+GCQRgH3NNUiOk6Sh=6fzsFaiHk2LEFbi2g@mail.gmail.com>
In-Reply-To: <CAHC9VhT3DqOeYbC+GCQRgH3NNUiOk6Sh=6fzsFaiHk2LEFbi2g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Mar 2025 00:16:25 +0100
X-Gm-Features: AQ5f1JrkwHqBIjbP7TRgugbmpbgtur5VfMYkLdAY_NvdioIDeBMjT02OOPGYXig
Message-ID: <CANiq72=SZv7UPvcZ1NgBtbM72n42b8GqS+rTVjccVZmn4z3SVg@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Paul Moore <paul@paul-moore.com>
Cc: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Thanks.  Yes, I've seen the summary and the recent threads around Rust
> in the Linux kernel.  I don't want to drag all of that up here, but I
> will simply say that from the perspective of the LSM framework we're
> happy to work with the Rust devs to ensure that the LSM framework is
> well supported with Rust bindings.  However, I will add that my own
> Rust related efforts are going to be very limited as my understanding
> of Rust is still frustratingly low; until that improves I'll be
> reliant on others like Alice and you to submit patches for
> discussion/acceptance when there are issues.  Thankfully that has
> proven to work fairly well over the past few months and I would like
> to see that continue.
>
> As far as the mechanics of which tree to merge code, I'll probably
> continue to ask in most cases simply so we are all clear on where the
> patches will land and how they get up to Linus.  From my perspective
> there is no harm in asking, and I *really* want to encourage
> cross-subsystem communication as much as I can; I've been seeing an
> increasing trend towards compartmentalization across subsystems and I
> believe the best way to push back against that is to talk a bit more,
> even if it is just a mundane "my tree or yours?".

Definitely agreed on talking more and encouraging more communication,
so if deciding based on a case-by-case is best for you, I think that
is good.

And thanks for helping us here in whatever way you can!

Cheers,
Miguel
