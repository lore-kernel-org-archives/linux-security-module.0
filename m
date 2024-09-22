Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C1BE68
	for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017705; cv=none; b=IK5+2kT7Qj/OgAPlvbptRs8xYLMTfVRrxWvaaQns0baIdemw5faHqE7tG5g47pjRE7OBkQv+lnDYMqwIPZNHYqy3pt/O5fMFa/js9G8k0CaQQgCHbnuL0reAjEJzz0vFSrVyuknIcbeXfRJ0lpjnuI9Tidowc0oyfTg9G1CssFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017705; c=relaxed/simple;
	bh=MoxLQntrUUoBxHnrc81SIjQBbgnESJ+mo2PgPhhKzIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6wfDIwSSjhy4kVcCl4anQIYq3rtsZMuS8LQoPDX1ijUcNbSqsPUbehhTvGLrEK8+xLUqi/uS+cbdta3oVGav3MJqgELEl+A/8dbtpo+vrrHYAAbQxOjyMmCQirZoxPbleU4MHAzzeuG8wxYs/utEUFvxr68ycEDw4SS/Z4z76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2dVclGU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2dVclGU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so27578345e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727017702; x=1727622502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrk84WPNDauMmuWhCZFOUjncMPCI7YUNKYrU5/9qDmA=;
        b=F2dVclGUp5a7EM4tP9+xCCMYqkbaoRIRxlNETzqmzVxWFsYvPNcSTRMkKWx4fXuUHk
         7CNbV2yGyCGsEHeZMwII0IkKcKtetbtFJl72SzWUsvCGV+KVdF1kxXA8v727JShkuFtV
         1veYL3UrwnX9obfwGokHplauqFDkJv88KTl26ljdZ/XgB2hCGTVyhY3Sb4IzbEAwocPz
         pu59ZMoUnZFOES1VKaZPe2DEYnQD4t6+/3Sy2LCZbVODHgLurM8wx7mcbx7gg2T+wolv
         /9TWR6OO82bwEATbf95r2ZiQnNW+/zd/3NKadlMvY95hZg+ylyos5M3g69sYEFeHlkbk
         BmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017702; x=1727622502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrk84WPNDauMmuWhCZFOUjncMPCI7YUNKYrU5/9qDmA=;
        b=MeYvt1u8XU0W5cvrHEqDB4TS3C86tfgfJsuMumbyj6Y25RR0s6/FlZiB834MbtlVzS
         biSnmkWzFwuOxCTmtCy8tPUzllMh9PfTObpyqefJP7tAPA8bv/hnIo3EJRunIS0ZsH/r
         7Utrev44n5CYc0lkalWRTg2y13vv2zeyB1Y5RgO/W52b60i2WaJbvgT0bFkcgoX+F1kF
         BrvTREm8VOG/9usokQv7+isDwfWFlc7a+5YQCwSpIuuI+q3b4p5iEsxhmWoUFhayKSrX
         5LmZ314YLijLeyT40KzBgFcY2Bd1nuSah4NgDWK3J0ycW1ijZbvyh5Zck2/Io9DZ+qQf
         T+8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1+PHG5udl7SXCgLiKU9InTJNLxFty3vMMiEz2axrI35cC2W93J092T4o7ywOTrC8OVDqJwEcif6eye0fyOKkhQlumxRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVWm4S4vmfMpySZOVIHQrSUiP0eTikD6zxxgxdneE8yvjmnbR
	OoRWsaAqsPJvnfGEAamvWzHOSmcZ6ZO7IoHxYUX8pnsKGzd2+L2ivMoQji8bX/cRgywIzk6ULOH
	OvDsucHhlqhS4npq+v99Kr8QNzPZQ6SiGGLu0
X-Google-Smtp-Source: AGHT+IGsADpkm2OD+9HXWvm6Vc0+DYXpUjMQmyyBBb8VDvBcDtBLRCFADYlT+Lh/yx62UTYueWg79gtvFb1xPGK/3S0=
X-Received: by 2002:a05:600c:1c04:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-42e7ad8e706mr66211845e9.22.1727017701846; Sun, 22 Sep 2024
 08:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com> <202409151325.09E4F3C2F@keescook>
 <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com> <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
In-Reply-To: <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 22 Sep 2024 17:08:08 +0200
Message-ID: <CAH5fLgjWkK0gXsGcT3gLEhYZvgnW9FPuV1eOZKRagEVvL5cGpw@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:40=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 9/15/2024 2:07 PM, Alice Ryhl wrote:
> > On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Kees Cook <kees@kernel.org> wr=
ote:
> >> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> >>> Add an abstraction for viewing the string representation of a securit=
y
> >>> context.
> >> Hm, this may collide with "LSM: Move away from secids" is going to hap=
pen.
> >> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.=
com/
> >>
> >> This series is not yet landed, but in the future, the API changes shou=
ld
> >> be something like this, though the "lsmblob" name is likely to change =
to
> >> "lsmprop"?
> >> security_cred_getsecid()   -> security_cred_getlsmblob()
> >> security_secid_to_secctx() -> security_lsmblob_to_secctx()
>
> The referenced patch set does not change security_cred_getsecid()
> nor remove security_secid_to_secctx(). There remain networking interfaces
> that are unlikely to ever be allowed to move away from secids. It will
> be necessary to either retain some of the secid interfaces or introduce
> scaffolding around the lsm_prop structure.
>
> Binder is currently only supported in SELinux, so this isn't a real issue
> today. The BPF LSM could conceivably support binder, but only in cases wh=
ere
> SELinux isn't enabled. Should there be additional LSMs that support binde=
r
> the hooks would have to be changed to use lsm_prop interfaces, but I have
> not included that *yet*.
>
> > Thanks for the heads up. I'll make sure to look into how this
> > interacts with those changes.
>
> There will be a follow on patch set as well that replaces the LSMs use
> of string/length pairs with a structure. This becomes necessary in cases
> where more than one active LSM uses secids and security contexts. This
> will affect binder.

When are these things expected to land? If this patch series gets
merged in the same kernel cycle as those changes, it'll probably need
special handling.

Alice
