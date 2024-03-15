Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA645011
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518108; cv=none; b=nIICheWmajkiMi0MARBsnLS4ECVKh/r4LF6B5S+QNR4UfoV8MgLly09URyoBD3lQEwfkFFZuUBF5SHB0IzezgLrPH40aDpraIFqtHZtt+/+BpbiNAPXBcCJzvnLQUClmxSFpcd8Wfxz/6GIH1sS/2CEIZuACXd62J8FHlqXj8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518108; c=relaxed/simple;
	bh=OizlHkCa+YZ/+lI67ke2UeFL+4aqsLf07bPkzN9tit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDaMYDDhWC3A/tY3+RLHVhqUolKQ5ymUejH0wBeYgxfNamkg6aKdnkr45iI/ugHOc/In7RxXt8/+NoZj6HTuEEvg0w5kVWHPZigS332WThiGMQ4tzlgcWfLg7+Yi6BdJlvyeHtJ/oyIV+On70jIlH1TS50JnRtJh1TYc5tH523k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1ED758AA; Fri, 15 Mar 2024 10:55:03 -0500 (CDT)
Date: Fri, 15 Mar 2024 10:55:03 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Message-ID: <20240315155503.GA308713@mail.hallyn.com>
References: <20240314022202.599471-2-paul@paul-moore.com>
 <20240315150208.GA307433@mail.hallyn.com>
 <CAHC9VhRWbiPSrLKaykFJ80p-orvxhifxMvN+emygF6Q2y=hf_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRWbiPSrLKaykFJ80p-orvxhifxMvN+emygF6Q2y=hf_A@mail.gmail.com>

On Fri, Mar 15, 2024 at 11:18:38AM -0400, Paul Moore wrote:
> On Fri, Mar 15, 2024 at 11:02 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > > Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> > > way to quickly determine the minimum size of the buffer needed to for
> > > the syscall to return all of the LSM attributes to the caller.
> > > Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > > ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > > such that it returned an error to the caller; this patch restores the
> > > original desired behavior of using the NULL buffer as a quick way to
> > > correctly size the attribute buffer.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/security.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index 5b2e0a15377d..7e118858b545 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
> > >   * @id: LSM id
> > >   * @flags: LSM defined flags
> > >   *
> > > - * Fill all of the fields in a userspace lsm_ctx structure.
> > > + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
> > > + * simply calculate the required size to output via @utc_len and return
> > > + * success.
> > >   *
> > >   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
> > >   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> > > @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
> > >               goto out;
> > >       }
> > >
> > > +     /* no buffer - return success/0 and set @uctx_len to the req size */
> > > +     if (!uctx)
> > > +             goto out;
> >
> > If the user just passes in *uctx_len=0, then they will get -E2BIG
> > but still will get the length in *uctx_len.
> 
> Right, which is the desired behavior, this patch allows userspace to
> not have to worry about supplying a buffer if they just want to check
> the required size, regardless of the value passed in @uctx_len.

To be clear - I was saying that is the behavior before your patch.

(If I'm not wrong)

This patch changes behavior as follows:

Before this patch, there was one way for the user to query the required
size: send in a length of 0, get back E2BIG and check the *uctx_len you
had passed in for the required value.

After this patch, there are two ways - one resulting in -E2BIG as before,
and one requiring uctx_len to be set to a large value *and* uctx to be
NULL, getting rc=0 and taking that to mean look at the new uctx_len value.

> > To use it this new way, they have to first set *uctx_len to a
> > value larger than nctx_len could possibly be, else they'll...
> > still get -E2BIG.
> 
> True.
> 
> > So I'm not sure this patch has value.
> 
> Oh, but it resolves a kselftest failure in a released kernel, that's
> worth a *lot* in my mind.

Sorry, you didn't mention the test in the commit message.  Which testcase?

-serge
