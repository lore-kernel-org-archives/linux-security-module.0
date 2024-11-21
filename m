Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D51A0726
	for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214562; cv=none; b=SvVZAkkXW55eVW9VDhmvHc116Yhr2PiHO72KRRrZD6NM1JuEMMisHgLColKN/u9rJAtKKHVIL+bBv91hCjs9ANSlv7M0PAnNRCXNMAtwO/6dDgCmvdXUmJ5nKSIlxIwVamQgJMj85SPCSsKM4AuT876zjnxhyD3iVK7+ZePfdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214562; c=relaxed/simple;
	bh=cSewRZ1YbXLnwtyM55ZI2f5x6LBz464aeLGdLK0xUPY=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=FC+vLiwmwULnlHXLHdVZVL4B7bk9IGtVFyzZXFJ5UGblzm1rCoWsSbRDSGw1jHUuR7swer0MH1GsQ8cjF2MYpq0NOS42mX9cywmP9CYR97iPf1QxEgymk0G+BKHWUxaevz3L/GtS9Dlk9PpM6fLCfPMEJvJWmq3QT0btcVRgbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4ALIg9fT011356;
	Thu, 21 Nov 2024 12:42:09 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4ALIg78O011355;
	Thu, 21 Nov 2024 12:42:07 -0600
Date: Thu, 21 Nov 2024 12:42:07 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: penguin-kernel@I-love.SAKURA.ne.jp, linux-security-module@vger.kernel.org
Subject: TOMOYO and runc containers dislike one another.
Message-ID: <20241121184207.GA11007@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 21 Nov 2024 12:42:09 -0600 (CST)

Hi Tetsuo, I hope this note finds your day going well.

The rather lively discussion we had here, after you submitted your
patches to Linus to allow TOMOYO to be implemented as a loadable LSM,
caused us to put some resources into the upcoming V5 release of TSEM,
in order to generalize its modeling capabilities.

As a result of that work, we are now able to implement TOMOYO as a
TSEM loadable module/model plugin that implements the TOMOYO security
model, in an isolated security modeling namespace that is driven by
LSM events that only occur in that namespace.

Essentially a demonstration of workload specified LSM's.  A few rough
edges, but it is significantly beyond a proof of concept
implementation.

We don't suggest that it fixes the problem with Linux distributions
not compiling TOMOYO or AppArmor into the kernel.  It does however
demonstrate that an LSM can be created that has generic modeling
capabilities that can be implemented with loadable modules in a
namespace specific manner.

We can discuss later, why this type of infrastructure may incent
distributions to include it in their kernels.

The TSEM userspace tools have the ability to create a modeling
namespace that tracks a simple process heirarchy or a runc isolated
container heirarchy.  In the process of testing TOMOYO in a container
environment we ran into issues with TOMOYO causing the runc execution
to fail.

We reproduce this in a stock kernel with TOMOYO as a native LSM, so it
doesn't seem specific to our TSEM based implementation of TOMOYO.

We tracked the problem down to the tomoyo_realpath_nofollow() function
failing due to an error return from kern_nopath().

For smoke testing purposes, we are using the minimal default TOMOYO
policy that is used in the absence of userspace policy loading.  Given
we are the farthest thing from experts in TOMOYO this may be a
limitation of that internal policy.

We are testing with runc version 1.1.15 which is the most current
release of the 1.1.x series.

Kernel version is 6.10 something.

The path causing the issue is as follows:

/dev/fd/7

Here are the warning messages that runc spits out:

FATA[0000] nsexec[1291]: could not ensure we are a cloned binary: No
such file or directory

ERRO[0000] runc run failed: unable to start container process: waiting
for init preliminary setup: read init-p: connection reset by peer

Since we can generate this in a native TOMOYO implementation we
thought it may be worthwhile to bring this issue to your attention.
It seems odd that no one would have tripped on this given the ubiquity
of runc based container environments.

We would look forward to your thoughts.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
