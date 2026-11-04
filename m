Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827197;
	b=EYWvgd53s1QzrYcJrZlRpKsxGIKBRHr2TODAEb3mU2tvHS+Qkg792yiINs0wHykzfuuw
	 LuhYNn0ZVvVKrdvd4r+6SPfdexYDvgb4F53mboLONTlmuuasp5TyvM65inWtGB1SYgA3G
	 L5u2oj2ImlSi8yLSw2QEiThUpREdPIWtqzPkYwTMoDWfbB8artmKSUlPHg2WWG+yruV6L
	 cCUxO/HjRWSSPVUZnqlyPeyFBwpQjYwBU19FJvvKV/tZ1jnzeHTqz/xby0qlSvyCKrScN
	 o+gm/MpH8iWje6yv6aF/Oidb7KsxLAMoYZ9uNve/swfvdEpFRzO6ISZqZasN0evyzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6GBBZKly6/eUICSlGSyG6zAPBbVp0dK6Ox+HGiN45rc=;
	b=23+t38E2sEtoXeZHLLydkINw1ea+RR9ml/ruApLhJt20RTfbi6Z+HiuvxBQg0ezyU/xx
	 QH8xMVlVXuKh5kaEQC/zhsk3MgHYev5LZFpZPHhjqpXFSDhaSWR/O7UQujZOshWEVlSNc
	 clDujgzc/JcH0l4N30glRtgm3zs5YoVKq2BQiLmhnD1vuwvKBA8mP3InTAND9WivkfhPP
	 q3JbyyoZ/7IRnVvde1FrSd0ykWu0AckBBYsNlyjJvm+1ZkxpmKrjOfiCjeI8qtEK47Wqu
	 +/aURVBgOzFxuXqoXPlSwN2mlEQeoDK0nS9/e6PZTajIjOYCqLtq5HvWlSyTWIbRHOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ4MBiGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC3606B387
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ4MBiGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9F61F00A17
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827197;
	bh=6GBBZKly6/eUICSlGSyG6zAPBbVp0dK6Ox+HGiN45rc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IJ4MBiGi77yCNB/mjh5KV4BnS9CdJo2fwjv4dcFDXz2HBX6xBPKMqvnphhf3kP1q1
	 /+CApTECmRp73nQ+yB/KP/UexxEK7GU5/WRI5RG5QLtGc+qQBuKzt8GKtZX4U/+uum
	 Dc2HgZWlk2yuRZvmLonIcrOT0jlc0R6sP+70dXUQCmBWSgm7kXnTRJE+HQF7f7f58v
	 BGEx3s6RD81DAWJT9HSvcgof9r/4iFceZwAoVA0WNa8+7iq1CIL/90djF1Pu5jaomy
	 bZ9uQTIYrBR0b90BINk+VtmN7x/+dkDjhJe86Qy0TOd2qU8uwYfTQQY7iexqUgn01T
	 /VlZOUlpv8eYA==
Message-ID: <sashiko-outbox-198097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/27] selftests/landlock: Use EXPECT for closing FDs
 and stopping threads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-26-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-26-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/landlock: EXPECT_EQ before reading thread output in re=
strict()
--

commit 85f196c7c04b9c3b9c11f5b1ad1ee130ba7d4079
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Use EXPECT for closing FDs and stopping threads

This commit changes ASSERT_EQ to EXPECT_EQ across Landlock selftests when
closing file descriptors, cancelling or joining threads whose results are
unused, and cleaning up at the end of named_pipe_ioctl.

> diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testin=
g/selftests/landlock/tsync_test.c
> index 2b53596c986e0..aff973ba4735b 100644
> --- a/tools/testing/selftests/landlock/tsync_test.c
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -152,10 +152,10 @@ TEST_F(multi_threaded, restrict)
>  	EXPECT_EQ(variant->expected_no_new_privs,
>  		  prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
> =20
> -	ASSERT_EQ(0, pthread_cancel(t1));
> -	ASSERT_EQ(0, pthread_cancel(t2));
> -	ASSERT_EQ(0, pthread_join(t1, NULL));
> -	ASSERT_EQ(0, pthread_join(t2, NULL));
> +	EXPECT_EQ(0, pthread_cancel(t1));
> +	EXPECT_EQ(0, pthread_cancel(t2));
> +	EXPECT_EQ(0, pthread_join(t1, NULL));
> +	EXPECT_EQ(0, pthread_join(t2, NULL));
> =20
>  	/* Checks the no_new_privs state of the sibling threads. */
>  	EXPECT_EQ(variant->expected_no_new_privs, no_new_privs1);

[Severity: Medium]
In TEST_F(multi_threaded, restrict), no_new_privs1 and no_new_privs2 are
declared uninitialized on the stack and passed to the idle() threads:

tools/testing/selftests/landlock/tsync_test.c:restrict() {
	...
	bool no_new_privs1, no_new_privs2;

	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
	...
}

In idle(), those variables are only populated when the cancellation cleanup
handler store_no_new_privs() runs upon cancellation:

tools/testing/selftests/landlock/tsync_test.c:idle() {
	pthread_cleanup_push(store_no_new_privs, data);

	while (true)
		sleep(1);

	pthread_cleanup_pop(1);
}

Since the subsequent checks on no_new_privs1 and no_new_privs2 depend on
pthread_cancel() and pthread_join() succeeding to populate and synchronize
those values, should pthread_cancel() and pthread_join() remain ASSERT_EQ
here so that a failure does not fall through into reading uninitialized
stack variables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D26
