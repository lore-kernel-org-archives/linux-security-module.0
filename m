Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034EA8120E
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116877; cv=none; b=mVdNPry0+6xc4hsXaSP7diFk4wJKLeZ4nX3uUk3CRySJNQ9X+2PD8BWh8mQ/9velWxKo0GiGLXLQYRjOrRpSFasaKlYXgUR1jejM5d2gPU7LFv9OGBD74/iPcmNxZ+8aSK69wycxy+vg4p06hutEhTYuNjaCSg4jlkqrjLz1NXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116877; c=relaxed/simple;
	bh=i0fh2fvqUB6h0Bq9w6eV538kz5PYIbRga3q0Tr+/O4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpboCd/l7NaY9QcVzUPaqDBO2tTUXFmGAkFYlxpODgt1+r9PiDBZcqUkYeRLCxsRf4yQWHiQkp0LzCwMOQuNCcJS7e9ylTvXtI9YkKQF50F3Ym2fX+NmgR22XWLlVYTHV6WeRl3dYubiWWyxvP9ODflU5/McIFRsPwwOrt/GU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KloGb6hc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KloGb6hc"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso2978197b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706116875; x=1706721675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=KloGb6hcbTufAwdkYqlBSsWZOgn0F6LTXmIJSgH9nORprcQx8B2lRFJwhTiC2pO2+4
         fLHqqbiXPDUjPxlVt+kyLdHcTMULTYXLTqLdPOT55mTc8/XIaUU9S4krI65CVfTFFBuL
         WzleLev4QZD/VY7xznAXEGiD/XokWkniDoLr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116875; x=1706721675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=XpRlKoWSge+dGo16QN9XsziF7IC2iUBparLxAOWqHnjpck2SmMkeebeVIhEuAQjsga
         r1V0K/FuK/EaKw3HKQfq8foc0kRdw8VDSEw+FOkVbMX8GbzZzgOt6u7JCL6CENNeMLi/
         RH/RNTMzLkeht5lAIGNgIolIjv1ILxSxCMtcgJ8u12DVg3qOpm4wEmt4taVddQP561U4
         3m1qqECBYv8iMM+6v5bcMzjuP4YtFiJzJZa1VhgBMGSei/Zn6yqUQXw64v8/9NcZWk5z
         CUMNCG01sQ4hDaC3f7htgyLMAMPiKtyYwba1jwyrHctJBh+ylmoZZe0ysJ7m+qxOxyg0
         DlMg==
X-Gm-Message-State: AOJu0Ywm/FoyosdVqaqmhkhhFp/cK4SViQ5D4lYNHEfbl7bpLTLY7LwI
	ZiD1NaraDw0J3cHZlesdeBa5P8nxe76R8SEsCfMH5+POD2VcZgCmFR8CxPbXWw==
X-Google-Smtp-Source: AGHT+IF8mYZHsXtIZHYmarYRM5N7qbVfGOw6LSL+xSG6379FubnYGny6wPevlrY8z5lhGqrKJ4N0fA==
X-Received: by 2002:a17:90a:cf87:b0:28d:c7bf:3a12 with SMTP id i7-20020a17090acf8700b0028dc7bf3a12mr4364083pju.8.1706116875365;
        Wed, 24 Jan 2024 09:21:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id st13-20020a17090b1fcd00b0028cf59fea33sm13880703pjb.42.2024.01.24.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:21:14 -0800 (PST)
Date: Wed, 24 Jan 2024 09:21:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240916.044E6A6A7A@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. That whole thing is disgusting. I think it should have checked
> > FMODE_EXEC, and I have no idea why it doesn't.
> 
> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
> think it would be even better if we had the 'intent' flags from
> 'struct open_flags' available, but they aren't there in the
> file_open() security chain.

I think there were other problems that I might have already fixed when I
reorganized things in commit 0fd338b2d2cd ("exec: move path_noexec() check
earlier") to more correctly map to LSM checks.

> Anyway, moving current->in_execve earlier looks fairly trivial, but I
> worry about the randomness. I'd be *so*( much happier if this crazy
> flag went away, and it got changed to look at the open intent instead.
> 
> Attached patch is ENTIRELY UNTESTED. And disgusting.

I opted to tie "current->in_execve" lifetime to bprm lifetime just to
have a clean boundary (i.e. strictly in alloc/free_bprm()).

-Kees

-- 
Kees Cook
