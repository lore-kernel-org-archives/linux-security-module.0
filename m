Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE7346E46
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791681; cv=none; b=fiXr+VFZ/C/GL0E2qTZW9Oom5AEF2lPn9Rf8oOAAenevc89y7aJ/JHoBA8CZWiyLY6/z639OymcCQOdxyYVjIx5X1Blqn5jcZqFLcfhL0fQpiEkntwZPNoigxheY6jTaYeVe6WAgXgpqgH713Kkgxcl226qmCDLR9tGA8vNHJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791681; c=relaxed/simple;
	bh=4y79Kl8WzXCr5Rk9Zb629M35maQPDXeKDyl7nj8DYVc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IcUCPaWReX09jEJvABBNAnLqS4/hG0DcxQHQ6Rsi3GrJYoq4EhefpPsnzLvSn9JGDmRN/g0AXWn/HDT28E212nNkuQUxtAC1kEvQ0xQexJqM0JILpePrwXgZELgPACiYftQtQuSE1Q3wSHT4rgk3YlN/pneORoxl0m9/TvTb2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QhOYmp9n; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QhOYmp9n"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90cbb2b50ccso270712785a.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778791679; x=1779396479; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOlLQlTi3o05frdZLbYuVm1cEc621rSLbOtr/H5CI6U=;
        b=QhOYmp9nyqmC94Wp3oB3TUXOXtz1bYLmQOz6aLV7W75XW/oibX6gOdIK0E0TYmR+dm
         TGuwwt+hJGyi2qfMLU6Uk7QzIpC4OD/aes8oVwd3pccTwGxmrZFdT3rQ7Xe+/cYXVOIM
         6tqXJVsxmUWCkkH7KL/Gd2AEMme00x6F8DRuem5QtsGMt14UvI34200eavM/4mKvvLj1
         C8f6ti9pPJkUyqXB10TQPMhYmvT2NBEOO+6mLfAkwsSHPi4aiMfHQiyq4t6eIUvak1rC
         xHNCY+IDXHfrE3LpJmKI86dqhzxcTqA2h5V6hKLA+X05BtDfi9id823dE5yy9z6k6dJ8
         JmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778791679; x=1779396479;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOlLQlTi3o05frdZLbYuVm1cEc621rSLbOtr/H5CI6U=;
        b=aUE9U4y1G8m9AoelYWyOatI3Ymzzd+mhBPvlEXK8WEMW//2R8USyCxUG5BJ+Te8Apn
         7QqwJ2+AdrU03/7DSJO9srFgCkYjJ8EQKe4oO8L8WpvhfPEuZnpWtjPz7Xd6UC66hSiz
         H+GThYgIrx2g2ABRWNxbRplmN8UebL5+2JZ752VbxPzYOvwoCgC5CZIJJGMdipJ4PGVi
         D6cIHCSiAKwRHOoZL9NCaC3K2rpNGiaBMvlHPUi8dwyfuBWG3FUtRgdrezWyInWoZVm8
         nbX+W4nE4dfHW7B2UyclKiKdzXMdfoMDgHPpgRFDa+hovtlVBM4SyFicVW8E6Yw27FeI
         uoug==
X-Forwarded-Encrypted: i=1; AFNElJ/liSiel5Zhq2g7ghDktXsWzM2NfXUjODn6qZZD7AvNbU9mES9F1y+r2kPzaVypEFXYRIg4C49tYP5mgIOmPHR2R0e1dwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZK7SEWqQbrgp3Dxz3Xr1BLfqfyCyuMw2hnIF9y1+3z+wv7ME2
	QRv8JZquOfqIDPxk8w07ABK1dLIcfROuX3W/FIpwmhB+0biUid78AFL6QGI4SSISyQ==
X-Gm-Gg: Acq92OEokngDP5vqPztSUShMSfqM8wL+FoztRWwdZAb06ppr4if0kf78mq7ZNo5Y47S
	EEOxFrZqQH9Qb7+Uq12YbD22Xqe6WXXBCVHecaLqRpPOaH39LeBWOSeP15j6WhQbgEftfKh5vjh
	wr3nfeZSlqHNIoL0PMCvjLXgdZJnvr6wAoNihMGyJ9wAF1q67aoKyoinTcpg2mT4hVtvWpX2c3c
	F0tQHdALJFo+y6wbx/ixMCPtKJLPb1oJqrMTTFNadXGPIbDCHV26Ct/9uMqJbQyCW+9Oq/T6Q47
	ojvm7UVa+fMkU+spSK+KrGcALGj+CrpEifVqp6z2jVZ2uAvyUOwij0a1JqQblBt2Jq5IyVFtvKq
	VfauQjsSuYPsU7y0WBC7DiZxmW6I+F6xvBwKf53icZeQO5I1mvKRhPaJ/DIdGBesXVW6N/AUbVh
	u9dB4xzFKEcxS5aW4Zi3imLXrK6hT7WwbqXo0slQatrUdMYUSL8KRZHnygQrhFzEPiWg9l
X-Received: by 2002:a05:620a:469e:b0:90f:6153:3eaa with SMTP id af79cd13be357-911cf002797mr205705485a.51.1778791679135;
        Thu, 14 May 2026 13:47:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm339202985a.28.2026.05.14.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:47:58 -0700 (PDT)
Date: Thu, 14 May 2026 16:47:58 -0400
Message-ID: <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260514_1634/pstg-lib:20260514_1359/pstg-pwork:20260514_1634
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com, john.johansen@canonical.com, linux-security-module@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513180506.760657-1-stephen.smalley.work@gmail.com>

On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Just as proc_pid_attr_write() already does before calling the LSM
> hook. This only matters for SELinux and AppArmor which check
> whether the process is being ptraced and if so, whether to
> allow the transition.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/lsm_syscalls.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
hold on to it until next week before sending it to Linus.  While I
can't see why John would have any objections to this, the extra time
should give him a chance to respond.

--
paul-moore.com
