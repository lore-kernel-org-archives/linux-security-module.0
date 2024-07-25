Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF904C7B
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938747; cv=none; b=dU+/rlEqAsbzvJaao/HhWFlxPQwXRYEZml2E6zEfm0lmswAbeydjs88Kf9SsghR90krPmIwwlgBx9ESY3L3Jb0iWh/ChMDoIzSMywPEylgIHKgAhi3zD15C4DFA3prSnwRDbryXGRUi3o9FvT8FGNTs10WRGwZDUDqgvPf7gxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938747; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J25gcP9cF6HnWFX4sOIG0eBPbqGNNrCp6ziorcj9ZYtcziJu95E0drCqAH0uYwpxD5aXT613fzbtfDYUFNgVTdJYuZW+akq+OXPY7gZcIlBlvGxabXrxw/KWINqnCsBhJzc5hiCPFH5cdUFZ6OM952dEg2vz9sUV2O0lgV+RlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hBBTmeCX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hBBTmeCX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7ad02501c3so111786966b.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938743; x=1722543543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=hBBTmeCX6cAlViT0TiqdLTmdpnekeygOj0tmSbNLfe9rSPa1yZvVEGB3bBLGeTrSmE
         h8dj7TOy1XaXrfQXGxqiPmffXtXtqQnvukToe5ORHpPJG5eJxeU4IseJn7url8lyRl95
         MoS8Yf4QLq35Hp5BARG0xcZv74QK0P/X38/Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938743; x=1722543543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=hgZtYPJaZP73FeXRlZpkCPOG3b/yQg0gf1aiUM1dVWrDWS5lEwOpA1dHwPKKlql7dA
         PHMfCvYN7ayYd8FREHqEmWXV/yh6cC06w5a9EyVjGWorDWVAOuCiF9d7MMQ0kvpO6K3W
         IwKRyO6J0kqi5sXGy64oNmewY5nuvRyUz0595pyM3ctxhkbNbR21iBiyaZ+tX/b/HLDf
         WdIzjIrvW6Fiv/z2Vum6uAWYN13fUNejh4oYMoEKKZz0OMOIjcA9/Okk9IrGvgr37Imx
         CQ9k7CHbuV99OMuBwRMEq91yuQzsK+vCoKQ7adrrdWlWhAJ4eqN45s2F0dfeRu+YRTUx
         Ud2g==
X-Forwarded-Encrypted: i=1; AJvYcCVKXlLx25HAz78tAUceD/nU+nNwCt3n4iXBxASdCnztE1/fnj8BqcbO+aEWLMkwEGhAcHVCcgQkMOlSYhmRhYlBudfKMzHjEw4fNGrhTRxmQ62Vfpob
X-Gm-Message-State: AOJu0Yy+Bx+sCf4Yt0Qliwocg2oKqU2D8eN1xzL/IUdxR3UXX4WvG+NH
	yat/WVXm470xztU2nZ6hdx0ZcJQAWvzXlA0myF6dNe8GHiA5CLtqLTSCDCNBedWcaeSwpiLQQOu
	SGNI=
X-Google-Smtp-Source: AGHT+IGD4PwwFeRHYW45X3vjusHw3bmJz/sufjMcbXH6Cheh4pgh7ssq1zmp3yHdd29GRe4iiSr3GA==
X-Received: by 2002:a17:907:e8a:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a7acb38ef49mr250384366b.13.1721938743470;
        Thu, 25 Jul 2024 13:19:03 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8039sm103827766b.200.2024.07.25.13.19.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:19:03 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ad02501c3so111785066b.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 13:19:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9XYTBr+ymtOjvAKWvTRHP2YGxy2A+tPYUfb+GO81t9O+Dgf4Fc8uI6XJ5leIuBCVyPK98NJ/Zfm53D1pgaryoOIzxnFW32sQypiMv74bQD+6hn0Nf
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
