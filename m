Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6461149DE5
	for <linux-security-module@vger.kernel.org>; Wed,  3 Apr 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156341; cv=none; b=bQhqP8owNBmmA8qPUHdD347txEnrSXSCopcmI1nPvUMegmAkpReizEWZARu+ZxU/vr4BjgW357nPI8WnSPep2Q7Ounir2cqykA2kt08JxX3BNIF5q5wJhD+LkQRZnxSzxFNsMwMptmwbZ6IWYEOl3WDJOy2XCBotVHR256GjyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156341; c=relaxed/simple;
	bh=bA08xc5rb3BdVwkyNJ3oXMMCv+codCJF7wxqAsTEmbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZgbpjNS+wPODYr6giATIPf9y4jajKAd5OZ3DGWB5jwcd8MQzWJqJiWvWYxyhU6eqjCOE1kPkwoe2GNXXXS4VEWyHoSsTM+2RloUollD3fSVmWa5EMC9pqAePiHfcXQY/GcR/aPigzkM+vYNhWhvnLD7Zy8s6PBjrZPq1FqHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NTgGLUkm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NTgGLUkm"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61495e769bdso31607377b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2024 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712156338; x=1712761138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6ozn8GWGaymICONfaql8z8aBGhL/vcq5PD2xm3yHTg=;
        b=NTgGLUkmp+mD862RxBHk1Uizuyvzo0bnE4KI+UdiJDaO1+vrbFUwPNSgGT5lOL/wvP
         aV2EW/WE46eGtubOBk10gQJ1m6nm0aCoQ+Btrc3bxvCS7WZr/kqsZ5CB0WcRqmvfLtoY
         8vv0D/2HFC4qr4kvXmD4aQ0qyeVEwSOQ49Kzhul3jd6F6yiz/SkGzSzPGPgkkMivA5M8
         GVYzVGzczxBfUBzjE5b83d5qJAlaVgSppSzmkzmmj9z1KWZLjI/fe9+trzKkns8IN4zt
         1foAqoJrbFc3e5+yVtOpEjVHAahVO2I3I3qJupKJGELRWPvqt9YbaEngxNgG3Co/W3W+
         0mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156338; x=1712761138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6ozn8GWGaymICONfaql8z8aBGhL/vcq5PD2xm3yHTg=;
        b=nhn8q2PA+fidPbIkBb6Qz+9JYjvy7ExbNv84oPO/6lRwMF2ZdWiemV5Cipce26v8ca
         qz685yE6doBd3BPslLElM4W/UWLUzMi2jP3nZJLrOnzZFg+1JenigdxEIOgadfHAwr78
         M7MXVSgkPjhRb/BqkMQ9UQmxVoH0zUwmwpZ6VjBUX8IDfDkn/ao45JvqbBWDlXT7+T4+
         6vDoELwaffx6qqHej6kRtght9MQD9McNZIkbDAYMOkTH92WUcsN7SyUObli5wFPNzbfz
         ZNPC5SzYuRhCiaiZbp4cqyZ+UbKjP7tg+4Q6MMkyBabk6cxnhVGFu6TBb7LCdiZUoTY3
         REow==
X-Forwarded-Encrypted: i=1; AJvYcCUFcUszVrl0aRdUYg9s8ioehVIckI1IhAHNWJlav7VR5E8NZBIc4hEsrBruQe8oVHw3e/Z1pXSt0oV1W9zxXGrnzVszD3JPCvA7oRjN3pygf4zXIJua
X-Gm-Message-State: AOJu0YxUaN9M5/tvlDzB0i3qmRzzmlJZCLlezdY2sMThJoG2zyoTii87
	LFY46ZFh0LJy81JObBKsgpak/ZTiZ/37C+WGw9mLsipkQZVoy3q47oeB+VTyxFj6hk6R8uX3Msl
	cvwaLp7wtyEUiTMx5BSDb85GxnfheUnMctybx
X-Google-Smtp-Source: AGHT+IGNgAodpsrYQT2AbEmyPbb+UGOULWYqBs8jhyUUwdxQtLywey14p1gGYRWmBh3FA7fTEozafbxC8444+PUG35M=
X-Received: by 2002:a0d:d5c1:0:b0:615:144f:1f5c with SMTP id
 x184-20020a0dd5c1000000b00615144f1f5cmr6498090ywd.47.1712156338103; Wed, 03
 Apr 2024 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Apr 2024 10:58:47 -0400
Message-ID: <CAHC9VhRFsvBs0ysZ1rwqaz0TvMQf9JFQTBTA1cym08nbvoTVEg@mail.gmail.com>
Subject: Re: [PATCH v3] security: Place security_path_post_mknod() where the
 original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-cifs@vger.kernel.org, pc@manguebit.com, christian@brauner.io, 
	torvalds@linux-foundation.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:57=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call t=
o
> ima_post_path_mknod().
>
> For symmetry with security_path_mknod(), security_path_post_mknod() was
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
>
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
>
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.
>
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHm=
BpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c          | 7 ++-----
>  security/security.c | 4 ++--
>  2 files changed, 4 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
