Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648873E9588
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784992; cv=none; b=N6zUN1cXvNDd0U3bt3l88SwL0yN22a7Vh9tRYrBthFB3Empn4VN+xolzzR3P1SOBihnXPdWEE4kjB7ubQ/Tp0eMuInQGHSmBy4py3f20khP1cN9U2NO5TkDYHgLFJZE7ZJG1sS6PWFm6oOYq/VqqeYL150NiUJtIfSwVk3W/jEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784992; c=relaxed/simple;
	bh=alYxmbcQkRLnus6HzAReH0YS6FmyBajG1qbZ4SROazk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2E/FfymQPv42M3drzipRK0opMhCV4bqSWVU+atca4djEi9mm1T/3wB1xtpJEBm8XHgC4k/Y2z/YDNSsNDISJ/Wzmt5duD5xLqx9ENvxM2sD8pbr+I8UEzNZulcOY2kqBbwAQ+I7ZerjF854SvVdkhE6zF2vdz47lPzKBZB+WB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOMKWb8C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOMKWb8C"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso19606425e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781784987; x=1782389787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sv/Jb9vWD96CsEgS7PRGucKzFMQgwXYk5KDmj/DVT58=;
        b=hOMKWb8CVagKAo1+d+dIY9a0CXNgu5uQGcB4caCtu6Lr8RyOx3WeI7txfkKS+GNCGl
         sHpAM1TxXWecNLwi9gEmEYqL40H750SONiBYAJKoYj9LD0oYJoQ0ECmYcJxx8e56Uw7q
         kA2Seo0yIQh5p92/CwSEiisseZPOL6Sp+xETX+xwQgkd+x7wxSxsHHreQ/itQCVDqC+q
         Y3lGKHr134bPD2mv73LlaFsWqX6QoJmqbO2fWstecfOQJXhxgTQoOtypQbdZ5LCcxdq9
         HtskdVM6e/4fJ90KmYTWYqQpZwMWt426r2Tv6yAKujXa0RDlZXp3nZicp7BugsiC83cs
         abZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781784987; x=1782389787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv/Jb9vWD96CsEgS7PRGucKzFMQgwXYk5KDmj/DVT58=;
        b=M8Mzo+BV7H/mxGIYzBg7vGnSwdBsW5w5Jlt4KJtxyixUB6HnNx5KHil5hOf/I6H8Z6
         cIBHn1zmMmfPyt6doB3odVCp1D06gRVf/rZGRLtzzW44f/QWEUWrhrlimlPEkglXddGi
         wu4uBpvnHiR3bVvo+nbmYU95jmecC0tXmciBIVcJfeYL6nx/krJGJKg91yE66kHpZFvq
         ZOA2L/GeA2UNyvCbiYRNmBk2385B2GbCxWjHpwkeqBUf8xmleQyB4lQWgyTMlLOb2fyK
         6COgIA/6FcjgEUDbC0lBroAzZxy9yKkqQ4BEvIoRVXWC+SmAukOtQrNckvaMZNcoYLUd
         MCvw==
X-Forwarded-Encrypted: i=1; AFNElJ+keHWU+xYvFcbyhNydV88o42QYsUCV5o2CYqsR5lGh+24w7/6+h39mPb2dMW3ipUtVxWTb246UNp7pwFO0qJWdMdF5aH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+M+UZ6z6vHraSL4uwgudDqSiEiqSFulGBetZOlecvoUYHwZ3
	BYkzvLQAzgX9Ku1yRK4Ht2KzDO5803uP/Kl33+RnL08nFAq+Tg6nT2QW1S8Nl2iOlA==
X-Gm-Gg: AfdE7cnXjwe3O7gdyT0gCjknFn7SDDN8isEGu15WihkuBvZSFlMhbdnw/QjAXqD4Qwq
	hWuVXMdIlL7OiL52fPmlhDifdcElmGE6h8s5Uoq3JVq7aAjocSoGWhRmu6U2x9LdhZhv3ugMlHY
	WPw3V9i+AN77YPbvfF0Rsa7jIk73WAYtYcRzksYoEMElt8IT8xPYaW/XSHMVzgSJD1nTzNw3wr/
	8eINNl25fTtoyIZshU0Uxnd6l2U3EfvMDZoS0f0OR3P8Y3NNlWEmUhVjt3fZeAeAhvNeKow0mtp
	xPZAugGHhNxvmzL3iRKdhfVLL4zOntRRKo45oZVYIv/P0u6lo7gHYFyGyyphNZAGavA08SvrtrO
	2VyqLpXVTy0tyiwLl2SsXQBl+BN9r+Yg9tSUwBGpGySJA9zAT+sZNooezeskgzrXQcP33G6uAE4
	JNXdt8F9LoW7DExfPH/8T5nvgzgdEeID1rt0hz2lsjIriLAL1KEADtSA==
X-Received: by 2002:a05:600c:3541:b0:492:38c9:b265 with SMTP id 5b1f17b1804b1-49238c9b275mr40277555e9.15.1781784986971;
        Thu, 18 Jun 2026 05:16:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:b8b9:62b8:4f72:45ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm265162015e9.6.2026.06.18.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:16:26 -0700 (PDT)
Date: Thu, 18 Jun 2026 14:16:20 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
Message-ID: <ajPhlNSgUcmBoFcM@google.com>
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
 <ajJtTHyqWTmX7lHo@google.com>
 <20260617230237.14718-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617230237.14718-1-hexlabsecurity@proton.me>

Hello Bryam!

On Wed, Jun 17, 2026 at 11:02:41PM +0000, Bryam Vargas wrote:
> Thanks Günther, and thanks for filing #64.
> 
> Straight to your two questions:
> 
> 1. Block: you're right. blkdev_uring_cmd() has a single case, BLOCK_URING_CMD_DISCARD,
>    and the blkdev.h note that it's a separate number space is fair, so I'm not arguing
>    it should be a generic ioctl multiplexer. The "others, through other devices" are on
>    NVMe: the namespace char dev takes NVME_URING_CMD_IO / _IO_VEC, and AFAICT a
>    write-capable confined task can reach IO passthrough (write, DSM/discard) with no
>    capability, since nvme_cmd_allowed() only wants FMODE_WRITE there.
> 
>    Correction to my own report: I overstated the ceiling. The NVMe admin ops
>    (format, sanitize, firmware, security-send) sit behind capable(CAP_SYS_ADMIN)
>    in nvme_cmd_allowed(), so a Landlocked unprivileged task can't reach them. The
>    A:H / 8.4 figure was wrong; only namespace IO is in scope for a confined task.
> 
> 2. Truncate: correct, no sidestep, and none looks possible. I went through every
>    f_op->uring_cmd provider (block, NVMe, btrfs encoded I/O, FUSE, ublk, sockets, ...)
>    and none change file size; truncate(2)/ftruncate(2) keep their own hook. Please
>    ignore the "and truncate where relevant" line in my suggested direction, it was
>    speculative.
> 
> On framing: I'm happy to call this a coverage gap rather than a bypass. IOCTL_DEV was
> never documented to cover io_uring, so nothing it promised is broken. The one hard fact
> is the asymmetry: ioctl(2) BLKDISCARD is denied (IOCTL_DEV, and it's not in
> is_masked_device_ioctl()), the same op via uring_cmd isn't, and SELinux/Smack already
> hook security_uring_cmd while Landlock doesn't. Whether that's worth a hook or just the
> doc clarification Mickaël mentioned is your call.

Agreed, a coverage gap is in my mind the right way to think about it.

I filed this issue about that gap:
https://github.com/landlock-lsm/linux/issues/65

Even though that's technically a feature request, you are quite
right pointing it out.

As I'm saying on that issue description as well, there are in principle
multiple ways of blocking such a feature.  It is possible to block it at
the fine-grained layer in uring_cmd, but maybe a more practical way to
go about it would be to block the creation of an io_uring itself, since
most sandboxed processes do not normally make use of that feature.

(IMHO, we have already made a similar mistake in networking, where we
first built restrictions for individual TCP operations, but left all the
other protocols unrestricted.  Maybe the better approach is to start
with the coarser restriction that addresses the majority of use cases
and then provide more granular controls later.)

I'd be interested to hear people's opinions.

(Mickaël, if you feel this is the wrong approach to frame this as
feature request, also please speak up.)


> If you do want one, I can send an RFC for an all-or-nothing "IOCTL_DEV for any uring_cmd
> on a device file" hook (cmd_op is a private number space, so porting
> is_masked_device_ioctl() wouldn't be right). Otherwise I'll drop the provider detail
> into #64 and leave it at the doc fix.

I'd be happy to review your patches for the issue.  But let's find a
consensus on the overall approach first -- that will hopefully also save
you from going to much in circles in the implementation.

Thanks!
—Günther
