Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985C22A4DB
	for <linux-security-module@vger.kernel.org>; Thu, 12 Jun 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729120; cv=none; b=VvXOVz9JbDbRdcRTPViwImTahWBoIusiV84L0CXxyGD2rFuF2OpMW7zqobu5WZbxNVICGAQf4XOttS+Q2xMMfy1kqqbU2MjZu5/4ELcAvQCJwJHjqruAy/9IqpncWelnEW95TPzbmcUU802GskOuXnL+fs4G20ShKVCgSrborho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729120; c=relaxed/simple;
	bh=rpaoB6Kdgo30xP8EggVBx+Midw7SMjcJzLqwV3FyulY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JsG+3rMErT0IGydgzc9fpvDLL8iVRamauBGK9Cg9RkGwbDhCcwH0rLFPTdaBxb/nhioKz+TMkeBe7OT2NLVP1RIOJfG5Kj6oJqqXNv8KVcGfKKZlkrzESVtX9eguNtDlUxLT4Z0C5AXy0wJh3bJChrSIT7y1c+Qckc4iaGQ0HSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ojci9aEQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ojci9aEQ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4532514dee8so6896355e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jun 2025 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749729118; x=1750333918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAzmGILo7rrIxQG7aEQAZf7smERdqkspR5utlYUtpd8=;
        b=Ojci9aEQrBh485tfzv7GvvIhoDv/t9jkNfNwJ+/O8qwZ2LMc9AsO5CRjTezdP5Oz2F
         PF51PX+X9OcfVLAUkTInFwtES4lndDA0dv5B4zYjml0JaMhzHK0r5Zunp2NfBqkheyc7
         g/cQxfsO/Zjo08dXZIqzKdmQlMgl8Eg7DQ9zgPQcqCfoOTd4NZDgjxdg4n2kSazJ3b09
         xsN3+OCDhHcTX2o9QypyoldVZnAS9r+qAqehn+0r45I+uceJPC71OeVVsrWn7sUGaq3a
         IeiHj1O13UwlHGNvFyNuLjMy0/fZ2fBeHS02XWIZNP6W/zbOW6oNvG8Vh9A/ySUkdsyq
         KyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749729118; x=1750333918;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAzmGILo7rrIxQG7aEQAZf7smERdqkspR5utlYUtpd8=;
        b=Qel/bjX6jy9TQq2Vbzk4m5wJEfAZDx3ZwQBVdimfYKb9zRcl46TUoFCGuXATy7iVtY
         rVylrJNCF5eonyV1bnbcw1jy88Lw+7+3uoQ5TkOSgNDoIDENd0irgi9DHaRFlgdI5PMj
         1iw3i3lxLjKT9ltqUE7Hs/ph4s2ygncoggwUszOrPMvbepCKBpf3jwIwjYjhBFMRiYUz
         21dYYsIG0JHzyAlPACZIZzX9bJn+Kd9M4UdnXIQWdtDomvQfyPQMjbS7F3FKn+n6sNkO
         XxZW0lguh/Lw+XOZ8v9XSqkl6n7QNUygUNuDZAoYB1ilKFlisMwijjmcatsjBQRvQYSv
         7RCA==
X-Forwarded-Encrypted: i=1; AJvYcCVLNKfB6uwGoQugpQnYbeKNXwPEQ7zDRgOpM6bLzWCMXBGVLjrQJa/8Kle4O8vlSaOCQ9YsC837+S4KcJkRYr1H/DeLXTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWbiiWWXazUEUwUvCCQBXjWL+WBgSu9x7FHWggvAO7yW09VIx
	TXyhC2mKtWAK71K8fioZtgHg686Bf+pJbHK2Sy8394UGT/Fte32Ii8DVwOqY2rnqB6+bVAwnFMg
	OndsDZA==
X-Google-Smtp-Source: AGHT+IEsZKWdgHnANRx2ktnzmqvZGLXgx1+Ck47ZJza7y/Io0sU2Wnsif1R3hfmp7+yITN1T3BAdCVc/W1Q=
X-Received: from wmbei22.prod.google.com ([2002:a05:600c:3f16:b0:453:99d:39ff])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6304:b0:442:d9f2:c74e
 with SMTP id 5b1f17b1804b1-453248cadc7mr58292805e9.23.1749729117681; Thu, 12
 Jun 2025 04:51:57 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:51:55 +0200
In-Reply-To: <20250602.ko3thoc7ooL4@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228.b3794e33d5c0@gnoack.org> <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org> <20250311.aefai7vo6huW@digikod.net>
 <20250518.be040c48937c@gnoack.org> <20250518.xeevoom3kieY@digikod.net>
 <aDmvpOMlaAZOXrji@google.com> <20250530.ozeuZufee5yu@digikod.net>
 <aDncH8D9FoyAIsTv@google.com> <20250602.ko3thoc7ooL4@digikod.net>
Message-ID: <aEq_IAsYm2wFjA0c@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for landlock_restrict_self()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, Peter Newman <peternewman@google.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 08:45:06AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 30, 2025 at 06:26:07PM +0200, G=C3=BCnther Noack wrote:
> >      As Jann pointed out in [1], the tasklist_lock and siglock are not =
sleepable
> >      and can't be used while waiting, which is why he proposed an appro=
ach where
> >      we retry in a loop until no new threads show up any more, while ge=
tting the
> >      existing threads stuck in the task_work as well (where they can't =
spawn new
> >      threads).
>=20
> This looks good.  Too bad we need to block all threads.

OK, I'll take that route then.

In my understanding, if we are already blocking all threads, we might as we=
ll
use prepare_creds() in these threads again. -- It does not cost us much mor=
e to
collect these potential errors now.  Does that sound reasonable?

=E2=80=94G=C3=BCnther
