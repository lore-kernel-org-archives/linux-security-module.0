Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC96298CC4
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279470; cv=none; b=KqpvpWcey0WT1FUMkoIvxFkOXeqQxLQtuBrrczPBe5/6yjCnqzPuAtpqZLXomLCuO++7lR3jOfykHjEphqd/y8QtS1JexwzWU3pJZoEWl9QiJll7RN9KRpa2YTqK9mq1LMaNaVS2SW/aNP7dH6k5JmpBx3hN8eBMjdS8st8u+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279470; c=relaxed/simple;
	bh=LUqy74PciZKyOiynXykXAxY1PhBvDPQ7oA/n7UHdnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMJL6oG6HZRL4IvV27ql6UxjxQ509FXi/naUi32td7MECVgYC33n+H+lFI1jcy8eKjlEuWP7dO/cgdXUOOmV2o4MR3ylePWX1W0Ne8FWqvusWpRVegxYkZCxbtrWnTnEwIuEihf/sjneYzugIvF8BA0l7ZTt5U961++naxEj4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzMiYssw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzMiYssw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso6476875e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279468; x=1770884268; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qvJPgHgwdmbprTz9V2H3UVFMlz4xa9grffKXsh/r+5Y=;
        b=LzMiYssw+D1dos5qfH8Ll+jUzpyp1nNQuzr0/DEL6zFlEeTSRI6qKQ4yf5GpzmfK5J
         ToSownvFfmds7ZHsJbzfjCRDz5k6HfjOPXeJVFhLbs10/U78YsvF9/xZ6Yp8t1Z+3ewU
         ns921sfwqk1b2YjfwElruI1Av2a5grckb4XLml8yg2KQp8ZgCVF5YKCz2zmt/4YVPtJl
         OCPdckX+6UE9lmyStP1pEgvOybAxBa3StC1Szjnw2iHyyrEWLZGJyF6Ae7+ONFB/Rxzn
         /5MOWDMGBjdZVApAbbnpOofMIlI8bMtDGCD7XxdR0ffI0qZMBFcUd19D0ZQVt84TwNZ7
         4ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279468; x=1770884268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvJPgHgwdmbprTz9V2H3UVFMlz4xa9grffKXsh/r+5Y=;
        b=YFXVTgYvhMHpia9BM0xNBVab0dkCl+pQLh5hl8H89ZaHR3YRHapfbmE9fJFMPvMKGa
         2skOVd6d9I2vt8KKytEQRi25NqY12DEBC3MJZWyZWXY85JuFDShx9FkJb72Rwp/EkjJb
         cs5tH7aZ8tAACK01feTopiKZDtX6JUogtI/EQBgWc7q6/4jOdFnarlixwhJvRd0fP6FD
         8CEknAgt0YQU2p056seTLkXUHhZVRrbQlZXf/3+n4Xk2+je9e1OO9WWYZRhfEHlGkEyX
         i2+ELmVMZxs2Mam7epT96VlVv+fdjl5jxMZZSL+WP3nDmWAYzoo+qiwFWnYAMQS23Hjw
         rizQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIEczoe4B9dP3h0JThezF8uPDuaqLk6bof+bxBmat6aphf3IQ3gcxbFUfDbD1FdyiAW24SKMWSii693ULY6qSvCQKG5tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJaN2vGn5b2/M0PzUQpBgtgIm7Q65cVjKq6M2UjQWxtdlU8Kp
	R5xBtSLo/nM8qQ3cVdLJlwK/MMv0H9CVZjshqtGCnRiTSs69G2o7kiIk
X-Gm-Gg: AZuq6aIVagB8GnCbNE/ubqRHjZuA64YNbd2W1R/507Vnj6R4Xabab/mdC0K6uCTtZcP
	YjzDyVK6XQou7gupLlJgLGdZrm7QRdchPsInwhRUTWGsqTSdWdxIVfWIxFLSvK5OzworKalQYkk
	ZenHhF5dGAkO35JwHY6B10GGeq9SMOcuyZd+XsQkgXWkheYvt+lZZhXrwZViFrd9xhzPeh7+rVp
	B094n2CtEFnDZ8fsGYYc9j3T0u+Fs85MG3UqPRuft7H7XOLwfWS1nUg9a/FrEtmJl5dveZKKaRZ
	oMjW/Zs8l3rr9RTAzMIhTTkjtfMYULkzJnDCIXGWxTwtdJ8kmqJBLX2/v4MckNFr2ZyMJXniKdN
	vAuQNUFsGdndLvmGpRLyxfl+3BNvD7CE1TN5DZ7AOR2tDwZUiwdPMLNbqXftpZjLRr1CYFtkY7y
	lbBsePQHeU5eHdjQn/8eRhNT25e7qDBGU2fUdf
X-Received: by 2002:a05:600c:5491:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4830e935736mr70621265e9.4.1770279467937;
        Thu, 05 Feb 2026 00:17:47 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe53c23sm58695675e9.3.2026.02.05.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:17:47 -0800 (PST)
Date: Thu, 5 Feb 2026 09:17:46 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/6] landlock: Implement
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Message-ID: <20260205.994643fa6da8@gnoack.org>
References: <cover.1770160146.git.m@maowtm.org>
 <c5b090acf2c16f120d340ec376ed3a538d535158.1770160146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5b090acf2c16f120d340ec376ed3a538d535158.1770160146.git.m@maowtm.org>

On Tue, Feb 03, 2026 at 11:12:29PM +0000, Tingmao Wang wrote:
> Extend the existing abstract UNIX socket scoping to pathname sockets as
> well.  Basically all of the logic is reused between the two types, just
> that pathname sockets scoping are controlled by another bit, and has its
> own audit request type (since the current one is named
> "abstract_unix_socket").
> 
> Closes: https://github.com/landlock-lsm/linux/issues/51
> Signed-off-by: Tingmao Wang <m@maowtm.org>

A note in the context of this patch that occurred to me; While I was
discussing in my head which access bit should be introduced first [1].
I realized that if the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET were to be
introduced first, this might be at odds with our other plans where we
do both the scope and path check in the same hook [2].  The scope
check may be difficult to move once we have started doing the check in
the other LSM hook, because there are other error conditions in
between the hooks.  That only makes a difference when connect()/send()
is denied - if we do the scope check in the new introduced
unix_find_bsd hook in the future, then some erroring connect()/send()
operations may return Landlock's error code instead of another one in
some cases.

If it is not possible to move the check into the other hook, we might
then in the end have to hook into both LSM hooks and carry information
between them, once the other patch set lands.  But the implementation
will be harder.

[1] https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
[2] https://lore.kernel.org/all/aYMenaSmBkAsFowd@google.com/

–Günther
