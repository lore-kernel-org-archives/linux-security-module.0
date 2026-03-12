Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141173C062A
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310239; cv=none; b=JQvPuta0yZYKX57A2GtkX8nPWcOuPE6F/C7eeC7+FtWjz8AgLhR1gt0q2Fw2ZieOWf1ZDl50hLyLlC1ICjdBn8xYlAQdcnOHaqwG//r1HFQLzqcbgffmwQwhhfiiOvF7xuJFbig7SGMs06yG1xf0cgdH/v4eMYXI8SoIM6y48DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310239; c=relaxed/simple;
	bh=s/Q1S9sFlzUy+F3CjPkY8IMMObiEPEXIt8jAQOuMj6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAp1e/DxCwzn4xC7TZrVORv8jOd1X0VIgEx0MHUTSgcLdm7a3SiLHtsZicmysr7bmN/uui7oYuHt8Vu/cYohOTFdQMp+Wtr2kPiIX6UBkklx2n7XbXGDZe/DTDSGTDe9yIXvkut2/sVLbWiHQ1+R6JCvVwe5Vm5qFJAhBRysoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tdmgum2X; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tdmgum2X"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjzt4ZD8zJDf;
	Thu, 12 Mar 2026 11:10:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773310234;
	bh=e8Tq8/AnGAMLJO/hzghc8t6UkkJXb7tnn+Fjuzlt1u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdmgum2XeQb1KJGbdy6U7hfn9lhIw3VGTgDg52slcNiS9UfmzgTWiOp9ZPml8t7T8
	 nf1p+uTAqKgvrXkritZycGH1SL9bvZopvOupgBX7WSNs5hwi0S/zr9CILaRpXAk5Fv
	 k7DiVQIuw1A9Nf6zDuCTmuDuKvJwEstAKwvpLnw0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjzs6tKPzDbf;
	Thu, 12 Mar 2026 11:10:33 +0100 (CET)
Date: Thu, 12 Mar 2026 11:10:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Message-ID: <20260312.eNg0oog8eeHi@digikod.net>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
 <19c67cca5d8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20260217-armer-wegfielen-ffb2cdc60283@brauner>
 <19c6b606f40.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19c6b606f40.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
X-Infomaniak-Routing: alpha

On Tue, Feb 17, 2026 at 12:33:28PM +0100, Paul Moore wrote:
> On February 17, 2026 9:54:42 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, Feb 16, 2026 at 07:53:11PM +0100, Paul Moore wrote:
> > > On February 16, 2026 2:52:34 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > this to include a security blob so LSMs can start managing namespaces
> > > > uniformly without having to add one-off hooks or security fields to
> > > > every individual namespace type.
> > > > 
> > > > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > > > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > > > from the common __ns_common_init() and __ns_common_free() paths so
> > > > every namespace type gets covered in one go. All information about the
> > > > namespace type and the appropriate casting helpers to get at the
> > > > containing namespace are available via ns_common making it
> > > > straightforward for LSMs to differentiate when they need to.
> > > > 
> > > > A namespace_install hook is called from validate_ns() during setns(2)
> > > > giving LSMs a chance to enforce policy on namespace transitions.
> > > > 
> > > > Individual namespace types can still have their own specialized security
> > > > hooks when needed. This is just the common baseline that makes it easy
> > > > to track and manage namespaces from the security side without requiring
> > > > every namespace type to reinvent the wheel.
> > > > 
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > > include/linux/lsm_hook_defs.h      |  3 ++
> > > > include/linux/lsm_hooks.h          |  1 +
> > > > include/linux/ns/ns_common_types.h |  3 ++
> > > > include/linux/security.h           | 20 ++++++++++
> > > > kernel/nscommon.c                  | 12 ++++++
> > > > kernel/nsproxy.c                   |  8 +++-
> > > > security/lsm_init.c                |  2 +
> > > > security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
> > > > 8 files changed, 124 insertions(+), 1 deletion(-)
> > > 
> > > I still have limited network access for a few more days, but a couple of
> > > quick comments in no particular order ...
> > > 
> > > Generally speaking we don't add things to the LSM interface without a user,
> > > and I can't think of a good reason why we would want to do things
> > > differently here.  This means that when you propose something like this you
> > > should also propose an addition to one of the in-tree LSMs to make use of
> > > it. While the guidance doc linked below (also linked in the LSM MAINTAINERS
> > > entry) doesn't have any guidance for the LSM blobs as they are generally a
> > > byproduct of the hooks, if you are looking for some general info I think the
> > > bits on adding a new LSM hook would be very close to what we would expect
> > > for blob additions.
> > > 
> > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> > > 
> > > Getting to the specifics of namespace related APIs, we've had a lot of
> > > discussions about namespacing and my current opinion is that we need to sort
> > > out if we want a userspace API at the LSM framework layer, or if we want to
> > > do that at the individual LSM layer; there is a lot of nuance there and
> > > while one option may seem like an obvious choice, we need some more
> > > discussion and I need a chance to get caught up on the threads. Once we have
> > > an API decision then we can start sorting out the implementation details
> > > like the LSM blobs.
> > 
> > I might be misunderstanding you but what you are talking about seems
> > namespacing the LSM layer itself.
> > 
> > But I cannot stress enough this is not at all what this patchset is
> > doing. :)
> 
> Likely also a misunderstanding on my end as I triage email/patches via phone.
> 
> Regardless, the guidance in the doc I linked regarding the addition of new
> LSM hooks would appear to apply here.

FYI, I just sent an RFC to leverage this patch with Landlock:
https://lore.kernel.org/all/20260312100444.2609563-1-mic@digikod.net/
