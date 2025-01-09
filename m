Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB62054E4
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jan 2025 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452125; cv=none; b=uWq5WXDn7zNNVoaiEyLrNZ2Q0zZwRnBX/cTWJ59KO4dpjmhREqQm+eQkrq93ASxQrXGuWdt3jg961n8jqWf7xGRy1F6MzkGmxArFrPqRp144F26JwfcYfkb8gMZjwJs9xzWaxtC4QMeZ4oOfHTDpXF9el2uHThzO+01fMJjIn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452125; c=relaxed/simple;
	bh=D6B4BajMET+2TRhn88NxZIQ+bJWXtAz1Mfi9B6hFn2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmITHx62c3D4P1ALsZrasy89YNUCwH/lSozLVa3xb9IiyFlJ+nsunKjo+o0AsOxQG1jT5EWBAEwXqz+aagd/dgNvFat0+RhQLmXSVKy3HXgTUXNXrkZeBXJP7DoQkwrUoG95xO1T/n8M5zB4ZgnysjdTq2XnvFmH9vGaXWpxf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P6MNk2C0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P6MNk2C0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166f1e589cso25435945ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736452121; x=1737056921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7b+M8bLdxMMDXL0txEk2e29RoPCEkK7c4yJCv5CXWo=;
        b=P6MNk2C0SJZ7m35IT26aHflyp9jsmxiKmSMWxHt7KuK6r/FDM1As3qA+wHK9huwE17
         J7WQh00dq0K6fw9OyKbtN3K4ky5ttG7v9HH+908SnFw4uLePs3ceBEtYMm+QZpqMkAEq
         jjtHclSkjvCfu/vZdQpyRJOm8ys1aO4GIS5Fr5lkwk/nfdQBl0wGJnTLw9A9nYfINsyf
         7alH9x3IYhrZZmhpPHCs5kYBb9CpPC1Z7s5/5zWdI+59yhFnZ4Xb5wVO8+97XMg5A9k5
         4kSLyH4hM2RN//UbG69Hnhd7apfjv7FAXKWKgqqqIivwhmxV9iHE+plj81IIJ3gkfy1C
         CjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736452121; x=1737056921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7b+M8bLdxMMDXL0txEk2e29RoPCEkK7c4yJCv5CXWo=;
        b=Z2StbrV5Z2b0Bn2F0K39eCUGv/OVEzxNVEj1fugYx4MCvsMpgP2KOf89tOneDwgM1D
         gulTq7jSxu3lXfpexE2JVT5WeTBY8HTKD3GNCtqn1xj2MVuwWjqZatpByrg1npX5CfyJ
         Xp40b+TkUgahnLKlGdx3dbUJrgL0ki7B2IIWlF2pEq03gPvmE5pN+NBVWdY3+HFATdSv
         FjfOsv+VjGWsJpXda4BCVbRzbbI1yHxk7Qu0VSI4C/A982197YOHpnysrblW+gaBLLLI
         32H3C2D1IbuPSTo6oCgF6tGSrIZo4BEbF5EWQ5It3rYx9M/hJvJicvfj0pw6JbvA/OS1
         /BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq7TCnDhSfC5Zq9TknDyUnBXrnh3wnHFzB1JNUwk9XkDm4pjhqdrdiyax81Ylc64W3r1nBlKc2bOHRODOJ7D9cvcYPkCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx5EIRIRycDoXtIwCm6qLVqSG0hVVbNCAnK8Hz8Cs1oYfzRS/c
	GaLCTsuryDxNaR8lCQe1cVJy6MWJp40u85j5MZ1yEcN4yepUU5TXekkLrmx1r2Q=
X-Gm-Gg: ASbGncuA2skZDiB/e2qQNu0oBOZ7B1zvJLH2bTpUkfqC0a67gqiCwilzm/dfAhbfmRw
	Ha1F1u7XBqQZYBn/dJ9CAc22zSroBF5vUlHHXdzSWwG971j5rIX2nXn1JZBGvBmdmRMTURBnWPM
	kBjjBvu7AAxowcNdoDWkiRCxPdCtkcaKLUULnOO2YCnveqOJvrH3O01Kk7ph8s24TngGrJpiwDS
	mM7M8BdBGo4/7whU3OqcZ/3OSZqAPa1XiDEnqvc0ads24dTgTiz
X-Google-Smtp-Source: AGHT+IGqjTKjlwbC+P7rH4jnmptwQdrncdhIeRy9Z8irsAs8dzgv7ivzqLDAR+d7hQV4K4lcyKluyg==
X-Received: by 2002:a17:902:f70f:b0:216:32ea:c84b with SMTP id d9443c01a7336-21a83fc3652mr126858965ad.37.1736452120766;
        Thu, 09 Jan 2025 11:48:40 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f13c92dsm1606215ad.97.2025.01.09.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 11:48:39 -0800 (PST)
Date: Thu, 9 Jan 2025 11:48:36 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4AoFA974kauIJ9T@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3_ybwWW3QZvJ4V6@x1>

On Thu, Jan 09, 2025 at 12:59:43PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 08, 2025 at 06:36:15PM -0800, Charlie Jenkins wrote:
> > Standardize the generation of syscall headers around syscall tables.
> > Previously each architecture independently selected how syscall headers
> > would be generated, or would not define a way and fallback onto
> > libaudit. Convert all architectures to use a standard syscall header
> > generation script and allow each architecture to override the syscall
> > table to use if they do not use the generic table.
> > 
> > As a result of these changes, no architecture will require libaudit, and
> > so the fallback case of using libaudit is removed by this series.
> > 
> > Testing:
> > 
> > I have tested that the syscall mappings of id to name generation works
> > as expected for every architecture, but I have only validated that perf
> > trace compiles and runs as expected on riscv, arm64, and x86_64.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > ---
> > Changes in v6:
> > - Use tools/build/Build.include instead of scripts/Kbuild.include
> > - Link to v5: https://lore.kernel.org/r/20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com
> 
> Passed these, so far, more tests underway:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove dependency on libaudit
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JJT3tvN7bV
>               make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.BF53V2qpl3
> - /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
> cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
>          make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.KZuQ0q2Vs6 DESTDIR=/tmp/tmp.0sxMyH91gS
>            make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.Y0Mx3KLREI DESTDIR=/tmp/tmp.wg9HCVVLHE
>               make_install_O: cd . && make install FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.P0LEBAkW1X DESTDIR=/tmp/tmp.agTavZndFN
>   failed to find: etc/bash_completion.d/perf

Is this something introduced by this patch?

- Charlie

>          make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.AQ4uSxhHzq DESTDIR=/tmp/tmp.SyRIMEwTpJ
>          make_refcnt_check_O: cd . && make EXTRA_CFLAGS=-DREFCNT_CHECKING=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.boLQpo3gGR DESTDIR=/tmp/tmp.pvNzMWlMJP
>  
> > Changes in v5:
> > - Remove references to HAVE_SYSCALL_TABLE_SUPPORT that were
> >   missed/recently introduced
> > - Rebase on perf-tools-next
> > - Install headers to $(OUTPUT)arch instead of $(OUTPUT)tools/perf/arch
> > - Link to v4: https://lore.kernel.org/r/20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com
> > 
> > Changes in v4:
> > - Remove audit_machine member of syscalltbl struct (Ian)
> > - Rebase on perf-tools-next
> > - Link to v3: https://lore.kernel.org/r/20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com
> > 
> > Changes in v3:
> > - Fix compiliation when OUTPUT is empty
> > - Correct unused headers to be .h instead of .c  (Namhyung)
> > - Make variable definition of supported archs (Namhyung)
> > - Convert += into := for syscalls headers (Namhyung)
> > - Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com
> > 
> > Changes in v2:
> > - Rebase onto 6.13-rc2
> > - Fix output path so it generates to /tools/perf/arch properly
> > - Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com
> > 
> > ---
> > Charlie Jenkins (16):
> >       perf tools: Create generic syscall table support
> >       perf tools: arc: Support generic syscall headers
> >       perf tools: csky: Support generic syscall headers
> >       perf tools: arm: Support syscall headers
> >       perf tools: sh: Support syscall headers
> >       perf tools: sparc: Support syscall headers
> >       perf tools: xtensa: Support syscall header
> >       perf tools: x86: Use generic syscall scripts
> >       perf tools: alpha: Support syscall header
> >       perf tools: parisc: Support syscall header
> >       perf tools: arm64: Use syscall table
> >       perf tools: loongarch: Use syscall table
> >       perf tools: mips: Use generic syscall scripts
> >       perf tools: powerpc: Use generic syscall table scripts
> >       perf tools: s390: Use generic syscall table scripts
> >       perf tools: Remove dependency on libaudit
> > 
> >  Documentation/admin-guide/workload-tracing.rst     |   2 +-
> >  tools/build/Build.include                          |   2 +
> >  tools/build/feature/Makefile                       |   4 -
> >  tools/build/feature/test-libaudit.c                |  11 -
> >  tools/perf/Documentation/perf-check.txt            |   2 -
> >  tools/perf/Makefile.config                         |  39 +-
> >  tools/perf/Makefile.perf                           |  12 +-
> >  tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
> >  .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
> >  tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
> >  tools/perf/arch/alpha/include/syscall_table.h      |   2 +
> >  tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
> >  .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
> >  tools/perf/arch/arc/include/syscall_table.h        |   2 +
> >  tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
> >  .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
> >  tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
> >  tools/perf/arch/arm/include/syscall_table.h        |   2 +
> >  tools/perf/arch/arm64/Makefile                     |  22 -
> >  tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
> >  .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
> >  .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
> >  .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
> >  tools/perf/arch/arm64/include/syscall_table.h      |   8 +
> >  tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
> >  .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
> >  tools/perf/arch/csky/include/syscall_table.h       |   2 +
> >  tools/perf/arch/loongarch/Makefile                 |  22 -
/scratch/ewlu/ppa/new-glibc-dumps$ file core._home_ubuntu_glibc_glibc-2_39_build-tree_riscv64-libc_elf_ld_so.1000.a95f9a60-edce-47cf-a6fb-14d3a1705685.58093.1340004> >  tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
> >  .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
> >  .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
> >  tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
> >  tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
> >  .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
> >  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
> >  tools/perf/arch/mips/include/syscall_table.h       |   2 +
> >  tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
> >  .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
> >  tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
> >  tools/perf/arch/parisc/include/syscall_table.h     |   8 +
> >  tools/perf/arch/powerpc/Makefile                   |  25 -
> >  tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
> >  .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
> >  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
> >  tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
> >  tools/perf/arch/riscv/Makefile                     |  22 -
> >  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
> >  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
> >  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
> >  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
> >  tools/perf/arch/s390/Makefile                      |  21 -
> >  tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
> >  .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
> >  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
> >  tools/perf/arch/s390/include/syscall_table.h       |   2 +
> >  tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
> >  .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
> >  tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
> >  tools/perf/arch/sh/include/syscall_table.h         |   2 +
> >  tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
> >  .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
> >  tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
> >  tools/perf/arch/sparc/include/syscall_table.h      |   8 +
> >  tools/perf/arch/x86/Build                          |   1 -
> >  tools/perf/arch/x86/Makefile                       |  25 -
> >  tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
> >  .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
> >  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
> >  tools/perf/arch/x86/include/syscall_table.h        |   8 +
> >  tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
> >  .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
> >  tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
> >  tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
> >  tools/perf/builtin-check.c                         |   2 -
> >  tools/perf/builtin-help.c                          |   2 -
> >  tools/perf/builtin-trace.c                         |  30 --
> >  tools/perf/check-headers.sh                        |   9 +
> >  tools/perf/perf.c                                  |   6 +-
> >  tools/perf/scripts/Makefile.syscalls               |  61 +++
> >  tools/perf/scripts/syscalltbl.sh                   |  86 ++++
> >  tools/perf/tests/make                              |   7 +-
> >  tools/perf/util/env.c                              |   6 +-
> >  tools/perf/util/generate-cmdlist.sh                |   4 +-
> >  tools/perf/util/syscalltbl.c                       |  90 +---
> >  tools/perf/util/syscalltbl.h                       |   1 -
> >  tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
> >  87 files changed, 4105 insertions(+), 623 deletions(-)
> > ---
> > base-commit: 034b5b147bf7f44a45e39334725f8633b7ca8c3b
> > change-id: 20240913-perf_syscalltbl-6f98defcc6f5
> > -- 
> > - Charlie
