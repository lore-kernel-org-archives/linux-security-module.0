Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EE1D63CD
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775764; cv=none; b=lTeLLDcVIlWqZR7WIodXabnFETB9L8xplqRkYk5i450ry91KC8xd/cdy7TeA95rGB16Djo0wJ3OIKN2Wtn6capQhdrVpWIGVIaoKi3wdUTxatSkYolZEOvPIvPqo4uRVzw/XKubONmVytk5KgaMu8KnomM4STHGxpD96unHnOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775764; c=relaxed/simple;
	bh=PokIbil+4vzb3IM+d56Xpj4Mvgib+ySxP9q4ulJxR48=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Xr9cqhUN3lpjBT0gJYpCzPsoJVVmXLa8CAAlr9yt22XUFsoJn8hk/NhNxJQ5rrkMz4Uh97+kevUQ6or6zoE8MH6XKQ49RHxAnvE9gbF8Ys1BTgGIV0eTJeplUrcXIZ9c/ChPOdV3dl0uajtiijf7tf4oM8NAQby0IdUTlVhFDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SATGsQUV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SATGsQUV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0ad74483fso64428116d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747775760; x=1748380560; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=SATGsQUVNCcWA5EQ2sN31YQi0KcO0OMgg67xcYs16ITaMOe6Op0u1D+gq7ILTSB/DL
         FQdpiltkvmAEgWIanzWiNeydwbuD0aYpWwjtKgHSWO2+a1IMCM/L2d/EDsMDVqiR/t2A
         Dr4vo7CV/Fw3dsrFiU//gjBLuMSUaBhq8lVdNQAtdZY1PTDlbLXocFdQ0S6bxFniWug3
         JssnaOmXDTxnsZ7//pEfNyN7VOKN1Tmeke8pl+mCHHEZ5Qa9IcHIRRtY9bPIi/qbv8Zm
         XyXzgURy4XykbyrKYNDGCVpAz3iq+XNE3u0910/h/s0G2OWeoqOMatHPvm/cFMZvW8ps
         LJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775760; x=1748380560;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=Im4HCt72z7pi0xC7GYL+8W6PLxngt6Q3fXuSNq4vdn5AKr/Fs/Frvix5X8nU8O3bgj
         GSrnJB87b8J7hNsRr2KksWJdalqnd4s6R5RSjzUC3Dv0WONAWgc0JyiYyGQyhU7L7+Nz
         y17W/1TWrnUg9tSqk6NpHfoE5c3b2qG5v/k/g/shlfA/EEJo0rMd0xMZP6n6rkUcW+Z5
         Li1FrNkWkOwHsfqtEhplDEXR4J3neOMo8iGNEHLvhmejuHS7V7hOZzrB5vGJ/aieZ3o4
         LX7+wi4peFg1kzBguCSoGHuJP9eNbruTZCdKWhQa1P4R25oUl+NDUDQm1PE+xBGaROow
         P1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaU3qiWzvA3PfoVJm1fBqvZsk2PlAvU+eL9yz6uTHoe8hwRiqatQGOrFKUfirMpGa9Av9LKXozaTu23+/SkwgJn3XyYDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9GMxgnmpoMyeKwEyDREIEaz7C+IuGCmubiy6GFQAURAO2I3o
	0PpbaEcYcWf8HUQFzsMy25X7f/6PT5bEazncJ9BpEoX8aviH/PZjjHwdXCPNq2RFAg==
X-Gm-Gg: ASbGnctmcfIARrP36zYNaAjGmT2q+s9VEnyc8G08UhGruXx6vBtSz5QJO43fTnEhMVu
	dbrhQMvHtg1eL1O1QMqHo7yM+wNNVovBKQUlPOVpMWAUO/FrTxcjPNGr1dezhyTxN5aKvu3sPxj
	nhptczhLBE4um8Bka8i+cd34viwZcLWjMw3a872CO5/OWhxAhRYhDlShoMYifhKKFXS0NSsdGi3
	XvxTnARzTebK7w+8WD40KC4tk8DxxKv/QfC6jiLUQvX5tXVWGMzLif3snRVID7u6rBwFMdhluJQ
	CR0FjUPBMqrOkwv6LKGkXOpVoldWLDydy4UoKVc6gMZ+bU5+ShUozTZV6rtVGfTSStrlpUVQ0nj
	f1xd56fxbGqD0kYOXwZ1veTGpLSgAo9g=
X-Google-Smtp-Source: AGHT+IGXRcWfO4AHv0ErYu9MQe8pxWB5OkTwD4jggVmmRyicMFT0cpUlaxE7iaZV/7atuSeHLh1gYg==
X-Received: by 2002:ad4:5e8f:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6f8b0873ba6mr330435226d6.36.1747775760552;
        Tue, 20 May 2025 14:16:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883b93sm76456226d6.14.2025.05.20.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:15:59 -0700 (PDT)
Date: Tue, 20 May 2025 17:15:59 -0400
Message-ID: <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, maco@android.com, joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com, surenb@google.com, omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, hridya@google.com
Cc: smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to  binder
References: <20250417002005.2306284-2-dualli@chromium.org>
In-Reply-To: <20250417002005.2306284-2-dualli@chromium.org>

On Apr 16, 2025 Li Li <dualli@chromium.org> wrote:
> 
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic
> netlink driver to report certain binder transactions.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  6 ++++++
>  security/security.c                 | 13 +++++++++++++
>  security/selinux/hooks.c            |  7 +++++++
>  security/selinux/include/classmap.h |  3 ++-
>  5 files changed, 29 insertions(+), 1 deletion(-)

When possible, it is helpful to include at least one caller in the patch
which adds a new LSM hook as it helps put the hook in context.  With that
in mind, I think it would be best to reorder this patchset so that patch
2/3 comes first and this patch comes second, with this patch including
the change to binder_nl_report_setup_doit() which adds the call to the
new LSM hook.

--
paul-moore.com
