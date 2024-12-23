Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07732C95;
	Mon, 23 Dec 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734931983; cv=none; b=W3sWjy+1SUFBmC63MXVUn5AhkhQZ0Nmi9dhA+KoBok1I6yMgUQLs/0C7eYw5M6xcBfWQJXTit/O0cTnIYXtaff8M7PTVr21LtR204Iefnkn8XJCXK5IBYU/rRCfjmpOA4eTZqRSG9S4yJbPlzvoD0F3f55NgWN5eARIqrC54tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734931983; c=relaxed/simple;
	bh=nUhGpdyo3TxwV88lvip1eJqnVZ8kNkc+r07iMd5e8UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzp3tuHHf4vUIsiGY6zPwTLDaD6H0rtIoIgMFVNCLW7yhGb6yKlg0p6f1cRw4A1OPYH7Y4woF6jlcrY/WikZbzqkBIslX4JzBHTPhXPz5YyIZepRSoLz81aBXai1aYFrJDy1VmIdpaTFjRk091Ten1090Q48bFKqwzg+xLy4avI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKnejo1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKnejo1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733FEC4CED4;
	Mon, 23 Dec 2024 05:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734931982;
	bh=nUhGpdyo3TxwV88lvip1eJqnVZ8kNkc+r07iMd5e8UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKnejo1NxRzUOt+gIT0rY8w4qKHWNNiRFBkNk0kkHGZs0zDz3AvZkZDi5Iy9Is1ie
	 TJU2NuXeQOpiK/hhBODXt574szJ0K4AOAlnwOjwW4WDOW9hdz5Xl3RbWWEIeqtXLQt
	 xgkafSHRLpTJ6acFBthHE2vLAbDssPlVSmcme0jbwS+7LAm0xVQJ9Yt6ERs53Q7uwG
	 cVugeexY5ICDSoB9CM5cgB69NoXVukv63jJArjZWiVmj99K7w6uPddRFxpLzj8Pguo
	 ExS7V+772l0FK2YvBFxHr+4HALU1YMA/DTAB35eRjauWqHyyHUTe9ltFzLXNLvFXSm
	 x68bQh7QBupow==
Date: Sun, 22 Dec 2024 21:32:58 -0800
From: Kees Cook <kees@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com,
	jmorris@namei.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, serge@hallyn.com,
	syzkaller-bugs@googlegroups.com, Paul Moore <paul@paul-moore.com>,
	Leo Stone <leocstone@gmail.com>, mortonm@chromium.org
Subject: Re: [PATCH v2] lsm: check size of writes
Message-ID: <202412222126.E70910E7A8@keescook>
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
 <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
 <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp>

On Sat, Dec 21, 2024 at 10:40:45PM +0900, Tetsuo Handa wrote:
> Hello, Kees.
> 
> On 2024/12/21 19:00, Tetsuo Handa wrote:
> > FYI: I sent
> > 
> > https://lkml.kernel.org/r/014cd694-cc27-4a07-a34a-2ae95d744515@I-love.SAKURA.ne.jp
> > 
> > which makes this patch redundant if my patch is accepted.
> > 
> 
> I got a question regarding commit d73778e4b867 ("mm/util: Use dedicated
> slab buckets for memdup_user()").
> 
> While I consider that using the same slab buckets for memdup_user() and
> memdup_user_nul() is OK, I came to feel that we could utilize
> kmem_buckets_create() more aggressively for debug purpose and/or
> isolation purpose.

Sure!

> 
> I got three bug reports on TOMOYO
> https://lkml.kernel.org/r/67646895.050a0220.1dcc64.0023.GAE@google.com
> and I guess that at least the fix for the first bug is
> https://lkml.kernel.org/r/20241218185000.17920-2-leocstone@gmail.com
> because the syz reproducer includes access to
> /sys/kernel/config/nvmet/discovery_nqn interface.
> 
> If the slab buckets for nvmet and TOMOYO were separated, we might have
> received these bug reports as nvmet bugs rather than TOMOYO bugs.
> 
> We switched to use module-local workqueue if that module needs to call
> flush_workqueue() because calling flush_workqueue() against the kernel global
> workqueues might introduce unpredictable locking dependency. Therefore, I came
> to feel that it might be helpful to add a kernel config option for switching
> whether to use dedicated slab buckets for individual module/subsystems.
> 
> For example, I don't know whether it is worth using a dedicated slab bucket
> for each LSM module, but I feel that having a dedicated slab bucket shared
> between all LSM modules might be worth doing, in order to reduce possibility
> of by error overrunning into chunks used by LSM modules caused by bugs in
> unrelated code.

If the LSM core did a kmem_buckets_create() for each LSM, and the LSMs
were adjusted to explicitly allocate from their own bucket set, that
would be one way. Or just for the LSM as a whole (1 set of buckets
instead of a set for each LSM). I'd be happy to review patches for
either idea.

> Maybe we want a flag for not to bloat /proc/slabinfo output if we allow
> using dedicated slab buckets for individual module/subsystems...

No, I think accuracy for slabinfo is more important.

> What do you think?

I think per-site buckets is going to be the most effective long-term:
https://lore.kernel.org/lkml/20240809072532.work.266-kees@kernel.org/

But that doesn't exclude new kmem_buckets_create() users.

-Kees

-- 
Kees Cook
