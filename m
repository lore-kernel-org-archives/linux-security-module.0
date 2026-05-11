Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105A37E2FE
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529178; cv=none; b=L0YRrGF5qK2CMbmxEevv70likF93SvlMrSngemhGaiMpy/R7LWsZRI8u9nMqD4CO6cNIXNK3kAictUH0nR4ibyprjUslkXsaB3U2KQYw5T2QN8HvKZeIAiwfKz2UgGIMKzCPH6o4VOxtb8BtvnECAMDY0XtSJYld2IyYKliK+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529178; c=relaxed/simple;
	bh=NbvMVDje1g1aqaiVOzz2K32oDBpOtaiDEYD6UFem3c8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bn2ZL29zy9id17fghsBhbjwFmErKMR+/puJ2Gt3/H/LYR8TkF4FXwVkQ8egDyZ+zQFMwIyNDvyLpJFWQASQ6UKtIRLQdOG++YxwReX5ZTLVYEtbu7ecLLS9TRqFvV8dzsL2p8IXexk6enALY+oElhrgbdepjB28xHszOxnPa+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PKSlELAT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PKSlELAT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ef45a6d9dfso514965385a.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529176; x=1779133976; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxQM3MCta0Hfqwc0x9Ru5t7hQnbf8j++I/Uj2TAvc2Y=;
        b=PKSlELAT1V6RORNhm8RrQQXRmyieScRU6HdJ3kp5D5/5sVhFvy9B85LKTKl1m2z0gu
         Pv0kvaE1epR2Pr6Jyu1MeAuNMve3o9UQro9S6M6IztUuGnOjmK0omJ5PxyCNaxLnvjP0
         fw5B0rgIh/YtA05O4CZDnYqcO0jcUUUmknNUrwjYmE+/bQRQ4RTBJ91fC4lmZ1IcqCe7
         NWANUdKNFRWOWzu40j0yWZNXxWbuoJiAmKqhiw/MD19yFQn3xwsQ023w91SubkHQpCTm
         yXpT1JEfm72ATXJePUM+Zrj78uJsTPp8Ozg+5D5/c7vUA4a29b8pQQAp3qij84eRMEB0
         ulig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529176; x=1779133976;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxQM3MCta0Hfqwc0x9Ru5t7hQnbf8j++I/Uj2TAvc2Y=;
        b=OhOL/+CbodK6sykr5TWbQ0+QqFIyEwig/m/6riDZJc3wPgrqj9YykcDZ1cyVU9nbKc
         rJtV2e2PVCCLOKXOPK6bjwiOzMmLQ+mYTyaVpuy3kz5RGHqE60R9ilpcSefMZzNLuw0R
         uLz/6jQ8J2NWTNIyKE6Af1Etf0Mewh/VUvYEbEWID2/+hi05ma7EoKdTe/RZcx9mfnUg
         c9YYqnWl8QHbLm42han2Puyo8NSDBbgxCcGpMa3Q4Ya5EbIGfD4DwXJ0rDRyP3oImwb6
         /YWfP/qp9aPaW86CNz9QnLgHij8USTgZLfVM/KlT9rjZMrOvUFXIjIpJ2VToXcA299ER
         Gong==
X-Forwarded-Encrypted: i=1; AFNElJ/lqDOsIWScUE72REMy77ARBAweF8orysgYnRLkmMatCu3Dyvc709BWbbJQIxv7FMbzImHt/pVK+RSrUPy54AY9gIaVqeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MX/pf32rAWuy30RfijCnwWTwVwNF2la4diuO4hj6zaBhhOZy
	BTonl6u9Q2gkh6c0K/OwVOmhaMYCdg+Dhdig8HjUobaDVuTlYyVPB4rJuoz0uXPE6g==
X-Gm-Gg: Acq92OF2muSza0iT3dMH1ooof8pB6A+jXLUpJwSZHMwsq6i5D81LZkbnyuJ5dd1wnCL
	+AH+U6RN9kz/JC+p3dumThsp5FqltQjq4S8NhA6B8zDP4r34tGZvVMTmbG9hYNRjey3g8N3yCNU
	8ZLYaKDfLG3X7/XOnQ1gRJiZ/f0lIE3qrrKvL0unMthsd5BgEIjUs2jFBzVktmmgiLqOXoXbQ1V
	91AsHo1vk/KJvpTXXuuvsiZzzUywzt4bat6sPy4Mc04dYmkFSq3vm5XkRwwMCh0CdWkWa7+CMVp
	5Js3KGp05uStM4asWbXbvNBIBoWyxMQAUcdhFxMjSdCUNkwV6BpzzzNuhKF+MWb+G2vk/3mNXb1
	RZ7NutJ7Kff1JfHRtXy3Q0wjJ9lSKi9tI9n5Qc4VwwMZ+AmiqnlnykqoqqC5W6tt0/6mCf31Cbu
	p92F+CxVIp9auyYvF9G+waHQorYkmrUoeGjfNMzpMtO93o8hzULp+vdl4Zu3NxprAQmj1D
X-Received: by 2002:a05:620a:4451:b0:8ee:a1d:baf1 with SMTP id af79cd13be357-904d68df87amr3599789485a.42.1778529175906;
        Mon, 11 May 2026 12:52:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9772b87sm1103258185a.5.2026.05.11.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:51 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:51 -0400
Message-ID: <63277ce0e3f65eceb6da88d7cfec4d64@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: penguin-kernel@I-love.SAKURA.ne.jp, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-7-song@kernel.org>
In-Reply-To: <20260509015208.3853132-7-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> reconstructs the MS_* flags expected by tomoyo_mount_permission()
> using the original flags parameter where available.
> 
> Key changes:
> - mount_bind: passes the pre-resolved source path to
>   tomoyo_mount_acl() via a new dev_path parameter, instead of
>   re-resolving dev_name via kern_path(). This eliminates a TOCTOU
>   vulnerability.
> - mount_new, mount_remount, mount_reconfigure: use the original
>   mount(2) flags for policy matching.
> - mount_move: passes pre-resolved paths for both source and
>   destination.
> - mount_change_type: passes raw ms_flags directly.
> 
> Also removes the unused data_page parameter from
> tomoyo_mount_permission().
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/tomoyo/common.h |  2 +-
>  security/tomoyo/mount.c  | 31 +++++++++++++-------
>  security/tomoyo/tomoyo.c | 63 ++++++++++++++++++++++++++++++----------
>  3 files changed, 70 insertions(+), 26 deletions(-)

Tetsuo, I know you had several comments on an earlier revision.  Can you
either ACK this or let Song know what changes you require?

--
paul-moore.com
