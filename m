Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D629C321
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625756; cv=pass; b=Oh0ScHX7X6zbdZgZbjFRUzvY8kiurY4GFR/6Xhcmc5yB8HVFaitplVBypibAqrhrcbW8yl9NWyxW9Zx1ymOYnrFy0BCCrzZ89OzGH1Vhs4hEXFNK6J/UA7W5O3LgegRdqLCf9FwAEpRR5tdDhrYclIVMUUzwkrnhxLSxnmeIkDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625756; c=relaxed/simple;
	bh=j2FvKpOUAlz++LQtlLxLTnYm0ZHmX0REwKDmOP9aiII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCwuPFVHhepaGHOmB+uIWclv5SMAj3o34rNMmyVRy57vDFlhU/demvi45RN2D29Qij6Ckj/b1lzOsQL1TKA/gsPTaIEjH3x9pQuBrJ28wi0t4uvCttWYyaW+gpjvrrqtkwdCQ+bAaO+1gGLgcas3OBj2jxC9QNMUumoJvdGKiqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GxS1yFxb; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GxS1yFxb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354bb7d2cb1so1591131a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 14:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625755; cv=none;
        d=google.com; s=arc-20240605;
        b=KrqNuRlR2cLL8jQ10kagtF8pE4EJ1WVWSuBrPWfOPhqPbAIBghv9Std6ugdUxDea0a
         wtwv5Ve4AkcU2kzv7nKH6iAq+2qX/hyp+YC0YtxZQpUHNBYfhxTI/wlgNcddnOpjeUkx
         PB+WjI8odjA94aqM0dZFfYqTLRmaz+zr2OI+S0MXmrAo0w57epqen4fKFROgVNrYJC7R
         /PoCBe57n/Nc4e9emUlVXW5aldGPWxLxgkmo402Sopyn8o0kXOD8Y93d5KAUmFIUQMqE
         tkm83cpV8eqQe8cOguQoGuLj0H0L9fTGjPAXu8uW70CQrXnJtgHvnz+5m+b0XKbWuDsS
         Pmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        fh=Ys23c2Qvg7ZZrQi6ijlCzgkXYm9YbX7xSV6jAZmS99k=;
        b=f9A7caTuXcTzHFHU3sRTmIcTzb/wnWnhiv342bKGJJAu7d6S2ObqiRop55MN6MbWER
         Um8dLo6hpMOlcpz6HK3dpm+wI+fVtBGU21vTkJM7xTUxz7iWETOurqZLiglG88zQ+lrZ
         Qhy00ciE2fR2K5nBUHXRb1rwAR3D762uu9AQRA5ufXATmoGHn3sn+pXtA1go6pjBKFZc
         BSGgeEQRzKqC59o1du6zFpnJZ9qKWwm5U/6geDR1gkfJlveowOs2Au6ZtFLUdreEfeNq
         1sUrtG00woYEZiMeBxoU/pH+SwFfrCn97S9SJ1Idwpa0Vyag/FYg9b+DG8MozjhdCpM5
         25Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625755; x=1772230555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=GxS1yFxbMbDV1VgMssO4X/h5IrLqOjr9uvNzwdF4mwF5cmVoE+ZEOSFkmWaKDlKd5C
         6LnUrQ4jY4ppgMmO+EyapjaqqKVdXdteUuBTZjavR2UYT1QAYke7pzDTOZ4e1s5dkG0R
         fodiCoVW6svow+f021AA5D4XDQTlV5svzccPg1zsd9Qrd9b4DY4zmSYM4ojUGUyjjAiM
         MdzVFb0+YxL0hWDOp3DFLYTHXbKGhoDcrLYA4urKNHkDoQJxE7jdKTZWkjyCD9drPzdr
         BURLdLA9MwHAZmWZb/NN18BTSLdgjIzuCc1UIXZ1UgGYQ4U174+RTzTCbOu28JQtn/gP
         KuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625755; x=1772230555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHhdAwx80mhHQaO0rCUoaLA5wCfJXcsgYrbpluCJs5s=;
        b=QfhB2cJDyt7mwmWerbqAg61w2D5j4x2F12/hpssVXkLPey1R5B1n1Vp9ygzwU/PfUG
         DcUFr0rZpm+z9vWIU44DdMM1GPRJQ0TLbei1l1BDmsNKTliCQqXIEPmafD1ZNLfoVutJ
         u8/jxDc1yUZSeyyYKuELcbyMj3OrOL40bfFBVvHTeNB/ffAgR/E8KHQ0tSsd2gScYlyE
         05YZly+fmbfFHNhucpOWSpTErdPhEEU21Igk3L8XO8F5emDrcHu1Ou+iOXpn3QMcXFtx
         ZN/Qyzqpkm09PMwoLtdRLKgx5XI2VVJoIwVFa3e/BZsvXHuo9LjQ0GMi02UCEwdPWZ6w
         g90Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq56lYmpn4GpBsGs4Xjse0udrt+xRvJp2vjENh29fgemfwtC+y0BcK09MopYHwNN7WITKMjQxn5caKV9gC9ckkUTu5GqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci9w6O3hL7oufts+qO2b5PFZtJXH+vbZ7G2dQhjfdG2IZdeGl
	pWccu40363XX9n/3nSeBxQ6lwlAOdLnHiB53hSrm9nAH1I4Bl7eZyWhYF5doe/+D4ELNR1BsXe7
	boQHP9reT3dmJruWC/8JNYHVCiBylix6NHFp2VcEn
X-Gm-Gg: AZuq6aJ05C51vJrFvIjxXBWsDKKfLhWsoeZL5R8Jxb5Y2daydDhOI2HAYOh6dJ3w03q
	aVe1TsKE+1PjJ6BMIzXdu4WgsCq2dZcdbr3TdmHcQv1xPpyP+TQyhFErbjr742+rpmO+a4EXy40
	yyl3+4E3I/cpvdNy2Ha2VrBTB6JUNLr/4YmdHIEbEr5Slpl8/NNQwJYMz8yV+EtWMtDsigbDAtm
	MLbjiXutk2CAHfYzV5WyAaic+SqFT4PZhTOOmrkVKKFgEkT0xxEat1QYzdzxqD1ttwPRo07q3fz
	0Itjeqw=
X-Received: by 2002:a17:90b:57c7:b0:354:7e46:4a8e with SMTP id
 98e67ed59e1d1-358aeacd536mr799506a91.7.1771625754671; Fri, 20 Feb 2026
 14:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:15:43 -0500
X-Gm-Features: AaiRm51NzP7pLbkxnmuQ3vMkAzifx0h6WMPLv9aK6B5e9dNw3jFzqT1KPgQ_5Xk
Message-ID: <CAHC9VhTxkgEnU5nP+7zs9eXOn18PXc7vBCUfY1vNd6qM+N5uAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 10:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
