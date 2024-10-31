Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626F6A019
	for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387161; cv=none; b=YsytolYhN4HQoLXLp0W6b6Dp0eiEfd7VzDbQtyqpfSaVxbScbIkg8uSUWP0apwtrHNsjdfsprPsnhZk2UZIWIN9nFNWyPSzF+L71IxH0aEiAE/apidF3NVmZ1FviUaKDieIBx0g5YJNBVi/Gc750gIwDUUCnK7nsA1DEuj6tNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387161; c=relaxed/simple;
	bh=okN6iKADsHDU5G1xc79CsdDuAzz4fO12E3NBBKkipAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt+u6RTa1dDotTnz/+b3t92qbBxt2jrWxi6YtEgx1iFHDxHQ/c4tJ2LuzpnzKGOgB+1xHU+dvuEUEbspjAv9sAt1sPYBNIUcqVY5K/Ph0H+z8I0oU7+sBU1Hm2AQ+uVQrF6Aj8myPl5tJz8BbSr4jrEvufA5RTP4cSG9dAfT4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G6ZMR07w; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6ZMR07w"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so506709fac.3
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730387158; x=1730991958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=G6ZMR07w8tevJNTje3ABI3oJ7cHZVCKHddeJFBHhkW1nAMGiYL98gtbTPX+EwN7Kap
         upJxsGRNgNLNEKhiApaCsXEy5r4jNLYuSjFnnEUNco+XXZJn1Hm59uY35AvxvZzEDpTA
         nyfUsDqN0pLPiffF6TeJMp25M75DKGrJJlWAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387158; x=1730991958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=KDhe88zT22kfhSYIesemeq8M4XIvX7KG8K8FwdzuTPK7Qc1rVkYHcwQfHeIelvg0lA
         Wf6rsmowR2iH3k9z0bj4GcWXVR3SRQK0N3BP+xoxIV45e6OvT72EkwzrOhZWgn2mC2zg
         x2Xzc2Spe7OsphK90yKekzr8xfE5Y0RtN8V7nVG+n2tJUD2maLwMT7ZJkNkpVWSrwOfL
         4QuHig6HN/Ab/V3uZHWSy5YM8gcNOFdDn8AfMWJsXX3ucBAcjwc+8ObHkoMXsMwmPcYK
         TH/VROr+Mly29ZMSceeHd/NqGQ/+R/ou34+Cq3DMtHhh6TFJ9WoCeEmKzjhV/EDM2XjY
         i54g==
X-Forwarded-Encrypted: i=1; AJvYcCVWR3dB8oJfemPnNgzfYh2kLpDT6rVQo+ms1lWra5mCih5QNlznJhk6BosbRqA/0F9vi/eRoAaA3BkFcAK+GqlpjG3QsUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROUuJt2TUUdve81ngg6neTpNNypaclkC6HjYpq36Dy2YszJXv
	P9Wm5uM2hqXx9fbDyT8+cueotHrZOqT/I35egOrtGZgdUu4MPrib1Ya+VC/qxOsGZukJSPCyIN3
	hKw==
X-Google-Smtp-Source: AGHT+IGLD+TFBF8njIDJOZio2BN4e+RhYdWNMb2IZ0Q/10OypmOjD3pvHNgbdbApTjkVZpGGCPgAnw==
X-Received: by 2002:a05:6870:5249:b0:288:60d3:a257 with SMTP id 586e51a60fabf-29051ddc93cmr17686203fac.40.1730387158247;
        Thu, 31 Oct 2024 08:05:58 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048bfebesm326880173.55.2024.10.31.08.05.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:05:57 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso226685ab.1
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 08:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFmfM7zTXMF6CGILT9PEiArBfsN6MVtO6nCvCxTG2cqlsCzjFk4De6aH1yfurrJkmeZkKYlDzN8sDaN6tkbJmqRy7/pIk=@vger.kernel.org
X-Received: by 2002:a05:6e02:2141:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a6a9361423mr2927785ab.5.1730387156524; Thu, 31 Oct 2024
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org> <ZxckGbxzpWDuXG_q@google.com> <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
In-Reply-To: <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
From: Jett Rink <jettrink@chromium.org>
Date: Thu, 31 Oct 2024 09:05:45 -0600
X-Gmail-Original-Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, thank you!

-Jett

On Wed, Oct 30, 2024 at 5:48=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue Oct 22, 2024 at 7:03 AM EEST, Tzung-Bi Shih wrote:
> > Hi Jarkko,
> >
> > On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> > > I applied this (will push later to my remote tree).
> >
> > I failed to find the patch in [1].  Is it somehow overlooked?
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd=
.git/log/?h=3Dnext
>
> It is applied to my master branch now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/lo=
g/
>
> Can you sanity check that it looks good? Thanks and sorry for the
> delay!
>
> BR, Jarkko
