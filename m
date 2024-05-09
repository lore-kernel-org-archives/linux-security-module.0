Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B784A5E
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289578; cv=none; b=T2lCm3Bdnj4ADZvR+53fkQUXKW2aFeSlmmYyj9mLvxJZkEWhcNbAOOq5AJNUy1HUbzC7zLXZGzAp9rsfIjQayWI2oZp0CU+cO5Ibj4Gh+6a4lyhmHvwa8tUmTNwiJoWW2gL1Q4bkVnvtbJbCw5qfQP30uCJRoBpzlUROWQk3Px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289578; c=relaxed/simple;
	bh=Um2iaQ7WeSFO93nhxJoPQRrULk9qwBNcQZW38ADgIuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX2GFr0Nw9u4zUQfe3XVhRt4F60Xb5QdMYl9LuHWDMpr0vTPLMDGnLWVqnC1niQzzpyVWAiBAAP4d3ylZdXgJVyw/GLsvRPCT4/NA/kog8H8pB/2imuRK2wQBCjrrZ0g3JWGpKdm7+HmP42wmeAAyOASWnnX40gZ9itRnX+o2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trNPV7GA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trNPV7GA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso1762a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715289575; x=1715894375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=trNPV7GAjAMpGgGW8LZyLxXFHt7j85bparG02TyCKFXIGFgf4sHap+1w3Cn7C93R8U
         DG6380Z3+Hi1WYJwez1iMPmgXqA/pXdegK7RMqAUXtNMH69WbOK8wlCMU4wpVoWiVRMP
         NwvHhyUh7C8fKOATyP1Z5O9sQQgs3xa+pLLToxLIdVrij8BFLnOqc5N/lbX2190CMCjn
         fgUX2GnMjgE8jbcJDPQxvAb5zbogmF4lPXWJNmQMQJ5jdSjJ0C4fO2+zh9+x+KK0w9Ok
         GH3MAe/9Q/M8cvxdXxnv+x4Uxb2brv5vu5ZUdC3Qk+VNByptN/ZbFYJcefDT9cctVmJT
         oJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289575; x=1715894375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=dTzuX3Eq64XTaAwsbxQNfmSm6amZ+7gCEWFT1UjsHSJhWiPjZywdlOADa3SWoiVO0U
         3OWr8bJFA3kb6v2x9OM7llU9CvwRfvqmg+s4HjH+dawcOFZUTzrQIaTcsF1kuY/IgpeX
         3PGQKgIJNQHcmYdVH17gDA8HG2f+s19F5r7dS8xqeE6hmdCgvqc3r/W+EBchlWcF5k9L
         3i+Je75+0GRiQPuMSlQYqLT0fCN4j9k8nGV0BOUW34dKsHMWxb8VT/8JVdG6kg1jmT7B
         Z2D+0cN0frBAh2gfHyIssjdJJLKV36rtAz7AJONR5oCfmi5TkRxbIwvNG3mTOUuVsl9U
         4Pzg==
X-Forwarded-Encrypted: i=1; AJvYcCUUMfgTYmlt2hESZsjzTAwT/VUkWorJcldfycfAYRi2d3fo0K2guehdXP2o41AB9EWZav1wy+hywqgh2J+TCrXWwPxw4oNA/Z/76RBaZ8SPZc1TrjgR
X-Gm-Message-State: AOJu0YwUzrnY7V2WGT09H5Cc31uvgOqiwH9lX+FogQK22xYwh+gRiJEI
	DkMMoymcVy8mpE02OJZgywNnRDoixfrFNG45r1eY1umS/KDA4SDm7LZo2ABdPqLbswQIhZfbd5P
	CTAm53VvEVhMROkb8cF38mnt9sbP4P7FseDoa
X-Google-Smtp-Source: AGHT+IGI4zzf79CVFYKmEZhPf2lhqJh1b8pYhjbZ5go+AXsEnSPUSUtKffiZRTXlmKPdbvdXpzTycKoV7ugVsV+l6ts=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-57351ffc899mr8908a12.3.1715289570474; Thu, 09 May 2024 14:19:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com> <20240509200022.253089-55-edliaw@google.com>
 <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
In-Reply-To: <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 14:19:05 -0700
Message-ID: <CAG4es9UxSmaSdRU7T5q2t_TgOJg+=8UPf8xmTV5bhP6gbDwJuA@mail.gmail.com>
Subject: Re: [PATCH v3 54/68] selftests/rseq: Drop define _GNU_SOURCE
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:16=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-05-09 15:58, Edward Liaw wrote:
> > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > redefinition warnings.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
>
> The patch per se looks fine, except for the "Fixes" tag.
>
> Commit 809216233555 introduces use of asprintf in kselftest_harness.h
> which is used by (all ?) selftests, including the rseq ones. However,
> the rseq selftests each have the #define _GNU_SOURCE, which would have
> been OK without those further changes.
>
> So this patch is more about consolidating where the _GNU_SOURCE is
> defined, which is OK with me, but not so much about "fixing" an
> issue with commit 809216233555.
>
> A "Fix" is something to be backported to stable kernels, and I
> don't think this patch reaches that threshold.
>
> If anything, this patch removes a warning that gets added by
> https://lore.kernel.org/lkml/20240509200022.253089-1-edliaw@google.com/T/=
#mf8438d03de6e2b613da4f86d4f60c5fe1c5f8483
> within the same series.
>
> Arguably, each #define _GNU_SOURCE could have been first protected
> by a #ifndef guard to eliminate this transient warning, and there
> would be nothing to "fix" in this consolidation series.

That makes sense.  I can remove the fixes tags.  809216233555 will
likely be reverted first anyway, and you're right that the focus of
this patch series is on consolidating _GNU_SOURCE.


>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
> >   tools/testing/selftests/rseq/basic_test.c            | 2 --
> >   tools/testing/selftests/rseq/param_test.c            | 1 -
> >   tools/testing/selftests/rseq/rseq.c                  | 2 --
> >   4 files changed, 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/too=
ls/testing/selftests/rseq/basic_percpu_ops_test.c
> > index 2348d2c20d0a..5961c24ee1ae 100644
> > --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <pthread.h>
> >   #include <sched.h>
> > diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/=
selftests/rseq/basic_test.c
> > index 295eea16466f..1fed749b4bd7 100644
> > --- a/tools/testing/selftests/rseq/basic_test.c
> > +++ b/tools/testing/selftests/rseq/basic_test.c
> > @@ -2,8 +2,6 @@
> >   /*
> >    * Basic test coverage for critical regions and rseq_current_cpu().
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <sched.h>
> >   #include <signal.h>
> > diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/=
selftests/rseq/param_test.c
> > index 2f37961240ca..48a55d94eb72 100644
> > --- a/tools/testing/selftests/rseq/param_test.c
> > +++ b/tools/testing/selftests/rseq/param_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <linux/membarrier.h>
> >   #include <pthread.h>
> > diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selfte=
sts/rseq/rseq.c
> > index 96e812bdf8a4..88602889414c 100644
> > --- a/tools/testing/selftests/rseq/rseq.c
> > +++ b/tools/testing/selftests/rseq/rseq.c
> > @@ -14,8 +14,6 @@
> >    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> >    * Lesser General Public License for more details.
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <errno.h>
> >   #include <sched.h>
> >   #include <stdio.h>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
