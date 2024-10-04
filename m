Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72879F3
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047474; cv=none; b=E7DMDXnG+ZefaXSEf3AXDbENxo8RwIqjIPNj/0pvZO7LIDK5vrpmXqb7PU0KkVf3MuzbdFchnxmd5wkzdfR56dgFtHzNxVjXmARNQ2HWAspg9PEc7GPY1kp0IRT3BaXQQPI8uBwH/RDf+TalepSAX7+X8TeiSckRFfrwlS23Go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047474; c=relaxed/simple;
	bh=rdbep6rmGySaldTKD7PSnuCCcaargaRxFje/ATvnhJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCPNsPi3/duhjDOKcGIo6iGO9Ml18DJJ+rOTlUSSy0gF2hYIa0R6wWdHyCdriQOMTUzCqgaark8sOhwEFoIW1EUbeTiVtLeHe2F/awYwW4AZTF7/ohU9B1nmI6lsKuANeb5UG7vwMf6Bmsi9zt1CBLZTPFWCduCSrZfO1I7Mtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nfddU1nB; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nfddU1nB"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XKpp30Cpkzwl6;
	Fri,  4 Oct 2024 15:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728047466;
	bh=/iX1rGxw1N5zxUhhGnTQgFkwB+XMIkUOiRqn6BRhh64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfddU1nBLXnzQun3aj2MAN//+yL0oEtq/5pzWm7ezLRKyW5FXKuGwwiJ2xz7uDFRU
	 QKyKdS/JyoQzDXCh1kRkwblkFHvnx0VPR8ZTpBpmTz2reOp4FkKGZu06IO2Iby4/nf
	 +UkCIGuck7L9jTRAEtbY0Cref8hPdpWTm+e2HQto=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XKpp10WXnzT9X;
	Fri,  4 Oct 2024 15:11:04 +0200 (CEST)
Date: Fri, 4 Oct 2024 15:11:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241004.ohpie8Ing5bu@digikod.net>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
 <CAHC9VhSa-Jpqmej=3WsLFvSKWamZjFDwUpLHrJOyxaPPujM6ww@mail.gmail.com>
 <20241003162940.GA848724@mail.hallyn.com>
 <bc8bd0d5-ce58-4146-8bfa-1042c6575290@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc8bd0d5-ce58-4146-8bfa-1042c6575290@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

On Fri, Oct 04, 2024 at 07:50:05PM +0900, Tetsuo Handa wrote:
> On 2024/10/04 1:29, Serge E. Hallyn wrote:
> > Well, this didn't occur to me last night, but what I'd be curious to
> > hear is whether Tetsuo has discussed this with RedHat.  Because unless
> > this makes them say "ok we'll enable that", it still doesn't help him.
> > And I don't imagine them agreeing to enable the CONFIG_TOMOYO_LKM.
> 
> Majority of Linux users I work for are using Red Hat. But I have absolutely

My understanding is that Red Hat's customers must ask for a feature for
it to be available (in a future version), so you should ask your users
to support the request.

I wish Landlock would be available everywhere too, but this requires
some effort.  Even when an LSM is built-in, it may not be enabled by
default and then not available to most users because of the "lsm="
cmdline or CONFIG_LSM...  To protect as much users as possible
(potentially without their knowledge), we have the burden of convincing
distros and other parts of the Linux ecosystems that a security feature
is worth it.

> too little relationship with Red Hat people to involve somebody else into
> this problem. Too little attention/interest to make progress.
> https://bugzilla.redhat.com/show_bug.cgi?id=2303689
> 
> Chicken-and-egg problem here; since TOMOYO is not available in Red Hat
> kernels, I have no room/chance to help/involve with Red Hat community.
> 
> If I implement a subset of TOMOYO that does not refuse requests (something
> like SELinux without the "enforcing mode"), can such LSM module be accepted
> by the upstream kernel? (The "patent examination" is a barrier for doing it.)
> 
> You might think that such LSM module is not a security. But TOMOYO is
> also used as a sort of system-wide strace-like profiler. Understanding
> what the users' systems are doing is useful/helpful for users.

I think an LSM is not the right tool for tracing because it only sees a
subset of the access requests: other security mechanisms may deny
requests before they reach an LSM.  Linux provides great tracing
mechanisms though.

> 
> If one of Red Hat's worries that refusing requests due to broken policy is
> gone, the barrier for enabling such LSM module in Red Hat's kernels will be
> lowered. If such LSM module becomes available in Red Hat kernels, I might be
> able to find room/chance to help/involve with Red Hat community.

The question is about potential maintenance cost vs. ROI, not only
security policy issues.  I guess Red Hat would not care about bugs in
non-default service configurations, eBPF programs, nor LSM policies, but
they will if additional code potentially impacts other parts of the
system and may increase the number of potential bugs, and then the
maintenance cost.  Open source is not free for everyone.
