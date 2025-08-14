Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD36218EA2;
	Thu, 14 Aug 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193745; cv=none; b=nzSUUpFoHRZeeiO2Zzuc5A7h5OPva4SLDxykLFg9ITtscpbDi4qSEuBFEBI9XPBDn3OBBbNt/DQDEmGTNWLdsSw+3TuSVQg7S3Dlm8g7n3E4IdFbkqchJFCU6lBqcHQe/1rX3GF0fRhhxhpgS+AG6fltI0jh7lFv5JJjg7kFKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193745; c=relaxed/simple;
	bh=F2QDxsA8NXIZ8nsnGOEc5a/iyY0fxwaAVvnNMyeJmT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOM8te8+2zfO7ux0I7WgFoYSOBRnDsVEt5o5D7r0+/b9aTylxoBnVcc4OT+y2RgTT/qL2QPJzj1mTdp2G1Eku2xw6afUq8vOmKddirK0HE+in9nUpsHqBl31+wroAxUcQmX8D64ucA2VEWFGD7xeA0LCjBKno/gd1wH7P0k6E9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQArJVjx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQArJVjx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244581eab34so1793835ad.2;
        Thu, 14 Aug 2025 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755193743; x=1755798543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2QDxsA8NXIZ8nsnGOEc5a/iyY0fxwaAVvnNMyeJmT8=;
        b=KQArJVjxcLMtrtPmHdGA7GMgOCG2s07592a6RlhRZ9gVBVv2nLZB8Tp5r2B4f/aYi2
         Y/MqdA+Gz+qtdzA8p3supGhotJbaXXXrPtkup9jp2MsWHxA+HV2Hl2MIkQU94GyaV0H7
         cIIAqjG6kGAiT5cDd1D0fqDiTMtYciLRT29jpg5gqIs2CYnUROPfpiddrSpNNxsaY+Cl
         iIhImGp9uHxIe8uAI3pCbmQbeps/Cl4KPY2loOFTWE5huEX7a5smryUogO0pRSCwJ7j6
         QaAjAjzRjmmVltSdDRN9Wxt0sNd2eaXVcbs2EWOjzQZtN5zk8JCZbWZ+/ltrInEGEQnA
         2E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755193743; x=1755798543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2QDxsA8NXIZ8nsnGOEc5a/iyY0fxwaAVvnNMyeJmT8=;
        b=RlxIitp9qxHEiljVjyFv8ad2sUslmb2YfAf3o/46XJTwL7zBLjBwLVCl5LUiSuhYi6
         GZZa6ugGQFxyLkkPz+FMq9qgMRd3y53kGy3dM/qwC1K36BHz5dUf46OXlP04onTSnKyj
         xyu5ad8NVQ/hCuBST/tuZqwmnr6/3MJfyilN+oFjnBJEWJxwtT2JxVqUZpH8Qp++qg3A
         yYefDcGadEn20uadTSu7qN3S9cCkPAZZiRU17qcouWBWL0s8bY3zNkilf6jLtKjteDpy
         z3vs3p0H6AqBDu4LbVsfLWSH1wEwYW1BJF0Bz9QRwco09c4H60Io3KQhE+pNdP/s7nrp
         Jung==
X-Forwarded-Encrypted: i=1; AJvYcCUZyiPSP85oyXHkSDBlgltzQ1W8tyYVr3egFYfdVyw7v35sPG2HhAmBC1K2dU9HA4e5G2KEA/Xx82kr9PdZPQw=@vger.kernel.org, AJvYcCW3WxHWNNJBxojJyB0NyDeemtc9e4SX1a2AbbIU/xz+9nM863y0//gHpwUDNUY8l+SivNF+JdBiw3sAwL4=@vger.kernel.org, AJvYcCWhxMH2tLwr9Z8xHlOn8umGQZwRLhDimExZUuEDRYQAg1aKPvDiL38NTn6CT3W5FEPJAybtD/Nz0KSRVYoMpi5DRCYIn1t2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5TPWtZquFRIq9gGsOsi3vtK9Lmxvdr+tEbbMfixMpYSlt2zl
	xaADZ2nP9Q4BAVzQ2MqgfrH3xHuJs1wVysI5xgkUte6+Chuj2ZAXaEL4+FThO1c5u/Vn1bl2XAe
	NE2Hhqdukf2sBU3siK6L5wiv1vtGVBxg=
X-Gm-Gg: ASbGncuJwqbF46ObMlj2Qj/+XXE7w0h8Jbjzb61OQdEW+d1DnZOcLdk8OL3ddsxbVgb
	oK+fsH+TCqUU1TMEQN0E0ufxTKg/W+Yu6LOlSGI5HeEtcvyJ+r5d2UzTmkP+uG/vBJ2vgxsVhZH
	YNpsd6qGLFNEs2/tvTiqB1nqG3iuTvPD7vrnrAVcpAwQk4zwnRY3Z6WplvuDDj0L1sWBpyvv3x0
	LKR9+EKzL0PBf3J0eE=
X-Google-Smtp-Source: AGHT+IFjrkARC1efQ8PliN/O9bpl+qLBj9K7BFBzG6Jx3HYCk1dbKs6zyzxbm3DBAQB/L3/oLbus2GUJu9j1DunxzmI=
X-Received: by 2002:a17:902:e551:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2445855d35amr26267225ad.5.1755193742774; Thu, 14 Aug 2025
 10:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com> <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com>
In-Reply-To: <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 19:48:51 +0200
X-Gm-Features: Ac12FXxWv6NagqNyewUQgY7bZRjwqFRJGx8owWy8E3np012h4wmZdlUz7EbuVfw
Message-ID: <CANiq72mr3k6Dz6WFjYNqO3pEa9Up93Jowpx=FqUT_f4crjCvyw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Paul Moore <paul@paul-moore.com>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> That's fine, it wasn't clear from the post that was the plan, and I
> vaguely recalled from past conversations with Rust devs that they
> preferred Rust wrappers/helpers to go in via the associated subsystem
> tree.

Yeah, it is still the case that Rust abstractions and Rust code in
general should land through the best tree possible.

However, sometimes tree-wide improvements may be easy to do with
simple Acked-bys.

> My comment asking for additional review/ACK tags wasn't due to any
> distrust of Benno - thank you for your work Benno - it is just a

Ah, sorry, I didn't mean that you distrusted Benno or anything like
that. I was trying to give context in case it helped you evaluate the
patch/risk, which also allowed me at the same time to acknowledge
Benno's experience/work.

We were mainly expecting the Acked-bys to proceed with the cleanups
here to remove these unsafe blocks, but we definitely want more tags
if possible in all patches, as always (by the time this gets applied,
we will hopefully get some more).

Cheers,
Miguel
