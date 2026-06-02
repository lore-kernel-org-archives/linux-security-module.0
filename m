Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CC2EAD1B
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380945; cv=none; b=PFRNKNtkKSJ5wia1PbiEsnQRi3Ud/gQmGjM8WYXjPUJ8IGJJin3rb16mhRijIUZWc7HGZGwC0jOisJ/AZW0/91i/lBPNdkFMnTAaFQeRIENeK/rdVcadHtHSme/P77uEvUeMgycHmi0N9MMfsFRV81CH+tTUmkFSTJb7G6FEQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380945; c=relaxed/simple;
	bh=1X/bccwOfssWIS6ajyQ189AljJH2LtuBT18CMIZ+1Ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcrP/5oisw7dHv3lgDVaYgaxcTVoYHc3Gn5xL4WCR18zQFFQZHNy1K3aImYN4Oc2CL3rm9psmRFaGMNGzJ+9iXXrhZgIHOkv8zazh9pRoRV+k5SKqHdsz9oyhAsg3wNhwpLA3StTYt6x68WrcqnvXjB0KiU5q9zx/nHU1N6e8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXNPCuao; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXNPCuao"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49045f93baeso74088765e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780380943; x=1780985743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgRgw1IKC03OLwNyxPDI58QMkRMSvSCj4bII0pkMkMw=;
        b=ZXNPCuaoeorrH6dKoluuANYDEtScJKv3GR58TIMUYz7vkUv8hE3oA/Avwdg4Ejr2IC
         mSMqLHA5t3OEfRMWxFI/euhVIDH6hO+N5OTkJCSsuiNMEFfyjTE9a2enEaA9ttmirwCn
         G+omSuOWWaaye4QbjW3MQ6MmxIAZFULSpxQ3PAP4lTo2IVobfM5v+9za5QYi+hb+ko7S
         QlDW5caSFfqEmsQbBis9rkG3jv54us8ejPlWQOYLk6OKmy6ZXRh86e9Oj7I554ZBtT14
         sOIYqSvSCwOyZQwuw3tunwdg0rhTYzNcRe2nDpeZ9QmFAjJ+dXhwFY6+4CszCj3Gyk8n
         AovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780380943; x=1780985743;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgRgw1IKC03OLwNyxPDI58QMkRMSvSCj4bII0pkMkMw=;
        b=a54JdJFtqjgoYjbyweLSL+V7zrkdna8KecVdxXcePbEMyDvG2348mhvJxwetkoTEOr
         BSa714oM55YmfzvoU3qnRPBxdgo5CdRBvELga8LDsaus6ObaVc/qtyubP7yr26jnd5e+
         2npW6uXCws+fxM2pghYyBixgtjAGPZt+1xCcTrDZeIcpZkV216SX3io1iEF4mpDVk69T
         oPUNPqi5H2Sf8eTMKu3lE/XbO8MKNcFrqRZnRGMTaXKVBdB9+mpCsayE2gnT/y26SGyp
         PsggLP60bP6GHub/GeImDaoSfAyhCrlCC58o5HTG5GVyjphNglqcDXXFKImcnhXiV5UF
         SVTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9IBjFcwhhfOyObhehRzAPKvj6F/L7P+bU9iENFxfSzKzgctzItAOt21rdDGgX3CnLKgRIgrkros00p2sieWjntPAK7oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCtSyUojsWaNbaUHhXONhAhD1fhXA54Tk2pJd3SuCp3QmFa9L
	2RGzKeUtSUCaoEOfrjlOHn/2dk/0pu7bUwTVnC7h97ZOzVJvA9G3rP8Bgov+QJxPMRmIPzoYiYr
	G8+NAuiqRiuMQpMSeKA==
X-Received: from wmaw13.prod.google.com ([2002:a05:600c:6d4d:b0:490:b22d:da02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d2:10b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-490a2938f7cmr185302145e9.25.1780380942885;
 Mon, 01 Jun 2026 23:15:42 -0700 (PDT)
Date: Tue, 2 Jun 2026 06:15:41 +0000
In-Reply-To: <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com> <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com>
Message-ID: <ah51DY5yfaNZejBd@google.com>
Subject: Re: [PATCH v4 0/2] Delete task_euid()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 07:13:37PM -0400, Paul Moore wrote:
> On Fri, May 29, 2026 at 5:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > The task_euid() method is a very weird method, and Binder was the only
> > user. As of commit 65b672152289 ("binder: use current_euid() for
> > transaction sender identity") Binder doesn't use task_euid() anymore,
> > so we can delete this method.
>=20
> Given the problems from last time, it seems like it might be prudent
> to let the commit have some time to "breathe" in a proper release, I'd
> suggest merging this not for the upcoming v7.2 merge window but
> instead waiting for v7.3.

Sure, that makes sense. I'll resend after the merge window.

> > My suggestion would be to merge this through the LSM tree.
>=20
> That's fine with me.  I'd also suggest updating the commit description
> in patch 1/2 to indicate that binder is no longer using task_euid();
> it currently reads like it is still being used.

I guess this occurred because when patch 1 was written, it really *was*
still being used. Perhaps we could pick up only patch 1 now since even
if we run into problems and Binder has to go back to using task_euid(),
clarifying the docs is still useful.

Alice
