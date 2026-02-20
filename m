Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2B29C321
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625788; cv=pass; b=AKstt6Q7Ig7YXsoqiZM4DrQYtsqBNp8kSdBZ0rRhofF/fv4a8QCw1pVsDfN1+/z9XICO5oxLCH/0hMmaqOqaQ00vFUeQBQg0AlwVBTHuKcpWQAVl89cP66GVUBQDIqcXfOjZW54eU8mxJ2wrsJZIrFQy9C25cCcXB2WnWcprOtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625788; c=relaxed/simple;
	bh=I2pkF5QAewPTXXJtz0yw3qpr9uypN+JI71t0BKuPbOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+1A09JMiY92TmPgPycrxNgsS1Q7PDPUWZmD1doRE4Hisj35WKtCTyYJ09M16+v8cIanBI8pu7L1WGJGINs9GMmsFu6LMJ++2ZXIu1i8oVxBfsWQ1hRfH9peCgdVedQB6lWXH5fRR9mPJWkm5f64l4m+ao3nCCkHzci3dmDIZWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bme1k1jC; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bme1k1jC"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354c6619a07so1018537a91.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 14:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625786; cv=none;
        d=google.com; s=arc-20240605;
        b=AzNVQOea0JxD+n0mUxpcig95wzPCfhHz89glLgIKpitbZfbp930B7Lqfc9BS5Yw9o3
         OSIGqxehFNgjQAQNWSzc6qQnZYqFQ8uAFEkbTNtJmixPoA7euzeX7Rb481TNh+XbGYHE
         3+3SLB8KZOtnqQO3Ge111KHW2gxrov2atFxFxj3fGpBw8QHhIbuHEnoEFTeaNAtxZRed
         05NDFqutTvFSUPZquYTHuSYYvt4tr02rmLBGuAic4JdECCXWYxFrT1Q0To0G9QKJCssn
         ShregAVkAcmuxZWDFBXWU2qcMJKK+pObzJOtkTjRoVcrAEjobfhR2zFIGJcqsTtsnNPm
         NkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        fh=HsnzHCBPQ9fRAK/D64ShFo6iMKJgMcFHiSoBtDxdUa8=;
        b=g2IPyQg/Kzot/k791JR/VZDimwSoxwyaprHjstHZGK5Lllz/3bc2Hgn/lGjuTb7SKR
         QrgjJG7mideK1PVmxJcyr2xkjbk4OZOoIoZzaO0Zp3QjwNkMfYfw8IGTEwOhAN+lBNKM
         SBc8M2tw1f0J1LKddR7ClDenS+O+hiGvi2lIcSVePzEEka3f+LprLqVIDLE7I3rBik6g
         06mpojlcfS8oM+2LAxGS8id5bn0BhoOM5tsEPQb/EUdtLKmVF9TZ/dB2fX5T8Ks5Lecj
         Q5HoptoYmT50OLropKfwudRsu+UAZ4TSDGf8Udk2G6wW0kbderOpAcZv45mtwV4iU0TE
         LYRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771625786; x=1772230586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=Bme1k1jC2cFEcSNQxgaL9wQHB7SvEZ/gabSWPoX6xzBCzNnNAoDHxMFzNkqxoGd5xg
         IC7cXkvJYE5GUrxifnj712uMQk7EhVg+Gvc+dEDpdX1i2+c4ZSvCzN8yD+CyU/qY5kKG
         XuCGmKshY1ecwBV+TSr97U/Y93qorzP5MXpN0dlePVzLcwx1Wi+4biRnnnhg4r9rKAV5
         5MEMf+bHYwZbltfFcC+HL4u2JjoeVGTv1TYuUBN5TsXjxy/VkSQ/tDKWE4E826dtMeaI
         vUINoNH5r0MoTSDxJOinvodgbGlyehDpU4q/1S5wfwlC7m4m5jnOrGhycBNTXFyQGB52
         XeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625786; x=1772230586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FTdyxXDyRNWNKUIC2l8l3tftf8jJbcicbeOU9cdsjQ=;
        b=gNoaQEbc+LsQN5ZSGDjIBjEImhefhae+0dA+dfNXErXkCwLmN0u6Ry2ph4n1HQ2uKw
         iSrF1W0fkbrIah1PlSxtIEh1UX+8G3xeFGcK+j1wb6mdELHXYYoUWbGGur9xCZ4tG1Me
         Ho7msAR8dXhfLM5JJplS3R4VGUvr/22LImehjzhCuepKVFWAVcdlFrH7mtwrlOpG+R8c
         77hwe6FGOeclXBcKPqKb1AELs87FwRSWkDdrTvsm7uuiSBDNgV/yLEV6UGrTZ9F8Rs78
         9KthdXTh+Uml6pT1lLQGuAxuvEu1MTTvs6BtMZ9wI925jl9d3kqkZ7KZx0oTjKkCEi7u
         gg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaDM1ZwhGdvUCnMhgX/TIMm2j7g++ZzJzzPeBHUxCmjrLGS68hQelZTStnuOokymuPkKme2cnjRUTbvEKN4RIeTW1a9x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR48l+mw1KtnCZA8a3PCV4H3BV7cLIBJ1v7uxjOotZMOhvwXLg
	+vRcM7+e2f5G0Jd2zVx9/Xvg9GAve9WVPO68DxgYciWbTQvoholKWnrGsp7k2ieca7O7fyc5h4z
	STkHkTTg0QOS0MJFb9DU3tnfj4NVLpFr3cOETIhp4
X-Gm-Gg: AZuq6aLLPaPsrA4AC8JtsHaUtjmNjbgYitXbKwS2uxUMXk48OiejF5qjt08e1+JX98l
	BkNpWi1++ExiFgF/g+nOs/A3Y4N36WhlDvnOtP+25bSwtNGNFM3BzVksoqhvMK9xmmRyPUytPPN
	5Tkt0VnWosN/VtOcuvlOMBPdD2ee0HWHLZs+omK6Ern9fIWPE+mRqExaSj5IxoHNQm5oXh41flA
	Wp/lyTsZf6slYiaIoGvrxgeS0CBl04C3WFri0NSbsGgkrx/Q2Nxi89Cf1w0vsaZerGIufnVU7e2
	WhmWL3s=
X-Received: by 2002:a17:90b:3809:b0:356:1edc:b38 with SMTP id
 98e67ed59e1d1-358ae8c0f04mr1044426a91.24.1771625785809; Fri, 20 Feb 2026
 14:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:16:14 -0500
X-Gm-Features: AaiRm50rzPOdaKhOCRDQhwiojB-mAL3ILUNVZIdIhAPsr9Z69VQz2AhP1HaIvAk
Message-ID: <CAHC9VhQU3aMHYdvp_Af88iBVdiOzZv2gWjFABUpvCxF37YJBPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 10:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
