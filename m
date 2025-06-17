Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B708F54
	for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186943; cv=none; b=RGavsnsIGKvq1C4mdtBQnmD197DPimiHF+usg9ur9quEjBzoKwhoyxV0FBllPxtafGn/ToJx51pX/beGLZBgFe52l5S92qfCM4sbdeh1UhpYwNu+KMRVZ7jB2B4t3tA1AubSrwKP8W8cYFfqTVKO8BcrA6EVD81le32+awz9YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186943; c=relaxed/simple;
	bh=UMPk5giedv4xmGKjV33kkxaEh12+9CWHj6DEwstgUok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R78w6qX+JusAIVGXNkH/7OJSzZlB5a0BtIIdn6KBetZvKRFPJAdUqKBGyvnG0SGOo5952yhL+HPFKCmO/dUzBL713EoIsQxAvC79uHq0CGlA9aLwcAf3lfm6LKN7KkJFngM/paF6UxQl7c718eYYNkP5NTwEx3J5dbYdbnRoYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1ZCV3LlK; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1ZCV3LlK"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bMGKD0SCHzjJP;
	Tue, 17 Jun 2025 20:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750186527;
	bh=rp09GFFGVxRWmokMi3Vq/owOUFavi/lCsvsLc+2xcIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ZCV3LlKavGqvfnwNAL0jCKd7TuICz+Ih3SnqGLoJh+mbMUzGJhdFjLGWIAaPAexK
	 BS2ZqP6QTC+sBEHFV3btClJIsx4srS7GwEwpTxOcxe6bzZ5355LGMYyudU140yctoO
	 R2ygKYnbJ0HjV95o9YgrEv6g7CJ3ofnVcZqaKnRo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bMGKC48wGzmm6;
	Tue, 17 Jun 2025 20:55:27 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:55:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock/id: Fix WARNING from kunit tests
Message-ID: <20250617.Ahngeey8shuo@digikod.net>
References: <73e28efc5b8cc394608b99d5bc2596ca917d7c4a.1750003733.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73e28efc5b8cc394608b99d5bc2596ca917d7c4a.1750003733.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Jun 15, 2025 at 05:09:36PM +0100, Tingmao Wang wrote:
> Looks like get_random_u8 returned 0 here.  Fix this by clamping it.

Goot catch, thanks!

> 
> (Validated by running the test in a for loop for 1000 times.  Note that
> MAX is wrong as it is only supposed to be used for unchanging variables,
> but the lowercase version is good here.)
> 
> 	[..]     ok 9 test_range2_rand1
> 	[..]     ok 10 test_range2_rand2
> 	[..]     ok 11 test_range2_rand15
> 	[..] ------------[ cut here ]------------
> 	[..] WARNING: CPU: 6 PID: 104 at security/landlock/id.c:99 test_range2_rand16 (security/landlock/id.c:99 (discriminator 1) security/landlock/id.c:234 (discriminator 1))
> 	[..] Modules linked in:
> 	[..] CPU: 6 UID: 0 PID: 104 Comm: kunit_try_catch Tainted: G                 N  6.16.0-rc1-dev-00001-g314a2f98b65f #1 PREEMPT(undef)
> 	[..] Tainted: [N]=TEST
> 	[..] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> 	[..] RIP: 0010:test_range2_rand16 (security/landlock/id.c:99 (discriminator 1) security/landlock/id.c:234 (discriminator 1))
> 	[..] Code: 49 c7 c0 10 70 30 82 4c 89 ff 48 c7 c6 a0 63 1e 83 49 c7 45 a0 e0 63 1e 83 e8 3f 95 17 00 e9 1f ff ff ff 0f 0b e9 df fd ff ff <0f> 0b ba 01 00 00 00 e9 68 fe ff ff 49 89 45 a8 49 8d 4d a0 45 31
> 	..
> 	[..] RSP: 0000:ffff888104eb7c78 EFLAGS: 00010246
> 	[..] RAX: 0000000000000000 RBX: 000000000870822c RCX: 0000000000000000
> 	          ^^^^^^^^^^^^^^^^
> 	[..]
> 	[..] Call Trace:
> 	[..]
> 	[..] ---[ end trace 0000000000000000 ]---
> 	[..]     ok 12 test_range2_rand16
> 	[..] # landlock_id: pass:12 fail:0 skip:0 total:12
> 	[..] # Totals: pass:12 fail:0 skip:0 total:12
> 	[..] ok 1 landlock_id
> 
> Fixes: d9d2a68ed44b ("landlock: Add unique ID generator")
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/id.c | 69 +++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/security/landlock/id.c b/security/landlock/id.c
> index 56f7cc0fc744..b02a7da2f15d 100644
> --- a/security/landlock/id.c
> +++ b/security/landlock/id.c
> @@ -119,6 +119,12 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
>  
> +static u8 get_random_u8_positive(void)
> +{
> +	/* max evaluates its arguments once */
> +	return max(1, get_random_u8());
> +}
> +
>  static void test_range1_rand0(struct kunit *const test)
>  {
>  	atomic64_t counter;
> @@ -127,9 +133,10 @@ static void test_range1_rand0(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 0), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 1);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 1);
>  }
>  
>  static void test_range1_rand1(struct kunit *const test)
> @@ -140,9 +147,10 @@ static void test_range1_rand1(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 1), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 2);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 2);
>  }
>  
>  static void test_range1_rand15(struct kunit *const test)
> @@ -153,9 +161,10 @@ static void test_range1_rand15(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 15), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 16);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 16);
>  }
>  
>  static void test_range1_rand16(struct kunit *const test)
> @@ -166,9 +175,10 @@ static void test_range1_rand16(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 16), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 1);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 1);
>  }
>  
>  static void test_range2_rand0(struct kunit *const test)
> @@ -179,9 +189,10 @@ static void test_range2_rand0(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 0), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 2);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 2);
>  }
>  
>  static void test_range2_rand1(struct kunit *const test)
> @@ -192,9 +203,10 @@ static void test_range2_rand1(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 1), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 3);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 3);
>  }
>  
>  static void test_range2_rand2(struct kunit *const test)
> @@ -205,9 +217,10 @@ static void test_range2_rand2(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 2), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 4);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 4);
>  }
>  
>  static void test_range2_rand15(struct kunit *const test)
> @@ -218,9 +231,10 @@ static void test_range2_rand15(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 15), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 17);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 17);
>  }
>  
>  static void test_range2_rand16(struct kunit *const test)
> @@ -231,9 +245,10 @@ static void test_range2_rand16(struct kunit *const test)
>  	init = get_random_u32();
>  	atomic64_set(&counter, init);
>  	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 16), init);
> -	KUNIT_EXPECT_EQ(
> -		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
> -		init + 2);
> +	KUNIT_EXPECT_EQ(test,
> +			get_id_range(get_random_u8_positive(), &counter,
> +				     get_random_u8()),
> +			init + 2);
>  }
>  
>  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.49.0
> 
> 
