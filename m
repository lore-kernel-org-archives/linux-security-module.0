Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A01773D
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519230; cv=none; b=tX0bqBv0Cp0xXI11MLjAltNlh75O93bnxxesrzRIWnw0f6cKr1Za7sYMrCLp7I7ZLpDXZuHIU65WN2mBDtdYy3Kswi/oschHywztrcYtua3PLE44yTYOhOhdQI0Q2/RrPdCfo0STSUkbalMJEBmcoxHEqSvS5CBzClVSYTVzdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519230; c=relaxed/simple;
	bh=xDkiRd6e531EwD81sWB8rtZ6uQ0sOBRPuQLKCBlvB2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPgFAM56Hze8iEpSf872Chdo5tNNQXsKv0kWOs07rCNawFPoIAQNx+l5vmS4J40/sjK7sPktWpERSVBBN/JDnAwtRRmGLEAA27IEgmgL9V8yhP521684gjPelhvgGmcWl9o0/SK34GYWjJnmf9O9LEqUTxmz503U6bdJn8Ef4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 2869D625; Fri, 15 Mar 2024 11:13:45 -0500 (CDT)
Date: Fri, 15 Mar 2024 11:13:45 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Message-ID: <20240315161345.GA309097@mail.hallyn.com>
References: <20240314022202.599471-2-paul@paul-moore.com>
 <20240315150208.GA307433@mail.hallyn.com>
 <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com>

On Fri, Mar 15, 2024 at 09:08:47AM -0700, Casey Schaufler wrote:
> On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> >> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> >> way to quickly determine the minimum size of the buffer needed to for
> >> the syscall to return all of the LSM attributes to the caller.
> >> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> >> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> >> such that it returned an error to the caller; this patch restores the
> >> original desired behavior of using the NULL buffer as a quick way to
> >> correctly size the attribute buffer.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/security.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/security/security.c b/security/security.c
> >> index 5b2e0a15377d..7e118858b545 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
> >>   * @id: LSM id
> >>   * @flags: LSM defined flags
> >>   *
> >> - * Fill all of the fields in a userspace lsm_ctx structure.
> >> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
> >> + * simply calculate the required size to output via @utc_len and return
> >> + * success.
> >>   *
> >>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
> >>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> >> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
> >>  		goto out;
> >>  	}
> >>  
> >> +	/* no buffer - return success/0 and set @uctx_len to the req size */
> >> +	if (!uctx)
> >> +		goto out;
> > If the user just passes in *uctx_len=0, then they will get -E2BIG
> > but still will get the length in *uctx_len.
> 
> Yes.
> 
> > To use it this new way, they have to first set *uctx_len to a
> > value larger than nctx_len could possibly be, else they'll...
> > still get -E2BIG.
> 
> Not sure I understand the problem. A return of 0 or E2BIG gets the
> caller the size. 

The problem is that there are two ways of doing the same thing, with
different behavior.  People are bound to get it wrong at some point,
and it's more corner cases to try and maintain (once we start).
