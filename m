Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042C330662
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604877; cv=none; b=TQu6ay69cJUtyCL1or/vAz/qdNDLHFtBl+pjLK5Nwd9hMZquItmttikQf3S26XdKCAPrSx4bE02kZ8fLMLDeOd4HnyAlN/PeWBDMCYJTMFktHo4RAQWEnx+xdz6n6Om3yfLhoERj7OGkt9HtHoUCM8QCbDQN1XFrjpN/UJ3Jh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604877; c=relaxed/simple;
	bh=Xod3XHvlvPOi5rohMuqjFModaVJ0wfrBhhXxLg3gibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSQCpEouBSUCDqhBdk9ynYP+U9nxxRxNmXOV413QWhrc2Xfi3+H7RyoxRm8RUyGdrddUfch9ZCZg1LUKcaO3HC3hScegkBgkRF3IU88NWFEGO3FuvhlQS7UxpQMEuS4MbYpUHUwGVXGW35rCADg3KZhCDn5fYhKtIR9aTaDRoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKuUU6dk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKuUU6dk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso19050615e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771604874; x=1772209674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+TRre0GfSkQVtFzIahxUylbiw/llWCZvTNVURs/TgMk=;
        b=JKuUU6dkXKCa3BcbeY2bLCLa4pQ38yzuBFwYA65Fxd/Hk3nqlalPRj1Fv3Kq0Pjt4T
         jBHkN47di6LUX2hpFyzCbwKupB9K96ahUvm8gj65CcuuUU2Rul4ZfQFzjDE0NyTLUbr0
         m+kL0Qe7GF3q31zyFNOdL12oh1j63P4UPgcgIdiyeAQARaTQgx6K9QyiIB5RvZf4YmIh
         CJEr0P1IV2hGYVysEK51liw6T8vETv55esUtRSQczoEXiT6cD+ooPrRLyL3MXqNyPK1A
         MK8d4F1mtf/VeEr4K2NvcfK/mdMpicS84YG/GQrUVlVOtj8mEJ4WJHiEqXtFW5y4T6sF
         ZOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771604874; x=1772209674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TRre0GfSkQVtFzIahxUylbiw/llWCZvTNVURs/TgMk=;
        b=VddHBBIbOFZEURIn8ZA+h49XaiYuN5h+7Z9JQeA8X2ng7lMfwzvyf13fUnDxDK6NrV
         23zLOG27KdAk/ijrkjIu7rl1NlRg8OKodJwFkmCEvPpue+j8IGTTIRH+mYatjpfZPK5N
         BYUG3RJZMfs03kwj+xcaVFl6QdS/6Rehhs4QppaYzRFwiIR+yh5OKXG8MpkIzRwS75cF
         rmcMCJ5VfxeItdMvw6EI5DdP7wxW3LzRl1lUub2+0yjC1eTC24LlYKfLYBhNhnLEoqoL
         fbvUTPMhKSZt6gzIVzCql3MqyDQCrbYphor41CkJ3JGTEyUTMzXTPzhVTJ5HTgKJ6BzJ
         WU8g==
X-Forwarded-Encrypted: i=1; AJvYcCWOqFmNt2W2GAor3euSAy1eBx+HXFI/5nmZ9jjc4rWxYZGb9ekCamxMpBEtny62DEqBr3Dh6jCt9oxEpMinL6lkqLdRtZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVHzvHzkXfKbm2kcmWursJ6Sv4pJmCrvGtVu+lReHjLqjQZwh
	chzAHLgjb3XKunC6Wky3PdaC+f+p/CNy92FALZk9iHrjc9xsIQqU8FzvDNJ3KAxk
X-Gm-Gg: AZuq6aJXvB0Kt7BUzugDw3l1kkOvPSxlEfgdFG6W213qaqdXU//5l2nNSGvgmzGPdKF
	NxcA6cqWeyqqVjqX9qWRuMPrY7nvFgx3RtV6vxA9YBvDIEpkGhSQmPZTDL60Ersi6dG9/XLezBp
	jZ1Z37jcAfL2iPjReMNCGpSsCRo2pUWWeoE0ug0C0rKbN+RA4pppyzH//vwKZqrg3oFs0f7iygA
	Y3P0YKWfhKd9pG0CZwGHgzFk8ZR2DPy2G36qsYduXZgJLiq7coLsxuXhsh8MZJHHdX9IXD9Pebk
	kXgdPoZzUnsMUgfkK8Fp7slhXXck5Np4setnWHXWRlEfVi3jMOXW+w/u6Q0dyz4ogzV24ux/7nw
	e1c+VcQ5H1f4zObWRk5d0MI8P8uO/oHmeFq/fxj0W4pDjYDBLhYFSR3rQquLZHqMVOyDlwclr7L
	d/FzrUNA+0GhXSIBmiEpYdSYWY8il5kubM5HbE0jhq9UXxDzDoXfE05149z6c=
X-Received: by 2002:a05:600c:c166:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-483a960a0e8mr1506185e9.15.1771604874080;
        Fri, 20 Feb 2026 08:27:54 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm11994335e9.13.2026.02.20.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:27:53 -0800 (PST)
Date: Fri, 20 Feb 2026 17:27:52 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 4/9] landlock/selftests: Test
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260220.5f431119d04a@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-5-gnoack3000@gmail.com>
 <20260218.aser1cu7Aewi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218.aser1cu7Aewi@digikod.net>

On Wed, Feb 18, 2026 at 08:11:26PM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:52AM +0100, Günther Noack wrote:
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c

> > +	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> 
> fs_test.c: In function ‘set_up_named_unix_server’:
> fs_test.c:4125:9: error: ‘strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
>  4125 |         strncpy(addr.sun_path, path, sizeof(addr.sun_path));
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We should also ASSERT the result to make sure path's length is not too big.

Fair enough, will do, because it's less confusing.

(FWIW though, I think Linux can technically deal with a sun_path that
does not end in a NUL byte. See the long comment in unix_mkname_bsd().
But that's a Linux peculiarity.)

–Günther
