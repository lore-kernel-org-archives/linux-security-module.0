Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E603D903B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233727; cv=none; b=qzx6Zoe5R96HYjgJTg7Icp6+cIPsmnHDsfpqt6j4bmIlwI5rDvMeiP5RJTnfV6EofmOo0BlSxbRWnGxVOSm062ybmg88HLdGOfE/CahY+ZdraUsAdvnIBjMf0EY3nBsCHPHMLYzoqX16lGlLPuQEZBrItkMSrrdWlgN5EMyb8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233727; c=relaxed/simple;
	bh=W+HL/0CEmXiDb5RlKvVXF44MRpOHJAFIrYOi2QY1Igg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFIRp1BJ8TPkKyuAfRC3a2A38CQCh3DuQ35g90x51XTsTEwyqnGXsKk4c9GvroIGzumylO2+unt7lVyWiybeyK2o3n8i36lApX9+6PWLMMJVwBYFLDLJ5JLrrZDuTd6AHDi4UdvPXQcD7J9pbPDTjcP3GyIfn0nSQdBiB8qK71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZZLGkHGk; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZZLGkHGk"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40946982a78so52476fac.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770233726; x=1770838526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCOCkubtI+Z/MzOWEgWEVw343s7M3hKtjeJgtxvRSFI=;
        b=ZZLGkHGkfDgbaXYdg9UJ0T3LjC5wiI48F1kMFcGs7/oWN9nfQkIZVQyOGRQ9Xtiwi5
         VntpNrgoR6FV5b5hMUBU8c0C/z8w37vtYJm9QHkm3DzgbiPVLgm85aSMuIq+MF26PTtL
         bLub/KKzhcXimJc3kzeyHLvE7Pbj1JUwR9yqJIPdWF660S6MC6Rma5kfq45u96MZnbeD
         HBz5A36s04/p9XHWm3xNsULFfUf/cBRav+xGFJDehuUsjNhqIueQs2/JFQh2dk27zOkB
         OOl6ZSc6oXCRO7Bony+rsFKRqqn0WkHr95faPPBzWb1TMhfeGl0Y+ZUBE8bEaYpiHmfV
         xeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770233726; x=1770838526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCOCkubtI+Z/MzOWEgWEVw343s7M3hKtjeJgtxvRSFI=;
        b=PzfbJwcfNb5lbPOc9FuIqefbZzO8Cf/gI51O10lLJuVwEkY57m+NhyuCff30fmizjH
         X1TM3WM57Qgr74dAOSyoiE5maP4bzNFapFIBqHqQFB54XGN4hu8l/Rr9yTpbpLTGoFac
         wJ+Hj4AZFtIQ7hh0SkgG/nAjZAVXu8zORZWI0BFDM/x068rc0FwZquxn1pDn4qPNCcT/
         wFaIabLvKlYdDcOnzuqyg0V0fhszl1Kb1tJ8ZR3uS5ThLV/7etyHq+Mo4eaPd4xQMlWB
         a8qeCO6KtLIfTKljB/RG4+sH7fxIjJtRH+aY8km/ojJNEb1OHZgDqu9monZ24kwCRzNn
         2dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW1VUtDw7SV6zRJIcMWkqVIMQtvZAN0lN6bPzq3UyKWR4vpY/zCrmqfoQhx86LtoYaGYI0frykAdBBjdVpxb7ORyhsbKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK727N8L0ZQFx/JbxUR7WQdyA5i/4rDB0leFV9nyVjNcSW4puG
	VhzGeCOSSjkgxMk0gfKVT+KdmoD7qkVYaYT0h4J0P+hXoGT/JhpqG2vhWnKwq0bRAmOiBe9h+GR
	ShWJP
X-Gm-Gg: AZuq6aIMpBzCnfA0r/fM+Mk46uE+oTRWfHZyngZJSNd17bkxhEk1J7sSk6vHZm+BLyQ
	HjW4kLhGVsKKNj8aq1c3OQgtQKt8jVEGUUEfxnKgs18rcnqe49X965WzpWx0FCwGo0dmRIjCvHi
	0FfBIBA7SLjs+1GvF1OwcHbNNsEuVPtIqXl/baUn4To+AI4Y2Y9C7lxWALcUJyIia5u/c14bUPk
	a06C3oFOXR9lhJEG0HWE9BQ87g9gYZoor12x9Fg4eahEYKSs7mq3iad207WZLmNOjQ9E58IK+3k
	hwkhmqQXGwFcjyxnwU6pRFtqIuJVELcRjgFEmQG+9apONlEZc2fm9JX7o12LYy++s+WnoMYvtAJ
	G223mWzELq30X8QEnRMzVPTMDVWPh+3nE4W0xzIU2WIkRSUyRJ6/cj1xBoii3scB+KdD0
X-Received: by 2002:a05:6870:ac26:b0:408:9c83:5b1a with SMTP id 586e51a60fabf-40a53c0fb6cmr1930681fac.4.1770233725620;
        Wed, 04 Feb 2026 11:35:25 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a541e222dsm2310538fac.8.2026.02.04.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 11:35:25 -0800 (PST)
Date: Wed, 4 Feb 2026 13:35:22 -0600
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
Subject: Re: [PATCH v5 2/3] ima: Make integrity_inode_attrs_changed() call
 into vfs
Message-ID: <aYOfenrieJLYQ9jR@CMGLRV3>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
 <20260130-xfs-ima-fixup-v5-2-57e84ea91712@cloudflare.com>
 <9c25c201f384d7320fd83e648d61a0086016ee36.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c25c201f384d7320fd83e648d61a0086016ee36.camel@huaweicloud.com>

On Wed, Feb 04, 2026 at 01:34:09PM +0100, Roberto Sassu wrote:
> On Fri, 2026-01-30 at 16:39 -0600, Frederick Lawler wrote:
> > Align integrity_inode_attrs_changed() to ima_check_last_writer()'s
> > semantics when detecting changes.
> > 
> > For IMA, stacked file systems that do not set kstat.change_cookie,
> > integrity_inode_attrs_changed() will compare zero to zero, thus no
> 
> I setup overlay with two xfs filesystems, kept the file I want to be
> audited in the lower filesystem.
> 
> Without this patch set, if I modify the lower file, changes are
> detected, because actually the i_version is incremented.

Correct, but the test example in 00/03 demonstrates that there's no
modification. For workloads that only execute and not modify,
IMA shouldn't evaluate more than once, but that's what we're
observing at least for XFS.

> 
> In which situation there is a comparison zero to zero?

My mistake. You're right, but for the wrong reason.

To be clear, these patches are about the STATX_CHANGE_COOKIE mechanic.
XFS updates the i_version regardless of the multigrain ctime changes.

You're correct in that with/without this patch there is no zero-zero
comparison for XFS, and that's because XFS isn't setting the
STATX_CHANGE_COOKIE in the result mask either for last writer check or
the attrs changed check, thus a change is always detected with
integrity_inode_attrs_stat_changed(), and thus maintains current
IMA behavior for XFS. 

That said, should a file system set STATX_CHANGE_COOKIE in the result mask,
and not update the i_version (say its kept at zero), then it's always
zero-zero. I don't know how likely that scenario is.

I should reword this commit, but I am a bit hesitant to say "don't
squash this in with patch 3" due to that uncertainty.

> 
> Thanks
> 
> Roberto
> 
> > change detected. This is not dissimilar to what
> > ima_check_last_writer() does.
> > 
> > No logical change intended for EVM.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >  include/linux/integrity.h         | 28 ++++++++++++++++++++++++----
> >  security/integrity/evm/evm_main.c |  5 ++---
> >  security/integrity/ima/ima_main.c |  5 ++---
> >  3 files changed, 28 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index beb9ab19fa6257e79266b58bcb5f55b0c5445828..382c783f0fa3ae4a938cdf9559291ba1903a378e 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> > +#include <linux/kernel.h>
> >  
> >  enum integrity_status {
> >  	INTEGRITY_PASS = 0,
> > @@ -62,14 +63,33 @@ integrity_inode_attrs_stat_changed
> >  
> >  /*
> >   * On stacked filesystems detect whether the inode or its content has changed.
> > + *
> > + * Must be called in process context.
> >   */
> >  static inline bool
> >  integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> > -			      const struct inode *inode)
> > +			      struct file *file, struct inode *inode)
> >  {
> > -	return (inode->i_sb->s_dev != attrs->dev ||
> > -		inode->i_ino != attrs->ino ||
> > -		!inode_eq_iversion(inode, attrs->version));
> > +	struct kstat stat;
> > +
> > +	might_sleep();
> > +
> > +	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
> > +		return true;
> > +
> > +	/*
> > +	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
> > +	 * is not a good indicator of i_version support, this still retains
> > +	 * the logic such that a re-evaluation should still occur for EVM, and
> > +	 * only for IMA if vfs_getattr_nosec() fails.
> > +	 */
> > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > +				       STATX_CHANGE_COOKIE,
> > +				       AT_STATX_SYNC_AS_STAT))
> > +		return !IS_I_VERSION(inode) ||
> > +		       !inode_eq_iversion(inode, attrs->version);
> > +
> > +	return integrity_inode_attrs_stat_changed(attrs, &stat);
> >  }
> >  
> >  
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
> >  	bool ret = false;
> >  
> >  	if (iint) {
> > -		ret = (!IS_I_VERSION(metadata_inode) ||
> > -		       integrity_inode_attrs_changed(&iint->metadata_inode,
> > -						     metadata_inode));
> > +		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
> > +						    NULL, metadata_inode);
> >  		if (ret)
> >  			iint->evm_status = INTEGRITY_UNKNOWN;
> >  	}
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 6570ad10887b9ea1172c78274cf62482350e87ff..8cb17c9d446caaa5a98f5ec8f027c17ba7babca8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -328,9 +328,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
> >  	real_inode = d_real_inode(file_dentry(file));
> >  	if (real_inode != inode &&
> >  	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> > -		if (!IS_I_VERSION(real_inode) ||
> > -		    integrity_inode_attrs_changed(&iint->real_inode,
> > -						  real_inode)) {
> > +		if (integrity_inode_attrs_changed(&iint->real_inode,
> > +						  file, real_inode)) {
> >  			iint->flags &= ~IMA_DONE_MASK;
> >  			iint->measured_pcrs = 0;
> >  		}
> > 
> 
