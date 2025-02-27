Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F82A48
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614947; cv=none; b=KsXUck56t8tCHUFAPk+wZnjrNjRYZnZr7LthqttrGXmiRpeS4Y8GEJjfV+rYt+9ygbzZ9OBEZ/VBpLhSxdQPoPFBBZ+9eqNkEc/oicsiJ9TE0TvyyoG871KopZcUwoCOcTrlrhOYp8yAbwndFY5GjfW8rxYVE7RleI6oZouHTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614947; c=relaxed/simple;
	bh=T93EluGlAaxHLNvDA5oGbMjnzf0LzeJetPK/nBd96dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6vKb/CSYc0PThO78a2BBNNaTQsLyARSkugduTGpaKum7qDYnwXM71oCD9y4eky/ba+UQF+pb4NmSXTMfTYUCpQq9WDDwFdVidCBv2DPlI2paZEwtoJm84DE/15jqbZT+aUdJVO1VGrUp8YSIjlhMMnlXNXK1bfmBbwMFg0yzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KpbkjT6g; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KpbkjT6g"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f6c90b51c3so4100567b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 16:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740614945; x=1741219745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxDDdJmrNTe6UPiTyr082HreUva1ZWAfMMzgjWcC55k=;
        b=KpbkjT6gLFeHyNS5mt/AAAPUOMl+ChOWhqknh37UBwoU0vLPV7xqftF2F144K5d9jk
         GO4ylHhEO+GYBc3Tv9TpFVWYXmJikuqtrJ0ytq3pCqS/teaeepgnTPB5pZGzBXZC7m9f
         bOSsuDGkhmIYFu1/Et7PwZC4S/ja2Rs3aJVo8+4kLpGxAWC9ooWCp7hAOFJi4Z8qSrye
         g0BcwQJfENKq4mLRdnb3S2h8+LXTI9QFAjAvLYvZO+3JSeGup3+YIUK6ESe4XSDF2rGW
         lL28NXMY/tFOxggd1yJa0H6xVnA3HN68d9UAgjyOmdRHbc4285UGy/GBX9ctisFWlwkk
         sMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740614945; x=1741219745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxDDdJmrNTe6UPiTyr082HreUva1ZWAfMMzgjWcC55k=;
        b=eCN049mSMKUWVSu/gd9hiMSLH6vhyLzyzrjNAq4JPjZhjkqs5PvxpGO7IEC1RQBs53
         dQIo8Lk5q1aDVtE+3vBMm+kRxXsEukwza1Ycztjkgyept6jtq2oY/VG62KDBFDFxE+Et
         zP6E9gjs29ItmADc3YG2DvQCi4fgCffB1XYHkXN45LZH8zsBpAf7WXU4dWO+dQVAaFsf
         GzT2B3MAkoMDPA0ixhPEeE9lnlu2J4XGg0AiwsfjI2X6WsJ7LKJoOtl3Vo2fa6SyVA9/
         ZFo/r0juARyr4o34oZDbtaw8n8FX6rmOB7utt6IJnaAmSsPQwxpjNOKMF4nEmFN2durk
         DNjA==
X-Gm-Message-State: AOJu0YxFO0YtoRe571WgiVT3avcgtgvbCcvXeWnMWGFtkCB3LlPGEDHE
	hkXPnQaSY4w8fIPzb3G4ZsjU7UurEqiEJJEKFyNiCocAUVSJRClb4YqnnvY4f8c8cllZqMMs7tx
	bQT0m4UhhYXNvzosw229emzD4yP+f/rvbkz5t
X-Gm-Gg: ASbGncteh78Vn25giUrCdv0KZ2+rjKqLlQj3hh19ZADtO/zYx4BznCoA+WalXIHweqi
	qtrKxRVAjQPk1WexdAcWtdAQ5PP2rF0jslsuGxT+57UATDlzMHM7fRB/Cff/LYTxaT0yPsYlxYa
	ho2kw4BvQ=
X-Google-Smtp-Source: AGHT+IGsDgtv1KuxkNbzExf+EpIsoY+lM5NEnz/rT+LKaBz8EW3XsAlE+HFeGN6cBIjwcOMLp67F3eTv9peKYwEzbGU=
X-Received: by 2002:a05:690c:6311:b0:6f9:4f93:c805 with SMTP id
 00721157ae682-6fd10a18bd9mr89838447b3.21.1740614944849; Wed, 26 Feb 2025
 16:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219172859.188117-1-linux@treblig.org> <CAHC9VhQ73qdL2Qf-jOMMVSf=+h-H8K+mz165XZztb5X6XjH11w@mail.gmail.com>
In-Reply-To: <CAHC9VhQ73qdL2Qf-jOMMVSf=+h-H8K+mz165XZztb5X6XjH11w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 19:08:52 -0500
X-Gm-Features: AQ5f1JrBAIqwrkawhZsoxnOQhIVUJoQVq-3y9hl2L-3pD5-ohnf4Qjl11DTqy_w
Message-ID: <CAHC9VhTuvNuNfeLrR+5b+LOB_kC8a_67EvLPnOJO4vcvkcuMYQ@mail.gmail.com>
Subject: Re: [PATCH v2] capability: Remove unused has_capability
To: linux@treblig.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 1:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Dec 19, 2024 at 12:29=E2=80=AFPM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > The vanilla has_capability() function has been unused since 2018's
> > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> >
> > Remove it.
> >
> > Fixup a comment in security/commoncap.c that referenced it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  include/linux/capability.h |  5 -----
> >  kernel/capability.c        | 16 ----------------
> >  security/commoncap.c       |  9 +++++----
> >  3 files changed, 5 insertions(+), 25 deletions(-)
>
> Now that Serge has the capabilities tree back up and running I'm
> assuming he will grab this patch, if not just let me know Serge and I
> can take it.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Bump this thread to make sure Serge sees it ...

--=20
paul-moore.com
