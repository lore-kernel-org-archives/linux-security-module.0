Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037D1AD3F5
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894391; cv=none; b=sXnD3iBhCoi2vaOOZ2n2/VIpRm2fFWckC4nYcmUeChhS7jnewEJfObh8yQwbdG2kAwCFRy0avYzjbEeCeIxrEo741AEEtqnvdLOrQblpPwvOITBIRxY8QLG4OPfoiCjKl56hO0IS3sWf4F2LQCQruZwT0HAasok62l7XcEy8KL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894391; c=relaxed/simple;
	bh=2gMxO8NRNj0xQjLYVNQdBl5US4u+CofO2rJ4LNvHL8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lOKwZ/d2yHpbqQjRrLH/OnfX8KuI8PMdENvEZh203fjbFQ3nxh9CmrYZm5Z93qS+KxubvplAcdEJhS1e9cXArLQc79rPpYjBijyjD7A+lE04z4hH4XfMaCxli23XatAs1iZp8tE4zAeS9HEws7eC7Snx0wAgP7kxdoFqEBTa7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45KEdiO0064062;
	Thu, 20 Jun 2024 23:39:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 20 Jun 2024 23:39:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45KEdi5r064057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Jun 2024 23:39:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9978b326-15de-465f-b032-252899526119@I-love.SAKURA.ne.jp>
Date: Thu, 20 Jun 2024 23:39:43 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Yet another vision of Linux security | Endpoint Security
 Framework
To: Timur Chernykh <tim.cherry.co@gmail.com>,
        linux-security-module@vger.kernel.org
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/20 22:40, Timur Chernykh wrote:
> Questions I'm interested in:
> How does the community feel about this idea? Is it a viable concept?
> If all is OK, what should I, as developer, do further? How much kernel
> code outside the LSM module may be modified to keep further merge
> acceptable? (currently not all LSM hooks meet to intercept all needed
> data).
> 
> The general purpose is to make AV/EDR software development easier,
> more convinient, and stable for Linux-based operating systems. This
> PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> based on MAC policy.

I agree that security hooks for AV/EDR software are missing in Linux.
My experience says that customers cannot afford managing allowlist-based
access control mechanisms (such as SELinux and AppArmor) and they instead
choose AV/EDR software for their systems.

The LSM framework (which is using linked list for registering multiple
LSM modules) is about to be replaced with static calls (which reduces
overhead, at the cost of restricting at build time LSM modules which can
be registered). Use of static calls might make it possible to insert more
hooks into the Linux kernel because the overhead becomes negligible, but
kernel code used by AV/EDR software cannot be built into distributor
kernels due to support problem. Therefore, without ability to load
unlimited number of LSM modules after boot, AV/EDR software won't be
benefited with static calls. Such limitation will lead people to invent
a new set of security hooks (or resort to unofficial hacks such as
rewriting readonly data structure) rather than trying to utilize LSM
framework.

I prefer getting kernel code used by AV/EDR software reviewed (and get
their code tested by fuzzers), by allowing AV/EDR software developers
to submit their kernel code for upstream.

