Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C77378839
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451448; cv=none; b=s9jGD0wTrkK7twZ2K560/fnOmAML5cx4Q9AgxHyxbJLKsxgA+Cd5WhUHLkoKAQrq3UK7dulnPe1BmadSgskDJQcseBgq4NvYjnnW2ZMdg1NYhlHpBYMYl7GC0KChNSYCiaofAYu4PEUVLwot6AkyZ5zKfKNF99IwuH8jVS0NJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451448; c=relaxed/simple;
	bh=6QIPcqi/hr9Q5Mw00FYk5D293PSOJwYSWX9mfItRy44=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IeIXavrQ/Pie2URawnz1DZkmzRpa5Kt8YRe9II5pkuYNa54yI5w+Q4MMZhH/gFiXssDdiG8ru74l0GCFjURcdEGnO7GefA/H8obLN3zrAd45sI7cKW6Z1ewH+MAweb9+6DSRP/G+nUyyCQlHcey0mQZqWn7bNYG2JIJVy2dD7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c+BA9des; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c+BA9des"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8eaa7b5e31eso6039846d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783451446; x=1784056246; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LUpyADyWOfmSP2Gd0K/OIW0oeVkcwDMQQoPjYwT+FQ=;
        b=c+BA9des1e1uFnmqACzRnsVP+9gsL0iFDlEeHo5Ts1RVfRBQDtDTENqR8mqNBFQjtb
         BjW9KVwtSLpakQSpiJ8C3+zMwD35VIFTdTDJyoGxalj2MswXSjTG6WnKquZTUS+bR59R
         Emtjkol631c5jbD0JWshZ84dOnr8UN2RdPSrKFnUbBj3snPZvFNrw9zfzgE7XFhiHZ17
         CVLmIZauLKJo7Gic5PSOzGE+urEF9a8p/Yk/ZePgyP4Y3cyiGqL/ZZJPGAzWMJsGlBHr
         Kt6UmOpaPZBC3qc0PCdxWBlaAzfyAVwPVtLZNOxrdhDZVy1QW3CVR6xypPXyQSxetDMv
         NN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451446; x=1784056246;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LUpyADyWOfmSP2Gd0K/OIW0oeVkcwDMQQoPjYwT+FQ=;
        b=J4DZByUiNxW3W0vvzNAPiBG3hDPC3FSR+grbL4ZSYgsQD1Ule8jUsteA5h/65LZAKp
         iv0OYqGGoU9DXYnoaRxu6yf+yapFF/t49uzc9tsTnI59Epg+Y76H7TjmETpqw9cEzlDK
         wpXmBgiCy3QcCgRurU9hbzG/ZGyuBy7Sc3Bg5azSX+i3t4+OezAqdj3HDiYPOxWEzm//
         6i/B7yajlH+2TJwftfJxQUzLg7k+RaWFx3bQziVW+znXzxpFz+FOq0IsNx7/wmh5+vVh
         cP7O+YSne2WDgbkBGhGNBgQcrsJcbrIWoYj+LRHs/X6zh0/iSn3oCVvyzvFqcomM4OgC
         Y9HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKSGQHfOA3+MulmLLDSUOSuxIKoXk+Orzq0saaKUdszdjF6NU4oCEzU+hv8RbGeF7nx/QRdt1Jm1n/w9TqiNpLIaSakLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtp8uuhd2e+cu9iKZVlDPuvp3eH74LMGk8mJikD4J3qSUhkBsL
	Cmj4Ey+aZgmbg8q4RUs8VEgpfNWZk6FuP2D7LFwulTUW25wD3SJivV3EkLi9WF2RyA==
X-Gm-Gg: AfdE7cn/xupx3hu1jTql6T6sISoM+rp1xbYuDKR7paN01Brow4nMisijXzXH14Jr/x4
	w2DBOGCnNeAFgtE+vGWHVKOb7ST51UcEj9/B988lY84UQt64T+xVVfpCV2r+OfhJWQICbVl7lJ6
	GDt7lubw4j422t5RNmmlzOj6QMNnsJVzu0TNL2pTnrc6uMWuXfeqNbMgOTTCN+dLLNPsAKuvBQX
	TmAPr2+ZhB+2lF8FOPZn6twTh1z0UkUPdzSHWm6OxEnivN+5JNUEArJOU7ZdhHVVkapsKWsDHOD
	ZM2SBsqdKFF45pElbAsiX9TsPRFoa3SoJmlG4vHaa/kxlnlx/MaO4qJ8V1qo1bjU02vLHuL13OI
	4x4OHfNyR581+RUuXMjK1L/382W3DhRxbtpUbKV3xOhnXUueSjWHpZUXi1q6r4qqENk7guy0hki
	e5IGC5bvvLjG2s/zYtu8IsJe9YRIRp7JN2kiU02oTdhYaRHv2PwFxE5f/b26p/mKzb5jU/
X-Received: by 2002:ad4:5dec:0:b0:8f1:4bff:24dd with SMTP id 6a1803df08f44-8fd71be1e1cmr41525216d6.5.1783451445824;
        Tue, 07 Jul 2026 12:10:45 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724ba6fesm165735406d6.41.2026.07.07.12.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:10:44 -0700 (PDT)
Date: Tue, 07 Jul 2026 15:10:43 -0400
Message-ID: <c49545c6c69225bbc7e93cac58d58cd3@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260707_1504/pstg-lib:20260707_1258/pstg-pwork:20260707_1504
From: Paul Moore <paul@paul-moore.com>
To: Alice Ryhl <aliceryhl@google.com>, Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v5 1/2] rust: task: clarify comments on task UID accessors
References: <20260703-remove-task-euid-v5-1-c90c7e2ddf54@google.com>
In-Reply-To: <20260703-remove-task-euid-v5-1-c90c7e2ddf54@google.com>

On Jul  3, 2026 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> Linux has separate subjective and objective task credentials, see the
> comment above `struct cred`. Clarify which accessor functions operate on
> which set of credentials.
> 
> Also document that Task::euid() is a very weird operation. You can see how
> weird it is by grepping for task_euid() in the history - binder was its
> only user. Task::euid() obtains the objective effective UID - it looks
> at the credentials of the task for purposes of acting on it as an
> object, but then accesses the effective UID (which the credentials.7 man
> page describes as "[...] used by the kernel to determine the permissions
> that the process will have when accessing shared resources [...]").
> 
> For context:
> Arguably, binder's use of task_euid() is a theoretical security problem,
> which only has no impact on Android because Android has no setuid binaries
> executable by apps.
> commit 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> originally fixed that by removing that only user of task_euid(), but the
> fix got reverted in commit c21a80ca0684 ("binder: fix test regression
> due to sender_euid change") because some Android test started failing.
> It was since fixed again by commit 65b672152289 ("binder: use
> current_euid() for transaction sender identity"), which uses
> current_euid() instead.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Originally sent as:
> https://lore.kernel.org/r/20260212-rust-uid-v1-1-deff4214c766@google.com
> ---
>  rust/kernel/task.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
