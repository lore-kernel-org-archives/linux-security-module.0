Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5302561AA
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558603; cv=none; b=CIGD9FJcfXPPwg+3TCWoE6FYErkxiS5FL/9NHLmn7oTTg6/q3tk6orRpsi/LA3FEvMeRUFHWjAMn6kKE/WxD+TUEjXw8Y7mfuTGAoGnLpwiUM0lJHXOC7XHsjS7k5dPHtWnW6/L0mXuWO9Lw8jFCwhrsJZ+PbI0Zcm7Ji01iWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558603; c=relaxed/simple;
	bh=eZ6Fzv+Zqsb3jqRtdohRY5v27H/2cneGfp0+CONCU1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDFucV4AlDM5XnGMVDXeHXpgjezRfjXgU0UcxQccO6xqYiX40gKJIwjIUcgkywtmu+xuMHRX9w7EUjiogZ9V56dVgwxu/e/tWeCPgCmq9OFMfuP9sYrbntImLVTdwNNcM+aELoX9m4Bhxn5XpRx/r1GxYn6As0bwBWssPlzSdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgub+joI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgub+joI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc32725so16265035e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 05:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770558601; x=1771163401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uneFEMz9mCXxi7Emz8/QDPUXAln+FuLm/36TSQR2it0=;
        b=Vgub+joIA28MosSbgcP1oMZs2v+roNM3ulOcz1TBjll2FJjDTqBKho0vchB6o2MkUk
         d0m5EgHsM3BuPg8jCE7U03mB148nuKZW0T/rki5oBWOZ1TQRqiV2QqYnoiovxCavnjiD
         GqY2g5FAFnloIFMnHCSBAYgcMGx2pp+dyB7Wu/GOFr/b9TdC6vVLN7IcBr5AyAITenGD
         LFx57kRQiqTVIIZOPxLuaHcxCORnZda11nxeIK8ZoSGRgLPdvHr6kx+AcpOdkm2xnlog
         pkebOrR7d5usQopfKwG8jnGA8T2Z4aCEIWckuJ29YQOQCKJkk9kzHvkjuOFY/Esaip1o
         U3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770558601; x=1771163401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uneFEMz9mCXxi7Emz8/QDPUXAln+FuLm/36TSQR2it0=;
        b=Q7DrN82fgs1BHqayeL6HvPqhwKZSf74AG9MRNP/FrNjhAQIY1LDnfQLWy80ZCtYC4M
         XRKHkjHcUvLwdRQEW/MDkr0PXGyX0AVMmb/DOZGZ0F1kndDTeDKyd0BVsVB3GYKOT6E5
         dwkQ2ICr6Xc9W0qlCsBN150gOjAu8CXV7DiLu9sAnD0FyFOMMcP7CvEI+dzaS2i1O4da
         2dg96rv6VeCVSR74OIi9+8KC0WzXxMwUcrPx/tuci4PzkewaB/XFylB6PY3cXLhANy57
         AzQsi99zUCNP09/9G8z8vXSP7rJ4RmH9u6AUWUAH1AlSHEqVqzgtGc02pMqynrz1ovhd
         0U2w==
X-Forwarded-Encrypted: i=1; AJvYcCVbY4XxgTNXNzapyDEtXha0NmyTsbZcQfaMMYjoKcZR0sHIpbztSBtmMgLCz49b4LJYMNQJtIAk9RCc6iH43kqeSgxQ2+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIX7BhlljdLOUlOq8uvNhYO6rNo1vG5ztTX84gIiYqoy8ODUFg
	ONv+9z2slY4yrvSae+njO7o/W1p21/1SMJqdqFTKyU+9jE+3REZla1kc
X-Gm-Gg: AZuq6aIn8u5UWusLHXclYakq2GmLj0CynZQ9KlogW3S2R56PS7hemlDB9ELS6SiTnyB
	/FdMOeKZZCgwe6/jac/x3BZG4avGcXjHma/4P0Nc/ghCzbfl/QBSUA4eRnhcBLd/PKHw5tBsMCt
	tubJlznnw8sFwZ9sdX2Od9VQEO+95HbFmBwjUrZ7zZeB2bwG6si1xopWq/6caWr22rUrlVmSo1y
	iWcEp+HTZu4u7W1N0i5qwnM1NJnsS0zf2aeLiNg9yR26ia4PFIkbruCb8UwWwkOKCENmZ6TCdOq
	hvaM9Vy1XCg7aqzVdI5dcBm37dAor0QfxpMcNJKiaXEgj02OC89Ge8BROaMVuIDPlf+yTLgaFw6
	pKggWhPOv/gWkJWd0J++pAtRrPMS9NyXyIEhQZ8cVomCSwpzAoDjtvvawlypR/AfRvn5WSVSQCc
	qVmZEi6QVv7Grr67MNNk2D3W8bHT+FPdEtyRDuZsKoDSe0oG8=
X-Received: by 2002:a05:600c:4745:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-48320227169mr135253175e9.35.1770558600746;
        Sun, 08 Feb 2026 05:50:00 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc543sm187244195e9.4.2026.02.08.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 05:50:00 -0800 (PST)
Date: Sun, 8 Feb 2026 14:49:59 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260208.b25c4105bc03@gnoack.org>
References: <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <bfcac905-5901-4cfb-8489-fb228cef0ee0@gmail.com>
 <20260204.vug7Osheiwou@digikod.net>
 <44d216aa-9680-4cf5-bbf0-173869111212@gmail.com>
 <20260205.phohK6hajaih@digikod.net>
 <3f9d456f-8343-4b46-8770-38190f838dbe@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f9d456f-8343-4b46-8770-38190f838dbe@maowtm.org>

On Sun, Feb 08, 2026 at 02:57:16AM +0000, Tingmao Wang wrote:
> On 2/5/26 19:15, Mickaël Salaün wrote:
> > On Thu, Feb 05, 2026 at 10:18:54AM -0500, Justin Suess wrote:
> >> On 2/4/26 13:28, Mickaël Salaün wrote:
> >>>> Tingmao:
> >>>>
> >>>> For connecting a pathname unix socket, the order of the hooks landlock sees is something like:
> >>>>
> >>>> 1.  security_unix_find. (to look up the paths)
> >>>>
> >>>> 2. security_unix_may_send, security_unix_stream_connect (after the path is looked up)
> 
> btw, ideally for pathname sockets we can leave all the checking in the
> security_unix_find() hook (as newly proposed, with the struct sock *other
> param), and not have to e.g. call domain_is_scoped() again in
> security_unix_may_send and security_unix_stream_connect, right?
> 
> (Although if this changes error codes, we might have to "delay" the denial
> until the may_send/connect hooks...?  Hopefully not but not checked.)

Thank you, Tingmao!

So far, the selftests that I already had in fs_test.c were
straightforward to extend so that they cover the new cases, but I'll
definitely have a look through your patch set and see if there are
parts that we can reuse or that I missed to cover.  Either way, I'll
make sure that you'll get appropriate credit for it. :)

–Günther
