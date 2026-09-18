Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8444FC32F
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739742; cv=none; b=FqklBN5d1KRFg7Y3OXvBAE9E4plyC3GvKm4osSgItTcu/KmEv4MT8Bw7cAwtVshmHUOjfyd4DIphnDmszWcWNqwOMg52XnYP6VNLkX32eU4BG+iUAh6FvuhZ9LpHj8S7QHBA8QFKkTc6iW5tHTv2bPYpIN51l8jKPAHLTbHmtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739742; c=relaxed/simple;
	bh=OLlEp6HiPmwteNgpfFgTSKTzyM8Nd7EDQkX9u/GVDkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI5xIxCuaJBTeRi8FH+CI4hVAPEIHsg/mgyEfFosINx4LKCys0Q5xjN0XvBagqu7k08h3Hh1whCHAXT0kUACesUOv+Gt8Ka1txAW62NrC+4K3yw5ZhJGRb6OTZhniDdJRkBvKUbGxUazFqVFsZwKyix64sLPClqleX19iJyDiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FcAacEes; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FcAacEes"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmYzm4zfnz18dT;
	Fri, 18 Sep 2026 15:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789739732;
	bh=T3ufC42INIwJA1Uj+mhYOs+cNe4p+Da6IX2vT85Vehc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcAacEeshC0N0Z15PbH5Egdfd10dMLo+C+BJK+ltSZ7oaVRnSSmjtc9SZQQcHWpo0
	 3NtEltXmOXnGlaMd7Q7ypZip1lveJXZmV+S+tiEOfnSSH/fS34KleTVTEuD5zMIl1v
	 x2XiZmVJ0E/kXzciICx9Q8O0Qnt/6z/h2Y4DVomE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmYzk6hXgzcy2;
	Fri, 18 Sep 2026 15:55:30 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:55:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Arnd Bergmann <arnd@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Message-ID: <20260918.dofeC7vahHai@digikod.net>
References: <20260915201036.3527935-1-arnd@kernel.org>
 <20260916084947.6QDy8KZQ@linutronix.de>
 <20260916.shai0tha3IPa@digikod.net>
 <57b5869d-7411-46e8-ade6-6d2a7fea02ac@app.fastmail.com>
 <20260917070915.Ix8TOn5Y@linutronix.de>
 <1192c2df-d39a-4d43-ad57-68b0167759f5@app.fastmail.com>
 <20260917104544.3trW9Jq1@linutronix.de>
 <95e794f6-6ec4-4b3e-bfa8-7edae0ac898e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95e794f6-6ec4-4b3e-bfa8-7edae0ac898e@app.fastmail.com>
X-Infomaniak-Routing: alpha

On Thu, Sep 17, 2026 at 01:36:15PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 17, 2026, at 12:45, Sebastian Andrzej Siewior wrote:
> > On 2026-09-17 12:26:17 [+0200], Arnd Bergmann wrote:
> >> I checked again and found that this is a config that did produce
> >> the issue a few weeks ago, but doesn't today for me.
> >> I found a different config from this week and managed to reproduce
> >> the problem on today's linux-next using both gcc-16.2 and gcc-17.0
> >> from yesterday, so there is still a related issue that is not
> >> fixed in gcc, even though one at least one of them was fixed.
> >
> > Confirmed. I see the warning on arm64 while x86-64 is quiet. The patch
> > fixes the issue.
> >
> > You might need to update gcc bug tracker.
> 
> Correction: I noticed the failing gcc-17 binary was an old one,
> the current snapshot does not produce the warning any more.
> It does seem like the fix was not yet backported to older compilers,
> and seeing that the final gcc-13.x was released, we will
> continue to need the kernel workaround. I assume the compiler
> fix will eventually make its way into the other stable branches.

Ok, thanks for the investigation, I plan to sent a PR next week.

 Mickaël
