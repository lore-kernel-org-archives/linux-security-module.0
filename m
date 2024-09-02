Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F317C9B3
	for <linux-security-module@vger.kernel.org>; Mon,  2 Sep 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266497; cv=none; b=Crdu1oDaaARd0Spe+kp/sjShma63Bao1Eq80hk7gKkSHme+iXNXa7Or+Pgank3bMudfgxjXa8LzzT9Sm38rWDd+IdTG8hOR7MJtxgii+2dQr7eltpUBfSiaYATvc8VUb3EXAhC+cmOiaB014SMFtEd3frUhSlAOLzQBcXTESuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266497; c=relaxed/simple;
	bh=U4pH9n5opeXrTqy96OEvKqqGlgFtHFsAUi+KLg73r+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGRNCGuu8Dxlp6gIZvwwVc2LFXLIbCq8F/mSoPoVBCUflHO+EkvG2rhyLMMvoHPncXqVnTdK3FNXKG3n9yMgKAWtJ0nW/haxs2kxVUyhhZBWOcYShnaV6/fQ84yMgr0d3HZ/0FDcgHM2BkhHm42Xsc+KEumcgIL05DrelRATUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GO/WB/vC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GO/WB/vC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so284358a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 02 Sep 2024 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725266493; x=1725871293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=GO/WB/vCGGjNzm79oYQK5rjK14AoxVVXyRbSHsv+UDfpqclVn2OXYVfU0mT4Un6ATu
         E9ikzfDEiM8/b60Rxp5ByyPv8kMv+1tAQCf2do9qpF8MoXa9Ks4W/wQQcYE9gjO/8pI2
         HI2p7tCZTrXM9OGLI8UGhkaMj9zHjEg99SDnQy8sj+2RRswxa7RE7ny3pMBAebsza0fa
         q3OFXxILxNuRgK2Ldqbj56nCd0qbsaSivRp1Ut/K1o6XE6u3sDBUatpBGHd4SrAz3Aa6
         i0VnIziTb/CP4w6oSKlMCILJexkykGQf7VbCJIieezvN9x78c81dUFlcZGMYlxOq+lpi
         nZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266493; x=1725871293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=I6gJFes5aZ4kAqA5MJfKKnaDlvpUPrP5qCzU6Ev85GsyOQF0ZYxrDTH9xd71CB+KEn
         aw3i9D/bYAcv9cGrb1xN7d/ZQpXdrnMc4pfNWHinfJWIh6GQMVY+Q84tmKqdHGVObTxh
         P9yZjIRw/czli086ox3pDfEaKGui0C86NOjQe1yMY4OdT8fSHJvesRakfbjFrvkVyDNh
         vNki0zkdLtyfp8qbiiMTXjBA2vZtv2SOE1YPDKTLL3G8KG7byRn/Gub8lUcIECY765+P
         J4qyqKMWhrCWXmZ0RQZKP7RiyIw5HdyMffBOKB10V1bHzkbyNmA+aozwI13qibbwziBN
         ZTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmJsevoO2I2tDnW+Dr0HnGrEzhpnAKA8cEbi05eLO3EEHW4Wje6vujPN8xdi0butRi3bhTAl0Meoz7lwvl1WEQFNwV/gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0JKg2YHzPrdn21nDw15pfPxfgOrLkIJdtSfk/qTWvXVC12gY
	7gTmJt+eLa3cl69rx/H2L53v+x+G/V68hMGOOQJJLEPNEDKXf1vrSmbU0KtmGvg=
X-Google-Smtp-Source: AGHT+IH0oa4HGDBaWmEW2YFqYs/c/VIYcD3KLgtz3Ns27MTTgp0m3AKBLw/5R/bF6mlCHND1zKa/NA==
X-Received: by 2002:a17:907:60cb:b0:a86:8169:f3d6 with SMTP id a640c23a62f3a-a897fa6bb2fmr1161343566b.49.1725266493202;
        Mon, 02 Sep 2024 01:41:33 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d36sm535496866b.149.2024.09.02.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:41:32 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:41:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtV6OwlFRu4ZEuSG@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>

On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
[...]
> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> in the case of bugs, because that's going to be an improvement w.r.t.
> system robustness, in exactly the same way we don't use BUG_ON() if it's
> something that we can't guarantee won't happen in the wild - we WARN()
> and try to handle the error as best we can.

We have discussed that in a different email thread. And I have to say
that I am not convinced that returning NULL makes a broken code much
better. Why? Because we can expect that broken NOFAIL users will not have a
error checking path. Even valid NOFAIL users will not have one because
they _know_ they do not have a different than retry for ever recovery
path. 

That means that an unexpected NULL return either means OOPS or a subtle
silent error - e.g. memory corruption. The former is a actually a saner
recovery model because the execution is stopped before more harm can be
done. I suspect most of those buggy users will simply OOPS but
systematically checking for latter is a lot of work and needs to be
constantly because code evolves...

I have tried to argue that if allocator cannot or refuse to satisfy
GFP_NOFAIL request because it is trying to use unsupported allocation
mode or size then we should terminate the allocation context. That would
make the API more predictable and therefore safer to use.

This is not what the allocator does today though. Atomic NOFAIL
allocations fail same as kvmalloc requests which are clearly overflows.
Especially the later could become a risk if they are reachable from the
userspace with controlable allocation size.

-- 
Michal Hocko
SUSE Labs
