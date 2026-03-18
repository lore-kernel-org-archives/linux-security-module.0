Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D361C84B8
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852850; cv=none; b=MivhbN28t7f3j0c1ddnsO+KR9r5MKjtOyhS/muJfx4tHZCO6DFBpWgJSPsY4ueEld8C3ITObmNuKnddj8JD/E9fteTcsFxsdBV/5cLiypyOSR4dYLhga2J0VKzuAXFL17kwMAhk7b1zl5DAIeVE/dSfjyVn1ZBktdhX0+kEEiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852850; c=relaxed/simple;
	bh=vAwOahvXUjte2dKpVh2nLrqrRxfrW3q4I2FmwIV1W4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdGd0NoDhX5jyg9Njjfos1fmgjgPccz/d8CmViB7z+a8Trshog94cxCkXwIe20K6O5aJQWECa88CMkn+Wm3/IK/ApMuk8pEjNrK+jcvZNK95aNayUFwyBNXLA6fZ4QBmQrdDdxJJMXI8qf5VvkLhl9JMJyTFwsX67vf7lHvTezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lVfK8AsB; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lVfK8AsB"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZfd0DCCzd4b;
	Wed, 18 Mar 2026 17:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852840;
	bh=gfDGBgezCSGAWJlQyLNh/e9T2a2TaplCzhXmY7/w7k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVfK8AsBh2jVUF052JoQk7O6nhahDfBuStwmFNjmMQh9w1MntE3fO7Fz5WUB6/NMu
	 GJspL+morp/DYLSG7eOENJjqgdQgquh7j6axDT2i28KPSW8WmZwxgK3bnIJ9Mk1D72
	 VEGQwChwtCCEy6bvV7ciz+g5IZreJlR6pJSnGCI0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZfc2ZFzz72f;
	Wed, 18 Mar 2026 17:54:00 +0100 (CET)
Date: Wed, 18 Mar 2026 17:53:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 7/9] landlock/selftests: Check that coredump sockets
 stay unrestricted
Message-ID: <20260318.bahDieJohf1u@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-8-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-8-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Mar 15, 2026 at 11:21:48PM +0100, Günther Noack wrote:
> Even when a process is restricted with the new
> LANDLOCK_ACCESS_FS_RESOLVE_SOCKET right, the kernel can continue

LANDLOCK_ACCESS_FS_RESOLVE_UNIX (twice)

> writing its coredump to the configured coredump socket.
> 
> In the test, we create a local server and rewire the system to write
> coredumps into it.  We then create a child process within a Landlock
> domain where LANDLOCK_ACCESS_FS_RESOLVE_SOCKET is restricted and make
> the process crash.  The test uses SO_PEERCRED to check that the
> connecting client process is the expected one.
> 
> Includes a fix by Mickaël Salaün for setting the EUID to 0 (see [1]).
> 
> Link[1]: https://lore.kernel.org/all/20260218.ohth8theu8Yi@digikod.net/
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 141 +++++++++++++++++++++
>  1 file changed, 141 insertions(+)
