Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44619C555
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613902; cv=none; b=JDe3oOUVcRNMyBfkJSonKfV8kI3E+f/h1INxTetz0G8wg4+rZ2IVTonXSzvTCISh5AXjfJIZXmaubhFLfregxKRlSsGNjR3gBuhuKyG8mqLqoG11VNheMasoloB38GjYMyYTxzdkOLvtC6h0x9Kza4DVljpigEfqCvsdaqn2XFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613902; c=relaxed/simple;
	bh=a4vgyCUilUfBnoPWI19TuBaXml3Lm20oxY72FSpWIzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzEUnqdSMhUlUgpchMzookwhM0b+QApqszYL9nllh4GGjLjIzl4cPCBklApAyFW+BRnDB1xJowhvYCiWzcwdix8tOStXZJSN7D1b9iJLWbfg2+nTSYiHhCNUgTq881issobwihDQKGcXVUPikrYzn4MV1qPW/GzlifvE0/JJxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Fk/oDjd8; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Fk/oDjd8"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXy5j52tgzKB;
	Tue, 22 Oct 2024 18:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613897;
	bh=Fme+A2jYXvcHzY9G4s5D6co+KPiIbBIC0uaiwlaozzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk/oDjd8SrviRSQriZUz4hQfrdo9kbRkBTnNgiWolCVXQ+PRDWTlw9je5OiECY9uH
	 OOSTOWh5UQimIWid7qNhEojf1KvUCB7PfQKUsHg9txE3Tm5gL1jDjbvn0QAASpZ62b
	 c2nYCvT4yBxEocwcbu3XJxAMuAC1SpJverAYrIlw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXy5g5TFXzy9Z;
	Tue, 22 Oct 2024 18:18:15 +0200 (CEST)
Date: Tue, 22 Oct 2024 18:18:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/14] Landlock audit support
Message-ID: <20241022.Shah6itha0bu@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Tue, Oct 22, 2024 at 06:09:55PM +0200, Mickaël Salaün wrote:
> Hi,
> 
> This patch series adds audit support to Landlock.

> This series is based on my "next" branch, which includes these patches:
> https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net

To ease testing, I pushed this series here:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=landlock-audit
