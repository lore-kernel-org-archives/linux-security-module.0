Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A923259C87
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208920; cv=none; b=FJDzSWkUvFHcDvfgYuNJo4J/BE8xvo2ale1s+/A89DjV75sGuYImg8rRi4itg6e/v6m534+/ihL4GS2dhXs/yQ5S0N+pZZjF/hvdb+WGkaSMIYALciULnSGVQCbYYrYgJy85oQ3eugDF1FBYF50XPBU41QsfXffnWZDPrP2OvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208920; c=relaxed/simple;
	bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emtnc5UPPkgy8I7deTKIDt5e3B2X+xntCRUlfCN4YLPB6PgnzDKjSNN+ECUR21ooSznijGT1W44rYMpPIyvHOVm8wJjgel6SIG1kBaEcaXkKR7oOTx5k3+dUHvNp+3cFfq/QJDC+zgc47f10/OQcu/aVUG5dIws3lPnBcEtUU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M31sWAG7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M31sWAG7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266d38c2so1731242a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755208918; x=1755813718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
        b=M31sWAG7mWHhJiDsA0+DndcrTX6zs/MOfjGCRfPh18ZPQk9ObCOyC/MP6gMa/GTaid
         +Lli8PDAI/OZkHTsMiFZ577EB15qcY59ssLHSe2yIeFSdbuMU3RYXfYEa8G545U8tvEp
         uInuuKRiLoZl4I9Ya5mQ4B3cXRBud8Vhc5De9PR0c+e63hV6OlGmxmc4e4R4r+CoTt0O
         gwfozw2fIF+7M6cpts9QTUsBuzBeqqzHVKqKebxdzmxRdY25hwteyRCJ8iXIHcGPw0W4
         TfouhIdm+5LMHXPFoFfXI2VL1jXWgFWmAiHjXXhOjAC+OMzDFb02RADODs5q7/PyJ8Ib
         e74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755208918; x=1755813718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
        b=TPEdQPQqbgfwt+oEQ2hfII5X6FZB01xnS8yevETM/6VMIV41wgEE8dQGN6VE4z+EuJ
         D2saxNGPp93C293iQYAA0fG44BkzK8kP45YoDFMGgTgJzele8ATYUWsO34rgUPgyFYsl
         kmYA4alXWwEl3uwEq/0SqEkPY+ckxXfqr2eiM1iCZ9GtAb4jszdkGHHH3IHxSZpbsUem
         aY7DV7Ezm9P2xQ2V225QnlrocTvGxyWjylJd+VCxmzMBxcfKDLxuyDOWXX1qXyCwh1gI
         5JhSclRVBuLY66Ot7gRITg2P7tQ9rDX924X25achzdryljNKBoL+iwdXORbQ6AJhkN9Q
         bcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLxYI9B2YQAzUv3EZbGCexkcIN9mhPw99nO4lQcjhFLy8DR0Ng7HFiO6AXIdAMMdlFhTWM3QLknjhMHdSdTrmTD6SDCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaOpBtTJtGDgY6KE7+za+bLVbO230FjWuQoYrkXFoaJGxWvsP
	PMGVaM/TK9shlGlEwYR4LoKxYVCvrAzc37Hoh/qO+fJkIHT6ehrY/gqnaXVZgOfmutNTXkBCJ8S
	DLKApV0QNm4WLL3CgrDs4V6edqcUi+tBv95fkj2Rf
X-Gm-Gg: ASbGncuUbj5JH01DCbqPLxmIKt1+R8miiGKnpRj4Hk6lzSO+VUvXWQfLv/aM98YNc62
	XWPmiRxrb/1L6EgzlrKgG8ZtGjiCa6eNmKbacem520cL+Kr3+6TsewW8FH/XcF4430kl2juNjFR
	CseOFJmNn+ko5r2kCVEPD3FImOZgR0kz3a/65g8TdUtW71xuehCsYBb2T4fCvhkgqIVhnqxFl6c
	Jvjqho=
X-Google-Smtp-Source: AGHT+IEDzGUCUbmkKBi2lNmiCJDObwt7jyLc+L7VNoACWG6u+R/JY1FN/9Lybn1yT+eA+zKooGC4MTk6BwBsiV+iI+4=
X-Received: by 2002:a17:90b:57e4:b0:31f:1757:f9f4 with SMTP id
 98e67ed59e1d1-3233d227a0dmr691002a91.24.1755208918463; Thu, 14 Aug 2025
 15:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
 <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com> <DC2BTIG40SRU.16QBMDH0PP01Q@kernel.org>
In-Reply-To: <DC2BTIG40SRU.16QBMDH0PP01Q@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Aug 2025 18:01:46 -0400
X-Gm-Features: Ac12FXype_aLvHDtZZOQRIYNqbuL19JtT5JJvdcu70_SXP98N_IoFGs7sLelUB8
Message-ID: <CAHC9VhQAk4irkap1UUY1dLST3DVAGxMJ8m5VqX6BpkC7rLdhxQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:28=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
> On Thu Aug 14, 2025 at 5:54 PM CEST, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >> On Thu, Aug 14, 2025 at 5:19=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >> >
> >> > I'm happy to take this via the LSM tree, but it would be nice to see=
 a
> >> > Reviewed-by/Acked-by from someone with a better understanding of Rus=
t
> >> > :)
> >>
> >> I think the idea is to take all these through the Rust one with
> >> Acked-bys from the maintainers (or we can skip this one and do it in a
> >> future cycle when the first patches get in).
> >
> > [CC'd the LSM list, as I just realized it wasn't on the original patch
> > posting; in the future please include the LSM list on LSM related Rust
> > patchsets/patches]
>
> I checked and I didn't find a maintainers entry for that this file & the
> LSM list. I'm using scripts/get_maintainer.pl to get the people I send
> patches to and that also checks git commits, so I guess it added you
> through that (which is very good :). So can we add a maintainers entry
> for `rust/kernel/security.rs` so people don't miss this in the future?
> Thanks!

Here ya go ...

https://lore.kernel.org/linux-security-module/20250814215952.238316-2-paul@=
paul-moore.com/

--=20
paul-moore.com
