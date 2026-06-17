Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5337B00F
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737378; cv=none; b=aGnygSFnuzWPnpw9iJfoiHxZc64sfdooVfxjrgN4Hcpb0Tm3sX77h5Zs+5misXmqk3IzP8v+Dx1pIWA7sRCg9IY3O34CTY3/lYOesmjtHMX1pj65TEPgk4Pa9kxqJDxlYRN/djrTJkcB8lpovxBwk46CJcMrHjffIEw3kC9ESdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737378; c=relaxed/simple;
	bh=goMpKc20WWLgp813XRXVBkIwuN4QUKh7e/eWkucNL0Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN25eonhrcKODbLqQBvN/vYC+uTwczfNoxMQSq0cRHTPHmWI70BUlAc2zY6ehGYNfJ05m6dd0MhfhWNeavoRe9mqdyieAEL/f6GTCdc4pwGkHpDeu3sedONc1es9IrgtNS6eOOETHUILch5ZEcaJaRBfWMqRfkIXntIPBeeXuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WGT5OvGw; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WGT5OvGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781737365; x=1781996565;
	bh=T+JJartZWEPH3a3kFKvYUz17r/3Fi9cItcUnsl8qV4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WGT5OvGwJIjqE3xl0m42QvBttLtp6PFxwy5gLCDwNy4cx/xDVFOyFTSWM6uap9sFv
	 LtypYZADuF5hhha2sjVv1p+JVfHWHioHHR+C78VW1tTKh+oOr+bSFgTEr8fTcwrjco
	 oXwFcPT8GKgMwn/1LOOdKwFoqhFoiGBuvS0a4Ed3XGOSwNhuF4W+eZaI0nWt2/tLI9
	 cmCBWBYj/u0A/ox0xFtXi9vRbhk2r6T8HB70fRzOVxImefiTnEFnwvzK1lh+vMoh/r
	 SHmvB11lSfE3+B+xs4jHzGXYd2m/+MPLHmFVXiZjwNc9QDuNLCCZxWnLGmDG0CAm2b
	 0gv7u9CNbbX7Q==
Date: Wed, 17 Jun 2026 23:02:41 +0000
To: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring IORING_OP_URING_CMD
Message-ID: <20260617230237.14718-1-hexlabsecurity@proton.me>
In-Reply-To: <ajJtTHyqWTmX7lHo@google.com>
References: <20260616201633.275067-1-hexlabsecurity@proton.me> <ajJtTHyqWTmX7lHo@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1609b76f19771bb6944c2ebd5f4fa15f3c915e21
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks G=C3=BCnther, and thanks for filing #64.

Straight to your two questions:

1. Block: you're right. blkdev_uring_cmd() has a single case, BLOCK_URING_C=
MD_DISCARD,
   and the blkdev.h note that it's a separate number space is fair, so I'm =
not arguing
   it should be a generic ioctl multiplexer. The "others, through other dev=
ices" are on
   NVMe: the namespace char dev takes NVME_URING_CMD_IO / _IO_VEC, and AFAI=
CT a
   write-capable confined task can reach IO passthrough (write, DSM/discard=
) with no
   capability, since nvme_cmd_allowed() only wants FMODE_WRITE there.

   Correction to my own report: I overstated the ceiling. The NVMe admin op=
s
   (format, sanitize, firmware, security-send) sit behind capable(CAP_SYS_A=
DMIN)
   in nvme_cmd_allowed(), so a Landlocked unprivileged task can't reach the=
m. The
   A:H / 8.4 figure was wrong; only namespace IO is in scope for a confined=
 task.

2. Truncate: correct, no sidestep, and none looks possible. I went through =
every
   f_op->uring_cmd provider (block, NVMe, btrfs encoded I/O, FUSE, ublk, so=
ckets, ...)
   and none change file size; truncate(2)/ftruncate(2) keep their own hook.=
 Please
   ignore the "and truncate where relevant" line in my suggested direction,=
 it was
   speculative.

On framing: I'm happy to call this a coverage gap rather than a bypass. IOC=
TL_DEV was
never documented to cover io_uring, so nothing it promised is broken. The o=
ne hard fact
is the asymmetry: ioctl(2) BLKDISCARD is denied (IOCTL_DEV, and it's not in
is_masked_device_ioctl()), the same op via uring_cmd isn't, and SELinux/Sma=
ck already
hook security_uring_cmd while Landlock doesn't. Whether that's worth a hook=
 or just the
doc clarification Micka=C3=ABl mentioned is your call.

If you do want one, I can send an RFC for an all-or-nothing "IOCTL_DEV for =
any uring_cmd
on a device file" hook (cmd_op is a private number space, so porting
is_masked_device_ioctl() wouldn't be right). Otherwise I'll drop the provid=
er detail
into #64 and leave it at the doc fix.

Bryam

