Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEA3FBEB0
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851194; cv=none; b=odIivXz4/NSEmdqN1c/xK2dsV7RqSGxGgHEzjvixzejA8L4woJxWZuEAMVn9YUFcWaW5WO9DxxCk5UTeNuIobWE7WiA92KRl5VM/UiBgcCFy2HrLAR7dZplh6H4c90j6d9AhFUgSChPn4JVbrj5hbpjKYfrZmLzNTSnOYDaIBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851194; c=relaxed/simple;
	bh=0eq3joXe1x9nEYn+TCWWHizf8atXrQHvh7ttETs/PAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ0DakM+6I+yVHaSgJvk6wJ0X3MKmhg2wKOhiuRVN6uZleae9+0aV7CA4ZIzti2eEJ2eQDuDM2yHiZgXcUOpV7KkIQxloAgFKwhLi10maWRQ987GA1+os3GndclJ9hTzyb/GAyDsspr86rwC1u08cFOGwFEqRXI1kyJH9JA84zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uaBO7e3k; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uaBO7e3k"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZ2j6QjvzNxP;
	Wed, 18 Mar 2026 17:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773851181;
	bh=fDFqHu0QczVFjUR1GpfxIvDm499pFRwui2hSz1Keqe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaBO7e3kQTnsZfz5LbRx5f4f6HAHIEjUk1oIzZN/UwTYe/bKJIEu4Bf23SYiJJyL2
	 jjC3UcgAzvsiKKJdtrHxdWGqbgA4f30ZUpvDWaJ5VCcjeFB2R1nyW1ORow72Ohvbqm
	 kx2Ps+55KVtkFfFRzIKFAxMHUxpwMj9w+R7Ch82M=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZ2j1sb5zwFq;
	Wed, 18 Mar 2026 17:26:21 +0100 (CET)
Date: Wed, 18 Mar 2026 17:26:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Justin Suess <utilityemal77@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260318.Jeph6loh9uSa@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
 <abqzXO3MmMXKqXOy@suesslenovo>
 <20260318150559.j04YNDtV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318150559.j04YNDtV@linutronix.de>
X-Infomaniak-Routing: alpha

On Wed, Mar 18, 2026 at 04:05:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 10:14:52 [-0400], Justin Suess wrote:
> > Sebastian,
> Justin,
> 
> > In short: dom_other is a pointer to a landlock-owned refcounted struct.
> …
> > 
> > But we copy the domain pointer, which points to a landlock allocated
> > and controlled object.
> 
> and this is not going away while we are here and preempted after
> dropping the lock? (if the landlock policy is updated/ changed/ …)

I agree with Sebastian, this is a bug, see my original proposal:
https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/
