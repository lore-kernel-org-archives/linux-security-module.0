Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FA1EE7B9
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308355; cv=none; b=jq2iyyF6PoczeBtS9tu4ihozYeysGZerwkmJ07EZ9XP86uz1PSWBHptPBKottYVVc8BqT8cYb8dbFp8aLsme4SLbM5USn34mVz6K8cvdjTw6L5OCxBnEH3FrB0+Lv9WqjEmOxoMj3ksWbnM8nbgdVSXNWn2czSQ1MiJ0YEfUAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308355; c=relaxed/simple;
	bh=mdja1zPwi11rl3j2lP+FosY/etFHJecqSbnzsbEbdzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAyePr2upTaEav3r3nSzvTg0NNZl0NshPl+kqqSpCyfgMCfeJoqLbG9dwSeP54DrrACeWTKf5h5yuMtZmqW+o+S8ue5QiXzhqZyky109zg1U2DVRcqQ/cx/N9sq7cspH60PKfuD2GBtb2J8KewaeOabfXJpA2f3BdQ2+XFdPFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YrW6QqHY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YrW6QqHY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b10594812so4917793e87.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745308352; x=1745913152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr8zkHOcjJp8JH/D5R9zZ1N0PkwxRBvn2f61DwoqQx4=;
        b=YrW6QqHYMSXMXFG4BFWLnIMOusSnNpuwDIwYfVs7Q1qTT/7KAmFWl9i4XO2EOJjXoQ
         yBHSxtTxYr1wTtZB5oJBGG7eh38na1b+0fegCbUX/MLNxhTBwZFcHZFzRh+gAShkeyHX
         cKWwOkktdQh4qMuafKJhk0l2wXP+rv0AY+26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745308352; x=1745913152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr8zkHOcjJp8JH/D5R9zZ1N0PkwxRBvn2f61DwoqQx4=;
        b=jwQMhJy8xfXny/aoUg4wsZapuOAcAzS1i+MB8MFp2biqpMymPkJioQ3ej9VNval2RY
         jQCCgLHJxfB1iup2CBvPSgJieO8meljwQ2BJU0Wo8t3RO2cfpWaw0BpOyJQJQV2jnO4O
         DIXTcxzRKC4tKtMX8TkjNPiUMW/RBsDmfgpEARpMRYe9wfZINouy2AXMjkE/pmMhkGSL
         XKK8izfYYaeZO1Z+pItvdACmeLqnlRYam49ie++KsxPt7RFYetmOlJc42LSl+cIyb7s2
         TtoubD+suQzJa9pVTAZE+Lc/Wt3swDOMYrantlNidTGpqM4FmFmWC+Eo25FfehkeiOl4
         FWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUObmBxnEOGDLYCtPYuJkrZyzDBTey+Jdh1g1rBk/SMSvmwHbBZbkclAVkq9hjy61lY50qgVnc3q0/gs/blKCJj7NeKVCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRm7IdFmohKIyXB61RBo1S4lbgQU2xAfMAoC4Tt5Sq4Uj6L3d
	w6eQs96yZeLHzQOrV3AkBsHZ18O8U+NEOFvVI/m7aIpw+pnDLUoKgXEYg7L3elpORJT/KFtttGq
	utUr0COOh90RMKg8d1RtuvB1699HpmhU/Lglz
X-Gm-Gg: ASbGnct6GIvJTnSJGtTTizNcTsJarEUg5VHRNhZxWeq9ftJ1owpjeofHq9cRLJqQzGa
	+1zVMoa/ixGAhFiBpGEgFuydRfVkKuuoEl8Cfb7KTyE5/sEyYuk+jY1sGYi6vBT8Ig6TRuQcs/C
	WibybIs8K9JR9Ka4Hhex4VXg==
X-Google-Smtp-Source: AGHT+IFJ6lcJHhs4les/hHMElmGqx/Gs/phTM805DYAJAK3V4MGWnxBI1/ZYxVFXtSykbjyfqSGPHxrZlSGhtLEvNSA=
X-Received: by 2002:a05:6512:398a:b0:54d:6989:919d with SMTP id
 2adb3069b0e04-54d6e66c955mr3838846e87.54.1745308351721; Tue, 22 Apr 2025
 00:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417002005.2306284-1-dualli@chromium.org> <20250417002005.2306284-2-dualli@chromium.org>
 <20250421151807.GQ2789685@horms.kernel.org>
In-Reply-To: <20250421151807.GQ2789685@horms.kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 22 Apr 2025 00:52:20 -0700
X-Gm-Features: ATxdqUGEbodkKiKzPD66g6rMQ0PQiXs-yAUyfR5qae67BGBgscO6cW8-1gvL2Ck
Message-ID: <CANBPYPi9+JvWOAPgOZLxq9dM9PX3-7Tz+_GnUR_xOKbtjdu8yQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v17 1/3] lsm, selinux: Add setup_report permission
 to binder
To: Simon Horman <horms@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 8:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Apr 16, 2025 at 05:20:02PM -0700, Li Li wrote:
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
>
> nit: permission
>
>     Flagged by checkpatch.pl --codespell
>

Would fix this typo along with other changes in the next version.
Thank you for catching this!

> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
>
> ...
