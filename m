Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C21DB53A
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417848; cv=none; b=mbtdw4o0yrjDX3f/yoFsbZpubXYUz/iRgiXLCg3OkCez60yCpzX2yjkmh72rXXDULc1c1Ok8BXK/X+91nWhBO6ZSpOMARafkzlQPD0MJ9FJw+SbEuwmRDjjjrVohEtllw8GbqXUiUHcUcEKYP1fKYV2dlkEf+29IlBKVyZfqxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417848; c=relaxed/simple;
	bh=XM6EdApDEzksuMmtbmXfUCRcI+WD33NtLIPMOkhyeDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQEXag/x7O/wxN3inOsc+zAr5yC35M9U2uuXLAhd6HtRIEHSgscWuicXq3hw3DG7ppxrDNaUl6TWyGXbmW2GXLiflfFYoJXI8g1efiWlhNXMu7MBOM/DOWQwunhdK3Q20m146V3xkZu9buvdFz+TmhIdhJ0qC+gs7V11S0Vqf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pPJ8kf2x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pPJ8kf2x"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso58641915ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 22:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417847; x=1735022647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sptCrX+fdOk7TfHGeXVf4O4ZKbAw/hvz5tMzXM5QRWU=;
        b=pPJ8kf2xnBe8hCzY7j+cNwCDDWX/xrw6NTCPVg6r/6fMr/ZyI9sfwuZ+ntElJSdTWZ
         ZhCeYwVODP25g9JqlF9g69CnE57SuasPlm+ZY0/r9lVUr/enbHje8ZxKfgXgXfXuDmV8
         mO2Xc+LvvQ0HsnMNRlF7Pnf1Aqb3jpiF8/xw7rCugs6XAuCcSMH+H+Qpi/DSN4HwY/eG
         CdUxgyMQj3MJFIBo0nAWzVOAyU8BJRN64wR27IGgtc5x8GrjArGUtz3HtHx+PPuIDPUx
         ifGB69DweiNwetpCZuDy1R4nyKMkBNg26RYNqX5WXwMYx0dgRO7Vl9CDklcds2glDjbC
         OmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417847; x=1735022647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sptCrX+fdOk7TfHGeXVf4O4ZKbAw/hvz5tMzXM5QRWU=;
        b=XbYMj35pRLDA5bRp2868iYpQ8OmLUOEut7fIt1+snzLGGZEDRh/Wf9p33/3AXM/6Wk
         /wdR4CeGtvBm09IY06JVqUFox8jOB2dYOlegqES+pF0HILfbzFMdYfppD2GFRNBuVmI1
         4d+31BlNuK1zj+lTJUNbpewYV9gFheaqVuojKbAfI9nf62/oM1UcD6sTa5zUEx+KZ0a/
         kww/8Lt6oRBg39bGwZocGxMqZGlOuwKdiEZHJoXQ5UrtEiRVxHaXs2ZfMFASJQUwSUK/
         6nozfClzaauJPDv8emfMu8ImeWd0zf6JDLpFQZLOeEk8OK41KAiQ5vu8r1hnsxWN8H8J
         LAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0uwkaibJ4OaxpIOEe90oZI4/vGhURmDyayGcKSWU/HqaC+C8YPXKXhouII4Xg5FfngFMqua1w3CGQCRkhv7DNT4xwRoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXHzegvtDIA36bHRTlS6s99ADz20CoW1a4bqzQ3ni2EcOdLJ+
	1Rl1mxw8URK/OUIkOMJuQtwl6iUM7YTJF2v8j+4KceWHg12DhvBlfjXzQ3+4msk=
X-Gm-Gg: ASbGnct8BIG5jbu9AVxJeuvDfnrMJpVpQjrd+IxUv/gxgvntxQFlX9EePmf6vVFrYwm
	tZhPu9wL5ap88171+w/dNbjy8PkOs7kwNtD7JJok4Bol+58ylpv2qYVCyeCdMKgGUfPHwfrjiKO
	VPuR8dz9u0xU27drJDnR+zDrfKqxF0Q2LPCqCoDrMfYmXlHxy6QOk+GxSAOL+Apfi2m4lB3wxqO
	VNSD5b41GqGF0HCJZvzqicvB7ezwTCUv2iPVHKRQohckLlB9xk=
X-Google-Smtp-Source: AGHT+IFbTJRs0BXv1Y7k1oAF2gI2HiBiChGf9jttH4DB2JoV1zZ1F2nYln3NdWZebP2jJGmxHiY0Vg==
X-Received: by 2002:a17:902:cec4:b0:216:2e6d:babd with SMTP id d9443c01a7336-21892a0dfc5mr201253875ad.15.1734417846715;
        Mon, 16 Dec 2024 22:44:06 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9708:a71e:40e6:860])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e643d5sm53002335ad.235.2024.12.16.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:44:05 -0800 (PST)
Date: Mon, 16 Dec 2024 22:44:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nelson Chu <nelson@rivosinc.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z2Edsv2VB7D1hq3n@ghost>
References: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
 <20241216-perf_fix_riscv_obj_reading-v1-2-b75962660a9b@rivosinc.com>
 <CAP-5=fVvLv-OtkK57ri1EpM_v=PQZDZijYBpGv_9Smyz8EOm2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVvLv-OtkK57ri1EpM_v=PQZDZijYBpGv_9Smyz8EOm2g@mail.gmail.com>

On Mon, Dec 16, 2024 at 08:57:20PM -0800, Ian Rogers wrote:
> On Mon, Dec 16, 2024 at 3:13 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > After binutils commit e43d876 which was first included in binutils 2.41,
> > riscv no longer supports dumping in the middle of instructions. Increase
> > the objdump window by 2-bytes to ensure that any instruction that sits
> > on the boundary of the specified stop-address is not cut in half.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig              |  5 +++++
> >  tools/perf/tests/code-reading.c | 17 ++++++++++++++++-
> 
> Files under tools use a different Build system than the kernel. The
> Kconfig value won't have an effect. Check out Makefile.config:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.config?h=perf-tools-next
> which is included into the build here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n313
> 

Ahh okay, thank you. It was properly enabling when I was testing, is
there some bleeding over?

> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..f164047471267936bc62389b7d7d9a7cbdca8f97 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -229,6 +229,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
> >         def_bool CC_IS_GCC
> >         depends on $(cc-option,-fpatchable-function-entry=8)
> >
> > +config RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION
> > +       # Some versions of objdump do not support dumping partial instructions
> > +       def_bool y
> > +       depends on !(OBJDUMP_IS_GNU && OBJDUMP_VERSION > 24100)
> > +
> >  config HAVE_SHADOW_CALL_STACK
> >         def_bool $(cc-option,-fsanitize=shadow-call-stack)
> >         # https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> > index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..605f4a8e1dbc00d8a572503f45053c2f30ad19e3 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <errno.h>
> > +#include <linux/kconfig.h>
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <inttypes.h>
> > @@ -183,9 +184,23 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> >         const char *fmt;
> >         FILE *f;
> >         int ret;
> > +       u64 stop_address = addr + len;
> > +
> > +       if (IS_ENABLED(__riscv) && !IS_ENABLED(CONFIG_RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION)) {
> 
> It would be nice if this could be a runtime rather than build time detected.

Hmm that is a good point. I will change this to check the version at
runtime.

- Charlie

> 
> Thanks,
> Ian
> 
> > +               /*
> > +                * On some versions of riscv objdump, dumping in the middle of
> > +                * instructions is not supported. riscv instructions are aligned along
> > +                * 2-byte intervals and can be either 2-bytes or 4-bytes. This makes it
> > +                * possible that the stop-address lands in the middle of a 4-byte
> > +                * instruction. Increase the stop_address by two to ensure an
> > +                * instruction is not cut in half, but leave the len as-is so only the
> > +                * expected number of bytes are collected.
> > +                */
> > +               stop_address += 2;
> > +       }
> >
> >         fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
> > -       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
> > +       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
> >                        filename);
> >         if (ret <= 0 || (size_t)ret >= sizeof(cmd))
> >                 return -1;
> >
> > --
> > 2.34.1
> >
