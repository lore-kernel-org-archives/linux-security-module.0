Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D91ACE94
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897795; cv=none; b=Pt9Ub2tO9NwepO0YilVbZ9pG97cmEhnEOvjzEpCgtfgTb7XTguRI5d9RuurtZpkcIKbeuEW6dCxhtjI5IWV0OF14JVguiOX1XScpZVvBhbQbThazVhmLjoAH46f0t7pcYtkXQwK1FV32h41JqXOr3BAwk1v/z3huhew4gOTcZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897795; c=relaxed/simple;
	bh=5MPy9H6/MZrSI5ArYOAHM/uP6GCpr9j2aMXesDfOHfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyyzUWcRA05Jm+b00k0Ptm0kmFohimjfyZ9sIR1CNa7yBFg5EkylGCXxyGsEf3LkazUnFm2NuJkoeclGeZI5w4yqfQl09OFC6DCBs04+v81Nq7M7P9cIOHXoYMGCl9EAvn92kayLEX2zcYdicmY+Akz9rT8nddEnpdjN2HJm1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eStHfILF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eStHfILF"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d51e7557faso318645b6e.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897793; x=1719502593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5MPy9H6/MZrSI5ArYOAHM/uP6GCpr9j2aMXesDfOHfo=;
        b=eStHfILFdAyJtdv82IM5qdrXI2p2eqi4igzmgpdJiGtDT5Rdhedqg+omt3GUxshnWN
         DTryzHx5tqrG8z9hq3GQG/IJFUuTuBeD6dYZYvSXaSmcWtZGAu28n5W3TVZJ3Y7iZspl
         A98Kz/wsxXrkcM60F+j85yc5KIuM5LVep4hw7/zHZOAlCgm23t2JUc/Eo70R0Q/M7oSO
         jm32TcTZwJqUFZx8G6pJA9XFEKVswCaayhAe/9/MGfqeIot/1ARoeDhV5/k+l4ibvXrh
         0lGJMJAUooedybmlld0UHN2SFYZIIMxPJOcJHbGubOnVouPEgzoSD8QFKkn9wBwbqnrG
         DucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897793; x=1719502593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MPy9H6/MZrSI5ArYOAHM/uP6GCpr9j2aMXesDfOHfo=;
        b=GiiVEXq51Mom6FYy1yvNb06qGUZwQf1zz5/oDoODB0K6nud6cG3RIO8UKbk1ftg/xn
         8uxJ7UA1GspnLrJVDd0kX+cGXWRHI1jARYQbjt8CMhoDRoOPkk8PqQVYvol9jyxk1JeM
         EaNEjvZ+NG8OQYdZLvveIhk5IG213jhtps71m+MimfLjHx1CETK9eGGFkNitGD8J9Huv
         e3R51NJQhGsp4ooBAp5IkuJMi+AuY765f+51NbXtvRymsjzFo7v6eTx02RIkpE8jquQb
         O0nhaA8gDaXN1CTYhatAfmohqVVUdcrRfJMmbA0cGWmI0gmTsrDQjem7Khiagmrcz4md
         O+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdW8vXK44eRh8GN5leL6/FwFo4vHdZiwrIUDs99aC1cyjLAuQ0xcpkLYl8roVDu7KCAOGydZZFqzEI5EDrqlZ/AwN30TzVxP+hTe8vkW0tSXJhiT6i
X-Gm-Message-State: AOJu0YxejAfvsFrgmO1cCESOfeXxtRBXdIUVkDU0L198HIDfh2dMqUUh
	3UtWkNMkfOq5II4FfhjtJeWo+uzdyXRfqlIPnBOime2q89Czj8P5vk2qKPs73Y4KMX08Aa6Dm0G
	z05/5lOlEvQG0tSKMJ8svSAifmeo=
X-Google-Smtp-Source: AGHT+IH+XGYiBsDbEePvLfP+uFYj0NXt5JHJKNCV7UEeIK+6SbAVLw3cBq5sdIZwv/giGZVuEq4H7JBM+nTigjMtSec=
X-Received: by 2002:a05:6808:30a0:b0:3d2:49b2:c01a with SMTP id
 5614622812f47-3d51bb03794mr6593482b6e.46.1718897792958; Thu, 20 Jun 2024
 08:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
 <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com> <3e40424a-a73c-4258-a796-b5d75de323b6@I-love.SAKURA.ne.jp>
In-Reply-To: <3e40424a-a73c-4258-a796-b5d75de323b6@I-love.SAKURA.ne.jp>
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Thu, 20 Jun 2024 18:36:22 +0300
Message-ID: <CABZOZnSsDadW0WmuSYzZ1H3yE=G586KQTtDUz1CJvwY2ZSye=A@mail.gmail.com>
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I could be wrong, but I thought that supporting such solutions was one
> of the reasons that fanotify was introduced

You're right. Fanotify was invented to solve AV developers' problems,
but it gives only a filesystem monitor with, in my opinion, weak
instrumentary, when the modern EDR solutions do much more than just FS
control: firewall, fs protection, process monitoring, vulnerabilities
scanning, container security and so on.

> Can you explain which ones can't be met using those
> today?

Audit + fanotify doesn't give you control over the whole system, which
good AV/EDR should provide as a feature. For example, now you can not
"pause" the process execution and then "allow" it after scanning, like
Windows defender. You even cannot deny binary file or script
execution, like in my PoC here:
https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/samples/esf/agent.c#L543

Moreover, you can retrieve consistent information from just fanotify
and audit and correlate it because:
- They have a different format of events;
- They aren't synchronized with each other at all;
- Audit is not a reliable source of information, it has some sort of
events that differs or may be or may not be from system to system.

Of course, this is just "another programmers' task", but it could be
better if Linux provides it all from the box, like MacOS.

In my vision there should be only *one* source of security events for
the whole system. All events should be consistent and sequenced.

> Note that a number of the LSM hooks are called from interrupt or while
> holding locks and thus cannot sleep/block.

Yes, I know, thank you. This doesn't seem to be a big problem.

> I don't know the reason, but I think that that is because LSM framework
> did not officially support loading LSM modules after boot, and LSM hooks
> did not receive enough arguments needed by AV/EDR software.

Yep, I'm talking about moving all security logic to userspace, by
allowing some security agent(s) (like EDR or AV) to interact with
restricted API.
In this concept kernel just gives a guarantee of well-written code to
developers and delegates userspace protection to EDR/AV vendors. It's
like a loadable LSM module, but in userspace and not eBPF :)

I believe that there's no need in loadable LSM at all, just a security
agent, which communicates with the kernel. Therefore some of "hooks"
might not be LSM, it can be integrated in the kernel as part of
technology, as it is done with audit.

> I prefer getting kernel code used by AV/EDR software reviewed (and get
> their code tested by fuzzers), by allowing AV/EDR software developers
> to submit their kernel code for upstream.

Of course, it's an obvious thing, but at this step I haven't set up
any fuzzers or checks. It'll definitely be done in case this idea get
approve from community and I'll continue working on this PoC like on
new technology.
