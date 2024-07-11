Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247E262BE
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728935; cv=none; b=LeaDcWAf3AiBBj3jBwX5ol3NLLTCbuUhsY3U0/55BSvSzdNpf7/hujH0Ox783rV0w5WY020Suea+BMtSdgzb2GCJLpYaS6E6L/Hgd3Q5qutVktSDpRjsCc6TzShOUxXfr+ZP0sSqO2YhLfRsOqEuFJHFABFCQ4jMs267616Spi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728935; c=relaxed/simple;
	bh=MiKddPhHO5bTFiK3lBDosTu2tLEQG6fbhdLDlQA4CAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIKHY7+iBS70ktwwhB0jnRwGNoENlGggSaXRMTCtzrXOKCIc+e8HpNCVf1SUFb1gjdzZS4FoJdRbPtKoLaQp6NT83eEqPeRG6WRFPsphMD3TwraG2qVmnnG7pVO6iTDwxe6Br0SebChNB0eYQJ9anD8Qs+OBqwZIw93GfFzw53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RNR8s/r9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RNR8s/r9"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64b5617ba47so12514247b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720728931; x=1721333731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g6pxKC/tBZZKeMaQtJd0U0YQCXPRbZF0OQWpIX0uYU=;
        b=RNR8s/r923Ow9gYrH6BRUzfXbXqC0W8V7WEU103xSJm1wwpaKe/wmCZONy61Q2KTaO
         jsxpZqi0igAQ3CJ05NzjnHG+EYUFxCEqodvQBzTvfs1kv7exsraTi8sPyxJUqBYYWF5Z
         pz9MaW7yMW7i4M3OQxEAadKw+LZJXp858FUfCWcVrix2sU6y3Y4rVHytIjpxxUiUDVGt
         +p5gfgQz1HpHrzYlKxeKM02CSXECNbheAWlEPzQhDNrYGOKkZypvA3+H43lX25o5CJWI
         fjI29hpeSThF3syCV/74blYQ12ORZePgwC9C9sl8HJzOLRIVqQP6lz+v3GDkBCxXTxiP
         hahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720728931; x=1721333731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g6pxKC/tBZZKeMaQtJd0U0YQCXPRbZF0OQWpIX0uYU=;
        b=veRTsDzjAD6jkaJqlydiCYOrQLJ2Kan01i2VzeDQgcDXO77vZ2J7ZLI/YSOEphaZ8X
         QO523uMHHAh/xlU8XJWoZl7n78X1rhj4EN5VxeMf/Gu+HvGCARU7W8QO765mRqGj4M0r
         9ZY0appQD+jHoWHMqpUPm6MeBU/1YFtvWmtdT35Yolu2Zk5dPyyk/00+y+GgXcFt+4CA
         BaU5+tG4KLd8RJNGRZnZFE79crdj6nK10GlA3QxFUTTPnEPumfaWx+xuzmMLD8RGalD7
         IHL65E4uvI0RpSeZz/Uk9RqvO0/LUUMblbxUo5P3E6BCgb4meT/PwafiB+2ZxcUA5rjf
         K1sQ==
X-Gm-Message-State: AOJu0YzjRv5q6fJfG5kpb15xgsNo7d0AoQ3wEr9khl264wOXUrwMvffm
	2oYAgSifWwCow1f6wO0yfPWHvhkRW0K4q9uZz+7IXXIH02VCENj1+0Rveqg1yf1px39/GMZ2/P3
	Gv8o6eS4xsfwTgl+g49xs4P6eQQNlqhIY5GWw
X-Google-Smtp-Source: AGHT+IHP5jyc9eIxQahKwLD1FaVzJ6X/kMf0yr+wMeycRrjsAcL4R7EikxiG2Zn6Pb2Taj/KGKkLJBA6nXi+qjuuYXw=
X-Received: by 2002:a05:690c:f14:b0:632:7161:d16c with SMTP id
 00721157ae682-658ef3411demr140109347b3.28.1720728931573; Thu, 11 Jul 2024
 13:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710213230.11978-1-casey.ref@schaufler-ca.com> <20240710213230.11978-1-casey@schaufler-ca.com>
In-Reply-To: <20240710213230.11978-1-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 16:15:20 -0400
Message-ID: <CAHC9VhTLnxKUdJCYUejMiEsn5cBmMMS4aiHt_Gq8qKvpqx=YLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LSM: Infrastructure blob allocation
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:32=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> When more than one Linux Security Module (LSM) can use the security
> blob for a partincular object the management of the memory associated
> with that blob needs to be done by the infrastructure rather than the
> individual modules.  Until now, this has been done on an as needed basis,
> with the blob management remaining in the modules until such time as a
> new configuration of modules requires sharing the blob.  This piecemeal
> approach makes adding new modules that use blobs more difficult, as
> moving the blob management to the infrastructure isn't as simple as
> it might seem. This patch set moves management of the security blobs
> that is done in the modules into the infrastructure. Making security
> blob management more consistant improves mantainablity and makes the
> possibilty of general improvement of LSM blob managment easier.
>
> No effort has been put into pursuing the possible performance
> optimizations these changes introduce. For example, sk_security blobs
> might be moved to use kmem_zone_alloc(). The option of changing the
> blob sizes to being compile time determined rather than calculated at
> run time has been considered for future exploration.
>
> In the cases where infrastructure blob freeing no longer requires
> any special action on the part of any security module the hook
> definition has been removed as it is no long necessary.
>
> Security blobs for the xfrm subsystem are problematic as the only
> security module that implements them (SELinux) has a variable size blob
> that has a published external API. Management of these blobs by the
> infrastructure will require significant consideration and negotiation
> with the maintainers of the existing code.  This has been deferred until
> such time as another user of xfrm appears.
>
> Casey Schaufler (6):
>   LSM: Infrastructure management of the sock security
>   LSM: Infrastructure management of the key security blob
>   LSM: Add helper for blob allocations
>   LSM: Infrastructure management of the dev_tun blob
>   LSM: Infrastructure management of the infiniband blob
>   LSM: Infrastructure management of the perf_event security blob
>
>  include/linux/lsm_hook_defs.h     |   8 +-
>  include/linux/lsm_hooks.h         |   5 +
>  security/apparmor/include/net.h   |   3 +-
>  security/apparmor/lsm.c           |  17 +--
>  security/apparmor/net.c           |   2 +-
>  security/security.c               | 184 +++++++++++++++++++++---------
>  security/selinux/hooks.c          | 157 +++++++++----------------
>  security/selinux/include/objsec.h |  30 +++++
>  security/selinux/netlabel.c       |  23 ++--
>  security/smack/smack.h            |  12 ++
>  security/smack/smack_lsm.c        | 101 ++++++++--------
>  security/smack/smack_netfilter.c  |   4 +-
>  12 files changed, 298 insertions(+), 248 deletions(-)

Thanks Casey, these look good.  I'm going to merge them in
lsm/dev-staging now with the expectation that they'll be merged after
the upcoming merge window closes.

--=20
paul-moore.com
