Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B728469F
	for <linux-security-module@vger.kernel.org>; Sat, 18 Apr 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776549014; cv=none; b=SWpvaxOKdMTY/OeIX+98Q+SVk5Jd/jr5tWaVSaEWPzs0F5CnxnDQd2tU+INje/uPEgY6uV4THdIakiwsxZ6Q1UhEjD2m7xWRw1M1LRqANX9hWpXp0BYimah0fsEpOt1d+D6pu3UHOvfZ+VlmBLOej115ARJMFqNUsqFHkNm5cpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776549014; c=relaxed/simple;
	bh=3t3O3sUz87huz0M+miAOXIZUv7RqPxu3nH6k1jR28j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtudoxV4h8heYPEXR0YafVQAFHI/K8sKLlU20DWNfQQHr+1uj2Yd4x/Y7G++sfQKGrd8BGBPMIyGLzt5ZhXpX4oiPgcI+ehZAsKSN3D9yXWKJ2qQ5cgP3fhxvDrpdUUywkG1pER6B4n27qH5j6bAUeZJgXITakpagXwFOfS7LXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEIRqRep; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEIRqRep"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so16691377b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 18 Apr 2026 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776549012; x=1777153812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=36X19zjYQyKBdMHD9gCjle7K5J8JMLJfZmqliCGv0kA=;
        b=fEIRqRepCGZHHwDeYcQPuGgeVTaflRQq5+lBchI27/BfrZgSyaafzb8AOwkwE1Stfb
         Nin0EPW+Vw8I4M2su6BmCfrShrHJZgdSiO5qpdSzJSEI5sc5mSYWTHaSK2UQXvv3+RJN
         SpD8WvbvafSjgZRK22N7msCzhjEc3r+iXKTvNPAfE22tEYgPqmha2EGmh78/Lh+MFiUk
         zoTxpDvuxUu22vKYSm5sJxB0VlVWXAVmIQ+OKxPYzvQHACZRohRJO21zROlY/CV0GiZf
         wWq+ZAxjBKTrMT8dO6AEbG6Abo4p2q9k5Uyy7lQ/VkwwzaV+FE1s9pPc5bd0EaVToJWc
         48Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776549012; x=1777153812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36X19zjYQyKBdMHD9gCjle7K5J8JMLJfZmqliCGv0kA=;
        b=jh1RPSDGQPQa/ODNpY/CfUj2Q7Jvs8FtFirmffYup9yxnj5hOaSn/d9cWPmz2j5i8M
         ucpntYGjfBXA1nIpQcVgHtXYFFV0epTP+clXECDQt1bKGb8lmQhvl2zMgexAFveW+2gJ
         mECxAOnPfkBYGc7pyUp/VySlyT6k1H2UQkNW8EiDcL5BSXswy5JtziaKf2CZzjcUM5kl
         sUpnyx6ZZdfApTmAl6HyMdq4S6v96OxnM2peD7pFNCc7Ale6aiRd9l7LhTCtrJOWv5sb
         M/qv5LIz4zpibvD2XAzFHPjwQYL8azSbH7prW8nlIEN/FLMnaKA+h8mS3Rij+4+Lr0Ny
         lIXg==
X-Forwarded-Encrypted: i=1; AFNElJ8rqpgSGW5HEu8cH5XXS9S5bWairRWgBHPJN4Hu/ahIovOhQ0pO+8nAJToh1l/c2UNgTcmcganzCJ9Iiwtp0wjVWJAfRuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy51T0oPhGLfE8S83ftRfFbgxYvuyA9qGVLUXJ3DyBopIYqcHv
	lpI0jb+t8MQOjVCWAUXbMyuCD5VEL+dS8bMZQ9qVzMA6hSZX78kSn6Kv
X-Gm-Gg: AeBDietPfVMruDuAqcOSJsWNqv7CQoJlT+ANrTXWEIbkbgIEQGqqBcM9okuJwLTlnNc
	zuT0S9Z2RQWiSvDSHOM/62EJ20jR3/5JzEk7ojDKsHIkbqDrGTLaQmW90MmmrPtN9/6YbvAEUnt
	toI7s35dny/jMtkBW1N6xN/Fpmz+JdKuoEHoJ+/oi22trINj8mV+znZAYR8aFrz9fpOdZGs1Gs+
	Md3h3moQb72p2V2aQwdgo8rn443mpWiINbn8Z0t0knTzq1eTba0FM4SYh67YAanyNY0gdhFqDMe
	4TlXrClFr44KuOsEUUVCBNCexQXdzjtY+P7MdxujDuOJNENQSV3HnHzBG4SZhcGxG0SztrlHx4C
	1HqpTDORApzR2SiUXpQclN38q/uMq3m+D1nSfDC/XZ8bK8hFhtU4isd81y+OHRSVFWFiXI6mU44
	yBOjs0xZGEZviHd/ky+3GvmhjNcz69rVlhcMIrOy+xXAiBIRSSw8fxRcHCZHKLZAKIz+ByiwYhu
	RA=
X-Received: by 2002:a05:690c:1b:b0:7ac:ff2:4603 with SMTP id 00721157ae682-7b9ecf0fee4mr87792467b3.20.1776549012081;
        Sat, 18 Apr 2026 14:50:12 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:3699:d8a1:7856:daf4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ce88dsm24935397b3.48.2026.04.18.14.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 14:50:11 -0700 (PDT)
Date: Sat, 18 Apr 2026 17:50:09 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Song Liu <song@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
	paul@paul-moore.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeP8kWX2POlBBjlm@suesslenovo>
References: <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
 <20260417.ohgoh0Eecome@digikod.net>
 <aeJlHIoSjVPmccDx@suesslenovo>
 <20260417.aPh1ooQu8esh@digikod.net>
 <aeKY_QUge4okHjrW@suesslenovo>
 <CAPhsuW4CoskfaqEE5yS2LU_mFvNBDsKc5OX1+f=Lkduc2ykSdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4CoskfaqEE5yS2LU_mFvNBDsKc5OX1+f=Lkduc2ykSdQ@mail.gmail.com>

On Fri, Apr 17, 2026 at 01:42:02PM -0700, Song Liu wrote:
> On Fri, Apr 17, 2026 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> [...]
> > > > > to the caller) and pass them as file descriptor?
> > > > This "pass them as a file descriptor" is the tricky part. It would be
> > > > very convenient if we could send the fd to bpf from userspace and have
> > > > it be implicitly converted (like in the BPF_MAP_TYPE_LANDLOCK_RULESET
> > > > implementation) in one step, but I just don't see a way to do that with
> > > > the bpf_landlock_get_ruleset_from_fd kfunc approach.
> > >
> > > Song's idea to have a generic FD map looks promising.
> > >
> >
> > I agree the generic FD map sounds like a good fit.
> 
> Well, I am not 100% sure a generic FD map adds enough value
> on top of current __kptr solutions. This will be more tricky if we
> have to touch file_operations.
> 
> > So this would be three parts like:
> >
> > 1. The new point-of-no-return flags for NNP and staging domain to
> > execution time in Landlock. Selftests and doc updates.
> > 2. The generic FD map implementation for bpf. Selftests and doc updates.
> > 3. The BPF kfunc implementations for Landlock using the same point-of-no
> > return staging. Selftests and doc updates.
> >
> > The scope of which is probably too big for one series.
> >
> > Luckily part 1 is pretty close to being done as part of my work for v2
> > of this series, and can standalone as a preparatory series for Landlock,
> > since it adds flags and features that have utility outside of BPF.
> >
> > Open for ideas on how to split this up (or even better, for some help in
> > implementation or prior works).
> >
> > I'd like to get some feedback and figue out what this generic fd map
> > should look like and get some more eyes on that idea to avoid wasting
> > reviewer time on an unsuitable implementation.
> 
> I will think more about 2. If it indeed adds good value, the upcoming
> LSF/MM/BPF is a good opportunity to move this forward.
> 
> In the meanwhile, we still need kfuncs to access landlock ruleset.
> Therefore, any work on that front should be useful.
>
Instead of a new map type, could the same usecase be fulfilled as a
flag for bpf_map__update_elem? (BPF_FROM_FD?)

  int bpf_map__update_elem(
    map,
    &key, 
    sizeof(key),
    &fd,
    sizeof(fd), 
    BPF_FROM_FD);

We could register an operation at the BTF type level to acquire a
reference to an underlying kernel object from a struct file* to a
specific BTF type, like how destructors are registered.

Something like void* bpf_kptr_acquire_from_file_t(struct file*)

(adding it to btf_field_kptr).

Then this would get a reference on the kernel object for the underlying
file and insert it as a kptr into the map if the file indeed points to
the correct type.

This would be valid only for a map holding a supported __kptr type
implementing the bpf_kptr_acquire_from_file operation.

This flag would allow inserting __kptr from userspace (previously
impossible) with a file descriptor.

This wouldn't need any new file_operations changes nor any new map
types.

This could be implemented for specific kernel object backed FDs as
appropriate.

> Thanks,
> Song
