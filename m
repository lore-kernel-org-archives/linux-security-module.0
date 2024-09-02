Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A51D1F68
	for <linux-security-module@vger.kernel.org>; Mon,  2 Sep 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269986; cv=none; b=spzgwB03MBLicF+AIGUp6WuFJr/Mq3cro9CzLSSWYo036UmJsT40T5s7AmNUiBjS3VOHYSUq3dNITalNBTxd4n/WcEDP4mLuFvo0HocukIL9+8WVfi4FRvJ1F5nb5rb0oQkyNX5SzeDMMp2S0JLyOIIcJSoIoUZ9Xt4VTAuCsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269986; c=relaxed/simple;
	bh=+vKy5Bgi2ilsJQBOHU1T90A5J7NRotgh5xEpOxt0vFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcOBPT5vZMf13SGQMWuBRO/IX98PrkCZyEAPXtR/93icf3CUq7g4dK9+nGoUDXOeqhA7h0hMO9tJ+bL/o1/8KDYrZRp+ISCItiXa8Mm5W5kFpeI3NNicqOd9voReRrQwqFRnTA8SgQLWb6iv0zae3i0s220K8F5cWkj8QneMSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DKMsorey; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DKMsorey"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53343bf5eddso5284111e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Sep 2024 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725269983; x=1725874783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+b2Tu1YlvpDpDetKigSg2I/Ak7ZaGYzocV3AQmvxK6U=;
        b=DKMsorey3xyKISF0wmzSkFnSm59ZijqpUHAERajTyFwQuzkbzBRUzePo9fP4GQgEaG
         x3tLHeiw8IuTzeYKTuEXcOLHokqhmyANzBNXwH5bs6lSdN+Nmvk3WzEdGAUVzw6/i3A1
         DhxQhrfYdAqAVhrjZt1JUdw/hZoLEe/+mmPqzqXNLZ+cw/AtX1Ai+KDK82XC2JFQMFJD
         IIDOdq4YRBALJysNDkmjmBEHNTEGdUHY9Ja/AgiOKUsq74B+1yKFbaA+GerrZoLnnu/M
         +bwT/j+JChCtRghEOOZPXdWXADyNKybi6zYqIEycLYwdUXPqwasyNSK+gX0P/aDRcxZl
         3LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269983; x=1725874783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b2Tu1YlvpDpDetKigSg2I/Ak7ZaGYzocV3AQmvxK6U=;
        b=Qp53LqftBEe2jA4zFvfiFTnXE6ei4bK0B+TSCQ+QMHdHwZcirKdSclLbZ+bGedCf3f
         PQolgriV+h97C8z6R3/2VHIwrpO9/z9CrgXqQ3wMMz0xY3VelXLTc0v9bOnQ/2zSiOWJ
         x4WRp9JG1rgprdy3tRp9OHN/zc2FTIXnn9W43cl6uQWvudM8nO5q05VLeZxA4svcsLLm
         qpFSOLBzzADcPWn+RFD6Q62fMPpUM/MgqTR/N+KVf11ur1XxALhmxxOfWaTl4tXWsFvV
         YKM76t1GvgV1306Gz0i1JH7W9BENwSGgZxNy1Z9Yw6+8t+PlsrXk6KpjODDQl0Zs4VUE
         eRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1WltreDmkhNDf3xAJy2syw8o0RFK7pMngVhQEaye+zxOthZ4dDG8o7Q2fHKGgAg/sEKDiZtYz2GL6ID2EVrdbCXwaa3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8V+aCtnKjjKVDBk7JdwsfRV9VE79jA7/OGhTK25jyU9WcC4SQ
	kpclcjU53XjCp37KW744Ce11W3dN8m6OUk4rLTI5cz4AKJvxibhDQaV8rU/BqVE=
X-Google-Smtp-Source: AGHT+IHZM5waMu+X5FhE3mW4B0crx++9U1PxnK3hjmktHHYE/8KgZSZDyo13u7RHZxzfN09KFJCN9Q==
X-Received: by 2002:a05:6512:ea0:b0:52e:97dd:327b with SMTP id 2adb3069b0e04-53546b38f94mr5722464e87.23.1725269982952;
        Mon, 02 Sep 2024 02:39:42 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm533179266b.182.2024.09.02.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:39:42 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:39:41 +0200
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
Message-ID: <ZtWH3SkiIEed4NDc@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>

On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > [...]
> > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > something that we can't guarantee won't happen in the wild - we WARN()
> > > and try to handle the error as best we can.
> > 
> > We have discussed that in a different email thread. And I have to say
> > that I am not convinced that returning NULL makes a broken code much
> > better. Why? Because we can expect that broken NOFAIL users will not have a
> > error checking path. Even valid NOFAIL users will not have one because
> > they _know_ they do not have a different than retry for ever recovery
> > path. 
> 
> You mean where I asked you for a link to the discussion and rationale
> you claimed had happened? Still waiting on that

I am not your assistent to be tasked and search through lore archives.
Find one if you need that.

Anyway, if you read the email and even tried to understand what is
written there rather than immediately started shouting a response then
you would have noticed I have put actual arguments here. You are free to
disagree with them and lay down your arguments. You have decided to

[...]

> Yeah, enough of this insanity.

so I do not think you are able to do that. Again...
-- 
Michal Hocko
SUSE Labs
