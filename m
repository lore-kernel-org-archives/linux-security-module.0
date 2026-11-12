Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525933;
	b=EMGK4903cD/QXfWhB5Ds2cS208y+R3ckbefEi5TvUvE8ZEuxRm5eL61q6p2NrIkWapdW
	 JF0WXl57PZ7qI8msfDNmfQQ7QVV9IoEvYEMianjb5gqpAUC/IsGj7Sr9QsTGYTKF9JyXA
	 tnmt9wAFABj9CIH2miLmivDtQpNxAlUEMgoSbZFzEep9sPbzBP/cc2tZThIW1qs8NEEqS
	 KPTqX1KMKJSLIrmRHOoFT7Hx1K7zJoKdrjFnM8yDLvWIWahaBrX09hGsPOVyZ5iOWmMsS
	 p1ckwVZV7EA13JWi2kJadmofx6PEHsUWfUPZFn0fra5o8C1Pm3QyiGhAIOOfFtxxjbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=i/IEb5sbCw+dvUMD/y77Bue90xBTDxwEBx04VZhs2ho=;
	b=z8bQUe4/O/sGuW0Y2OzD+y2AeexwizT40+5oonz7sLrAkLG0mTkpP9FdUve2b+/9/+Ro
	 NcwOtn7mbrPiuBebDlZ/zzlIVZc9PwyZXpXggGZExkIcxmhNVSOaYr/xHm8wk5HYuCto9
	 5V0NPZho5EW9wz8aMP3djWe1TOANNUSkXGYgOLoVlGoJQrF5Fq1s91rnV1r9SyUTDVxKc
	 X8yYKIrgzuG+HAQslosgPgiltOis/dqU9P2Eo/+2D4ZAOTERRmMFj3tQpa2M27N3Yqe1f
	 7WS2tIincnQjV0D7aZQ4KbltedfcdIWh92ZctiiXQch2XTZAEsDbnzJq5qZVpJTkCqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="gf/JdALV";
	arc=none smtp.remote-ip=185.125.25.14
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F55606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 23:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F55606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=gf/JdALV
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQc1x3q6Vz19hb;
	Fri, 13 Nov 2026 00:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794525925;
	bh=i/IEb5sbCw+dvUMD/y77Bue90xBTDxwEBx04VZhs2ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gf/JdALVgMfOJ9gpLyi77NKnYwrmlwdWXNWVXqdTg2OW8CmZ+sVFXC6pu6sQV4arr
	 okdznOth5fq5rlLfj1afci94886gvR5PWLE2Ug+KfMPQC2l0X8HJ32MJhD46kuxYPy
	 EsQX+xCI2p45zNCgWuhrVXFkwkGeqLSPrp87WZ68=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jQc1w1fzszfxX;
	Fri, 13 Nov 2026 00:25:24 +0100 (CET)
Date: Fri, 13 Nov 2026 00:25:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests/landlock: Test that layering does not
 break refer
Message-ID: <20261113.eivahj2ohKae@digikod.net>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-2-2b405fc1b3aa@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-2-2b405fc1b3aa@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Nov 08, 2026 at 09:23:49PM +0100, Günther Noack wrote:
> Regression test to exercise that layered Landlock domains do not
> accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
> used to be the case when layering a non-filesystem ruleset with a
> filesystem-enforcing ruleset.  In that case, REFER operations that
> would have been allowed for the individual rulesets would get denied
> when layering the same rulesets.
> 
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>

This test patch should also be backported (Cc stable@ + Fixes).

> ---
>  tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index f725882fa4a7..b92cb988a39f 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2612,6 +2612,45 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
>  				layer_dir_s1d1_refer);
>  }
>  
> +/*
> + * Regression test for layered domains: The two enforced Landlock layers both do
> + * not restrict the tested "refer" operations on their own, so they should also
> + * not restrict them when they are layered.
> + */
> +static void test_layering_does_not_break_refer(
> +	struct __test_metadata *const _metadata,
> +	const struct landlock_ruleset_attr *const non_fs_attr)
> +{
> +	ASSERT_EQ(0, unlink(file1_s1d2));
> +
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer_dir_s1d1_refer);
> +
> +	drop_access_rights(_metadata, non_fs_attr);
> +
> +	EXPECT_EQ(0, test_rename(file1_s1d1, file1_s1d2));
> +	EXPECT_EQ(0, test_rename(file1_s1d2, file1_s1d1));
> +	EXPECT_EQ(0, test_exchange(file2_s1d1, file2_s1d2));
> +	EXPECT_EQ(0, test_exchange(file2_s1d2, file2_s1d1));
> +}
> +
> +TEST_F_FORK(layout1, layering_with_net_does_not_break_refer)
> +{
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +
> +	test_layering_does_not_break_refer(_metadata, &attr);
> +}
> +
> +TEST_F_FORK(layout1, layering_with_scoped_does_not_break_refer)
> +{
> +	const struct landlock_ruleset_attr attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +
> +	test_layering_does_not_break_refer(_metadata, &attr);
> +}

This looks good, but it would be better to also exercise both
layer-construction orders for non-FS categories (e.g. FS then scope, and
scope then FS).  That would confirm patch 3 is good.

> +
>  /*
>   * Tests walking through a denied root mount.
>   */
> 
> -- 
> 2.56.0
> 
> 
