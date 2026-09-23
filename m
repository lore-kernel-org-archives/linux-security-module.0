Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E460456DF7
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157831; cv=none; b=Rw5Uf/plUsZgTOpOV8glLOHUI/6veAvR5xLyFQFm3l9xRz1mT04TTB1G+iGtEA0prEMHHLqztfm+WO1Y7D88RMAmP1cVnMMEJDQqjEKTUgHGUcg9BBylCuK5KEDiRWxQQNfIiCz3xrLBUkfM8xMHu89b23HkqxtndbBsHX2ZLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157831; c=relaxed/simple;
	bh=PVOIsDn6pcFMAnCEhiCYpLCKy7D9K3ZTe6HdGtIuI10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKloIlp8PC/Q/iFD3SmkILKTt8IYiXcRVtiQEmvfxRmEH/kLhrNg6jNkTjRjIyL4exQ1QI10hLuY2Ba54S5FdwAWVrdOfo5nBIIDE5TFluBy7f/hqWDtZKQd0ELUnbCNV7uFwNf2f+5vuquQrVSnXAW5dqidDt0rpXFp3D+uSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ly8X49xa; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ly8X49xa"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqXbz6w7nzTfW;
	Wed, 23 Sep 2026 12:03:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790157823;
	bh=jo5BAFeQ+LQMNxWpXBTUI1R+keGwdWmCoZUbkfVBPP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ly8X49xaBN00w1Yusa2OTlLmc1kPySCRdt+LFYEYasvgHYTjOB5ZFecuPP7M1L7/v
	 isFSZo6xT4odfBnqvkysYLoITYDBqhMOAxlDwEGc2c7XbeARMxpUL9xKJdBgLuoA8R
	 9+cR6+wgyVsUx+FE3DMyMV1eRfF0Q0nGDMIklb2s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqXby4P0Hzxfk;
	Wed, 23 Sep 2026 12:03:42 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:03:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Message-ID: <20260923.eehieph7UaX1@digikod.net>
References: <20260913221958.839429-1-clusk@northecho.dev>
 <20260914.b8a029f9abb8@gnoack.org>
 <20260914134013.1457130-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914134013.1457130-1-clusk@northecho.dev>
X-Infomaniak-Routing: alpha

Hi Christopher,

I agree with Günther and I'd like to bring, from my point of view, the
most important thing about TTY master FDs: they are mean to send
arbitrary data/signals to TTY slaves, and in most cases this mean inject
keys and then commands.  So TTY master FDs should be seen as a
(legitimate) way to control another process, even if that might not
always be the case.

A case in point would be an SSH or sudo/su command attached to a slave
TTY.  The process able to write on the related master TTY FD should be
considered as privileged as the slave command.  This illustrates why
human-computer interfaces (including TTYs, desktop interfaces...) are so
critical.

Also, just adding these LSM hook changes would break exisiting LSM's
security policies.

Updating the Landlock doc with this rationale is defenitely a good idea.

Testing this invariant is also valiable, so it would be nice to tweak a
bit your test and include it with the doc update.

Regards,
 Mickaël


On Mon, Sep 14, 2026 at 09:40:13AM -0400, Christopher Lusk wrote:
> Hello Günther,
> 
> Thanks for digging into this so carefully, and for the clear write-up.
> 
> Your capability framing convinces me.  Controlling who may attach to (or
> open a master for) the PTY is the right layer, and the master FD is best
> thought of as the capability, the same way socketpair() is.
> 
> You are also right that the series is incomplete as a fix: the same three
> signals arrive through the n_tty control-character path (Ctrl-C / Ctrl-\ /
> Ctrl-Z) that my patch does not touch, and PTYs additionally raise SIGWINCH,
> SIGHUP and SIGCONT.  That reinforces your point rather than mine.  Chasing
> individual signal-delivery paths inside the TTY layer is the wrong layer,
> and a per-ioctl hook would only paper over one entry into a mechanism that
> is working as designed.
> 
> One question, mostly so I have the line right in my own notes rather than
> to relitigate: how do you see this relative to the SIGIO/fowner path that
> 4b80320ca7ed brought under SCOPE_SIGNAL?  My read of the distinction is
> that in the SIGIO case the sandboxed process unilaterally selects the target
> by arming the owner, whereas here the recipients have voluntarily attached
> to the terminal and the TTY driver delivers job-control signals over that
> attachment.  If that is the intended boundary, it is a clean one, and I am
> happy to treat TTY-driven signals as outside the guarantee.
> 
> If it is useful, I would be glad to send a small documentation patch making
> that explicit: a note in the SCOPE_SIGNAL / IPC-scoping section of
> landlock.rst that TTY-driver signal delivery (TIOCSIG and the
> control-character path) is not mediated by SCOPE_SIGNAL, with the practical
> guidance to control PTY attachment instead.  I will drop the task_kill
> approach.
> 
> Thanks again for the thorough look.
> 
> Christopher
> 
