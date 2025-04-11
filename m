Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA927BF82
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399215; cv=none; b=NJ4c8tyJBsJ4nyoGLa0T+V50qiqOBHtXm7uyN2sc3AKasDNQI+5yiAOXvU9dCppl2SBO5dtFp2jlKT2mrTmEoH7zMtDUbegvs6XZh08Edg1icqr669KDmiU7xzizav6Ji4BuxVp0cyZia9s4+37qztAy9phy13noB55hOtdPS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399215; c=relaxed/simple;
	bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIHTEHYsym0M9Ba29NcRMdGTglnRvNqFwPPGZfv1HvIR4UoES+IymG/44wpMzgLCV4c0I7RUijTa4mFcVuE4vv8Sb8FeEiBnvh5CZuUmM4ZbNX9YIs4ZhF0XzBzBPFn5o07DxmEdvagZH2ZjPF9vwmySD4faZZjUVirUu92wOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XT+hUKYL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XT+hUKYL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so316742066b.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744399212; x=1745004012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=XT+hUKYLG9ussuY9QStIWsO+NRwf71+8e9MCCCvImPVfbTh7mfqsTd/sp9Naoa8fEi
         dF4s3Olq9Cf3dLUMxOhCTiTq8rwXZ0fKJiR/FFg7qxfpBGOUig84RaBCqKDtsFDfdQt4
         D6q6IOyx3rTSQKPs4MlwmUnTLKcd7hYc7RTSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744399212; x=1745004012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=HlIb/He9JGIlxrFt2m61Z7+UWg+Abbu/uzKXetlbruEE2b9t3mMTnTLABoO0WpBiHH
         ypA8SeYa5sc3zjYQb1dEMhPxztJiSYbv+5x+EmuLFWntBEGOTLry3lSzT1nRGkGMseEr
         49CO/pLXVdBIg/pjBi2m1X+Xw8HoC8Vp49VQ22M5BW64uKZQi8mpBGmQ+OHHuTCuXHHV
         royjeOHeso9QoUtQVr4yeTMcAjQCRB5BoEGh/Qje1jPZWlefcI6Ml7cSVsY1/GTsZ+3e
         G+nhPmpeWhg6yntNX31eHliX2mGPzOBFhLOtpjzUfk5sNGNiD5dU/dEVxOPw+ya12BBv
         TRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdHEe253Npl3+3U1ASUK4KDIWxoJG4z4HFxyjCQmeztineN39dLv8y/Yqb91Cj2dZyqXvymw/Om9RzEncMFBhRorR1Apw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYhzUq5Cn63ZoWTu111P9S5ISwX1QYqAoMlPdbT1c219vznwn
	aIB7thRRCGWi6SXRzIXRnHqKQoXKaE/SOveYRy83I8Gcgr2EVe6qUxVZCM1OCJ549LCKSZEaAs4
	/AFIMtIAwte172PM55jF8K86pyyMItvLhKHHh
X-Gm-Gg: ASbGnct/v9gSsoMf7aMW80JIl9v6/H7AFdaC67ZIR06s3H3OaBdfsF+suU4upVxBPt8
	R2uGrhtV9ec9+cKTjDeVUnacJHLZ2EWv/bHgP1nksnqczqEIcMorFmC2faBAjyPdk4uCeL0avir
	c/LLpUzymcCfV0zfrJsVuZjio=
X-Google-Smtp-Source: AGHT+IErO/wFycetDqHLZ59nJlqxvZeRR7iYXzNYsaGdLraNNvnVeWXTxdCP3oc+y0OVwxcW9yRJa73Xy0cfI5TS2Z0=
X-Received: by 2002:a17:907:3e0e:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-acad3446cc9mr330029166b.6.1744399212186; Fri, 11 Apr 2025
 12:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-53-paul@paul-moore.com>
 <202504091643.3C42B66ECB@keescook>
In-Reply-To: <202504091643.3C42B66ECB@keescook>
From: Micah Morton <mortonm@chromium.org>
Date: Fri, 11 Apr 2025 12:20:00 -0700
X-Gm-Features: ATxdqUGiVvNux-N2_Zf2iA8S0CxC8AJE2HGWavCv50sc5-TRBEPKBa8mI6Moi7Y
Message-ID: <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:50:07PM -0400, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Acked-by: Micah Morton <mortonm@chromium.org>

>
> --
> Kees Cook
