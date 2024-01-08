Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62455C23
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jan 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kccll3Y2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3f8af8297so6462145ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jan 2024 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704735863; x=1705340663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1abJydjZLln7hQl4E3lvrRUTA89HK7MRnwUoF4czmg=;
        b=kccll3Y2FdDLUo5tupbjJIUs4wG1s03ovzv6aHkTzill4M2c5vu+zc3OoJ9PM1sCDI
         zrv1M1pmLbfgwG+AJDcx+2SJRM92LNLnv3aZabxwW19N93nTLP/qY/tFQ9NYN7sAuEJ+
         XIiTX5kqFO1VdKKdOBckO35BzoST5D3ArXkMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735863; x=1705340663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1abJydjZLln7hQl4E3lvrRUTA89HK7MRnwUoF4czmg=;
        b=COzDhyW6iIiDs9zzAQT2eqKpmFtbBpEWCV5M6n+zE/98aGD9aegbjxFkGkVKa3dgsQ
         J3clAuUJO095dNEgsF2iG6DyebjvQ6fxpp8jhu4XULa2VyFF2QD5la+wKXm2vSo540q8
         mrBx6JJU0mdT/lv1iETKBMZushwro5taiesXNSg2spRPqTBNY6Ndku3QgXqa/217+5Tb
         LeQxmJq7t6aEdvmBVRY2zHDf1Pf/PDye0m5DgDcvAK0v+cEIsjbpW7+Tl3GpDqgqx9JG
         e8973UL96ISF4H+otJRbueJpo3o156blGrAoUwv+1Zt7bPmEgQvWJk2b89cscoGd7BXO
         Ztyg==
X-Gm-Message-State: AOJu0YzHUNJU9MGlgNOC4EuLnmL2fLQCScEcykQF2ype2ZOFOMxE8qve
	0tx3+oUk1abBQgHe7I4pQCWf91wAwVgp
X-Google-Smtp-Source: AGHT+IEttQb3FycvV0cgJvko1q/TkbA531qRGLLKG9qbhqKwDtTLQgXePvr4WKDehTx840cKzwWrxA==
X-Received: by 2002:a17:902:b093:b0:1d0:6ffd:ae22 with SMTP id p19-20020a170902b09300b001d06ffdae22mr1611156plr.137.1704735863639;
        Mon, 08 Jan 2024 09:44:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006daf1ded817sm136207pfb.209.2024.01.08.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:44:23 -0800 (PST)
Date: Mon, 8 Jan 2024 09:44:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"luto@amacapital.net" <luto@amacapital.net>, hpa@zytor.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Post Compile-Time RandStruct
Message-ID: <202401080942.9729377F@keescook>
References: <CAMjCObt_VOWp9fz_onYesfpvLLiJqnzpQA8W1HfOpLc0_bNGog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMjCObt_VOWp9fz_onYesfpvLLiJqnzpQA8W1HfOpLc0_bNGog@mail.gmail.com>

On Fri, Dec 29, 2023 at 11:57:57AM +0100, Jasper Niebuhr wrote:
> Unfortunately, debug information turned out to be inaccurate and
> incomplete at times. Combined with the kernel's quadrillion edge
> cases, this prevented me from taking the prototype any further until
> the deadline. We can see this concept fully shine with, for example, a
> compiler plugin to log any accesses, instead of a tool that deals with
> debug info. The second part of the prototype (or a mature, later
> version of it) can be integrated into distro installers or run
> whenever the kernel is updated. Even integration into the kernel's
> boot process would be an option.

Have you tried the Clang implementation of randstruct? It has correct
DWARF info, AFAIK.

> Since I am now in the writing phase of my thesis (deadline mid
> January), I thought I'd share our thoughts to hopefully get some
> feedback. Do you think this approach solves some of the issues that
> RandStruct currently comes with? Can you see such a system actually
> being deployed once it's fully functional?

Most distros don't use randstruct because it doesn't really do much
given their identical kernel images, so I'd love to see this kind of
work happen at run-time, and I think distro images would embrace it.

I look forward to seeing the research!

-Kees

-- 
Kees Cook
