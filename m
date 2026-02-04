Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD823093CD
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240130; cv=none; b=Ws3ja/FgErp0XYkA0grDUQOYm185Zbgev0EJuTmnIIHnW+ozAb7z3zzTh7l5JF2WtjQd6RxYwsLXOJ8f3gwHkrfBM1g6gWFgS6GYT3/lgbQlAP66gJZP+Sm9A87Tpc8nwL3OemUM5bx5h05GZUXUauRecVptW9GpHj34iV+rOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240130; c=relaxed/simple;
	bh=BMkEm1h0yqxGL79B9vL9ribwfVgXcsFGW6l8FQV73ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAKH9vym/aliM9D36jpmUWCLDIPvMLEzdQ43mW1iprYKEHi/u8IX2LBjUkvBlUO/TsBV6FqzAeAm9vGUQ4p8M9g7ChuB1nZrcJAlLFr61sAt31PAo+supGVKZpqpcm0CLSuq/dNgVHDWor+b4zDYGwuya36vlXVJcteXE3fStxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YakFmS/P; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YakFmS/P"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfcb46ffc9so754016a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770240129; x=1770844929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhRyIcVh982aeUAhunNuQefxD1ERKdFkk0A876qdfz8=;
        b=YakFmS/PLZP+mmelh4iJYQBXZTskkLhJ9CC8uGTQKa0wCSWnqlSzhb4VP3qg1786mk
         W6mOD/ROc5OvTrH5Tkr63RUAiAWzRSRdC+wZYwojJpMwqhRVGv38ZJT9+PvkQlx19MB5
         5gPWYcmUfy6m6gfv2+pSoh+6dX/iXvQq4EGTN7WGc2WpVQ1A7BGCJheGgISpNHoOjPHm
         uGWhW8V8qSML4r2VC0Cs8ZKFGA0Bl+/OGIKj7PSIpxSYdZmqRbXXrNRCUbkFfp6GHWGI
         BVPqg/2xZhfuWZLOTdz6LvwIHpWTgMs6BDpZmU7UJRXSE6CBq/XAfTuct96qJk6n3blp
         RJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240129; x=1770844929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhRyIcVh982aeUAhunNuQefxD1ERKdFkk0A876qdfz8=;
        b=HMo5BJifGiCyhV+3nlPeG06fnvRS5a7vVUc8cbb8CB0a52Ho4gZartyjszEzR1RNz6
         g9rVzX7hJTx0U8eoXZ2lBIGEGch1mBIBC36WAsWFMgJgVPIuZX+cFttYaPBgVlGKGHTD
         itYe8eX2NCedbBlNrsv2lH5OOJYuR4nn/lqc5g1tCQn2SDUi+DSpOIKRJvHcy3sSZoU/
         4p1k3PdnEXXXO4DMF/u7Mz/tZxQmJZUjE+5Lv+dajFHAagvG3ROAMiCzO908KOB6jXk2
         RvDmU5GsOh8kvahuPN+ofFYQU5pW3s+vhZWm/cq2AxRIpHTZmlBVk0FEdx1xq8mXGdQc
         QA5w==
X-Forwarded-Encrypted: i=1; AJvYcCV7TyqMtsA4rutuehvrJO+TZkroYZGNr8EJ8yCAJo7bAeDQGEYUZHyd1CIYA0R6bMhC8VJqR8DVJyPvlcorTfhvkHyH+kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURxJcJLO1/hWQ0NNV8BXEY7Z3/opbHeQnQUN3mWz54cdE3BKP
	VeVxa9r49nWqtsDMY2fTLe73qOIEaW7o6ovTdT/gJG5xVX6q3+mFcJsjmb+JwrEHrgU=
X-Gm-Gg: AZuq6aKbc7k/7SW5qE/+IhsEh4Bf+RfQuZMz8/hpLxYM4OvMnxlnV0zbDvNR3cSsHud
	0gh5EbhimhBIhlKjX5JQ9U/7QTZjPweb2KttLI24DPOFwoArxQasqBq1k/3/bjOJIgc3uGkmLMS
	S9V74ki7JcU4RMysbL6WEfzdPVqMB0nW++ghgwlJSpvzjIYIHRWqkJUp9XUjhh57Ipx/zLv8z2A
	P4rrKS5dVEOLYQKJugDp0sLYgr1afMJvw0H/bMC5BtI8yBo9hpKBkTQ4ZNG3lAr3jv0t25igKVg
	6XCpawvewCNP9Bjz0CKfwqWD3aQDw9VboHQ/qUGcAEgmv71g5TptwbYlMcZAWsliWKDsv6hu5Uo
	FP7WE43uyf/lD4dkoVmft2Rupg4KuOPMpZfyf7/EgOYWGckdHZ2qbFsUJi6y4sTzd3jGe
X-Received: by 2002:a05:6808:140a:b0:441:c8a2:ba26 with SMTP id 5614622812f47-462e9ee6fd0mr407092b6e.7.1770240129136;
        Wed, 04 Feb 2026 13:22:09 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d67cf821sm1999909b6e.15.2026.02.04.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:22:08 -0800 (PST)
Date: Wed, 4 Feb 2026 15:22:06 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change
 detection for stacked fs
Message-ID: <aYO4fj0Uw0aUWXOX@CMGLRV3>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
 <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
 <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>

On Wed, Feb 04, 2026 at 01:36:09PM +0100, Roberto Sassu wrote:
> On Fri, 2026-01-30 at 16:39 -0600, Frederick Lawler wrote:
> > IMA performs unnecessary measurements on files in stacked file systems
> > that do not set kstat.change_cookie to an inode's i_version.
> > 
> > For example: TMPFS (upper) is stacked onto XFS (lower).
> > Actions files result in re-measurement because commit 1cf7e834a6fb
> > ("xfs: switch to multigrain timestamps") introduced multigrain
> > timestamps into XFS which changed the kstat.change_cookie semantics
> > to no longer supply an i_version to compare against in
> > integrity_inode_attributes_changed(). Once the inode is in TMPFS,
> > the change detection behavior operates as normal because TMPFS updates
> > kstat.change_cookie to the i_version.
> > 
> > Instead, fall back onto a ctime comparison. This also gives file systems
> > that do not support i_version an opportunity avoid the same behavior,
> > as they're more likely to have ctime support.
> > 
> > timespec64_to_ns() is chosen to avoid adding extra storage to
> > integrity_inode_attributes by leveraging the existing version field.
> 
> Correct me if I'm wrong, but this issue seems to me xfs-specific. In
> that case, maybe it is better to remove the stacked filesystem part,
> which might be misleading.

I'm using XFS because that's a clear example, but as Jeff pointed out in
an earlier email, there's too many file systems to account for. It's
clear from Jeff's prior email[1] that the intention is to stop using
change cookie for change detection for more file systems in favor
of multigrain ctime.

The stacked part is important because AFAIK, if not on stacked file system
the check in process_measurement() line 329 is skipped because
of the last_writer check doing the atomic read on the write count.

That said, I think Mimi pointed out in an email [2] where multi-grain
file systems are impacted regardless of stacked fs or not due to the last
writer check.

I don't recall coming across that in my tests, but perhaps I did that
specific test wrong? To be sure, I created the C program, and on the VM,
created a XFS disk, mounted it on loopback, ran the rdwr program on
"somefile" multiple times, and only got 1 audit log for it, until I
mutated it with touch, and only got 2 hits: original + after mutation
after running the program multiple times. 

I'm not sure what's going on there, so I'll look into that a bit more,
but so far the impact is stacked file systems & multigrain ctime AFAIK.

[1]: https://lore.kernel.org/all/75618d9f454aece9a991d74eaf7ae5160828e901.camel@kernel.org/
[2]: https://lore.kernel.org/all/69540ac3aca536db948b6585b7076946a12ebe36.camel@linux.ibm.com/

> 
> Thanks
> 
> Roberto
> 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >  include/linux/integrity.h         |  6 +++++-
> >  security/integrity/ima/ima_api.c  | 11 ++++++++---
> >  security/integrity/ima/ima_main.c |  2 +-
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index 382c783f0fa3ae4a938cdf9559291ba1903a378e..ec2c94907f417c4a71ecce29ac79edac9bc2c6f8 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> >  #include <linux/kernel.h>
> > +#include <linux/time64.h>
> >  
> >  enum integrity_status {
> >  	INTEGRITY_PASS = 0,
> > @@ -58,6 +59,9 @@ integrity_inode_attrs_stat_changed
> >  	if (stat->result_mask & STATX_CHANGE_COOKIE)
> >  		return stat->change_cookie != attrs->version;
> >  
> > +	if (stat->result_mask & STATX_CTIME)
> > +		return timespec64_to_ns(&stat->ctime) != (s64)attrs->version;
> > +
> >  	return true;
> >  }
> >  
> > @@ -84,7 +88,7 @@ integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> >  	 * only for IMA if vfs_getattr_nosec() fails.
> >  	 */
> >  	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > -				       STATX_CHANGE_COOKIE,
> > +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				       AT_STATX_SYNC_AS_STAT))
> >  		return !IS_I_VERSION(inode) ||
> >  		       !inode_eq_iversion(inode, attrs->version);
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..e47d6281febc15a0ac1bd2ea1d28fea4d0cd5c58 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  	 * to an initial measurement/appraisal/audit, but was modified to
> >  	 * assume the file changed.
> >  	 */
> > -	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> > +	result = vfs_getattr_nosec(&file->f_path, &stat,
> > +				   STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				   AT_STATX_SYNC_AS_STAT);
> > -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > -		i_version = stat.change_cookie;
> > +	if (!result) {
> > +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> > +			i_version = stat.change_cookie;
> > +		else if (stat.result_mask & STATX_CTIME)
> > +			i_version = timespec64_to_ns(&stat.ctime);
> > +	}
> >  	hash.hdr.algo = algo;
> >  	hash.hdr.length = hash_digest_size[algo];
> >  
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 8cb17c9d446caaa5a98f5ec8f027c17ba7babca8..776db158b0bd8a0d053729ac0cc15af8b6020a98 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -199,7 +199,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  					    &iint->atomic_flags);
> >  		if ((iint->flags & IMA_NEW_FILE) ||
> >  		    vfs_getattr_nosec(&file->f_path, &stat,
> > -				      STATX_CHANGE_COOKIE,
> > +				      STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				      AT_STATX_SYNC_AS_STAT) ||
> >  		    integrity_inode_attrs_stat_changed(&iint->real_inode,
> >  						       &stat)) {
> > 
> 
