Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C71773D
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520116; cv=none; b=gTBuRhWN9zWNsVgaOBzH+692JrgEtUFPmNmNw1xxWFK+jgAjczrwjYUlTTJNfXYNux/7WqwEC97JQQDswU4QBYeIoRDofyyn8pOytw95rrxKuZPeJggQ+Xt0e4GwNt7r6bkHIMOS2Vp3x3ciimbC7Gc+yKMT+88aszAoY7/1tj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520116; c=relaxed/simple;
	bh=BmTACyeRWYIt+Zg/gwh69HRRM7Amr+agnN1VNya/qcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEDK45NY3rPPDvUKakNW+cWhcDOeoXDtd2tTURJTWfnPskUG6CrAgTCkpc6rELbuTrXkTJAAbvlMcNOfvQ1CBLgorkMj3TnqINWUyYmY46o6E3SILb54XofNx/LYfe6m2kmFR4sLVWFkk6msvwyP8Dyq1yl/cMYsWz+0bccdRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 245AAC12; Fri, 15 Mar 2024 11:28:31 -0500 (CDT)
Date: Fri, 15 Mar 2024 11:28:31 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Message-ID: <20240315162831.GA309358@mail.hallyn.com>
References: <20240314022202.599471-2-paul@paul-moore.com>
 <20240315150208.GA307433@mail.hallyn.com>
 <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com>
 <20240315161345.GA309097@mail.hallyn.com>
 <CAHC9VhS245LRsa3DhdkZ-u3+qvroygsyBm2q5mZWkOW8eOKOdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS245LRsa3DhdkZ-u3+qvroygsyBm2q5mZWkOW8eOKOdQ@mail.gmail.com>

On Fri, Mar 15, 2024 at 12:19:05PM -0400, Paul Moore wrote:
> On Fri, Mar 15, 2024 at 12:13 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Fri, Mar 15, 2024 at 09:08:47AM -0700, Casey Schaufler wrote:
> > > On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> > > > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > > >> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> > > >> way to quickly determine the minimum size of the buffer needed to for
> > > >> the syscall to return all of the LSM attributes to the caller.
> > > >> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > > >> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > > >> such that it returned an error to the caller; this patch restores the
> > > >> original desired behavior of using the NULL buffer as a quick way to
> > > >> correctly size the attribute buffer.
> > > >>
> > > >> Cc: stable@vger.kernel.org
> > > >> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >> ---
> > > >>  security/security.c | 8 +++++++-
> > > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/security/security.c b/security/security.c
> > > >> index 5b2e0a15377d..7e118858b545 100644
> > > >> --- a/security/security.c
> > > >> +++ b/security/security.c
> > > >> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
> > > >>   * @id: LSM id
> > > >>   * @flags: LSM defined flags
> > > >>   *
> > > >> - * Fill all of the fields in a userspace lsm_ctx structure.
> > > >> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
> > > >> + * simply calculate the required size to output via @utc_len and return
> > > >> + * success.
> > > >>   *
> > > >>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
> > > >>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> > > >> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
> > > >>            goto out;
> > > >>    }
> > > >>
> > > >> +  /* no buffer - return success/0 and set @uctx_len to the req size */
> > > >> +  if (!uctx)
> > > >> +          goto out;
> > > > If the user just passes in *uctx_len=0, then they will get -E2BIG
> > > > but still will get the length in *uctx_len.
> > >
> > > Yes.
> > >
> > > > To use it this new way, they have to first set *uctx_len to a
> > > > value larger than nctx_len could possibly be, else they'll...
> > > > still get -E2BIG.
> > >
> > > Not sure I understand the problem. A return of 0 or E2BIG gets the
> > > caller the size.
> >
> > The problem is that there are two ways of doing the same thing, with
> > different behavior.  People are bound to get it wrong at some point,
> > and it's more corner cases to try and maintain (once we start).
> 
> I have a different perspective on this, you can supply either a NULL
> buffer and/or a buffer that is too small, including a size of zero,
> and you'll get back an -E2BIG and a minimum buffer size.  What's the
> old wisdom, be conservative in what you send and liberal in what you
> accept?

But if you pass a NULL uctx, then surely you should send *uctx_len=0.
And that is already handled.

What you are adding is that the user can pass NULL uctx, but a large
uctx_len value.

Perhaps should change my objection, and say that I would prefer the
comment fix to suggest passing in uctx_len=0 and uctx=NULL, and expect
a -E2BIG.  The NULL check can stay (though I still think it should
return -E2BIG).

Because with the current comment update, the user may pass in
uctx=NULL, but the actual rv will change between 0 and -E2BIG
depending on the uctx_len they sent in.  Which is whack, since
the incoming value means nothing.

-serge
