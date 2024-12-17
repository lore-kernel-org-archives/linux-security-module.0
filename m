Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DB14831E
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411455; cv=none; b=PRfPU6SpEzOZcyvD41WsBDhlxHxPV+rtc8Nthwfn2XRWJBj8jBh2WhiNJk75zAma4p6PMg0LuAWB+FQUMwwT9RethnvQmQNI5G/9QWbbmG1k7cHhC0I/hFszhftegGQ/DQu3h3kcW2Bv6k2m4LLwqD0OZPUrFtPBzfO8SSkXqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411455; c=relaxed/simple;
	bh=fAZh6YN7BDxWYSlX0Fp1Tgj9S+0JUp7/sHCKRiQuiUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkWIQ2VJyFGWcVlr96Iz5OotsPqYLCyIhxQSjGM8BWOmjY1IhUBrekx4ishH810sev+IJ87TmCLPbuxRsHwMM8qNXQqcmMfJJU1l6X/dm+aohniplfGewNBSaGTPV7ibsHxmKj6jtjgA9jkD9q376JW5nqXwr8hji5E+T0C4c00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIiIl06d; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIiIl06d"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso61285ab.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 20:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734411452; x=1735016252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=362/6wPaNoggwJpGGOdG6RgZlj612Z1MukeYbnnzsUo=;
        b=LIiIl06dWR6lg0bJDxXMf0QxMv6IEm6+lKoJUB6Xs4TcTmqzDGu89+bgKhz5CBR3zy
         TGu1U7Y5LzgRGTnguXltIq9dILKNum/+/p5FhlYdE2Z36bnr5fj2WPjuDR2FQRVxIwAd
         tSBquImO50nGkfkXwXGdxE7NGvq6ZJlEuwZxd8xmvgkkp1fHhELH13tyTFhNmc0ckB8P
         Hso9ZVxNryXJcnlppwRxGXWh8h5/r2N8DshePIUxLiZyUw0ybfjc2B8ehBf9/0xHvODI
         p8++Q2QcgMBik3XHirRr3jdJL5lR8iYKO0oz9G2LbTJj/1EIY/HAlfCWiBqu3S2Zxc/5
         YZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734411452; x=1735016252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=362/6wPaNoggwJpGGOdG6RgZlj612Z1MukeYbnnzsUo=;
        b=HRpGbDpTF01aiZYk5AS+lY0Oo8IwXNs/C/EK0pd3zZ4wRq61Qz6vG+CB5XjOgGKJ9Q
         Z3LtM3LqwQOYukDqjX3C6X+kFKPV6RYmx57zASfh0FqrE8blWNOLkEk4xsNGIhf15Jjg
         ncCJuq8J/BmkL2Nl2wtgPEjUcs28hw8FU/V1H2342q2lc0vigGadkihgEDHxDhxuw+87
         co1Y67Z8yXcqLH53qO3KJKerrk6icBWx8k4EHZ/L8N7wADeSrM19VIeXXolaIR47p8Xu
         RDNKd9MRs50XlkTWRPQS37dG2XqiJH+/bteax5clgp6SlnpIhVl9yaIAXtSJ9yTfc0hA
         ct5A==
X-Forwarded-Encrypted: i=1; AJvYcCUnImSUbHaOEe66XEKl/jUKzA2Jrfkp1/ZRJrNgsiuJdp3ff68rGNpfPxFWCWaytL+J2tsCWhvMd3+1ZIrCTmJwh3idx5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zO4gd4XJKF2MZvfKB+6jSJ+Oyjwd3EznLDvm0vUSJoOiTC3x
	Ux2ngdVYIHlzHH1AvU9RIVyIPOgZdn5cIpBj/fsrNed+ZtR+WyppRtp5btQFyd8XvAWEpmxY+mb
	1MVBXNpaK5nzat9vviWB/ssqbTbt7chY9/zfd
X-Gm-Gg: ASbGnctSUmOa0Lc47zZHbtUMLTuUpmhQ5S7p1wc8ZSDoJ5bpO0BpbWgfJUKH4jC9pJ0
	5J8kVTn/CcPq/epVUfF4CmZCdr+Mt1miPoTf9li8=
X-Google-Smtp-Source: AGHT+IEon0H5P/SgKkxsKeFtvxthHZIZFm7pK/6IZOgc7rOanq4HBnSG1t4asn1594qBhXnfuxhIF4Hwq5/vBKcKGhQ=
X-Received: by 2002:a92:ccc4:0:b0:3a7:ddbb:1b19 with SMTP id
 e9e14a558f8ab-3bb8430e0d7mr995405ab.27.1734411452091; Mon, 16 Dec 2024
 20:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
 <20241216-perf_fix_riscv_obj_reading-v1-2-b75962660a9b@rivosinc.com>
In-Reply-To: <20241216-perf_fix_riscv_obj_reading-v1-2-b75962660a9b@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Dec 2024 20:57:20 -0800
Message-ID: <CAP-5=fVvLv-OtkK57ri1EpM_v=PQZDZijYBpGv_9Smyz8EOm2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: perf: tests: Fix code reading for riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nelson Chu <nelson@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:13=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> After binutils commit e43d876 which was first included in binutils 2.41,
> riscv no longer supports dumping in the middle of instructions. Increase
> the objdump window by 2-bytes to ensure that any instruction that sits
> on the boundary of the specified stop-address is not cut in half.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig              |  5 +++++
>  tools/perf/tests/code-reading.c | 17 ++++++++++++++++-

Files under tools use a different Build system than the kernel. The
Kconfig value won't have an effect. Check out Makefile.config:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.config?h=3Dperf-tools-next
which is included into the build here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n313

>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..f164047471267936bc62389b7=
d7d9a7cbdca8f97 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -229,6 +229,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
>         def_bool CC_IS_GCC
>         depends on $(cc-option,-fpatchable-function-entry=3D8)
>
> +config RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION
> +       # Some versions of objdump do not support dumping partial instruc=
tions
> +       def_bool y
> +       depends on !(OBJDUMP_IS_GNU && OBJDUMP_VERSION > 24100)
> +
>  config HAVE_SHADOW_CALL_STACK
>         def_bool $(cc-option,-fsanitize=3Dshadow-call-stack)
>         # https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a48=
4e843e6eeb51f0cb7b8819e50da6d2444d769
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..605f4a8e1dbc00d8a572503f4=
5053c2f30ad19e3 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <inttypes.h>
> @@ -183,9 +184,23 @@ static int read_via_objdump(const char *filename, u6=
4 addr, void *buf,
>         const char *fmt;
>         FILE *f;
>         int ret;
> +       u64 stop_address =3D addr + len;
> +
> +       if (IS_ENABLED(__riscv) && !IS_ENABLED(CONFIG_RISCV_OBJDUMP_SUPPO=
RTS_SPLIT_INSTRUCTION)) {

It would be nice if this could be a runtime rather than build time detected=
.

Thanks,
Ian

> +               /*
> +                * On some versions of riscv objdump, dumping in the midd=
le of
> +                * instructions is not supported. riscv instructions are =
aligned along
> +                * 2-byte intervals and can be either 2-bytes or 4-bytes.=
 This makes it
> +                * possible that the stop-address lands in the middle of =
a 4-byte
> +                * instruction. Increase the stop_address by two to ensur=
e an
> +                * instruction is not cut in half, but leave the len as-i=
s so only the
> +                * expected number of bytes are collected.
> +                */
> +               stop_address +=3D 2;
> +       }
>
>         fmt =3D "%s -z -d --start-address=3D0x%"PRIx64" --stop-address=3D=
0x%"PRIx64" %s";
> -       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, =
addr + len,
> +       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, =
stop_address,
>                        filename);
>         if (ret <=3D 0 || (size_t)ret >=3D sizeof(cmd))
>                 return -1;
>
> --
> 2.34.1
>
