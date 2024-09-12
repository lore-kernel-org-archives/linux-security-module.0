Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2081A7265
	for <linux-security-module@vger.kernel.org>; Thu, 12 Sep 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145506; cv=none; b=ovhiQjiuF9CAhxbTQIyR7GHMUFEb7Wv6SRYlwzuLmH6T+mkZsWko7+YeWfmwU396Dy3BjtilWlPlcHAX15N5PGJ8YMPLB/6LbIZ93t7i9XrKf987n0wHY0bWbEDLPrERzKzq2ABsdIFM1RUZ/CV3b3ARMmUG3xcj6l9Etb/iIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145506; c=relaxed/simple;
	bh=+s4cuWV9FCCV9kiSXQStJDVMi0ZGdbkjYyuMGpZLoOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr+cWRBhC5hMuhpyh21woS8Wde03ZhPrqoACoYSW5Ixcst8tn3W2ctCr0wZLX1Swy9RlHj2gYUeBSP8rkP6pN51+M81DyQhwnZtmZHTXYDmHpYolUcyvYkoxWc1ddDIHKR8lzwq2lxra36AGKqznqryp45n08TGcDMihBp4EnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hQ+9/jWR; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hQ+9/jWR"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X4HPg4kqyzFTL;
	Thu, 12 Sep 2024 14:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726145495;
	bh=MzPZaWCk9rvJ+Krjp/BYLyr4/9IRkRBCVaUs47HsSns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ+9/jWRLB6fSjcbjyJ3ZgZVtnDYdvGoFn+QSDDoakC0TJ69jaA4gLd4qOLT/it9C
	 tiv9FfMHRA9QPK01WiUD8ekW4ySx3aGif2Y7zK/TbJjRC7fp9/IO5IfiBN9QPP/7mI
	 ilAhkYql4sFyiQK1syEp15heZnGiMbVlmMHAukCY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4X4HPf1L79zPxq;
	Thu, 12 Sep 2024 14:51:34 +0200 (CEST)
Date: Thu, 12 Sep 2024 14:51:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/6] landlock: Signal scoping support
Message-ID: <20240912.eix6ith8Zuxa@digikod.net>
References: <cover.1725657727.git.fahimitahera@gmail.com>
 <20240911.BieLu8DooJiw@digikod.net>
 <ZuIynFIRt475uBP5@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuIynFIRt475uBP5@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Wed, Sep 11, 2024 at 06:15:24PM -0600, Tahera Fahimi wrote:
> On Wed, Sep 11, 2024 at 08:17:04PM +0200, Mickaël Salaün wrote:
> > We should also have the same tests as for scoped_vs_unscoped variants.
> Hi, 
> 
> Thanks for the review, I will add them soon.
> > I renamed them from the abstract unix socket patch series, please take a
> > look:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
> Wonderful! Thank you :)
> 
> > I'll send more reviews tomorrow and I'll fix most of them in my -next
> > branch (WIP), except for the hook_file_send_sigiotask tests and these
> > scoped_vs_unscoped variants that you should resolve.
> I will keep an eye on reviews. What parts of hook_file_send_sigiotask
> would need changes?

The file_send_sigiotask hook was not fully covered.  It's OK now, I
reworked this test to fix that with four variants.

You still need to work on the scoped_vs_unscoped tests for signaling
though.

> 
> > On Fri, Sep 06, 2024 at 03:30:02PM -0600, Tahera Fahimi wrote:
> > > This patch series adds scoping mechanism for signals.
> > > Closes: https://github.com/landlock-lsm/linux/issues/8
> > > 
> > > Problem
> > > =======
> > > 
> > > A sandboxed process is currently not restricted from sending signals
> > > (e.g. SIGKILL) to processes outside the sandbox since Landlock has no
> > > restriction on signals(see more details in [1]).
> > > 
> > > A simple way to apply this restriction would be to scope signals the
> > > same way abstract unix sockets are restricted.
> > > 
> > > [1]https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> > > 
> > > Solution
> > > ========
> > > 
> > > To solve this issue, we extend the "scoped" field in the Landlock
> > > ruleset attribute structure by introducing "LANDLOCK_SCOPED_SIGNAL"
> > > field to specify that a ruleset will deny sending any signals from
> > > within the sandbox domain to its parent(i.e. any parent sandbox or
> > > non-sandbox processes).
> > > 
> > > Example
> > > =======
> > > 
> > > Create a sansboxed shell and pass the character "s" to LL_SCOPED:
> > > LL_FD_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
> > > Try to send a signal(like SIGTRAP) to a process ID <PID> through:
> > > kill -SIGTRAP <PID>
> > > The sandboxed process should not be able to send the signal.
> > > 
> > > Previous Versions
> > > =================
> > > v3:https://lore.kernel.org/all/cover.1723680305.git.fahimitahera@gmail.com/
> > > v2:https://lore.kernel.org/all/cover.1722966592.git.fahimitahera@gmail.com/
> > > v1:https://lore.kernel.org/all/cover.1720203255.git.fahimitahera@gmail.com/
> > > 
> > > Tahera Fahimi (6):
> > >   landlock: Add signal scoping control
> > >   selftest/landlock: Signal restriction tests
> > >   selftest/landlock: Add signal_scoping_threads test
> > >   selftest/landlock: Test file_send_sigiotask by sending out-of-bound
> > >     message
> > >   sample/landlock: Support sample for signal scoping restriction
> > >   landlock: Document LANDLOCK_SCOPED_SIGNAL
> > > 
> > >  Documentation/userspace-api/landlock.rst      |  22 +-
> > >  include/uapi/linux/landlock.h                 |   3 +
> > >  samples/landlock/sandboxer.c                  |  17 +-
> > >  security/landlock/fs.c                        |  17 +
> > >  security/landlock/fs.h                        |   6 +
> > >  security/landlock/limits.h                    |   2 +-
> > >  security/landlock/task.c                      |  59 +++
> > >  .../selftests/landlock/scoped_signal_test.c   | 371 ++++++++++++++++++
> > >  .../testing/selftests/landlock/scoped_test.c  |   2 +-
> > >  9 files changed, 486 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> 
