Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93588223DD6;
	Tue, 17 Feb 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318481; cv=none; b=cOMEZcgaFKGSNJzAUpckLnbVkJDojWD61+6jhwS9JJEYc80AoIJfEL7mZnjkuSd33xcWleSCHX11L4cFYALPXmVegT2HhDUWnh9dppePxFMUsSFjF3mq8dBRnPQJCQAGhcie1oB69XNShNnDvEuCh6LWcZr2LHAnMohj22jgrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318481; c=relaxed/simple;
	bh=30FiGb7wpvozzifJWX/UNGsM70woSlPa4RhXFqxqkls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu1TWizp6qoxaPG/UaF9xgAy2eY5WwYdOYy7xjeR20fonG2LkCxp7G1E9mdG6l/VQOAvgt3ZLq3SoUsX1jcs3pHv2UfStWJT1MR54i+FqfMGGQzodbDVdNcaRBssTwiWmrAg9mOdjeeQxGGtOWxXbsWmQ1/DHVUpi3LKFFQYsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbPUV59l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbPUV59l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176F1C4CEF7;
	Tue, 17 Feb 2026 08:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771318481;
	bh=30FiGb7wpvozzifJWX/UNGsM70woSlPa4RhXFqxqkls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbPUV59l2lCWqnDnDE0LhKFSbuZYVWb04n9nC0wg8iWgTy6pCKX7Szt2tUPbHeAfT
	 B7SRX7u0rg35iXidF9ub+YA5WDhPy/srsnRvL8TUYipRinpTZ6enuwIKn/kAgXm55k
	 2ctiU3tWjC03P4xm0FIMwiaa73yrfklKqGX3nmYy88aPkTIjX3Wtn8V2L96glapsyF
	 LeA2SXKxfaVp97BBOuiyPonGJKy8wD64A9c7OTmk1zcbFBXS45nrkzhMwl3heunPAQ
	 9WcB582EoS8qKqzxM6x86+dnhb3EVlk136HBZehTQ9QFWlTY960d2BF1VyjMLrIgH2
	 hmjhhoCCGWjbQ==
Date: Tue, 17 Feb 2026 09:54:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Message-ID: <20260217-armer-wegfielen-ffb2cdc60283@brauner>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
 <19c67cca5d8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19c67cca5d8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>

On Mon, Feb 16, 2026 at 07:53:11PM +0100, Paul Moore wrote:
> On February 16, 2026 2:52:34 PM Christian Brauner <brauner@kernel.org> wrote:
> > All namespace types now share the same ns_common infrastructure. Extend
> > this to include a security blob so LSMs can start managing namespaces
> > uniformly without having to add one-off hooks or security fields to
> > every individual namespace type.
> > 
> > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > from the common __ns_common_init() and __ns_common_free() paths so
> > every namespace type gets covered in one go. All information about the
> > namespace type and the appropriate casting helpers to get at the
> > containing namespace are available via ns_common making it
> > straightforward for LSMs to differentiate when they need to.
> > 
> > A namespace_install hook is called from validate_ns() during setns(2)
> > giving LSMs a chance to enforce policy on namespace transitions.
> > 
> > Individual namespace types can still have their own specialized security
> > hooks when needed. This is just the common baseline that makes it easy
> > to track and manage namespaces from the security side without requiring
> > every namespace type to reinvent the wheel.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > include/linux/lsm_hook_defs.h      |  3 ++
> > include/linux/lsm_hooks.h          |  1 +
> > include/linux/ns/ns_common_types.h |  3 ++
> > include/linux/security.h           | 20 ++++++++++
> > kernel/nscommon.c                  | 12 ++++++
> > kernel/nsproxy.c                   |  8 +++-
> > security/lsm_init.c                |  2 +
> > security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
> > 8 files changed, 124 insertions(+), 1 deletion(-)
> 
> I still have limited network access for a few more days, but a couple of
> quick comments in no particular order ...
> 
> Generally speaking we don't add things to the LSM interface without a user,
> and I can't think of a good reason why we would want to do things
> differently here.  This means that when you propose something like this you
> should also propose an addition to one of the in-tree LSMs to make use of
> it. While the guidance doc linked below (also linked in the LSM MAINTAINERS
> entry) doesn't have any guidance for the LSM blobs as they are generally a
> byproduct of the hooks, if you are looking for some general info I think the
> bits on adding a new LSM hook would be very close to what we would expect
> for blob additions.
> 
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> 
> Getting to the specifics of namespace related APIs, we've had a lot of
> discussions about namespacing and my current opinion is that we need to sort
> out if we want a userspace API at the LSM framework layer, or if we want to
> do that at the individual LSM layer; there is a lot of nuance there and
> while one option may seem like an obvious choice, we need some more
> discussion and I need a chance to get caught up on the threads. Once we have
> an API decision then we can start sorting out the implementation details
> like the LSM blobs.

I might be misunderstanding you but what you are talking about seems
namespacing the LSM layer itself.

But I cannot stress enough this is not at all what this patchset is
doing. :)

All that this patchset does is add new security hooks that get called
whenever a new pid, net, mount, ipc, ... namespace is created, freed, or
when someone wants to change into another namespace. We plan on using
this in systemd to supervise and track services.
