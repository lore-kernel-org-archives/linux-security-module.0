Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D293D1CAA;
	Wed, 25 Mar 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442077; cv=none; b=fm5vRtFPVM+USO6oJMFCv3KQ7v3vghZNIwAYtGJRr8Xz0RdNYRZS6HSK8Lm7OoqFLIE78hidkEtu6ORLpAVW19Eu+KHLANxyoe2rdiM/mfdzPEDyPyKu39ubzlFeFD7DfqciKczMBmaLkyDO0G1B5KO48URgpbz3ZuO2dJQS4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442077; c=relaxed/simple;
	bh=0jxo8TsiYhf8iOrlyqcK8vwA9UbheNxgKgSsRjFIh+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS+bm6dXvlc6rBClLPTDMWowY0cDOoxb5NZTCbf9okc+ZxSHDy88kTvSjE+id50r5lBVOf2Gp41aVYqfDD/h60B61JNNDj+qQkdWBcFjpgeKXVCxt/6xz0jqdqHT1H655FLg2q6F0g+y34PsKhb0WBgqVEQh3/+lStpbcPbQtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYGcX/fj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYGcX/fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA471C4CEF7;
	Wed, 25 Mar 2026 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774442076;
	bh=0jxo8TsiYhf8iOrlyqcK8vwA9UbheNxgKgSsRjFIh+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYGcX/fjiqjsRXmLCI+1mhF/5U0cBXoy3L26s6rJh+rJ0K7Rg0sWS1RruvSDPYzne
	 H7nlDVCRZP/osaW8OL7uXIb4GGyDysDG1b3VHcrrl3unoCyod50YCl5xNYfhlP+Oxr
	 plD2ZkOgL0+MtTzs9gAeXd6upLXgxXEb45uY/CzUEHY7BX9vSIDiykO2dUlxFbH3eE
	 7Qd1q6v7GPut2t1Cb9hD/hAz+x3poPqAg4nYla9kREOh9VrTsLzd4iV8MAzv9b3Jjn
	 21+7ecrjqhpXTFoogbDhvUh9K2cYE2F3L4lmV46krM+idCASnMS0kjRpStpPz0QhAd
	 PlWvYT87rkl2g==
Date: Wed, 25 Mar 2026 13:34:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/11] Landlock: Namespace and capability control
Message-ID: <20260325-ausmerzen-wenngleich-7cf068c7bd9f@brauner>
References: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:33AM +0100, Mickaël Salaün wrote:
> Namespaces are a fundamental building block for containers and
> application sandboxes, but user namespace creation significantly widens
> the kernel attack surface.  CVE-2022-0185 (filesystem mount parsing),
> CVE-2022-25636 and CVE-2023-32233 (netfilter), and CVE-2022-0492 (cgroup
> v1 release_agent) all demonstrate vulnerabilities exploitable only
> through capabilities gained via user namespaces.  Some distributions
> block user namespace creation entirely, but this removes a useful
> isolation primitive.  Fine-grained control allows trusted programs to
> use namespaces while preventing unnecessary exposure for programs that
> do not need them.
> 
> Existing mechanisms (user.max_*_namespaces sysctls, userns_create LSM
> hook, PR_SET_NO_NEW_PRIVS, and capset) each address part of this threat
> but none provides per-process, fine-grained control over both namespace
> types and capabilities.  Container runtimes resort to seccomp-based
> clone/unshare filtering, but seccomp cannot dereference clone3's flag
> structure, forcing runtimes to block clone3 entirely.
> 
> Landlock's composable layer model enables several patterns: a user
> session manager can restrict namespace types and capabilities broadly
> while allowing trusted programs to create the namespaces they need, and
> each deeper layer can further restrict the allowed set.  Container
> runtimes can similarly deny namespace creation inside managed
> containers.
> 
> This series adds two new permission categories to Landlock:
> 
> - LANDLOCK_PERM_NAMESPACE_ENTER: Restricts which namespace types a
>   sandboxed process can acquire: both creation (unshare/clone) and entry
>   (setns).  User namespace creation has no capability check in the
>   kernel, so this is the only enforcement mechanism for that entry
>   point.
> 
> - LANDLOCK_PERM_CAPABILITY_USE: Restricts which Linux capabilities a
>   sandboxed process can use, regardless of how they were obtained
>   (including through user namespace creation).
> 
> Both use new handled_perm and LANDLOCK_RULE_* constants following the
> existing allow-list model.  The UAPI uses raw CAP_* and CLONE_NEW*
> values directly; unknown values are silently accepted for forward
> compatibility (the allow-list denies them by default).  The Landlock ABI
> version is bumped from 8 to 9.
> 
> The handled_perm infrastructure is designed to be reusable by future
> permission categories.  The last patch documents the design rationale
> for the permission model and the criteria for choosing between
> handled_access_*, handled_perm, and scoped.  A patch series to add
> socket creation control is under review [2]; it could benefit from the
> same permission model to achieve complete deny-by-default coverage of
> socket creation.
> 
> This series builds on Christian Brauner's namespace LSM blob RFC [1],
> included as patch 1.
> 
> Christian, could you please review patch 3?  It adds a FOR_EACH_NS_TYPE
> X-macro to ns_common_types.h and derives CLONE_NS_ALL, replacing inline
> CLONE_NEW* flag enumerations in nsproxy.c and fork.c.

This all looks good to me, thanks! I'd really love to see this go in.
