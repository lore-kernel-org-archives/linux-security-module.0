Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F41BDCF
	for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363090; cv=none; b=ZiI0mT8JfaGlJ5TOB1hdOpl9+Un12khKpL1VqIS83OyrhMasvjTxMaWiw/ArGPtddBfVLagn8db+iE7p9ADZxxwUFlMfll8OmBFcICp/UXDEaennOUhkP+zN/6yuBvIZAlObS2fTdGk1TKAW7cA0R1thm8mKDrblAooZDHK67Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363090; c=relaxed/simple;
	bh=xJmMGpijLVbfzV1aLbCyIFqmqtVghhRlL3fIAx0Zf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWM687K6pSUN0GLru8DIGdGSTFn4U1Ex+Qw4AWGdXJ2JTwsN3kPv24bTnn+pLaAs2HMmToBkfX3/n1eQFkU7+5PGJGGd7UP1mSAudbutuTpoYvRxGuFy9Np0Rnvt5RMit1kVFRCYWPwE1K2OZ25m+OCxypRPTwNoiWea58Ngi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ssdy8x/g; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ssdy8x/g"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so1980312a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 May 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363087; x=1715967887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=Ssdy8x/gu3v6owk4cRKjS558k6DX65Wm05p8vmbUS80yA1nhMtBEJKTlXakydU7iv4
         jz8AfO4nTvtwcQQHM5EqSaU/QOgxMSGVsoDmr4ZGk5pIburKLY11uAn84+0OKXfb5nef
         O8XA4bl+7ytiI5z8A35fyK64yuLYpUa3igqEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363087; x=1715967887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L57+zK9MzVoCupg09U6DhX9rKCFQrUW4lM5mF0fCgNY=;
        b=hSoFiXuLHzwuTMUZOc0jecn37ee5pLvBc438/TaPg3l6tOEsEb6+nOJQlFqpHNY3lZ
         yFrmXXrTIWtCYHhL5pMAbs9i0Yq9KKY1El69Dv8mk8CqUmdJDpNz9N+ZLH5bMBWNeXfF
         gIsBUQ42C/n3LyvUO483SxucjiPzY/85pDYPDovf3G7kpQHz6XVqUo1GGPKQRARKILCE
         TihLAvyx2jUtC7ptK7g2ODUWH32WpeKpSXT17uHHSMITA1hKQg07xPx/BUk4v2lORHhM
         EAuzbkhfdsCptcmTBP+UHVR100cnKRczhipC4WzQe4Q22t9V4QGPQ2KPJgO32vr0wRG9
         jSFw==
X-Forwarded-Encrypted: i=1; AJvYcCUxShN5DALAg+1p/wCninDG0r4PeQ+GyughmXWzKBZ/6CwOtg8LoziIZoFBQYI3i4MKL4a7McCEXr/PTBMNSNAR90Gl59ADRCKIhAWEbfkSw4RkU3Jc
X-Gm-Message-State: AOJu0YxFWW72uDJdZ+cxfTWX4zaARmhhAvPrv6kWJ1uCjs17ztfK8X/r
	d1FY36fyemyYuvN/WIZdCKDroC3Rx4eXBEk/nQwN4NwBansT5rC+7395rNKnYA==
X-Google-Smtp-Source: AGHT+IES457OerJ6E+sjpYxMiTqrSeTP8IOKWgMKTpX1LuCp+KnQ+g1iaESf6bNjK6mubIK/EdZwFw==
X-Received: by 2002:a17:90b:46c4:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2b6cc777f3cmr3358191a91.14.1715363086792;
        Fri, 10 May 2024 10:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53cesm5360572a91.44.2024.05.10.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:44:45 -0700 (PDT)
Date: Fri, 10 May 2024 10:44:44 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
Message-ID: <202405101044.5D2742EC@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-14-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-14-edliaw@google.com>

On Fri, May 10, 2024 at 12:06:30AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
