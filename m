Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61916F27E
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967087; cv=none; b=Le2jM5zlbHfaTFJDO4y643PMFY4WCov5huMrpiCEk2gYEzZMpjC6m0Y9gqUebGn5zBm/R5X9npSS65kcDeWTWRPUo9D59e/gjaNzrN8ojkLHmhPIWbHIu/YL9jAIe1oJ0n+OlKX5wcK+Ne/C7VQ9AwacA1/mDCeF/CZD74Ooc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967087; c=relaxed/simple;
	bh=A7rWod1mPpDnJHEONIPO07HoWnY59UHJAGZd4q7mnMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcRFmLdFMRII3dOseWWO8J7pgzDx8hRuc5FLoCmnLa2GvgxQBHCkxsKCox7hEqZA9yH3mOtyb/25NGeMgug+ciXKDQh2E0Sgv9WbbrZjMwMHPCsgWZinmptrkv6nKugRyyxX6b1BU70piZjjElwl30FOodXVN8CuZjnNXOgh6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jrxo9HVE; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrxo9HVE"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4ef3cc03000so451946e0c.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718967084; x=1719571884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7rWod1mPpDnJHEONIPO07HoWnY59UHJAGZd4q7mnMs=;
        b=Jrxo9HVE+Ya05c99qeNCtWdNuU1F7V0BzqlEqK+p8uObZ4X7Cqa6/xJQSJ5mRzxxRa
         d0JsJPwTD8hXl7HS1/NUMj/xLqvUQ17nhcekU/bPE7YKVh9gqpOljQk+/DPu0IaxMwQb
         Wh2Y5sva+nAteKAGsSEkBtATTrhWwK7pmKojxDnrLNzZBCi6/NBBcvYYdKfcVQNr8AkY
         wOp27/nfUNaZGKaFmXpwKAuxSIjBKOlitvhBmDAIqoEKcCUASpMjHLnG8+J69B/GsAzZ
         S/ZZnKu/0AgE5gCcatxn2MVkCtaoOJOXG5d7xVrEQ+pMP0LQ3/HPjDVusFZZgqNK6uo1
         I0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718967084; x=1719571884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7rWod1mPpDnJHEONIPO07HoWnY59UHJAGZd4q7mnMs=;
        b=fzKXNd67z+IdYQsrJozQmsX2lOUHlH0r8fiMG/CacqxIo2CQ12k7y3JJqKcFg3n9gk
         Ji4fgPfXZRiqD+mSn1+kpqbIck7Xs8NAOAf5dFpcCowzhFaUs2QFNpZF6iHsqBu2IUKo
         I/luPFvhsL2krVOcqoojdv0t4vCLD8kVlSEi/opVhLRm5nGD0MqtvGNazFut36sMvPGR
         naZlZ+epF2oCVonyJB9z8xJf5QKP0Uas5sLoMD4b6+dv0CtKaKqEATBPsh5sipu6czSo
         XSO0I5Ly2r7EJrca0fJaGfkdYbeUuMNjhtsMMjtNPDt6SMgmLauRI+TMdi2oBd5viJMP
         CP3w==
X-Gm-Message-State: AOJu0YyCdvfkjw40XpIqhS6bBHWykTBpviAi5Gm9CHYNgxf/r+7h6epm
	jozoXqVo+5Xt5QWrJYOnDIo78mMRBFLav1kz4fuGhl9+28c1swpBgNrCtC/qE/9+QBxFARO/o1S
	/HmIG/lS2lViAxCFqrjOMwx/rtAYrNTCr
X-Google-Smtp-Source: AGHT+IH2CJyUlwTjV6JXe9aKopDm8CiRs5YHr9/EbLcRcTawpoTyWTi6thAcgfsPH2+SF0doY5Kh57uynM1sfI7Wbco=
X-Received: by 2002:a05:6122:250e:b0:4d3:45a2:ae53 with SMTP id
 71dfb90a1353d-4ef27845548mr8630847e0c.16.1718967084278; Fri, 21 Jun 2024
 03:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
 <9b672b38-f580-4278-be20-9b9ca1f0cccf@schaufler-ca.com>
In-Reply-To: <9b672b38-f580-4278-be20-9b9ca1f0cccf@schaufler-ca.com>
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Fri, 21 Jun 2024 13:51:13 +0300
Message-ID: <CABZOZnSeh49tBoBAe+Ku42_=xTk95uAm2NQTancvUE4JjBedCQ@mail.gmail.com>
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please don't assume that everyone knows your abbreviations.
> Audio Visual / Editable Data Record.

I'm sorry for that. Of course, AV - Antivirus, EDR - Endpoint
Detection and Response.

> "Consistent" is hardly a term you can use to describe Linux security events.
> Is binding a socket to a port a security event? Where is the security event
> when using io_uring?

Under "consistent" I mean "has a unified structure". Currently all
security mechanisms in Linux have a different events format and it's
an additional task to read, parse and transform it to a unified view.
The assumed list of security events can be found at
https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/defs.h#L73

> A comprehensive set of events is likely to overwhelm any user space
> collector.

I'm definitely agree. The kernel in my vision must define what
security events are, as it is done with LSM. Userspace should have a
restricted set of security events, it shouldn't know about any kernel
internals. Each event should be a kind of abstraction above what
really happens. There is a good example of real-life implementation:
https://developer.apple.com/documentation/endpointsecurity/event_types.
For my vision of linux security events in userspace, please, look the
link above thought.

> "Consistent" is hardly a term you can use to describe Linux security events.

Yes, and this is a bad thing, which I want to fix.

> Is binding a socket to a port a security event? Where is the security event
> when using io_uring?

Socket binding may not be a security event itself, but a listening
port for a network connection is. And it doesn't matter how many steps
are included to a port listening itself. Opening socket, setup,
binding should be converted to a single event, that says to userspace
agent: "Hey, this process is trying to listen to the socket for a
network connection. Do you want to allow this action?".

> Performance concerns (locking, sleeping and a host of others) are
> likely to prevent this.

It's not an unresolvable task. MacOS and Windows solved this issue.
Anyway, users should have a choice between security and performance.
All modern security solutions in any implementation already affect the
linux performance.

> If the kernel's policies, mechanisms and structures were more consistent
> you might have a chance at this.

I think that's a work I (and even probable we) should work for. As a
better OS Linux should provide userspace stable structured security
events.

> User-space arbitration of kernel events won't work. It's been tried
> repeatedly. I started seeing it in the early 1980's. It always devolved
> into a kernel bolt-on, with sub-optimal performance and versatility.

Can you give examples, please? I don't remember early '80, hah, I want
to get to know about previous attempts :)
I don't be sure if this is impossible. As I mentioned before, Windows
and MacOS are done with it. Anyway, I think that users must have a
choice.
