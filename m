Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8D2E888C
	for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210949; cv=none; b=DfSKduH2GdF3fZRBzMCtPNNLj7nqkyzhwEgqs8wOn7jG+2IavfF1/mwPp7m4NOrc7zPH5cPqvvJKo+ETZhkfGm3DfCCMFnUfpKQWz6VdIvY70Hs/PfW9/kbOdEFINaP1VGc6ZudXBPuqTgN+nme7WFlXXviBnXtsPpgj4Io0hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210949; c=relaxed/simple;
	bh=FhdP40ZNedHqEmlY8s3OTQPdz7LoUhJhpTXV8+ccUeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLJrrwCs2BJsbInaMgZGBusILyeisuxgZa2UHbY11xW+ZaL/aAJ2UFKsTLxgXzJeLR34MXpqdylJb2UPQfnqh3282ZWMvwlG08RzJinuaRhALc38rPWhpSXLcA9CtQ8uWD85MFoNCT/r6SbXWf2kbkjn1GexvnFYSDuKLaiKiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NDVK9wCG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NDVK9wCG"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a7bbe9d0so78424111cf.0
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777210947; x=1777815747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etZa6+dwk3PB/o1Yn2oB8jvevYbsEL8oVxXn5echsWc=;
        b=NDVK9wCGz9EYGOfwj4a+B7VlhjB+7bxntO+H2Mhsmfh7HADt2fuEn7Sm0iCM098dI0
         GV6TunZ93LQSKNrxXPxmwg/MJ53dYV8drX54guno0onWf4crbuJa5LbgjWkTNH3Ok30S
         fUtLQMo4W8G5W/1xI6OANVL5kO5J1dKBMTd4sOlO8L1Wn3DE/AnMcGVl81a5IG/xzFmB
         Bsa8p6eX/cVEH26ggcREruOgMbp/xpfytVhND/VStxGcstiEUHvRwxPGvXeYsCf35G07
         sZG+pt3Z2Y9kXqKaMdBDpoELBmE2BcxoVH/niuVgtAIMzjRtCAXMOIV2/qb1QTYJtE2C
         fPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777210947; x=1777815747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etZa6+dwk3PB/o1Yn2oB8jvevYbsEL8oVxXn5echsWc=;
        b=UYIlsiF9BQbopE+ajrm4+5di6D7188hmyayhMbGGQFzQUKZn5FawRE5uShzHprupTO
         NJC9PW5k/jf/Rghc7SDwWxymy5eP5ENC6uvnrQ8ZhcprNKKmKFtMlLzCEhvZilMyNmyZ
         bbhI+gKhZZeNov7Ah926paUFOLjCf1OTgLlUs6/xBqtcxW22tHER1PwJ6z4T4nczdotj
         0NMiqfQBTNy860yPkLMCGHNghunFAi8dnSF24lWTYbkTzPpeGzrYvndolX0dPzM3VaCq
         juUbvx0o0VBJ5tm/OHrclDoY9Z/5vDvB0Z53tTN4q+iriZ3RTT4spd70gXw5rDy19l1B
         OG/g==
X-Forwarded-Encrypted: i=1; AFNElJ8Gw/KSp3E/7OM4/tUwFjLnclaW83OsKMdLfo6DfqyFwpSS5hrZ13o/KHI443jLKeTYCVRsMWEoScYBwDDbuF1YZMQStNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypfcrNJf8yZGxFkpRySzyNAAKqp1O/oifJSOruAm+22V6HiD4
	3Ze7nWkD9MtT/92SMuiFlYVYIGSExQjnfYijf5SgtPmYmjf7wSe90fMPBQHbTywedDXk2GS6uwy
	giCPhN1Q=
X-Gm-Gg: AeBDieu8+E/kFKJGmBY4OHkt9UUXOvk57Rz2k3o9nu01osQEt1P1V/HCFExwLYgQtBn
	XGPEF1Ht4Uh0I7/z/wvFfOwiMQYfZPfMEbgXZq8mzmcH3Ca1OSTxmgNxQ9BYn4HwDmU0J+bsLph
	vEebtuzqBSvLUA2oqcXAsM/DYA7EbdGMtBt00UdiqsVK7ALQmSGfbNIfZLCgL1QfkSNqBF0hV3c
	Eb2CkoKJ9+lC2zprULOJLkLRhjQj83A0aL5r6VfHlLYeHeDKJ9A6MBZtSUKGGTI/NsY3JGqmDH7
	TGEBxFMnkgngY0T67fl6vK2XNhNe5lMV6eIYwW3oL9vPUA+YRyDGTsdLA2Hx6hkgc8id9fmpAhv
	RBActL8rp4LeR7CmVf4aHCjLXkRAxT28Oug/qLBZ6I59lwoFOkAF8+/mWSAe2/17BxWPPzn5rNE
	xCYU6z+h2z1fDajEYR5ttl/vgJLnQMtldcQFMUq2a21f0Lp1mlynnLQkIxnLNKWCM3GzVw4lF2n
	dQAIQIZtUfTR9zz
X-Received: by 2002:ac8:7d14:0:b0:50e:df54:c36d with SMTP id d75a77b69052e-50edf54c741mr408613341cf.18.1777210947033;
        Sun, 26 Apr 2026 06:42:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c859asm305729281cf.1.2026.04.26.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:42:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzke-0000000EqhS-4C2t;
	Sun, 26 Apr 2026 10:42:25 -0300
Date: Sun, 26 Apr 2026 10:42:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260426134224.GC3501894@ziepe.ca>
References: <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
 <20260424141921.GA3611611@ziepe.ca>
 <20260426103957.GH172828@unreal>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426103957.GH172828@unreal>

On Sun, Apr 26, 2026 at 01:39:57PM +0300, Leon Romanovsky wrote:
> On Fri, Apr 24, 2026 at 11:19:21AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:
> > 
> > > > > Leon mentioned that different firmware revisions would have different
> > > > > parameters for a given opcode, and that one would need to inspect
> > > > > those parameters to properly filter the command.  Is that not true, or
> > > > > am I misreading or misunderstanding Leon's comments?
> > > > 
> > > > They are ABI stable, so there will be rules about future changes that
> > > > old software can follow to ignore or reject future things it doesn't
> > > > understand.
> > > 
> > > It is wishful thinking and applicable only to mlx5 devices. No one
> > > promises that other devices follow same ABI rules.
> > 
> > Well, I will definately kick them out of fwctl if they don't.
> 
> It is easy to say but harder to follow. The kernel includes many devices that
> exist only in specific hyperscale environments, where the update cycle is
> tightly controlled. They easily can break FW backward compatibility.

Well Linus's rule applies here, if it doesn't bother anyone it didn't
break..

Jason
