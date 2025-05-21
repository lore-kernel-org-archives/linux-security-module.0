Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6622F745
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800790; cv=none; b=lYl8eYNrC0ZVjDsDIgeCP91Ut2l+ju7XYY3c8iij/zMl2suvmQTh1qWLbrJQiu9ZSnGHvF8knMC0n/d9FGMAUZkcs7Gb+m+rW77MHFZkw3Jioul7XdAWjUoVb0v50hoceRZOXribG9WfpfPmBRH5iDHWIYqZYSeepNWSS+c14t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800790; c=relaxed/simple;
	bh=CzZplifB4yM9E8aHgw+DcCEuudnsO+hd8IgPL+dvMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtIY56UygdBptKnRNw6OXOneE+dv6PHN/SMBT3jsKmXq+TEn+4hH39wBv7s4y7qsiipCXSBCa87Nx7QUywwkhhLCarqk2XI8cpLbuGlXiNjLhmNWDcGewvUJzMYG0DmP7Xo1XkUihblp+MGQhfkEcCMwg0an+lNS3wP/Vuhe4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZH/4zBx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZH/4zBx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231f61dc510so934845ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747800787; x=1748405587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0KXv+Ko44cUZ/uyfsrxurypyzmWgliBU+Xqfak3IgNs=;
        b=uZH/4zBxdBzJhhSg9z8ZH/U+QKIAAc1aXme2mVtl+ij8KPeVEfkJCTLyKpVKUtl6UK
         4vh3TEBzZofKvopxWD6TK7L8nQLWfXIVtJgiHYH6O1n6SpTusr8Q2UBtWQl/BqdloUaY
         FU+XgdZsjyy9bNFgZKJOsSCeK+3vyA90eQ4mMglZMZv4WJi6DXp1gTtXtBrRBdFjdO7A
         NP601Bf+duT5BCX3wMMjeEKHr+Ywstn4O3sXz+pv3doE+8zsZM14jNp09xlR8qLYp1XK
         E0Fugsw2zd0Wh+alGpMtGkEAUfaLAvZiq4KsPLoN5PYFG1JjOS/xKpKJZcy8N9xpOK7x
         fZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747800787; x=1748405587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KXv+Ko44cUZ/uyfsrxurypyzmWgliBU+Xqfak3IgNs=;
        b=Dcn9tH6GNYgzX8wRmTftc3g5XzYCG8XLj1EOX7w49tXuIUTm5UK2M4eQMT0lWuKTmY
         LSXcyLNFqGU7TOvVo2d3c+KZy8XC041vESaU1VyTHUDN8YwTA+hTP8zK7Tryjh/+sRZQ
         XJ4KXh6L0FJ2CBcdfaYqzyf6PSscxTeE0TkP65ftnEhJhoVujAMd50o1wIDa6n35Ky/3
         EXabOHzG/RrBgykdULV4J/7nFl1TQyjMe2gTONcrgDZE9FsYjcuTTso6jjhNYdS2/gZz
         Usk37wq/W3i6w2zID/gA/TbQWHTS15IUr5YvHm0TVgPHBzwvspYhwRaeACMbgvXa+FSW
         nQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdXnOus+K7UQ4IHcwnulUvhTFPoJsb06azQmVguoTUfA9QZFO5SBVpmC78l9Y3IDtX9NFhRN+eJuTmzjk/+xawGLxt1RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31b+USycVnxdngfQWrpzrc50wfZxrWOy6+bbGe0whLpuVlge5
	dJ9Xxtjli38m0UJk9pyuMT2mT/dQfd+Ldpo0u2V2YtEaWKR+/6EK+GXWjSwOEhkiRQ==
X-Gm-Gg: ASbGncs5cDF5I+yk9+wpbpfvsIhzS2mugAe2qGvucuTUOXQUmP8qvPMo9immDrlJCu5
	CLeepAsd65RdAvqDw3Jy+Z/V4xE8flLtOVeyMrxy8CCJ+H4lF6NU5et9lFT1sUH20jhFGIN6/ru
	t0F4auSM+KaiOf+PdkTfRM4tjMY82RjWBaNbSXuMXEqYDklwN3Q2kTDhqEXjmjotgozC41Idzbb
	9dpiTvYszdoiB/i42ql5OvEVa7T9h0sosGk2Rtx9WM5aV2da7xP1YHKrWsAsQyxbLHTm49cJfPq
	ifGIe2DTnJDVKbCHoXjG6EdvND8UbzScDrlX8m32FqD9aLxq/Rz/O7E1odkmjJFS8XYML8m+DRG
	cl9vWBM4LtDjABoHldOU=
X-Google-Smtp-Source: AGHT+IEqOpF5edfEWArOiOQhVink5JvyoS5B9Tf3hRBGfOIcPhNGaN33iWUyuNmrSOLpeFbUNtsvcA==
X-Received: by 2002:a17:902:d54f:b0:231:d0ef:e8fb with SMTP id d9443c01a7336-231ffd0e311mr9558595ad.10.1747800787099;
        Tue, 20 May 2025 21:13:07 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a032esm8594503a12.65.2025.05.20.21.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 21:13:06 -0700 (PDT)
Date: Wed, 21 May 2025 04:13:01 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, omosnace@redhat.com, shuah@kernel.org,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, tweek@google.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	hridya@google.com, smoreland@google.com, ynaffit@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to
 binder
Message-ID: <aC1SzdCwT90j1ajv@google.com>
References: <20250417002005.2306284-2-dualli@chromium.org>
 <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>

On Tue, May 20, 2025 at 05:15:59PM -0400, Paul Moore wrote:
> On Apr 16, 2025 Li Li <dualli@chromium.org> wrote:
> > 
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> > 
> > Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
> >  security/selinux/hooks.c            |  7 +++++++
> >  security/selinux/include/classmap.h |  3 ++-
> >  5 files changed, 29 insertions(+), 1 deletion(-)
> 
> When possible, it is helpful to include at least one caller in the patch
> which adds a new LSM hook as it helps put the hook in context.  With that
> in mind, I think it would be best to reorder this patchset so that patch
> 2/3 comes first and this patch comes second, with this patch including
> the change to binder_nl_report_setup_doit() which adds the call to the
> new LSM hook.

Ok, I can take care for this. I'll be taking over Li's patchset now, so
next version I'll reorder the series and add the caller. Thanks!

--
Carlos Llamas
