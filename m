Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6E439F93
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738130; cv=pass; b=uo7BgmILNeESsxM/2Q2wPA1e3sfLtBOH//hESmNTGfoKIWQ+e3DkVAjxuL5i2hDJh5zBMsVds3yzNNqSEYbmShwKOKJp3CREDejr+LN95KG6Ah5JR8m7+0ADzui8BrwShdl7Kgkj1XmS5UWQg7sraHhb8XCCF7c+JmOIO2pfyQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738130; c=relaxed/simple;
	bh=KSi1t97EgG7D5HEBbSRV6RrcN19EY5TnuQmV2O6m11o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd/wcj5iOoZ7K9Nk/CZr4Gae0XTAr9NIma+Ed04Z/mNOwk+3aNyHk9Z0ji7dzsy1HyUNOGUu8eDc4JiV4Huih84yyghyWLIpot1fZTgub2ah9gN5WJvXViIhwMwNGbp5KSI0GYi9oMrCaVGYhvc/mushV5m0d9IWZzY+O3ImAuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=tCY1qQ3A; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="tCY1qQ3A"
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4EE2E3F98E
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784738119;
	bh=ZUbyG1NopnGoWkyyB1dTvuGLUp5+MvxFGCYCJIL8+J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tCY1qQ3A3KY6Upj+XCoUGyJ/2Gbtn6z05Jz2WdZs1n1eDvzPOL2cuWBlotREWjpsr
	 4pbmtsM0APj940ntWwjAM4jBlvQ+y3fB8R4JR2M9NuOA/viGT7eQ8KjgjkChJ9N3la
	 modbb4uzh0dyWRF3YeJ6dun01aK6mKRfOd2cI2zbzKcsnLp4w60EAMginBpqW9Mjc5
	 iyZz5Hu3SpL8GL6xS+JFVj0h/W5iO+DPsIuUXu9kVIhrNFx6DW7k9UF4SkKWsFGtm4
	 giNGRL/KzTCUJNnskVJGp0NDXdmib+tTOtOlZ9+V4M9vBryOmsMC8yd455quY89lQX
	 hjLQDA0ioJDV8Ew7iEcs1/O7gTtJ5RJjMVbGjDuQr+90weH6pJtZRS9FR6oTOWHfqy
	 URrunmnHkRRlkalReH3AedcxWzEvF0Bi9Ae/tV6Ve3Ump4X3JF16eY3RzELtl76K1j
	 I++kMxjwRUYTI8TJyOKzTYzcp+jownk4xgm0HG2yqCIxQEhppew9SjbtHkeTjC0OoU
	 dqrh0CDc6biLXtkZ0XMY6vqDjZb+/19r4MK8+C0h20MDacAdepSK4cKJDeXSAo//+H
	 WIbnQRVnRP5mz46IkMAGDaUtsJB1ksRlMloO6SSl550z1PLfbN67laTIodwDeJizjP
	 i+lrragAyATr48ANOW5PrZ9o=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e8f17ada0so48747377b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 09:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738118; cv=none;
        d=google.com; s=arc-20260327;
        b=J3a+x9j5tvRoQ4Etb6wzsA5fF6mRo722lbS1J1Lcr0Msk+JQFp3B5byA+pmSL/alRu
         R5UmaVQChcy3/ayc9g0Js89mSBiU/d0222Hr7L05WOwvMmfRUV5lnXFBJls1CTTfIRtX
         h1UvmN4B10cjnq5slxVm0OTk3WNghG/LnxIKCkTZwklPJMTskKF3N68/CwwE5cTrug4S
         ah2rYxetMfXAe4MEZCgI1ZoAQOFUjfZxBzo+Zq2MOxgprVYasrx4lXc5wWpLYcWcY6ms
         Gto/2e9hIGy/06QoU8k/xLQ1fsQGwXX3Z4sMRXw/zZLMFTOq8gV2LNbls2Can/mc3i28
         AmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ZUbyG1NopnGoWkyyB1dTvuGLUp5+MvxFGCYCJIL8+J4=;
        fh=vcou5XQpaY++8eSIBUGMn6tfBdCtgomuHOZVsF/1AKc=;
        b=V0LHr1TjosOHnHJpzrJkJd7fpfOSgUzGdjoWnwJiOo6PNIxIcnZiHziA4JIw6iECU0
         NWlqlS3x0DDm+D9ciXaQzf3I1q3u5rj/t/8y7xnNFTl7hanTesF0qfukt84aUdDWir32
         GdUxEydLKhiTcG57h/zEaCows0/WEoj8svoURYfU+32Sp+eY+IVMz2fclq4puFCFD6fH
         KNHWmMRjPOYNAuTllVNQCkv0Jbjzr1h0TJVTrSiglRatdQvzrPfkPsRJLiou6mefdY7+
         SlY6SKsXzQ/wcernjXQysFEpimvhExVUrbDOy7y+cNnhCERqExqZWFJbgik8kDAj17ib
         O77A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738118; x=1785342918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUbyG1NopnGoWkyyB1dTvuGLUp5+MvxFGCYCJIL8+J4=;
        b=ICe6jJUH/L9cjNBXDyHPDKvgkKmEIgXugFWlufAqNKMiUJX6im6tjTipeopVyFpHLu
         MAb40IHcsoWD6UBpiXMKIpL+tJ0namWGKz3/hJ+6bX38+JtPwQ4HJy7tM+JyQFBlfO5i
         GwhAvuDg+APdR6Gnisi9ZffkdMIoF6kpUCgVw5e0TvfU9nQAvRAGaiuMNB1MgxWXr8tf
         CWpWVrT/b6hSUEoawNBw96h97PWcmQk1NvF6KIEpnByeQ7WYhZQv9Jd1Q+6sxjnxeCDt
         hni4vafvRFyATd96SliYpwE9GcbD45AIovMMlUkKwQuVbbaCvHFtbzDHSOGsp8wIxAng
         ZOug==
X-Forwarded-Encrypted: i=1; AHgh+RrJb0IV0IzY0aq5S8vioL4/ghhfnzzWzA/2h1aIvYUMui3eVyso/2Z+gHpYcfsAog2Vuje9G6QCF4amgENO0gsbKVcUOsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7aYv5aIGIh9u0yj8iLvspi4N73lR1QbZ2FR/PVWxjEESxDcU
	3oNLpteUedWPck5/HQduhBXEJYyORmO9/3Rv8S5yyndWlzY3aDHYxhghMOB8uvwwtuOgfFM5UVB
	bn88RRVXaui9/aQ9R7kBCHYtVYPi0mIXnr1TdQNk73+bME294Pws3PNLyW/OxmSjqq0mYpTVuBR
	aDvLxVxegL1/GKiYkHOQbyjPz6zggbp6WmKNkiCHQ7Qs3KF90yFITe8QYeAtUfdXC1KaMQ
X-Gm-Gg: AR+sD12Eyxhyamq8JF0K3FcfPCiJfgrrGyK2LfqCynNUjwyPqJ/utFIMHJT//4paAeu
	mVndMFuhzJQFsLN1bmoC5V8FtFLHXyuGRay/kvfwZZ+MXzFi5bCB7KljVTp0P4cNXFf+wwZrnug
	kOAT06KYLndgpQw8FoCDO51EILAd0kkkjCiakBaVp8qjqqaaH3Mi2GSINjT9esJ1dWH8J91neXb
	FvDnC/5kDaKPjZXSFo2Uhedk4LUlEX58RpSis7YnQ==
X-Received: by 2002:a05:690c:6107:b0:81e:bbcd:f5c3 with SMTP id 00721157ae682-81ef25e16eamr71030567b3.36.1784738118229;
        Wed, 22 Jul 2026 09:35:18 -0700 (PDT)
X-Received: by 2002:a05:690c:6107:b0:81e:bbcd:f5c3 with SMTP id
 00721157ae682-81ef25e16eamr71030437b3.36.1784738117708; Wed, 22 Jul 2026
 09:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
In-Reply-To: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Wed, 22 Jul 2026 09:35:05 -0700
X-Gm-Features: AUfX_mxrFEuFvafch3oOKkk6PD_KLSCHeXxKK5IsGQNKDKpirKx4nMj4rz5jiC0
Message-ID: <CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: update website link
To: Baruch Siach <baruch@tkos.co.il>
Cc: John Johansen <john.johansen@canonical.com>, John Johansen <john@apparmor.net>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:40=E2=80=AFAM Baruch Siach <baruch@tkos.co.il> wr=
ote:
>
> apparmor.wiki.kernel.org redirects to the current website.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  security/apparmor/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index 1e3bd44643da..472aa38254be 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>           This enables the AppArmor security module.
>           Required userspace tools (if they are not included in your
>           distribution) and further information may be found at
> -         http://apparmor.wiki.kernel.org
> +         https://wiki.apparmor.net
>
>           If you are unsure how to answer this question, answer N.
>
> --
> 2.53.0
>
>

Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
