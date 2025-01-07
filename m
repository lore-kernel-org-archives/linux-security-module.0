Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F3A50;
	Tue,  7 Jan 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208566; cv=none; b=nn4teaMApyNi5Lt6J7NI7wIP8u8xHm5fCd283oZLWR8WwpZU+3iiG8BFQyuDQ2DdqwyYuB0Bg3KgjHyKjLuAJzyQRKHlSxJjPUeTFK2C9qjlgQNUYCwpwCLqmdTNbPdGXx9UBEQ5P/oR5zgrHg9kHkQZ67aY33Zi/CHcfsbuOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208566; c=relaxed/simple;
	bh=YEIBvLxxL+FT3STBPLqTf/s9XK0487cWowFqLqW5CLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrUKYxlg3Sy9c1Xi2OucHKy/TEb+7JIyYyA3aweH0oEDi3MZsIjXsH6lPNWFD3AmxeRjQ0GXiyi/GV8Zrb+Tn/LGDMq2a1HMTLAk6btOH8bgtN7tSiki6wCmIJ+kX1RJXxBjxz+ar+nSWMQlLkUrmBLNhsYgj2M+JiVlDC3HtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6U7AsLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6U7AsLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE79C4CED2;
	Tue,  7 Jan 2025 00:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736208565;
	bh=YEIBvLxxL+FT3STBPLqTf/s9XK0487cWowFqLqW5CLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6U7AsLAx0qY+vzqfIyXK2bdgwqF5KWclF7AKUwdLftt4ku+PCtBh9y8nJ8CTOghn
	 dZQopTBHf69zEeJDg9pLAt7zuI+z6mFrrZ1wKJ7bqNrJg7ihUZOZg4z9yVMsmMD03M
	 vRQIXqEFhlZFkFrsQKDXOkuwChN31ftrYPrCn5cbY4s8MJUDt4b4SQuDbpa8vzTuxX
	 6a0Ou3PZJ1J9/yEBdboJ2gX64MFITw1InaGWK9VitAgOtiP4C3cIylu/R133SXWig7
	 ihdiRtEnvZyb3HThfM6YCl5nXDynvqy1wkY6KU/SRxj5WAv/W4cVN682TVAjR4G2hP
	 BOfNT8YSuJ9Qw==
Date: Mon, 6 Jan 2025 16:09:21 -0800
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com,
	jmorris@namei.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, serge@hallyn.com,
	syzkaller-bugs@googlegroups.com, Leo Stone <leocstone@gmail.com>,
	mortonm@chromium.org
Subject: Re: [PATCH v2] lsm: check size of writes
Message-ID: <202501061501.26556F56@keescook>
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
 <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
 <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp>
 <202412222126.E70910E7A8@keescook>
 <CAHC9VhRkAbvj=9qe8iWPCtsgkF0zvgP+pbOsUG=VVFcPgO3-jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRkAbvj=9qe8iWPCtsgkF0zvgP+pbOsUG=VVFcPgO3-jQ@mail.gmail.com>

On Sat, Jan 04, 2025 at 11:04:09PM -0500, Paul Moore wrote:
> On Mon, Dec 23, 2024 at 12:33 AM Kees Cook <kees@kernel.org> wrote:
> >
> > If the LSM core did a kmem_buckets_create() for each LSM, and the LSMs
> > were adjusted to explicitly allocate from their own bucket set, that
> > would be one way. Or just for the LSM as a whole (1 set of buckets
> > instead of a set for each LSM). I'd be happy to review patches for
> > either idea.
> 
> If we're doing the work to shift over to kmem_buckets, it seems like
> creating per-LSM buckets is the better option unless I'm missing
> something.
> 
> I'm also not sure why the LSM framework would need to call
> kmem_buckets_create() on behalf of the individual LSMs, can someone
> help me understand why the individual LSMs couldn't do it in their
> init routines?

When we moved stuff around for stacking, we moved other allocation
duties into the "core" of the LSM, so it just seemed reasonable to me to
do it again if this happened.

> If it is necessary for the LSM framework to create the buckets and
> hand them back to the individual LSMs, I would suggest adding a new
> flag to the lsm_info->flags field that a LSM could set to request a
> kmem_bucket, and then add a new field to lsm_info that the LSM
> framework could use to return the bucket to the LSM.  LSMs could
> opt-in to kmem_buckets when they found the time to convert.

Yeah, agreed. Since allocations would need to swap kmalloc() for
kmem_bucket_alloc(), we could also create something like lsm_alloc() and
hide everything from the individual LSMs -- the core would handle
allocating and using the buckets handle, etc.

Does anyone want to make a series for this? I am not planning to -- I'm
focused on the per-site implementation.

> > I think per-site buckets is going to be the most effective long-term:
> > https://lore.kernel.org/lkml/20240809072532.work.266-kees@kernel.org/
> >
> > But that doesn't exclude new kmem_buckets_create() users.
> 
> Is there an update on the per-site buckets?  I agree that would be the
> preferable solution from a hardening perspective, and if it is on the
> horizon it may not be worth the effort to convert the LSMs over to an
> explicit kmem_buckets approach.

I haven't had a chance to refresh the patch series, but the implementation
still works well. Besides some smaller feedback, I had also wanted to
make the individual buckets be allocated as needed. That way if something
was only doing allocations in, say, the 16 to 128 byte range, we wouldn't
lose memory to track the (unused) higher order bucket sizes.

I expect to send out the next revision after the coming merge window.

-Kees

-- 
Kees Cook
