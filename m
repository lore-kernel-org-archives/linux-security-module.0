Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B354146B
	for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077809; cv=pass; b=p7h1lcRnIDzfC2CJ5juxNwQqBfuag9IKDo20yNnxIHAH95ftSkIpabVqz+png17DVSoxZNAR+mqh6ue91h2+WyLFMMEvUxY0JGCb8Y85cCsiXsZERw4A7g+4zr4tM1jn0R1G3bQgZZfFRH979xRrSJ7Tc8OvBjcsve1qEJiy6gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077809; c=relaxed/simple;
	bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0+Owwu1eiguxieRlGIiL9iCxvhkY+JkphM9pzbADm5b2GiF7xa9TXBAwF3immjCLUXGhzrCl5WJepcAePPMvyZ9IeXvD7MjND8aAM+fI0fE0kU6D04OnEEZG5VjFN39GP9PhCPMGwjrDBZoRtw8u1J8YKklmHHKDZU8oh/rqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJvOiHM9; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJvOiHM9"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677dbe051d4so1789459d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2026 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077799; cv=none;
        d=google.com; s=arc-20260327;
        b=ipB3kJslwavEIQ/aCJdFz/2wO2Axc5UJ4dXA6zEs1UJIK3+ugo+rFkrPt4aR38lICU
         SUEuFyd5j5M8//m5WHaWjYTyt0w3+wFabSQSHOP777DdngiQ5t5vfHrHe12R5LPSswwn
         X4NuMdCcnhN8ja9xwe8UMosd9FRLu40MasBY3yBLrRCQx8oD65xA38/CS49hS+f/d0wZ
         61YAcHFFzu06rumHoPmwU1JQK6HWR0rydbiZEi0QOI6SzY0Hl3tk80JWbxrHxNz16+Vg
         l/U1U91NI04e73PfsoXnqKxGP1+2d1Nj8Gxtlz+VKS3HOepCeg2arEYnRtAycERvWIUq
         uZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        fh=mDjyNynk2jU/daF4HxZjf5CnGXH4lEgSsK4PUaEb6vM=;
        b=gyy+W/6wG7+gCqNBHNKNmGTxBywnxrZ6Q7kCbshGKWIqoUOpN8IQaGDRlHjSKfyiei
         dACE9QxvKPWECmdx9ipk5NfCjfe8MyuE7hnxAgM8eXIgRRafuBtfeuAqCkRFmlTSTRpA
         cUp6kcqNqfZBWpY8lguRnvyyJ1VrF3NzfKtGb1Ud/HLOQFewputKWmVk1BKs5m+hcmX1
         8enc9jIdFEcBDwamtUkLQVqnwlN9CkPmDTRaGq1NKuUHblxflOVRZdB6Z3Iqluf0Y66d
         ejfsc6TJwou7aX9PEX2FPlW/eGSrzhlmT+jWWxLw+Cs78bdPAg/PE4NFt13Dv5aGJ5c5
         CYng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077799; x=1792682599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=kJvOiHM9M0WnN33nHmHK3r+01pGpxKYp5aY/UMKhQFhOLUSVrDioLgyfEQddwhvQ38
         PSxocSnNo4gQUdIbe4ErVPJiV96p+kqbiIxQcBbi7vbgtMDwRxN5BGIrrEmVjrvwbGhi
         0YCuafuazhtWQFzgBrSCDze23oQAIfATfnChfJJA42QV55tZXBH4DSzlHC4euw7F+JYX
         ieWEFUQcCTMYDeBtXjSe9qtkAAJtz4+p2iCkdX7bjFDQxaCuc8msRNw56cgXEz9EFzHv
         UEuv6DmGT5a0nd7IP8MfwnoWyF+3btMgkyS9YVwMoxdO2oDWtDnoZXek8Em3C42YaF85
         mLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077799; x=1792682599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=c35t3quAHKiE5sS3Z0wMbmM9qrhF59D0HBCboql/4IE0xjNYegeLC3qnP6U31TiNt3
         +zJSkT+XiCQXXMmJ8wVSDqT8A3UnG3//FX9X+l63zl4qvW+DCw9zEVI6phiLXiehak5M
         O/16a81T9pK5CRvbMD6gnZ4YJROzrqMAc+4rrZ8dYugNeEEfeGaqSC6OUztl8Q4hau3b
         gZdMJajuISNWomOFbhb1waOQiitLiouH1NYnSR6OYcdU+Fk6wkW/UR9xo5lf6uM5CqX0
         /BKf1Y54nBz0KQEfyXYgk2OGS9VHPQq/CB67W8CmEj6vxhw1BWBbnC2oNRg+dxhNiwad
         X0Jg==
X-Forwarded-Encrypted: i=1; AKwUvBxuyvPWPOL9GCUEYlh2/0zk/Pjt6YRrdjWyDoOcWqN4N/u7RsYyhEO+kyZIn0c1G1T9nB1CV22/l18U6Wg2A0hT6j9C5ys=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnY0jSGCGDKzxnJTQSrCfGHvmCM3njvzTrpmYAk9OmS+sVJ3iL
	kfI+puWq0mABSs7xNtcUo/3E4DnbkdHJAQHOOC5fQVBuN4sTsKtdoqTViyMoeCG6TOJrTG5x8gp
	3L4duehAZcaJ7DB1rTD+GrPvhIctvlDM=
X-Gm-Gg: AYBFou3+kp1PA6eVw4lOT/vyzxsPjoKzeu4wdJ3SXH+h1Bhw8TTo4kFQTCkTc2ml06S
	CFYthXSmiPkqfKCuT0fWs06pZqd9omyxnMoBU/vhiAoWD/+pw6wkbh4XELCtmXf36tpNXHrSs0L
	nIajinAuLL/BriMTn6b1a1c4ANp5zKxxd+nQ/Blc4qn/dymNoRmf3XPEgQZ9wBqaLERT/coxPow
	6dosk1fquVPQPCZ1U8eRgVE9DAKvTvvPCuYO+imNEmrxh3G1w8nFqnQuXpmAre34gA71SLCII9n
	+L8ualhp8Tuaqna/i4UaOOih/AN0mIwf1OTJHMtyWNbA1Kk4E65QEOg=
X-Received: by 2002:a05:690e:1286:b0:66f:94c4:51ea with SMTP id
 956f58d0204a3-6793603db52mr5927090d50.47.1792077799474; Thu, 15 Oct 2026
 08:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015093854.2082600-1-huangsj@hygon.cn> <20261015093854.2082600-2-huangsj@hygon.cn>
In-Reply-To: <20261015093854.2082600-2-huangsj@hygon.cn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK8xZfXzISQM_5AP4aKpkZUrwKcxhhqslcqF8aMXobo6HxWE2h1pVZC0fso
Message-ID: <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:44=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
>
> This will be used to replace the explicit sb->s_inodes iteration,
> with the caller supplying a callback function and a private data
> pointer that is passed to the callback along with each inode that is
> iterated.
>
> A single iteration function, super_iter_inodes(), is provided, with
> the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
> INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
> inodes that still have a reference.
>
> Without INO_ITER_F_UNSAFE, the callback is called with a valid,
> unlocked and referenced inode, so any inode operation, including
> blocking operations, is allowed. The iterator is responsible for
> inode lifecycle management, so the callback only needs to implement
> the operation it wants to perform on all inodes.
>
> With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
> reference and the callback is run in an atomic context that must not
> block. This mode is for internal VFS use only and runs under a RCU
> read lock so that the VFS inode is not freed from under the callback.
> It is needed for operations that require tight control over the state
> of the inodes they operate on.
>
> This mechanism allows the existing sb->s_inodes iteration models to
> be maintained, providing a generic implementation for iterating all
> cached inodes on the superblock.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

Perhaps SELinux could also use this to replace its own inode walking
logic at the tail of security/selinux/hooks.c:sb_finish_set_opts()?
