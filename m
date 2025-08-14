Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AB3002C3;
	Thu, 14 Aug 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192521; cv=none; b=BcpXQ/P4J8yssfs/CnoqWUAP10w5Ue8mScaFnw2qZiTzox9rVmjtA1FYfLiOsUsENp+hcraH5kYBFOXekLffh9yyhaKG552fAyiMqIScUxKscEYfBdoLSuQueRMu0SMtb+lfNBlXljlQZ5TEwgScgsILUBqMFXEw1oTlo+93Lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192521; c=relaxed/simple;
	bh=K9Fz3Tth55oSSqbiAqsMup4T6Q6LSvXB5ma6wbSQSgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Nnb+FtDJrACzTbAgGH6igr8lCp1H7FFwAPlh9DZKqa4YFqBzcxCC1IRjzboGYFObtfvoPp86ZXgNBUU0SB8a2Bjyd+qzkxOllFphOwky01wiPa+AvHspC7CUj8/P61SZu0rf7Q1uvFBITL7gE2mLrth2TMnk3s4CgIGapu2LdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLhOoIr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLhOoIr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CEEC4CEED;
	Thu, 14 Aug 2025 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755192521;
	bh=K9Fz3Tth55oSSqbiAqsMup4T6Q6LSvXB5ma6wbSQSgc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cLhOoIr2l8NexPjtcgbrjw/7MnuAYz5wNom/HwtFo/D4JlY/f7RLNozjGQ02cb7Ij
	 RWPgRsiCq+/c9bmln4BPErVW83L3Wih2wkAaLrkNgbIH6On0qFovvXwrSLGOh7DuVH
	 qlCtCmreZojwrdAEpyLHQ1tewEWjljootVbgUMeZ1ivq+yCmNUZEtnTGoqT6rjYKtL
	 5J/RTGZgNJcmtpP0QcWZSAfOtYPYS8I5wFHIMBVXR5+8NGDT0XtNsFn+qpCmlZwovK
	 1vjAAh05GPWzf5pFCdLyAMye8zfNfrdHB1uQHs+V/e8AK70uxVubt07iObzoykvmrd
	 Y5PQyJ6UH8uoA==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 19:28:36 +0200
Message-Id: <DC2BTIG40SRU.16QBMDH0PP01Q@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Fiona Behrens" <me@kloenk.dev>, "Jocelyn Falempe" <jfalempe@redhat.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed`
 with `pin_init::zeroed`
From: "Benno Lossin" <lossin@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250814093046.2071971-1-lossin@kernel.org>
 <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
 <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com>
In-Reply-To: <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com>

On Thu Aug 14, 2025 at 5:54 PM CEST, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Thu, Aug 14, 2025 at 5:19=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
>> >
>> > I'm happy to take this via the LSM tree, but it would be nice to see a
>> > Reviewed-by/Acked-by from someone with a better understanding of Rust
>> > :)
>>
>> I think the idea is to take all these through the Rust one with
>> Acked-bys from the maintainers (or we can skip this one and do it in a
>> future cycle when the first patches get in).
>
> [CC'd the LSM list, as I just realized it wasn't on the original patch
> posting; in the future please include the LSM list on LSM related Rust
> patchsets/patches]

I checked and I didn't find a maintainers entry for that this file & the
LSM list. I'm using scripts/get_maintainer.pl to get the people I send
patches to and that also checks git commits, so I guess it added you
through that (which is very good :). So can we add a maintainers entry
for `rust/kernel/security.rs` so people don't miss this in the future?
Thanks!

---
Cheers,
Benno
