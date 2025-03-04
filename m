Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517E1FF1C6
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084627; cv=none; b=drGa7wWtv7FbUWD/Nw27BBUEx6AogTQ9RXqwIc92zBYY4XLnqK4874QzLavF0VykozBtv5bSd0DyqkR4H80KgTN5SwILClz4H4ZhIXRasovuEve5NgeX9BJKRld+PkEcPU/xz/KPMnR/c++jLpBLuzDYGcX4j4/reZeaardKuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084627; c=relaxed/simple;
	bh=Ph7Z/eQgdHPhRHi/cGs92I8dsrsvDBOdjLTZ5ObY0Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riqGeUOl4FaryIdE/w7SGhB03zU/z/uZqxQrV0o9TuUsp+tF0mPohguT41FywgaGMdAKEngieb+jw/0Cs8GOPkyh39OYw0mNmbAzVITLacGWYY0P9cGajn3srUi4ShM2CEg04RVbRW4sL5lZS3oxfE7YfkoGztr1FhI0yUgff1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOZ/Q1ss; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOZ/Q1ss"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390df942558so4256470f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741084624; x=1741689424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfoXHWbkxpn8CLKu2E2rVl/Oeya0FmkAvYXgZjUPXs=;
        b=cOZ/Q1ssJvP5NH+A/AgBtKieSCXSv2M4jeXGyim7rZDJ+kGJc7dYtK/M1Ea9C6q504
         4Lwmha3jPiwBJmA6hC5GXBZLs3MeNdqZK5R4c73qdghfsmwYZZVWtmHzrtzDK4f2EfyY
         hDFSb6gQs+xT19BeqAs1FXsa+NGhKhnWroL+RU6FQm8Kb/LlQu545FKNUX9WuTX/7pe5
         H5UtU2kfvvP61ZNlhIVGqpKOigycvecGOKQR3XBBKGgHMaFfxThmp5xSBiu0GMNn6N7S
         ++N7tC4Rlbhg6UGIHiR2x6yRMe0J544C5kHxEVgcLelRG0uQGLw0gYy2osXiGFl8pd7b
         gr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084624; x=1741689424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnfoXHWbkxpn8CLKu2E2rVl/Oeya0FmkAvYXgZjUPXs=;
        b=Nl6Uff+ELMn6RdPa8Bdd1YznBUq/wluaQr7/XId99sOjDADaOedoFxXiLBVQB/rWoA
         mTGSDqfBwsgEGs0w/JkBZYQeh92cKCRALz19Pt9wHPGusMis2PfdYmXSRJRA2w/eNXHJ
         IadJAVa7py2gu7Elw2PwiAQ4s3V5pM1rdQ2e2dl4ugKnE0bQQ2Sv/zlDroOQLojW5GH3
         11h+eIBfk/JdVkCDoyUQqrpwLQl+4USDr/lOUP0aX3UnsD4u+sipoUmU8ID2+0O79MZJ
         PkjHZy7SXo7BkT48bWojCfqsnROegLEKclFwKPBAZZTtbxTbgaQPPSgAxurSgQR2F47L
         g2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVm4oAdhTVfq2QyYQFSb2lkA7fZZ2dLofPuO4h41sSx+STbjz9SmyyDLAGy4hyLCz6CT1XkYIqFCxO1vuJ8e/T4Zvp945M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2udANo/dFeRTIRuYy9pqDw6nonq44syIPfDDDAhiyajPLXJUB
	vDmlZJomDkIUuanGGQ6WxuBTB2Kxe7IUdVUwYGe3Oj5fz9opwxy7UZsWzAQVIwRoINJ6scF/mNZ
	v871y7wY8aZwq2xRYVBeVDpOY2+hw+OJAf0Hn
X-Gm-Gg: ASbGncs7Ognvj8IN4WmGYzrv5SXlxwzXUi+HIRJyLx9x2F88lCNRLTaWzy5r6/TMf+A
	gj3piCVj4xgWgb3PD9Coyp9dhiBHRoKjbqKd/RrsaFIDwk8wJB0mhBW2GcGrTI8oInMcCwPCBxW
	0Im0QFIAJMzM+kiWf4Aqqr4CKuVZbafi1KjbI3ITc3enWp4B+tYBFic2o=
X-Google-Smtp-Source: AGHT+IHnZGopTu14rJhQmFHdcWS/CmtUr7Vq5gBSfsQMqLY+ddlQ2k7+IHh8qMlJWxhe9a/q9UgVjpEYak7y23CaNeo=
X-Received: by 2002:a05:6000:1786:b0:391:1213:9479 with SMTP id
 ffacd0b85a97d-3911213986fmr4342313f8f.51.1741084624201; Tue, 04 Mar 2025
 02:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com> <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
In-Reply-To: <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 4 Mar 2025 11:36:51 +0100
X-Gm-Features: AQ5f1Jr6vlrRiPYv8T2mmkPxNCUjz2IzWb_BB5bszisP39eJSBbTg3T7YfzmtPY
Message-ID: <CAH5fLgi6ZFBqtyUuGPbdST-tEzHJ=Wp1khDxQhO_h+bZiFVj8g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Mar 3, 2025 at 10:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > I'm seeing Binder generating calls to methods on SecurityCtx such as
> > from_secid and drop without inlining. Since these methods are really
> > simple wrappers around C functions, mark the methods to inline to avoid
> > generating these useless small functions.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/security.rs | 5 +++++
> >  1 file changed, 5 insertions(+)
>
> While this isn't specific to your patch, Casey's comment about "free"
> vs "release" is something to keep in mind when working on the LSM
> bindings; what happens inside the individual LSMs for a given LSM hook
> can vary quite a bit.
>
> I also saw a similar Rust patch where a commenter suggested using
> "impersonal facts" in the commit description and I believe that is a
> good idea here as well.
>
> Beyond those nitpicks, this looks okay to me based on my *extremely*
> limited Rust knowledge.  With the minor requested changes in place,
> would you prefer me to take this via the LSM tree, or would you prefer
> it to go up to Linus via a more Rust-y tree?

It would be great if you could take it, thanks!

Regarding the other patch for "Credential", is your tree also the
correct place for that? It's a bit unclear to me which tree maintains
credentials.

Alice
