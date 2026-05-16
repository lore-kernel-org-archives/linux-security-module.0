Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E331361641
	for <linux-security-module@vger.kernel.org>; Sat, 16 May 2026 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959285; cv=none; b=Vd5QbpQAc/2lR2foaYYFj85TWdl6lMIraWhtP11wQ8stpcYzL7+CluJEvfj7dKZRziBKP5Am5WIbRAzKLd7v7c4zelmZ5VRUkHYmr+tDTxEpkijF0TJZXxK8FYMyVMup3Zn4zq02IWpMwxT0uB/5VGaClTK9d58EZkIKWWb1OUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959285; c=relaxed/simple;
	bh=ij9RhLklIgc4kT2Edgj8kTj3HFGxKELkieSEBcnJO3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzPtI21sjLkaDdgT6udauya/w70FfrRnmaMBApuLMfbULexm7gYBohfMeHYv8xCiZI8ptEQzdtM/wZGmbutXY3rAmZ8/HO91pLTdYwHG9by145TqCC6QyO2RGCBss1I6Oh32N5bQhKro653iKNtC+49ElXdQ/CR9YtmbvxToMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h55s76dM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h55s76dM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0046078so7710525e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 16 May 2026 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778959282; x=1779564082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hORsZ0lF+2IhvjNKlpi2MPEmhmAHK+ddvNGFULLRIaU=;
        b=h55s76dM+FU8j+Qmf6BavBe+pqIHOMYMpzXHdHTI2wu1b6x1cRENqoxsKQKilo2pXY
         EXTwYw1aKZM+6SLOQ005CBfpmtmtndLXqp697Svm7U3pZI9ml3QRftb+AALBSxt/Vwwz
         EgzO7lWkMfXlvpRQR5COky5AyfO42n4bs7lSVviiRUvv00ixqUPy1rMW1bvyvzcyR+xG
         TwgE1Hzi7TaS9VVxIEQTN0ph5XYwI58BFgI2vxwx2FoBHdEFRrxGAuFuS1MNP510YaqC
         Pcekdt64E5a8147qY8cR0keVfiPpaZX1wOka4Trj6LnK1cJRy0wEjfgeWqwGQ2wFupbl
         41oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778959282; x=1779564082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hORsZ0lF+2IhvjNKlpi2MPEmhmAHK+ddvNGFULLRIaU=;
        b=gyt/Nw7hghSYkiKRbQ164pUr4nxB2HOtFlEQvlKwefSinp6jvypKsII/hYHshuPufZ
         G8MnFfu7zHNOta8mp78opkZLk7eoRBRTtNdP+DUypL/TevdZiHnJRQoG61w6p/ew3v7z
         bqwgK+X4OrxsbWKQ8mviLuoYYWJclZYG5lXMGWJDhP8uXWf+AqHPI9G98pZH6NWa1Wz9
         BDTTO2hkofW0iYJq8s4+ZZ/eWdRkfj8zsIEAQRj4NxvvovCfWcjF2Jk9/8ws6Ji1D4dB
         potlDM/8Dj5d5NShP4WxhWsFmamoNDaQmRAkxUeRwlmhaU2wcnRqU87OcRuXSHB3pykn
         wKXw==
X-Forwarded-Encrypted: i=1; AFNElJ9wKe0rtkY+1Q/U7IqKjQkrnENReAgOEeH/bauGx4YdHU3YVjxaDGzHuwD4UFypibrHZ7TpO0CPtYvKU7zLni6SZ+PGpYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26PrIChcTZ1YhiyemUg9/oyllavvRVZ4jheYE3WWX3h5BRGRS
	FDAxgsWXQY/nYjHzGXdoNdCx3qEyTHvcPIrIc3k/hhsNzJwasLmAeiZ6
X-Gm-Gg: Acq92OEuZ6GCODRVNnKvioSqxWk1vbHNzGk7C8lUjIgMIDJwZp593SV6M2ql4YIKRwv
	vnIaxc8Qls0qsBz1pRkGQ7mSk+7O/ZArT6zi16hQGR7sTC15xi2cqk+6aqT+H25pWkqaVrdxy+7
	ANwHvVV9NafvjhTuTb4U3nA8zZ7y8aoFS2YHLcbhnqKBhlb3q9wkQ6+h/8/+BivsvoJrvWOdzgf
	ulLGI7ygx8qTeOjnYFi2dwRn9r+cQqOnpMkk9K4n7GUWNvqHFZbA18J2iLzMAvyR/k8CML5ykB5
	IsQb+WwZrxBx4YkD6SZWsEtdT9mH4vm+7c8Vca628W06FkHxbyNnALHiaGtnSfXoAImWtVqU3A7
	x5jX8kpNq0wwm5w+FKzh2XK8JRpxTHEJhhtmAzj23OiYdtz1lLkidJhJngS4OV2dktcFPeFRnUP
	0DQtvogt+kHD04N8H2hXvtuikNW+I3HNDN1M8fnBGADYMAJ3DZ
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48fe62f8861mr126830015e9.23.1778959281845;
        Sat, 16 May 2026 12:21:21 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm143781825e9.2.2026.05.16.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:21:21 -0700 (PDT)
Date: Sat, 16 May 2026 21:21:19 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, lkp@intel.com,
	oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] selftests/landlock: Filter dealloc records in
 audit_count_records()
Message-ID: <20260516.781b8f7cc1a3@gnoack.org>
References: <20260513105112.140137-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513105112.140137-1-mic@digikod.net>

On Wed, May 13, 2026 at 12:51:08PM +0200, Mickaël Salaün wrote:
> audit_count_records() counts both AUDIT_LANDLOCK_DOMAIN allocation and
> deallocation records in records.domain .  Domain deallocation is tied to
> asynchronous credential freeing via kworker threads
> (landlock_put_ruleset_deferred), so the dealloc record can arrive after
> the drain in audit_init() and after the preceding audit_match_record()
> call.  This causes flaky failures in tests that assert an exact
> records.domain count: a stale dealloc record from a previous test's
> domain inflates the count by one.
> 
> Observed on x86_64 under build configurations that delay the kworker
> firing the dealloc callback (e.g. coverage instrumentation): the
> audit_layout1 tests in fs_test.c intermittently saw records.domain == 2
> where 1 was expected.  The fix is in the shared helper, so those
> existing checks become robust without needing a fs_test.c edit.
> 
> Filter audit_count_records() with a regex to skip records containing
> deallocation status.  The remaining domain records (allocation, emitted
> synchronously during landlock_log_denial()) are deterministic.
> Deallocation records are already tested explicitly via
> matches_log_domain_deallocated() in audit_test.c, which uses its own
> domain-ID-based filtering and longer timeout.
> 
> With this filter in place, re-add the records.domain == 0 checks that
> were removed in commit 3647a4977fb7 ("selftests/landlock: Drain stale
> audit records on init") as a workaround for this race.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/audit.h      | 39 ++++++++++++-------
>  tools/testing/selftests/landlock/audit_test.c |  2 +
>  .../testing/selftests/landlock/ptrace_test.c  |  1 +
>  .../landlock/scoped_abstract_unix_test.c      |  1 +
>  4 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 834005b2b0f0..699aed5ffab4 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -381,18 +381,24 @@ struct audit_records {
>  };
>  
>  /*
> - * WARNING: Do not assert records.domain == 0 without a preceding
> - * audit_match_record() call.  Domain deallocation records are emitted
> - * asynchronously from kworker threads and can arrive after the drain in
> - * audit_init(), corrupting the domain count.  A preceding audit_match_record()
> - * call consumes stale records while scanning, making the assertion safe in
> - * practice because stale deallocation records arrive before the expected access
> - * records.
> + * Counts remaining audit records by type, skipping domain deallocation records.
> + * Deallocation records are emitted asynchronously from kworker threads after a
> + * previous test's child has exited, so they can arrive after the drain in
> + * audit_init() and after the preceding audit_match_record() call.  Allocation
> + * records are emitted synchronously during landlock_log_denial() in the current
> + * test's syscall context, so only those are counted in records->domain.
>   */
>  static int audit_count_records(int audit_fd, struct audit_records *records)
>  {
> +	static const char dealloc_pattern[] = REGEX_LANDLOCK_PREFIX
> +		" status=deallocated ";
>  	struct audit_message msg;
> -	int err;
> +	regex_t dealloc_re;
> +	int ret, err = 0;
> +
> +	ret = regcomp(&dealloc_re, dealloc_pattern, 0);
> +	if (ret)
> +		return -ENOMEM;
>  
>  	records->access = 0;
>  	records->domain = 0;
> @@ -402,9 +408,8 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  		err = audit_recv(audit_fd, &msg);
>  		if (err) {
>  			if (err == -EAGAIN)
> -				return 0;
> -			else
> -				return err;
> +				err = 0;
> +			break;
>  		}
>  
>  		switch (msg.header.nlmsg_type) {
> @@ -412,12 +417,20 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  			records->access++;
>  			break;
>  		case AUDIT_LANDLOCK_DOMAIN:
> -			records->domain++;
> +			ret = regexec(&dealloc_re, msg.data, 0, NULL, 0);
> +			if (ret == REG_NOMATCH) {
> +				records->domain++;
> +			} else if (ret != 0) {
> +				err = -EIO;
> +				goto out;
> +			}
>  			break;
>  		}
>  	} while (true);
>  
> -	return 0;
> +out:
> +	regfree(&dealloc_re);
> +	return err;
>  }
>  
>  static int audit_init(void)
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 93ae5bd0dcce..758cf2368281 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -730,6 +730,7 @@ TEST_F(audit_flags, signal)
>  		} else {
>  			EXPECT_EQ(1, records.access);
>  		}
> +		EXPECT_EQ(0, records.domain);
>  
>  		/* Updates filter rules to match the drop record. */
>  		set_cap(_metadata, CAP_AUDIT_CONTROL);
> @@ -917,6 +918,7 @@ TEST_F(audit_exec, signal_and_open)
>  	/* Tests that there was no denial until now. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	/*
>  	 * Wait for the child to do a first denied action by layer1 and
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index 1b6c8b53bf33..4f64c90583cd 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -342,6 +342,7 @@ TEST_F(audit, trace)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	yama_ptrace_scope = get_yama_ptrace_scope();
>  	ASSERT_LE(0, yama_ptrace_scope);
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> index c47491d2d1c1..72f97648d4a7 100644
> --- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -312,6 +312,7 @@ TEST_F(scoped_audit, connect_to_child)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
>  	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> -- 
> 2.54.0
> 

Tested-by: Günther Noack <gnoack3000@gmail.com>
