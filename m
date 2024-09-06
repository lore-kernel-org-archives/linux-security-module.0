Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E661CEAC9
	for <linux-security-module@vger.kernel.org>; Fri,  6 Sep 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632683; cv=none; b=FtNJyvuol2G1ZmxWDeCqeI7MalEAkccWREZdyczmBRNJ8Y94O5MBQug7DBuxql9s9F0Llr5TBjkgt+RUZBxjyrj+qSLhRqUmC20p1JPwHTcJS2UucFAmosfsYROO9MH6a8LJzCDggGvedZ+L+/Bzy14+WxnufzN+eTFb1k0/ptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632683; c=relaxed/simple;
	bh=wv6kJxYCqCengvLTHChe0c4KVEVeRveBWFTYnyGvtSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF8XICyMbhngqlEMPBPzl2Q4acbZqGb5r2sCGg6uTODUlwziimnyY5N/t//T1jarjo4Fqp8eMcmlytEJgPlmrfLxApSxEzGJBjiT5xRSaLWSVVkTlbCCXtJ4cviWFEmpEf8xaSxTMvkCP+wXJumu1X2+8XKhsL29SX9tdivvYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yj6CScOJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yj6CScOJ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c130ffa0adso19253297b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2024 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725632681; x=1726237481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNbaUU5vwP/wbzjKIGwlz0vt3Em9od+pl2HUlcVAsXU=;
        b=Yj6CScOJz17tA7YwqspISU2T+w/zx3UzhDhQTd5RTp5Xk/lZC0KGpkIaqJeDJUREUz
         bMYBhallnnSR61nMBttbYWPfY49hgeoK+k3/teTlY88Bt90G7dyUHZ6UEi6wDawO7hCp
         XYXxS8rX3QKFZCACHpBNS0QnqHmurPRa3yJkjHIya2B3/Cx17P4hK5oA6I2p3l4zo+9o
         B3wuyiA7ZxZucGUGd/ze0Lx2gPf8fWaifP49S6ZUQjrChkWaJBDtr6CjtHX3BTd+xvka
         svBPpnh+38xV2fQs9jWm5OhI+lO4FG+TLk/Fjk6fmQLYp2zDtH+BAmfvruUjCf+BFWct
         Dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632681; x=1726237481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNbaUU5vwP/wbzjKIGwlz0vt3Em9od+pl2HUlcVAsXU=;
        b=UTlWV3D8rNdarPawjThbcnyqy3O6mjC1Op5tutzeCKt38TV/72W4HFJibVR6aACkQr
         gBkESibPkGmbApq2z+QzuOJmtL/ExEAyYjT0hBoNj9LtMta9WmQ06SXAl3qERVnwBmeK
         d5z1uP5vkYjInrDjsmfQfJLRldEsmmttVr3XG9v/jvLKulpCSLGtLStoIg9gHzJgny6Z
         Kx8TVzvgMPXzw4X24IrwyYtdZrl40WTRGZhRjpANgSFHTZjsyjmMMoPj+R6Uq3ZNP3o1
         5LDRSF2Ts9pJ1bBRsuNaZF/AIAv4HVHVDagw4vnYt+f6gsagJUwcSIis7u++DGWk0cwM
         H/iQ==
X-Gm-Message-State: AOJu0Ywf7zapEV7gzzYuHUZnqRj8C4oPjWl53MxiFBaPpIoNVHNmNWcU
	gtJRiXhMH5e2i5jtSqR0AgwsOTDe2GqGLkvP/ETbkLSngYYq926Ih0JxFGSdH5rtSDVwmJn3U90
	ME5mFZz63/Frd5AIz2K2J/yxBLwLYkJjBstYxfzB5oIrDkrY=
X-Google-Smtp-Source: AGHT+IHkwUfgBd2GCUq4Ewk11aR7nvtoUcy0CcLvqAJSfxsI0EpdJKKQsnFEMsEDRxPJNpbCavId6DYQUks2DIdCYS4=
X-Received: by 2002:a05:690c:4604:b0:6ae:2f25:8bc4 with SMTP id
 00721157ae682-6db44f2c242mr27205497b3.16.1725632680764; Fri, 06 Sep 2024
 07:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com> <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
In-Reply-To: <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:24:30 -0400
Message-ID: <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me, 
	tomoyo-users-en@lists.osdn.me, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 3:43=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/04 23:23, Paul Moore wrote:
> > On Wed, Sep 4, 2024 at 3:10=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:

...

> If you ignore my concern, I have to NACK the static call changes you are
> going to send in the upcoming merge window.

I'm not ignoring your concern, I've responded to your emails and
patches on the topic over, and over, and over, and over again by
trying to explain to you that your goal of supporting out-of-tree LSMs
regardless of the impact to the upstream LSM effort is not something
that is acceptable to the upstream LSM effort, or the Linux kernel in
general.

I've already recorded your NACK on several patches on two of the four
static call commits, if you like I can add it to the other two please
let me know and I'll be sure to do that.  I've recorded your NACKs on
other patches in the past and mentioned those NACKs to Linus when
sending the pull request, and I will do so again during this upcoming
merge window.

--=20
paul-moore.com
