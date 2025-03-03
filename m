Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15320FA85
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027255; cv=none; b=GOsCq0kEEfZ9kBRm4dt4nuyThFDxmlAE3uXzSDGnAdI3r91kdKGHxYdqj5xLishGfUxozYlIqsHeMbQX/PnIQ9Mp0fViVhweARtjpn8IaDopzWrNhKD4HliUpgO+X71NCNpL/NRVwH/fmypSojpiiCFAXYeLy2SgZw74tgm1Zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027255; c=relaxed/simple;
	bh=nrcUawcCsSZ4sKk198mMgykA7LrBZL2L/S12GQRvXEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcQkkRT2ivyl3GEHIlYFyWbtNiw/vFMcu6iEIcR5chVuZTwOhSJhlqdVIEutL+XSNuVJHBn6mWZZCffD5UzuhPkexhWUl+pt3LHjl5PQZJr+29gh/avrrcQDcb2pThkHhL6zgLZckbYfnEFHoCMJStPozuJNOXTwdmKiM41TEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovYxqr1v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovYxqr1v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4527915f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741027252; x=1741632052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op8ngrfBeKcfAHC0fBDhWmrr+hR58OWpJPg3ZrZyuIM=;
        b=ovYxqr1vOCW+l1w82H3JnLVSQNzOwhYUwWsSDS84VPdA57fjFUDsVTTdyigTjwYGAB
         JDvmDYfmj81DuWiYvJy9/Qz2FovKaTR2JRYYE3W94bYBoaik1jr1ityRBDqIi5s6rjP6
         px2WtBLOi+Ur6O12ZT8IOyEF4aMilTtTfm7QeKIfda45/HH4BueZ0U1R+V7Rt9UHrlJ2
         zMl/0gvueMfKJqQLT8LZoNPQJhS8FoaR+m5rV0v25lFZ/Pn3o0zXZdBc72g8h9ALUKa5
         kSvUenTIWenwwwJvYuqtVLeWWRmMrRjBn8tcX+HdQhvDTIVLyU1jej1cD+wKUGbjqkPG
         knVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027252; x=1741632052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op8ngrfBeKcfAHC0fBDhWmrr+hR58OWpJPg3ZrZyuIM=;
        b=H/wqQi3Wztc23jvA8obBcnm1eotgpjeoYdR89d6YaZv3VaEaomWES8KdWiFNATFj9J
         MHdaoDdfcV7i9wf3H/KqEw0K+NQCUB76eDrIRzoiLIlYaqTWqjZr1j6ARro6a904dSl4
         F2Cpza/XoEAlqogj6PGaZ7HB+ZOIKPaGM0tKZafqBI6J1BQxnUyxOshyfcw+Knv+T2aD
         Kolgcpb8vnnpsr86YixIEvzuAO9YPuzA8WRaAb51HM2YiKf7YrNTc799JqOS6oZVOUB2
         tiHD/WTfoOYAPgfKDYtxuahdZ/u79Ea85FXqkBYunJVOzTMhYRZqT6jY7Hi/aS3VfS7G
         hYbw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPPSPhHpp36PeJb1iPey1DRKCd3aCnCrAuQ/sYC8GgilijzC6d6yb8Ee2G/1cN7Y0fuq9fZrBFBhLQLIZ78waSwSv0CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJIzFCcdzM3KS6W5X4o+9NVOF0Q0exAkf69RTz1otax38F+Oi6
	/l9SHTyGPcDi82iEmLKwQIRYjbRZP+Y22gDmy/g7zWL3MVCQStsSfLZ37S1Tig8y9g1QVTp1a2S
	X/DgDyaFWCwdHTGJtX+fhtbhCxAPO/X2VcW0x
X-Gm-Gg: ASbGncvzuPlNazJn/2CN4u8IO0l39NBnbk0DGGkby0zAFlZ+uhs3SYQQjdBp21hrGp+
	8q/T1mcv99ITxdMdlPcLga9Ugsw+/femiTphTTSO2TTz9sSzNiRYEa4EzByulJ/hKZ8wLIeOxmm
	3wO//Nzf9TCNGFlBdGqKsspYXMkhY=
X-Google-Smtp-Source: AGHT+IEbQAEL5lhQtMyWI2oz7m9QxyO5TIMYD/e1+uZr6W8jisydk+E/Pz2wJklAZ6U1BmFRXEb0dlT7aUP31FVHKCw=
X-Received: by 2002:a5d:6c6f:0:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-3910a438dbemr5878386f8f.21.1741027251940; Mon, 03 Mar 2025
 10:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com> <a5262d73-2b11-4868-9c6b-1c6161808979@schaufler-ca.com>
In-Reply-To: <a5262d73-2b11-4868-9c6b-1c6161808979@schaufler-ca.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 19:40:39 +0100
X-Gm-Features: AQ5f1Jqgc_xVRRc4yVQL3FqBf_jvG-GoH8NZo9p5eLE71Ktv6MhF-CyIro8CARk
Message-ID: <CAH5fLggNnOv2rhtUeK38GVQ7EuuZkZMwOSVKSsMLFG5eS2i9Ng@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 6:07=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 3/3/2025 7:29 AM, Alice Ryhl wrote:
> > I'm seeing Binder generating calls to methods on SecurityCtx such as
> > from_secid and drop without inlining. Since these methods are really
> > simple wrappers around C functions, mark the methods to inline to avoid
> > generating these useless small functions.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/security.rs | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> > index 25d2b1ac3833..243211050526 100644
> > --- a/rust/kernel/security.rs
> > +++ b/rust/kernel/security.rs
> > @@ -23,6 +23,7 @@ pub struct SecurityCtx {
> >
> >  impl SecurityCtx {
> >      /// Get the security context given its id.
> > +    #[inline]
> >      pub fn from_secid(secid: u32) -> Result<Self> {
> >          // SAFETY: `struct lsm_context` can be initialized to all zero=
s.
> >          let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zer=
oed() };
> > @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
> >      }
> >
> >      /// Returns whether the security context is empty.
> > +    #[inline]
> >      pub fn is_empty(&self) -> bool {
> >          self.ctx.len =3D=3D 0
> >      }
> >
> >      /// Returns the length of this security context.
> > +    #[inline]
> >      pub fn len(&self) -> usize {
> >          self.ctx.len as usize
> >      }
> >
> >      /// Returns the bytes for this security context.
> > +    #[inline]
> >      pub fn as_bytes(&self) -> &[u8] {
> >          let ptr =3D self.ctx.context;
> >          if ptr.is_null() {
> > @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
> >  }
> >
> >  impl Drop for SecurityCtx {
> > +    #[inline]
> >      fn drop(&mut self) {
> >          // SAFETY: By the invariant of `Self`, this frees a context th=
at came from a successful
> >          // call to `security_secid_to_secctx` and has not yet been des=
troyed by
>
> I don't speak rust (well, yet?) so I can't talk about that, but this comm=
ent
> has me concerned. Security contexts (secctx) are not destroyed, they are =
released.
> While SELinux allocates and frees them, Smack maintains a list of context=
s that
> is never freed. A call to security_release_secctx() on SELinux "destroys"=
 the
> secctx, but for Smack does not.

It's just a comment on a call to security_release_secctx, I can reword
from "destroy" to "release".

Here's the full context:

// SAFETY: By the invariant of `Self`, this frees a context that came from =
a
// successful call to `security_secid_to_secctx` and has not yet been destr=
oyed
// by `security_release_secctx`.
unsafe { bindings::security_release_secctx(&mut self.ctx) };

Alice
