Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5E199244
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702293; cv=none; b=RKYjnoH088BuXCDvdtUjJyR+7wIecn+KP7YOWIHttlJa8zacjPr+3dz5AEdgx85XszFDArU4YXCpXi5ApEgf522/Z+bbxCfMBcP9jsaPxR+GTr2He9t41UNndIVpGK1LQkwhS9o2CETO3z5LMgi22y/9RUyRc7gIHD4Eb9WT1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702293; c=relaxed/simple;
	bh=bNvj7bgWyh7vEonATRHC/EAvCzNu3EdpeAkNK3jCDPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD/JANAPeVb0vMj51IF9w0PW4HiWkOczr+D0B2UM16ec/ypawzqcgVxFkKIQTede+5IiZkZOv79HWGT8bkj7n+xM+vz94vszAC1Xp7GuVOgU2TiyRcxkQDJw090Ifh2pj5dct9IsWxQrapKRN4NsWgBNJ+TDelQoIMvAxEPG7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQzkH7Up; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LQzkH7Up"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso5924828a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724702290; x=1725307090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh14Sdlc2n6IxKjJ6RlYGRrhImnkQmnSBBa6O3qnYnE=;
        b=LQzkH7Upij0y1HqegxuGUK1QLMUWfJVj8+d7e4sbpJ11wRS3aEGYebhtTv8xdVmd9H
         u9LsUDqHC9Ym6/FawQYakWubVnIPyUZ2w8t6C59/1jGUmYHRUNDuSzpIO4DhUgFCeKdn
         ZiCANADj9F7DGAP4hDWJq8M/m2rw67ouoAzBasyVZQYmiqHr/jhsk/W6IIr8/hUdi0Dn
         7+QlDZ93wy9Ee0X/C8CjJo1ofTeIogYYMVBgySy8/bUb9b5hNDW1EZnE+/PIbSzxnuWI
         s8eSw5ndhSg841aFTDhEEavBqiZnKLXYCTFgYtcQnEfEk/+Gg3UMz7JFHMcue4N7cL0r
         Bd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702290; x=1725307090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh14Sdlc2n6IxKjJ6RlYGRrhImnkQmnSBBa6O3qnYnE=;
        b=JucwXyRgZPZoOncjGeE+M8y7Ktky/xViBJQ9p2t+GAYxj/DkPe0PNNeW+f+YwWbEzn
         RqmPxH2vFY+JshK6k10mWx3xf6c0i9kykWsYyVHnux64wFZoEBOZA6D8vBWv7lvDjW91
         ZodwZllB1rLgppUOp8K729PA7JmgkL442UPMyAi/dVy0TjiAeo8U/qY09Bv0zHwHT2MF
         yDLr3r2kIWlYXUwHiQ1vUy+9wH3nw/X6QZdA2KmtfvsXDTpJL0hpniomxwW93+OcM8d0
         5yH+sDDRQckW6uZhSQpkQh743Svw0D8Yy9j/0AvH/mMl3xgWC44S1XJmFI0XRKEaZHmP
         z0vA==
X-Forwarded-Encrypted: i=1; AJvYcCX6MrNmcMtY/QSNJaoI2WyEb+cb7/bJkugisCey3zekTuLPofFQ1EyLJeoiurm6BUkLIGgMk0lAI7OOMvRTGwIdZjWciaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtnoM5X7RvYESC16Ag9o907Cd/VtW+x2jw/58iVM8kA6e2uyq
	dNIaFo5JKiZHveM/sXyaQKQ82um7Di65J96ZiZzTroo6e/9cEPjfsCpS1v1b1Bs=
X-Google-Smtp-Source: AGHT+IEqLDw4bnaGQwfVtxUnt5R+nT/cvXOLGueUtNtCDMXl1cKCg9G27paLPy3+tFp8unGIxIOggQ==
X-Received: by 2002:a17:907:2d8e:b0:a86:83f9:bc1f with SMTP id a640c23a62f3a-a86a54de2cdmr683406666b.61.1724702289954;
        Mon, 26 Aug 2024 12:58:09 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d896sm13574466b.131.2024.08.26.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:58:09 -0700 (PDT)
Date: Mon, 26 Aug 2024 21:58:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZszeUAMgGkGNz8H9@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>

On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > 
> > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > dangerous to use if the caller doesn't control the full call chain with
> > this flag set. E.g. if any of the function down the chain needed
> > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > cause unexpected failure.
> > 
> > While this is not the case in this particular case using the scoped gfp
> > semantic is not really needed bacause we can easily pus the allocation
> > context down the chain without too much clutter.
> 
> yeah, eesh, nack.

Sure, you can NAK this but then deal with the lack of the PF flag by
other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
are going to support at the MM level. 

I have done your homework and shown that it is really easy
to use gfp flags directly. The net result is passing gfp flag down to
two functions. Sure part of it is ugglier by having several different
callbacks implementing it but still manageable. Without too much churn.

So do whatever you like in the bcache code but do not rely on something
that is unsupported by the MM layer which you have sneaked in without an
agreement.

-- 
Michal Hocko
SUSE Labs
