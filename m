Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708935;
	b=RxYHK6C5biENYfHmsoFaJDKa19LSX52YkvX5JnElFV1Jc2iCv9Lbsr0/7SF7jCCa1Otv
	 HlB2I1aKTuUrA3mcoXb8sEEWdiSJHVwT7YS2Zd8ORdVJEepmf0Iwytjazm+MY+7y7Wl0U
	 +l0DgSxPS/VYD0AyU8lqcyyfphuWkuF6b7ni9Y5OhsxnnOteRFJDnJRaqIcx5OV3SBl27
	 26YsfLkFYvCvkATnotGOCsAxw+ZUZAZ2G/QkdEgiApjMt2+Tbt0xlNnac7Q1oSGQ1Kgx/
	 JxeC12QwVi/PPPDAi58U/S2/8JlLB/KiKGLrqPNszztwy1IbWROoHIdDcqg35b0aybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708935;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qTehDfPNzwUjNcP9cYSYiF6+02tgP2ra+sL/j10HR10=;
	b=gtoORyvvWn8WRBQ4WzV6xq2J+5ugIUCZBIyswOIOe5MGP6aNFGPJ+nPdMLc0RIuP9qzm
	 GpORr4fHqGkKc8/mSm3Ea2a/Sz/3Voo3KF6sQYZy8mnOZW1HzAXADtjskAQiDJhAz0YCj
	 9bnHBUMXYA4pVJ/lqBA7ziMLaZF/4Z84P8VfsugvQaNVUX6WBxPoaxH7zl1/SwX1XUPDc
	 yjChdBglZI622ZABmpndsrfGtpuW1FcUczWZB+MTYy96wdffdXpHmN9By1yhymBU6DTQt
	 9tIKRdkcWoW96Yh82oQWj10Xz/CajZU7ZcDDbmIge2BkD1jcsZW8xmePTNjI06/Q12Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=fiBB9XTD;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4489606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 22:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4489606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=fiBB9XTD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1792708926; bh=I9h9tdKdGcPUZgRr+79Z0rnQgoexEEsUoC5vZDn1gvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiBB9XTDc2wWOgmidANeLuSw9X1fW+d9SZ8delv4U8IC8T2fLG791wcT1iTVObB6l
	 53IHXCaB6YN++JD01/vB4nVKm/BVknsRKPJJvFAFr4tNESjdfQI8s0y36O3WkrX5tV
	 U62MdRcPCJ3sHRGIrzsOt/CwRhksE8NE2yUumDVeBlPoIFA7hnhxMVmNWjsIuo5wb4
	 pJfHmvR6/Pxy3s8DsZVpMd55CaMM/Z56xDpE5o+czhxUPT3YKZBBYOFk9MZJZP64aV
	 zky0hy1bCz6BJPM9gtfDL7DzJ1bxdp6HZZcHPeYSIRWtCnAyy6jV7+zY8Tm32rJvQl
	 1x7C4Q79SYqag==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id F35381793; Thu, 22 Oct 2026 17:42:05 -0500 (CDT)
Date: Thu, 22 Oct 2026 17:42:05 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v4 0/5] capabilities: close the ways around the
 CAP_SETFCAP rule for uid 0
Message-ID: <atqRPZfUUUKzebNU@hallyn.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>

On Thu, Oct 22, 2026 at 06:36:18PM +0000, Josef Bacik wrote:
> v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
> v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
> v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/

Apologies, but I will likely not be able to look at this closely until the
week after next.  When I return, I'll take a close look at the newest
version.

> v3->v4:
> - 4/5: a v2 security.capability xattr skipped the new checks, it was
>   written as is whenever the writer had CAP_SETFCAP over the
>   filesystem's namespace.  It now only does that when the filesystem's
>   root user is within reach, and goes through the v3 conversion and its
>   checks otherwise (Sashiko).
> 
> v2->v3:
> - The setns() check in 2/5 and the ptrace check in 5/5 only apply to
>   namespaces that map the root user of an ancestor within the creator's
>   CAP_SETFCAP, or that have no uid_map yet.  Root users stored through
>   an idmapped mount are left to whoever sets up the mount, so a root
>   task without CAP_SETFCAP can join an ordinary "0 100000" container
>   again (Serge, Christian).
> - 2/5 adds cred_may_setfcap_userns() for those two checks and
>   cred_setfcap_reaches() for the uid_map check; nothing outside
>   create_user_ns() calls cap_setfcap_level() directly (Serge).
> - Fixed the cap_setfcap_level() kernel-doc, @ns doesn't have to be the
>   cred's namespace or below; cap_capable() is compared with != 0
>   (Serge).
> - Picked up Bradley's Reviewed-by on 1/5 and 3/5, not on 2/5, which
>   changed.
> - Rebased onto current vfs.all.
> 
> v1->v2:
> - The state lives on the user namespace now: ns->setfcap_level replaces
>   ns->parent_could_setfcap, and cred->setfcap_level is gone (Serge,
>   Christian).
> - New 2/5: setns() refuses a task whose CAP_SETFCAP doesn't reach as far
>   up as the namespace's setfcap_level.  It applies to every user
>   namespace, not only to those that map the parent's uid 0, because of
>   idmapped mounts (Serge, Christian).
> - 5/5 asks a tracer for what setns() asks for, also when the namespace
>   doesn't map an ancestor's root user, again because of idmapped mounts.
> - Dropped "userns: don't let setns() lend the right to map uid 0", the
>   setns() check covers it.  Its nested case moved into 3/5, which checks
>   the opener and the writer.
> - set_cred_user_ns() isn't touched anymore, so the put-before-use in
>   userns_install() is gone (Sashiko).
> - Rebased onto current vfs.all.
> 
> What it does now:
> 
> Every user namespace gets a setfcap_level when it's created, which is
> how far up the creator's CAP_SETFCAP counted.  If its tasks can write
> file capabilities for the root user of an ancestor, because the
> namespace maps that root user or can still map it, setns() only lets in
> tasks whose own CAP_SETFCAP reaches that far, and PTRACE_ATTACH asks the
> tracer for the same.  The checks on the way to file capabilities then go
> by the namespace instead of the cred: a uid_map write that maps the
> parent's uid 0 (opener and writer), and setting security.capability.
> 
> The visible difference from v1 is the setns() restriction.  A task
> without CAP_SETFCAP can't join, or attach to tasks in, a namespace that
> maps the root user of an ancestor, such as host uid 0, and was created
> by a task that had it.  A task that joins takes on the namespace's
> reach.  Containers that don't map host uid 0, unprivileged users and
> anything with CAP_SETFCAP aren't affected.
> 
> Testing: the v1 flows plus the setns() and ptrace cases, 41 in all, on
> vfs.all with and without the series.  For v4 also the v2 xattr route: a
> task that unshared without CAP_SETFCAP mounts a tmpfs, writes a v2 xattr
> on it, and an overlay mounted from the initial namespace makes a uid
> 1000 user run the file with CAP_SYS_ADMIN.  That works without the
> series and with v3, and gets -EPERM with v4.  Every flow gives what's
> expected, and the only ones that changed from v2 are the five idmapped
> mount and "0 100000" container cases, which are allowed again.  The
> pidfd, namespaces, mount_setattr and ptrace selftests give identical
> results with and without.  The TLA+ model, which has no idmapped mounts,
> finds no violation with the narrower checks, and still finds the setns()
> bypass when the check is taken out.
> 
> --- Original email (v1) ---
> 
> Hello,
> 
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> stops a root task that has given up CAP_SETFCAP from creating a user
> namespace that maps uid 0 and then writing file capabilities in it that
> the initial namespace honours.  The check only looks at the task that
> creates the namespace, so if somebody who did have CAP_SETFCAP created
> one, there are still several ways around it:
> 
> - setns() into their namespace and write uid_map from inside (patch 2)
> - write "0 0 1" through a uid_map fd that they opened (patch 3)
> - setns() into a namespace of theirs that already maps uid 0 and set
>   security.capability there, no map write needed (patch 4)
> - ptrace one of their tasks and have it do any of the above (patch 5)
> 
> On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
> from its permitted, effective and bounding sets and, through each of
> these, ended up with a file that a uid 1000 user execs with
> CAP_SYS_ADMIN in its effective set.
> 
> Patch 1 adds cred->setfcap_level, which records how far up the
> namespace tree a task's CAP_SETFCAP reached when it entered its
> namespace, and patches 2-5 check it.  Patch 4 is the check that closes
> the class, the map patches make the uid 0 map rule mean what
> db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
> the target is entitled to.
> 
> This does change behaviour.  Everything new is -EPERM:
> 
> - a task that entered a namespace without CAP_SETFCAP outside can't map
>   uid 0 of the outside or write fscaps for that root user anymore
> - a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
>   task without it to map uid 0
> - if a privileged task maps "0 0 1" from the parent for a namespace
>   created by a task without CAP_SETFCAP, that namespace can no longer
>   write fscaps honoured outside
> - PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
>   CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
>   root user
> 
> Rootless containers, privileged runtimes writing the map from the
> parent, nested unprivileged namespaces and containers that don't map
> host uid 0 aren't affected.  The ptrace check is one compare for
> targets in the initial namespace and in namespaces entered without
> the capability.
> 
> Testing: a set of flows run on the base and patched kernels, every
> bypass route above gets -EPERM with the series and the 16 legitimate
> flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
> proc selftests give the same results before and after. Thanks,
> 
> Josef
> 
> ---
> Changes in v4:
> - Link to v3: https://patch.msgid.link/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com
> 
> Changes in v3:
> - Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com
> 
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com
> 
> ---
> Josef Bacik (5):
>       userns: record how far up CAP_SETFCAP reaches
>       userns: don't let setns() lend CAP_SETFCAP
>       userns: check the opener and the writer before mapping uid 0
>       capabilities: limit fscaps to where CAP_SETFCAP reaches
>       capabilities: don't let ptrace borrow CAP_SETFCAP
> 
>  include/linux/capability.h     |   7 ++
>  include/linux/user_namespace.h |   7 +-
>  kernel/user_namespace.c        |  37 +++++++--
>  security/commoncap.c           | 183 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 214 insertions(+), 20 deletions(-)
> ---
> base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
> change-id: 20261006-b4-setfcap-userns-d63185a31ce3
