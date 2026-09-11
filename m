Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C52C235E
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130868; cv=none; b=YCINWj7Xcr18t86ckFdWoPUevqDX9lisMcq12f4oBSt8TmcsHhcnyQ7a9H2tPjjxdeN5TLAFdTTwbDHx7Sy716BWASofPsx9IIF/FtICNx/y3Xef+TpJ4MHSXY/Dg9BUuwfhZRmyjyO7AV0VLWPDo0mlXzBitsyJlhXJlto/g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130868; c=relaxed/simple;
	bh=IxJS5KyU+21Niru1Wn1OnOIl9SC8Gu4wuIjiOtQQB9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCBepKEFuFhUrqpq4Pt2AgyUxNUc1Vn86kJ1+0Ue1z91aZgOyDbqM0bJ4yQC9WwVtyt683tl9T3bNI8wFi3uqjuYawuoA52INj+HEnZheTRGH+sZMEyRH8sHZjTsjRhzO1z+Wzeq5GQgIDy4wted+df8t+RMXm/zGbfqFNO5Oy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmntemhW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmntemhW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so13234685e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789130865; x=1789735665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NP7YlHIaFlaJ4Iw2lII4MMkuIbD2GrjsP9KZVe4M9u0=;
        b=OmntemhWha56148V2qKKhTOdDywaK0Z4FqiT15TovmWXfjrhVcFI7PB0gxt9KKuoqd
         B42tB00MYjiu2ar211ApkH89QzODxKsr0sHYz12Du81S3FpVa9RmNhtE2m2MhOkKbJ6a
         GvJpg/jA0AGaZEzJeXbrmnLq788jmez0pXkpbeVcBEA/3KfdofKroRdYI2R3QG51bWjF
         cfs1uI8nrmdvRDuR8xo8oqo6xLWQlmzQOyeyKnAeoLmjflTMbMcwjXFQgFhaxlyM0wmE
         WD9EE+PEeWww7xj9ERyLP68QSti45i6DY4tWMKR/PmN7Pg3YlPRcfkObJ1deOsTMvgBl
         bqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130865; x=1789735665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NP7YlHIaFlaJ4Iw2lII4MMkuIbD2GrjsP9KZVe4M9u0=;
        b=VSUlNsuIlglCO4X9TU8AD5VGaG0SNsBe4ljbUfMVWpCoUfCLFze0ViPJbVGondA1W7
         /3rui3oJBPRLrCa7dX3icrC7FvXsjC7kd9enTvx5kYOBTPcxVQHkf7pLQeDoHYlYhE6N
         7Vf0f8KgHOAvv1JivTSd4RNFCx0I8jTzgsYmIixLFaSRO6OAvwYAh/rxcivcpzKMLy+H
         Xhgdc5yYMnh8GOHHjpaVgufHMLCBfJSmtsysSpktSvNmWWb37ch0Gx1a3/H5vnq62uyV
         8ka+aYDy1+wRDpUG3vM3PXrhvnL2dzmWqjIfIOfCBJAJmStGjHVt5o4gVNzEL9UAi8pk
         ISfw==
X-Gm-Message-State: AFuF++nyoQ1UF/cy28c4jcdydWjcI6PWFiPamNr3Ox1l4LMMmBLHHXIX
	919tfgyy2u/65FKNY/eLzOP4hCCVblk4iTb8OmU6irZTQETB3sbGSzZej/uMxofgXsQwV2bxoyv
	+ZyspIV30
X-Gm-Gg: AYBFou1G22zeFC6+cY7bqn2atzHuOdTJeorEmiLQqg//qOY8RINqTPtCmfaTYtqAeBt
	0ahyN7Z6VbswLLRJIGFi3iSaQEyxUpIIhE68T/Rifgnlk/CQB5gyAA1uxkifV1VbwG/HMm8cIWq
	2f7s4rIlaqEfitX2NSAaC9qaZKrIYB9pdUbJK5I8HqxqnA4ioufCdTrw8owXWtFfJDP5GsMyVv8
	XgRCnh7xRiEeoDCpbpVc0I19sC27kKslXX9ePr3b68eU+FrqT+FUtFrxIFKS+tPJwS6lHG0MaoM
	KeSws13Kb495YXegVasS4M+o7DNzGySCXlexvcSBZv3m1xdQyBHob1zbsFOgE5DDFlXk8rtkRt3
	/Ap91TLj6FhCB+M0HC0EWUdCb3YNfuZWVsdOxy/0CD4VxoOGadkVfyHM6+Cx7X3wIJriXrJl96v
	J+o1Blo1r3368VF5vyqbi6m4z6kv7kWYobb/efYQcBlAYwN9Xk++gTcdAUXkVYDV0Og7ZPoe6Nu
	lZ7tHqvrnR/eZqKyBebFhNqJLhIgA==
X-Received: by 2002:a05:600d:8494:20b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49e619c461bmr13852375e9.23.1789130864319;
        Fri, 11 Sep 2026 05:47:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d2ad:5013:49af:fe38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62225628sm44331305e9.3.2026.09.11.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:47:43 -0700 (PDT)
Date: Fri, 11 Sep 2026 14:47:38 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/2] selftests/landlock: Fix trace variant formatting
Message-ID: <aqP4alTn-mtM3Heh@google.com>
References: <20260907160710.126525-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907160710.126525-1-mic@digikod.net>

On Mon, Sep 07, 2026 at 06:07:06PM +0200, Mickaël Salaün wrote:
> Group-wide clang-format exclusions also cover comments and unrelated
> initializers, hiding which construct needs protection and leaving some
> variant fields bin-packed.
> 
> Use per-variant guards and format designated fields one per line.  End
> each guard after the macro header when clang-format preserves the
> initializer.  Keep the initializer guarded only where re-enabling
> clang-format would bin-pack its fields.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/net_test.c   | 13 ++--
>  .../landlock/scoped_abstract_unix_test.c      | 56 ++++++++++++-----
>  tools/testing/selftests/landlock/trace_test.c | 62 ++++++++++++++-----
>  3 files changed, 95 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index a18761e0fd82..0d13556c50f2 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -3569,31 +3569,34 @@ FIXTURE_VARIANT(trace_net_connect) {
>  	bool deny_connect;
>  };
>  
> -/* clang-format off */
> -
>  /* Denied connect(): sport=0, dport=<denied port>. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_net_connect, connect_denied) {
> +	/* clang-format on */
>  	.handled = LANDLOCK_ACCESS_NET_CONNECT_TCP,
>  	.bind_base_first = false,
>  	.deny_connect = true,
>  };
>  
>  /* Denied bind(): sport=<denied port>, dport=0. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_net_connect, bind_fields) {
> +	/* clang-format on */
>  	.handled = LANDLOCK_ACCESS_NET_BIND_TCP,
>  	.bind_base_first = false,
>  	.deny_connect = false,
>  };
>  
>  /* Denied connect() after an allowed bind(): the connect fields (sport=0). */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_net_connect, connect_after_bind) {
> -	.handled = LANDLOCK_ACCESS_NET_BIND_TCP | LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_NET_BIND_TCP |
> +		   LANDLOCK_ACCESS_NET_CONNECT_TCP,
>  	.bind_base_first = true,
>  	.deny_connect = true,
>  };
>  
> -/* clang-format on */
> -
>  /*
>   * A denied TCP bind(2) or connect(2) emits one deny_access_net event.  The port
>   * is reported in the field matching the denied operation, in host endianness
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> index eed684d4c364..54bc4081cd56 100644
> --- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -1268,27 +1268,38 @@ FIXTURE_VARIANT(trace_unix) {
>  	size_t name_len;
>  };
>  
> -/* clang-format off */
> -
>  /* Stream: sandboxed client connect() to an unsandboxed peer (peer_domain=0). */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, stream_denied) {
> -	.sock_type = SOCK_STREAM, .sandbox = true,
> -	.sandbox_target = false, .expect_denied = 1,
> +	/* clang-format on */
> +	.sock_type = SOCK_STREAM,
> +	.sandbox = true,
> +	.sandbox_target = false,
> +	.expect_denied = 1,
>  };
>  
>  /* Stream: peer socket owned by a domain, so peer_domain != 0. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, stream_denied_scoped_peer) {
> -	.sock_type = SOCK_STREAM, .sandbox = true,
> -	.sandbox_target = true, .expect_denied = 1,
> +	/* clang-format on */
> +	.sock_type = SOCK_STREAM,
> +	.sandbox = true,
> +	.sandbox_target = true,
> +	.expect_denied = 1,
>  };
>  
>  /* Stream: unsandboxed client, connect() succeeds, no event. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, stream_allowed) {
> -	.sock_type = SOCK_STREAM, .sandbox = false,
> -	.sandbox_target = false, .expect_denied = 0,
> +	/* clang-format on */
> +	.sock_type = SOCK_STREAM,
> +	.sandbox = false,
> +	.sandbox_target = false,
> +	.expect_denied = 0,
>  };
>  
>  /* Stream: lower abstract-name length boundary. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, stream_denied_empty_name) {
>  	.sock_type = SOCK_STREAM,
>  	.sandbox = true,
> @@ -1297,9 +1308,12 @@ FIXTURE_VARIANT_ADD(trace_unix, stream_denied_empty_name) {
>  	.name = "",
>  	.name_len = 0,
>  };
> +/* clang-format on */
>  
>  /* Stream: upper abstract-name length boundary. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, stream_denied_max_name) {
> +	/* clang-format on */
>  	.sock_type = SOCK_STREAM,
>  	.sandbox = true,
>  	.sandbox_target = false,
> @@ -1309,25 +1323,35 @@ FIXTURE_VARIANT_ADD(trace_unix, stream_denied_max_name) {
>  };
>  
>  /* Datagram: sandboxed client sendto() an unsandboxed peer (peer_domain=0). */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, dgram_denied) {
> -	.sock_type = SOCK_DGRAM, .sandbox = true,
> -	.sandbox_target = false, .expect_denied = 1,
> +	/* clang-format on */
> +	.sock_type = SOCK_DGRAM,
> +	.sandbox = true,
> +	.sandbox_target = false,
> +	.expect_denied = 1,
>  };
>  
>  /* Datagram: peer socket owned by a domain, so peer_domain != 0. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, dgram_denied_scoped_peer) {
> -	.sock_type = SOCK_DGRAM, .sandbox = true,
> -	.sandbox_target = true, .expect_denied = 1,
> +	/* clang-format on */
> +	.sock_type = SOCK_DGRAM,
> +	.sandbox = true,
> +	.sandbox_target = true,
> +	.expect_denied = 1,
>  };
>  
>  /* Datagram: unsandboxed client, sendto() succeeds, no event. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_unix, dgram_allowed) {
> -	.sock_type = SOCK_DGRAM, .sandbox = false,
> -	.sandbox_target = false, .expect_denied = 0,
> +	/* clang-format on */
> +	.sock_type = SOCK_DGRAM,
> +	.sandbox = false,
> +	.sandbox_target = false,
> +	.expect_denied = 0,
>  };
>  
> -/* clang-format on */
> -
>  /*
>   * A sandboxed thread reaching an abstract unix socket peer through connect(2)
>   * (stream) or sendto(2) (datagram) is denied and emits
> diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
> index afdaf8511b3a..a28a2ac55687 100644
> --- a/tools/testing/selftests/landlock/trace_test.c
> +++ b/tools/testing/selftests/landlock/trace_test.c
> @@ -1243,45 +1243,77 @@ FIXTURE_VARIANT(trace_enforce) {
>  	int no_new_privs;
>  };
>  
> -/* clang-format off */
> -
>  /* Single thread, no flags: prctl-backed no_new_privs. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, single) {
> -	.nthreads = 0, .flags = 0,
> -	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
> +	.nthreads = 0,
> +	.flags = 0,
> +	.total = 1,
> +	.complete = 1,
> +	.process_wide = 1,
> +	.no_new_privs = 1,
>  };
> +/* clang-format on */
>  
>  /* Single thread: the NO_NEW_PRIVS flag sets no_new_privs (no prctl). */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, no_new_privs) {
> -	.nthreads = 0, .flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
> -	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
> +	.nthreads = 0,
> +	.flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
> +	.total = 1,
> +	.complete = 1,
> +	.process_wide = 1,
> +	.no_new_privs = 1,
>  };
> +/* clang-format on */
>  
>  /* TSYNC on a lone thread still concludes, process-wide. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, tsync_single) {
> -	.nthreads = 0, .flags = LANDLOCK_RESTRICT_SELF_TSYNC,
> -	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
> +	.nthreads = 0,
> +	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.total = 1,
> +	.complete = 1,
> +	.process_wide = 1,
> +	.no_new_privs = 1,
>  };
> +/* clang-format on */
>  
>  /* TSYNC sweeps N siblings; the caller's prctl-backed nnp propagates to all. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, tsync_multithread) {
> -	.nthreads = 3, .flags = LANDLOCK_RESTRICT_SELF_TSYNC,
> -	.total = 4, .complete = 1, .process_wide = 4, .no_new_privs = 4,
> +	.nthreads = 3,
> +	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.total = 4,
> +	.complete = 1,
> +	.process_wide = 4,
> +	.no_new_privs = 4,
>  };
> +/* clang-format on */
>  
>  /* TSYNC + NO_NEW_PRIVS flag sets nnp on the caller and every swept sibling. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, tsync_no_new_privs) {
> +	/* clang-format on */
>  	.nthreads = 3,
> -	.flags = LANDLOCK_RESTRICT_SELF_TSYNC | LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
> -	.total = 4, .complete = 1, .process_wide = 4, .no_new_privs = 4,
> +	.flags = LANDLOCK_RESTRICT_SELF_TSYNC |
> +		 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
> +	.total = 4,
> +	.complete = 1,
> +	.process_wide = 4,
> +	.no_new_privs = 4,
>  };
>  
>  /* Non-TSYNC on a multi-threaded process enforces only the caller. */
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(trace_enforce, multithread_non_tsync) {
> -	.nthreads = 3, .flags = 0,
> -	.total = 1, .complete = 1, .process_wide = 0, .no_new_privs = 1,
> +	.nthreads = 3,
> +	.flags = 0,
> +	.total = 1,
> +	.complete = 1,
> +	.process_wide = 0,
> +	.no_new_privs = 1,
>  };
> -
>  /* clang-format on */
>  
>  /*
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
