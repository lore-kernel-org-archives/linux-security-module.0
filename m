Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD4175A98
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457986; cv=none; b=DBLsj+PpAq/CXgvy/qiu0cS+x0N/HIF+7abYBgb0xFMEcukl+qPukUOwQa6wCXpvx9amZlXwq8tlUKxn3Sj1d3vha0ykp4h5Rt2kWXTyFdfvvVoNsSelbUV9+O1yBXfIpn9JApbwTrDKWoaRvZCRjekfYV2pS92Dgq5PaW9Y/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457986; c=relaxed/simple;
	bh=jFrdw+X0q0nEQz1vk2GjktA7ZkOoieLsktKpKwr3zTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP3/539F+y5nZe8xXae229n6ZwvJRvNwZ8ovYG8s+RP13rwgRJRWR474yvPRsjgVk/rI4f0mpkbI/uTt3/pzZNfGjbfaVYzGNevva+PWHMz9NIkHIj9gTcv4MpwbObB/5VeLKrKm9z0/GaWydyLK4LjUbisV6MITD+cNrvZQ+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIEq/xxA; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIEq/xxA"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-650775f427eso1285771d50.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776457984; x=1777062784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESaQCO0d6F6EEXsq95L8Y+GOiOFVbRFpB4PjdvQLY8g=;
        b=QIEq/xxAbkZ6O5c/fPXqKyawmbwI4Q6j0S1T0aZ3Uo6WSgE7MvrIsP2BwumApzVRCm
         LSTPuCpA9U9n7vYfGuaEB4o/nWTZEi1u8ueioeyfmAN51YsXCSuhmHkssN86X52AmTIC
         0Nv+LQAAh118nRTrIdo3vFlKv6dUA21g0LqvUuw4Z6yRs7brk5UKph10rKOZfZF9X0eR
         CtCsLy7ktWK0ob19qWxYcFxzYI1wnNGWzlZyDQrQhNIUuLnd8LrrH73KyRt6dMEzjOda
         Z9M+dBsD9XPf1ZRrHHFPQxge0NIFaim6mKxiXZkGlwVZJB9QNnBjuvV/6nscNcEbY1aL
         gzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776457984; x=1777062784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESaQCO0d6F6EEXsq95L8Y+GOiOFVbRFpB4PjdvQLY8g=;
        b=aYCu4QlVaKnkbDegEjjA0x2S92SZ28+xRNfnhv45m8/uTIsam9SypI+pjsDYJ7f+3F
         g8+NOrFyEKr9N+6G/jKqd9SWx/d3CtHLmxKsOjxqlYqvtJZPvVDbEO3HS+4YaRIag5kl
         L0bawrbXffs0Ncv51SsT8we9BBkULCaiETHEvCtonWeWgcL7IQkFxrb6dxistiC+PT5r
         hbO/IM24IyAN0dTJg3gklTJEsXlzNYO1cfm4jLOtu14A/YKN+QPR4q5dODMuG7hKfOr1
         CA0USXFQ8Kx0cV6Vh2uHq0iI2YIGQ6fZSN82jqhsSlrPtyOqaT/MemZvLdy2P+DNGAYH
         r1+w==
X-Forwarded-Encrypted: i=1; AFNElJ/EatwFPJdRNPHSeL3fqkYm5xtmblJmYBIS7wDgP7EI06XjsXomePpkBuASlCM+tS9qWV4GIY2vDHfh/15iYdly1vpcsWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBuoyOH3bLY8VReDLTcgRdo3J2OAwf26nfNEYfNGzXwf+vFCv
	NNPWxgzv965TBCKD0b43TjaikakWYPhZKM7ad30R1t4i61DbmDi1oH0e
X-Gm-Gg: AeBDieuDhQI/Y7L8ptw2hya2y/ztj7knG4plpDe8yV2fP7n4hX3wb5glG7MxaCkbUqm
	hwKXBjDgreROGU0pzULOhVU6ttS3BvAhABv/FhnMVf9KolsSmFaIgOhkZWI9D+HQodsZppH5VGa
	QmuXbrGPCtUugStu2kKOVHu1wgM7VUk5TJZ/KmWXEzf7zD9HG9oN6tayZT1uuO8zVseMZD3oYIN
	UKu6CzDEI8holQMhXbdo7y0UD4ulNY3aexnezvrtxAjMFAWFBzP47sKBoCdgxu1GQOlOmLbmS2u
	ZVxRM6+HeKTT/OVTi+yjQ4Z6APmA6HwxWC2xSiAOknA4xR+wZzIIDB9PUjmuETv/bSKIGMyWv84
	VihOPtLbVPgb3YDBy/P0XYGNTYhgf9iHWJ0NhT2X9j1CfSjPIjJZFocDx0eq6QfNVCnSw1zeG84
	s0PTQrQjHY5SQsFKCjAi0Fa8vrFN7H4nISU6shEU8FaxObI4pGe2z6nMVjooG8jOo6eWZBcCG7b
	g==
X-Received: by 2002:a05:690c:3181:b0:7b3:5872:694d with SMTP id 00721157ae682-7b9ecef5437mr48642037b3.22.1776457983655;
        Fri, 17 Apr 2026 13:33:03 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:e63d:3ec:f0d3:1523])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bd34sm11026187b3.26.2026.04.17.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:33:03 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:33:01 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
	gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeKY_QUge4okHjrW@suesslenovo>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
 <20260417.ohgoh0Eecome@digikod.net>
 <aeJlHIoSjVPmccDx@suesslenovo>
 <20260417.aPh1ooQu8esh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417.aPh1ooQu8esh@digikod.net>

On Fri, Apr 17, 2026 at 08:03:14PM +0200, Mickaël Salaün wrote:
> On Fri, Apr 17, 2026 at 12:51:40PM -0400, Justin Suess wrote:
> > On Fri, Apr 17, 2026 at 05:18:05PM +0200, Mickaël Salaün wrote:
> > > On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
> > > > On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> > > > > On Thu, Apr 16, 2026 at 2:53 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > [...]
> > > Why not using proper typing with a dedicated map?
> > > 
> > 
> > I may be misunderstanding, but from what I see, a __kptr DOES give
> > proper typing, __kptr is an annotation not a type.
> 
> Ok, good.
> 
> > 
> > This is what it would look like in an BPF_MAP_TYPE_ARRAY.
> > 
> >     struct ruleset_kptr_value {
> > 	    struct bpf_landlock_ruleset __kptr * ruleset;
> >     };
> > 
> >     struct {
> > 	      __uint(type, BPF_MAP_TYPE_ARRAY);
> > 	      __uint(max_entries, 1);
> > 	      __type(key, __u32);
> > 	      __type(value, struct ruleset_kptr_value);
> >     } ruleset_kptr_map SEC(".maps");
> > 
> > So we get proper typing from what I see. (It's not like a __kptr is a
> > special void*, it has a type)
> 
> Looks good.
> 
> [...]
> > 
> > The answer the the lifetime part is yes.
> > 
> > The kptr destructors and the landlock ruleset refcounting give us that
> > abstraction. (along with the KF_ACQUIRE/KF_RELEASE annotations and
> > destructor implementation)
> 
> Good.
> 
> > 
> > > to the caller) and pass them as file descriptor?
> > This "pass them as a file descriptor" is the tricky part. It would be
> > very convenient if we could send the fd to bpf from userspace and have
> > it be implicitly converted (like in the BPF_MAP_TYPE_LANDLOCK_RULESET
> > implementation) in one step, but I just don't see a way to do that with
> > the bpf_landlock_get_ruleset_from_fd kfunc approach.
> 
> Song's idea to have a generic FD map looks promising.
> 

I agree the generic FD map sounds like a good fit.

So this would be three parts like:

1. The new point-of-no-return flags for NNP and staging domain to
execution time in Landlock. Selftests and doc updates.
2. The generic FD map implementation for bpf. Selftests and doc updates.
3. The BPF kfunc implementations for Landlock using the same point-of-no
return staging. Selftests and doc updates.

The scope of which is probably too big for one series.

Luckily part 1 is pretty close to being done as part of my work for v2
of this series, and can standalone as a preparatory series for Landlock,
since it adds flags and features that have utility outside of BPF.

Open for ideas on how to split this up (or even better, for some help in
implementation or prior works).

I'd like to get some feedback and figue out what this generic fd map
should look like and get some more eyes on that idea to avoid wasting
reviewer time on an unsuitable implementation.

Justin
