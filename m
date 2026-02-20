Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6508365A05
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608846; cv=pass; b=p8jXDnomir3GL5KteQgx8ZqWfezgTVVWvb8OMR1GdpftHoH3n9kq4thA5aNm8Fx7/CaxOsvycyq5cuXs/wAwPx2MZIJwz1LwlfTnd8EIWekBl4XNuo88QWaZKzpJa8G0ypgxZnhlL8J4daDhNMSDU9suPzZF0mHwZzkHJ7mL2Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608846; c=relaxed/simple;
	bh=dW69iUku9IRFksYkhFKb49OwK2nuvLOXPied0JTmtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7s9N9gfeEcnmwnuUiPoR5khfkzYnVcmKBvW3hIAzP5A1zKK6DiQmhIDiHjZ8O3jGKER8R/QF13H/d5DT1VNingygX8pBjeMjIi9YFuBOZxMGhUMk/hTSIfSoGnoGHYDhIQ74QqN/a/wFTt3De8bOLiv0ZHgPVcUJPdXMzZGWkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmovhQZ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmovhQZ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12736a0147cso191950c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608843; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9XYKjoJF53L+6m+KD9GA7u/FQZQP63J3NrnUP814CDI6SfGrvXlwkMk9sWOKvCLeh
         Iwbv2zPR87KKs4UXn7b+Cx5S9NRGGRBfUUxMtWdT45PyRBS83naXOa9Rgxrcy112dx3s
         R0XPtY/nTWuPIOi0EdNet2lUkOS1jzVFGi5cbpI6hnZbAN0No9FM+lMG9r6bfZYaSl4q
         nTk6t6LbmhFdf+qil6R2FDTRln6TvWoYW42wytQY4aOesTMO83QPMEufzaa8MjbJRgu+
         4SWdBHyZLuYv42TJ/bfqNbEFt7I9Fbi2muM2b5JaYDmySF2nqyE8tnRDs1g295yl2CWM
         m0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        fh=PDG6yjIqL+fl8DWjaK/OaYUmpqMeVWEimk20eRIEpPg=;
        b=c7cXQei4K9+UzKVb3750uW3DJYYYN+RU7aZJqL1Aygzz6Kblsg/Ws5xmi+MxCtCIiM
         CpKJBLAU/TsfRy5j627UQb6PioNvAo939xkeuCqHPJFfPSFfGD06a+RAODGnv14qp2o2
         TsI80r8ntZNzcmjUBkxc5IUvzBCwba+OVHtFRKlwwVxwYXy1EAawxkn8FPp72dJEjtiN
         gNZoBtnUgdlFUfEZf0jQbxdqQqUK9dvvzMJLfVXgNvQZ3iikZ92/ua4yH+3+HAhKwbNI
         GmLLkgSuCazxC3NaIQoj+qyyiKfyHNWSi1XvnXEzeVty01rOyaBpr0w+h/bTm4sH98v9
         FieA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608843; x=1772213643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=GUmovhQZ0/gL6Csm9lB/oZvXQzoRbh+uVmBzc8YSv+cMKg9Uubues33H/9RyfdILfj
         k+zc557ufFVnuu02HgkHoFuAOrYPjf492rTJMSJs+Y14GZdZJ6vatA+cSh9f6oo963Io
         d0+6cjq3IXdboW94NV5+1nI2XbXJvpX520Bj2HNaDdIOD88O4E6cx87O+l9159ye1JVx
         z5ECFYUXaEaFv94IyKrGZwFgzAl9mjpRAIoxg2VDDG4MXRpqli7BRe0VZzFziNXygZdF
         C5HOej3GIe0ixLu5QAUeJFlzHR9sfGixz9LuDB31Pak32LJ1sCx/7snoqduumBjN/l3T
         gKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608843; x=1772213643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=iC8LfZqwGUqsPA0T6k+Obo5iZWOljufWGTdMf8qV+hwF8QeAXj1h35TtW7Za5eifxe
         MvJ71ZtlOSMRXvN2/umPbfXcpLxnwucbd7E0m7fxs1jXhkL6l6ZE7hMp7IeYMw854FUA
         +w5tI2hTK3BhfzQBEAC/GvJEapExN/5p3hCNViSti1Ckp/4S7h9NyIZmX6gLEifMUAGc
         UPE0h0hlitOa/UDRU6hytcWTRldncb3QEen1+Oz//Nj/hJuy0x1lZfziPI66UbCEMNtb
         D20PoM9ui19iKw4PCHq1Qi8Bo/GKDJ5ciw0LL5wonR6UJoFU2N8gxAM5wsIITkwg1iCC
         k+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQLXpRxhoHnH/lZtBEzuII99U8e+WHdsz6B13AtJWne26xkhfmJeHC8VmgOh35edLPwndiGMgXjSkD0qcYckpdxdfyTJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFezZkXJaVAF73ov0HlwTrIm8E1H1X74snipK0j93xKssCU4T
	VSEow7zRn7w5TGRpuBxhcL5yNqFTv7YR+2NcLJhQU7GnngYbzUNM1FI+hu8ncNjVVJ8M/Zio82G
	tCnq+o32hdTekBE/gULeI0En+r/fyy0M=
X-Gm-Gg: AZuq6aKOfowPDaisCjzr+rulrLmNbG8LYPxU2hdtyXhxZhE003ieXAJ4aCZCgqxvdF0
	0QKLSxea6noYT7m1k0MZOZtcuAI+Weq0AsBe/g01Jfd6sZV4SYsmdLOsBY7/R2tgX/h4d+VVzpZ
	LdpNIEc5h3Tqu/0d7V8leID+naspiLBTlCpNYh0Mds+xTZapnKi0B27d962/uNjt5EUNyqxmcwD
	3HISqckIdXYVJz/+QA0RHz5cbRjJj7VOwoqtx3d0STN47N+MY5DaQaFgAtujt+nfzWNddouyq58
	LOSDQ7aYkiSbRYONF+ifUT2cIdgAmKnSmOvyp39FWDVwyec0ovZC2MxAm6HcumqPGMvD/NYAFs0
	mieLWDyU+lVoyxBlPbErRi+Hx
X-Received: by 2002:a05:693c:2c17:b0:2ba:674a:dbe8 with SMTP id
 5a478bee46e88-2bd7bdbce7cmr74947eec.8.1771608842904; Fri, 20 Feb 2026
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 18:33:49 +0100
X-Gm-Features: AaiRm53lo0keI-FayfnRj4AYfVuM2jzmE06bNyAO-n4MO92LWSUkvblDHz_tCFM
Message-ID: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> +    /// Create a `&Page` from a raw `struct page` pointer

Please end sentences with a period.

> +        // SAFETY: By function safety requirements, ptr is not null and =
is

Please use Markdown in comments: `ptr`.

> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.

Since we will likely try to starting introducing at least a subset of
the Safety Standard soon, we should try to use standard terms.

So I think this "valid for use as a reference" is not an established
one, no? Isn't "convertible to a shared reference" the official term?

  https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-convers=
ion

In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
stabilized for 1.95.0, so we should probably starting using those were
applicable as we bump the minimum, but we should probably use already
a similar wording as the standard library for the safety section and
the comment:

  "`ptr` must be [convertible to a reference](...)."

where the term is a link to that section. Cc'ing Benno.

I have created a (future) issue for that:

  https://github.com/Rust-for-Linux/linux/issues/1225

Cc'ing Tamir since this is close to the cast work, so it may interest
him as well.

Cheers,
Miguel
