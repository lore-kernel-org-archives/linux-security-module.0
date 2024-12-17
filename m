Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD371482F5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413446; cv=none; b=Yu0sSn6IrRg5L80j6w6XA4VvvRpJwS7YP66D7zbhOxCAoNJBHnpvWoOCIgKb+VhyaDtn06OUsueOo2IDmAqJwHUgaD5ZB/MkDsxx8OuFr630fln4w3DKpaJYfAkXaIh8Qflyh55s95uqy8KikN3MjgGoIG1XiBLqjkzNFH74qqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413446; c=relaxed/simple;
	bh=NXcQdo0wRRKb2/WNDagRZfaOG1sq8tDTThIxnEioR2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8sxCMQ59WSyyu8WuuTYP6MOHC27lO1ZmTzifWKNjOqSKca0w5gMsDzGOKoJ2s3sjz8JvgiGuqSw2hE73MZBnVE44VDG7N2+VfuOgjNyxWHy3iHAvv51d+Ki2IxL3p6JRNbRscUWxnEnFDosBOb+mgJBBqjdOr0BGXV6MTh7lEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G3E8wujk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G3E8wujk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728d1a2f180so3635455b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 21:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734413443; x=1735018243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eprAB6mL99nuDvuDpZ7xteMR+o2NtdFYL2yb/syKiQ=;
        b=G3E8wujkDoPb5DgpzmCfuvZsQOGcrS92LDJRcjmjK6pq9ot5malWkaYU15mvJ8FEmB
         +Q+Ms3gzw9vo2LoxeJBVo2zrCXgOWa01I0IKCrJCFWJyD0naf00xciH8vTot2hIUjoMJ
         ElIgCuqOzEshWo+4NpzmMazwJ6sCFHyN9abVILbqri9UXMSFulPpdqnvCGplq9ynI/kJ
         gpNuezQA95tLAMRKtn9nk0tJL/zaMqRgPCDE1+P6GwXGP2yVLlWR0zVwmX0FZsZWeNDq
         3qAnpJL8TXHrn84zKL6ov3ZB1p0RfmcV+doHCQkk4lfyVLf1wKDa0WD1uz8zKBuzlWzl
         v9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734413443; x=1735018243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eprAB6mL99nuDvuDpZ7xteMR+o2NtdFYL2yb/syKiQ=;
        b=q1PqtF5EuEvOp7hFFuicUEqVbqkqDsQpfRsLFS0j9OD0o/OaCtl3XZb4MR9v1CbBru
         uxd6OMRHKWj9P+wqUBIpzr94IYGVwlYHqLOt0kZLCo2q5Q8ti+1J/YA7lhYOPAWUOdty
         C9wGglreUOVafDs5xcHNqgZVo0FMBFJ+xxjwTJYEjrcE8aypRtsqnQk9VyHOH1KCH9si
         HJL4EW0482LE6LwsOIWzdDZ2YyfMCYcyxziQ88W2ZjiVyBEOMVbfax2bGMHumoFC3J8w
         0XP+L1E3nvzP0j+eF/fTNr8EAXSiN5LfTZoObReymmDi0cphND9EwTi9SZXJGGoJw90W
         f0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWPgW0bsa7yPyQkWVeBvqROI04Hw2NHTe8/EnQFalJldhPZQXRp+mAEFDtYDIf30Cf4mSlj97S6khB8WnhPriN92XiM0hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI56pb3KTUZ65RwenQ+VltokEc56cvrew5VjlHcZQghKRcnYBU
	fc1ibJ0Y+++JcmFiZFIu4muQaiLz037orP90YNTC8+hv3WElX/vdb5RyteXBItE=
X-Gm-Gg: ASbGnctD3zwS0YH6FuDwWqLhC7wqLyJp/IwrSw7ftvgf5ZagTkXx/bEP7q5KDySrnWc
	rfilEunicrhdrKl4iqpoa68PCU5Sz0InrrNpo6uYR98NsQXR9dQXxgNoRUjPmsUafF60c76RPB+
	yVSQ5M4OFsyVO+tfY1MtK2jO9BFKV51gf1ddYQpTT4JeySO1QK5rb3vTrYobNeo9eaebnXXtmCb
	FcyCzzOs2HPevcKHq4Ug6k7uV0xOSKlmAvyRce3ZhPCFvrc12k=
X-Google-Smtp-Source: AGHT+IGGG8XVKg+X8rmGZK6CbMCJ7mkfFmLPI5+tN+Ymugv6wmhrKZix3qMLXbksYQCVWS+ftd5fVg==
X-Received: by 2002:a05:6a00:7c6:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-72a7872b694mr2639309b3a.5.1734413443517;
        Mon, 16 Dec 2024 21:30:43 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9708:a71e:40e6:860])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5883sm5945241b3a.63.2024.12.16.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:30:42 -0800 (PST)
Date: Mon, 16 Dec 2024 21:30:39 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/16] perf tools: arc: Support generic syscall headers
Message-ID: <Z2EMf8_oShdXHyL1@ghost>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
 <20241212-perf_syscalltbl-v2-2-f8ca984ffe40@rivosinc.com>
 <Z1zIlKq19lAXMoGs@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1zIlKq19lAXMoGs@google.com>

On Fri, Dec 13, 2024 at 03:51:48PM -0800, Namhyung Kim wrote:
> On Thu, Dec 12, 2024 at 04:32:52PM -0800, Charlie Jenkins wrote:
> > Arc uses the generic syscall table, use that in perf instead of
> > requiring libaudit.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/perf/Makefile.config                           | 2 +-
> >  tools/perf/Makefile.perf                             | 2 +-
> >  tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
> >  tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
> >  tools/perf/arch/arc/include/syscall_table.h          | 2 ++
> >  5 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a72f25162714f0117a88d94474da336814d4f030..3959a9c9972999f6d1bb85e8c1d7dc5dce92fd09 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
> >    endif
> >  
> >    # architectures that use the generic syscall table scripts
> > -  ifeq ($(SRCARCH),riscv)
> > +  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
> 
> This might work as well.
> 
>   ifneq ($(filter $(SRCARCH), riscv arc),)
> 
> And maybe you can add a variable for supported archs.

Yeah I can do that. All of this is just temporary though. The final
patch removes all of this, since this series implements this for every
architecture.

- Charlie

> 
> Thanks,
> Namhyung
> 
> 
> >      NO_SYSCALL_TABLE := 0
> >      CFLAGS += -DGENERIC_SYSCALL_TABLE
> >      CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f5278ed9f778f928436693a14e016c5c3c5171c1..3b463b42b0e3982e74056e672b2ee6adad5a3f0e 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -311,7 +311,7 @@ FEATURE_TESTS := all
> >  endif
> >  endif
> >  # architectures that use the generic syscall table
> > -ifeq ($(SRCARCH),riscv)
> > +ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
> >  include $(srctree)/tools/perf/scripts/Makefile.syscalls
> >  endif
> >  include Makefile.config
> > diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
> > --- /dev/null
> > +++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +syscall-y += syscalls_32.h
> > diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
> > --- /dev/null
> > +++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +syscall_abis_32 += arc time32 renameat stat64 rlimit
> > diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
> > --- /dev/null
> > +++ b/tools/perf/arch/arc/include/syscall_table.h
> > @@ -0,0 +1,2 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <asm/syscalls_32.h>
> > 
> > -- 
> > 2.34.1
> > 
