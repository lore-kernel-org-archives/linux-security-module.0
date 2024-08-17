Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17B8BE8
	for <linux-security-module@vger.kernel.org>; Sat, 17 Aug 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723910727; cv=none; b=Ne86jDDRVJ0csQuojkb+N9Zx0XnJGXZxDvH8oDeSu4aCfJmBTI7bN44CE7vBSIR+YtAWLBxlhda/5zR3wV6UmHYYyPDgMHQvb/Grt+E8SXJNmNp9XHEXJSH+Wus9oVJz1ZZhRdzv/nvg4RlKYrgyC4/kbJIu/zOi0LXMHM/C5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723910727; c=relaxed/simple;
	bh=4wS9wZSgmNqpZU3hiXgfvkGGfmC4w3gRWJqw8PfIWrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiSAXFev3NBGM0H7BbBTCV+Det57ckEg7sJYjCF/Lv78dFdN4KvR6biIvnZfem4nPU2atxUwDCGIwTjp5+ibSmOQHcm2+4Iq9wwvNSaWK4sRx58HAK17Zi0XmWjg+0d7wmX7gZ9T/BUozx3AzqPD5cKLKFySZhcVPIvsQEDl2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Xoc11i2p; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Xoc11i2p"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WmNkj0BVszS9L;
	Sat, 17 Aug 2024 17:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723910172;
	bh=FW4Rtyh8r6fKpJGsz9C2GsN1N9DDm5fwxdou/Sd1Gf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xoc11i2p2N434ckky24HXkjOzqrVWYsNNl5e/7melw7Ro1aP476Sm1bITVRumqhfL
	 sZLHDOL20OjWkUdxoKsqIKvVDpcRdAFIuR0gTMTk19niDAGcyr9bfhiW+gQ89jL/7V
	 HeA9Gfz4c8lH7sRgQx5/Zwf+juHaVqA2gpCjb1/c=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WmNkh27S2z9Yt;
	Sat, 17 Aug 2024 17:56:12 +0200 (CEST)
Date: Sat, 17 Aug 2024 17:56:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: landlock@lists.linux.dev, oss-security@lists.openwall.com
Cc: Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-security-module@vger.kernel.org
Subject: Landlock Houdini fix: CVE-2024-42318
Message-ID: <20240817.shahka3Ee1iy@digikod.net>
References: <2024081754-CVE-2024-42318-f0c9@gregkh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024081754-CVE-2024-42318-f0c9@gregkh>
X-Infomaniak-Routing: alpha

Hi,

On July 24, Jann Horn reported [1] a security issue in Landlock [2].  He
provided a fix and a proof of concept.  Many thanks for all this work!
He discovered a logical bug that makes it possible for a process to
escape its sandbox and bypass any Landlock restrictions.  This is due to
a missing LSM hook implementation for the special case of keyctl(2)'s
KEYCTL_SESSION_TO_PARENT.  This issue is now identified as
CVE-2024-42318 [2].

[1] https://bugs.chromium.org/p/project-zero/issues/detail?id=2566
[2] https://landlock.io/
[3] https://cve.org/CVERecord/?id=CVE-2024-42318

The issue was fixed a few hours later [4] and we developed a dedicated
test [5] to make sure the fix works as expected and that the issue never
happens again. This was merged in Linux 6.11-rc1 [6] published July 28.

[4] https://git.kernel.org/torvalds/c/39705a6c29f8a2b93cf5b99528a55366c50014d1
[5] https://git.kernel.org/torvalds/c/cc374782b6ca0fd634482391da977542443d3368
[6] https://git.kernel.org/torvalds/c/86b405ad8d0d2994a7ffbacb8fcf83be8afb952c

The fix has also been backported to:
- Linux 6.10.3 (released on August 3)
- Linux 6.6.44 (released on August 3)
- Linux 6.1.103 (released on August 3)
- Linux 5.15.165 (will be released in a few days, but in the meantime
  you can cherry-pick
  https://git.kernel.org/stable/c/0d74fd54db0bd0c0c224bef0da8fc95ea9c9f36c)

This vulnerability only impacts sandboxing put in place by Landlock, but
the kernel is not at risk, nor system services.  The impact is limited
thanks to the stackable LSM infrastructure.

To fix this vulnerability, only the kernel needs to be updated, not the
sandboxed programs which will automatically be well-sandboxed with an
up-to-date kernel.  Sandboxing with Landlock is really an investment to
leverage current and future Landlock features.

To exploit this vulnerability, an attacker needs to have full code
execution including the ability to perform arbitrary syscalls,
especially keyctl(2).  Complementary security mechanisms can be put in
place to avoid arbitrary code execution or arbitrary syscalls (e.g.
with seccomp filters).

To test the fix, here are simple steps to run on an up-to-date kernel
source tree (Linux 6.6.44 to run these tests with an unprivileged user):
  make alldefconfig
  make TARGETS=landlock kselftest-install
  ./tools/testing/selftests/kselftest_install/landlock/base_test
  # The global.cred_transfer test should pass.

Landlock is a defense-in-depth security mechanism.  Even if it is
already useful to protect users and applications, it should not be the
only security layer for the system, mainly because it is not a full
feature access control system yet.  As explained in the documentation
[7], some actions may not be restricted yet, which may also be the case
for other security modules.  We are working to extend the access control
types [8], but it takes time and resources to build a new unprivileged
access control system properly handling Linux specificities.

[7] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
[8] https://github.com/orgs/landlock-lsm/projects/1

Looking at the other side, it is interesting to note that Landlock can
also limit the impact of similar potential vulnerabilities affecting
other access control systems.

This issue also started a discussion to improve (or remove) the
KEYCTL_SESSION_TO_PARENT special case [9].

[9] https://lore.kernel.org/r/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com

We are two official reviewers for Landlock, but contributors and other
reviewers such as Jann (who previously reviewed the initial Landlock
code) also work on making changes as safe and secure as possible.  The
Linux kernel needs more eyes, time, and experts to proactively find
these kind of issues.  If you are interested, reward programs [10] may
help.

[10] https://alpha-omega.dev/

Regards,
 Mickaël
