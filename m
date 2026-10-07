Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D7470E96
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368024; cv=none; b=mAIJ49p74/zdF00bF/IVLz+k8IEcjpgx+Me+8Vu4V/5j5UBxulEfaBA2kXqNfZOqT3dCeIUifNAKzkAV7OePShd+luisiy3NpJAPE44vwYxuNCAJEcxHIY1ZOevl2I/Pepmngnw7GU/KvMN83cANnRSdrISRRNLwN75Zn2oRKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368024; c=relaxed/simple;
	bh=WTCZcNWp9LD73G+G9ZroeoanjcxyFiMWxVdyz3ysvSQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Khp0IgAv2kKDyiq0lxN5wReilbz/7BKViZ3BoTJnY5M7Kgo1EQex0Z7r7uiVWbT+4qDW9x97kRNfZQjDMfagLVVrEPYqHirFgoez8T00/CEWpWJAplkqrtQAWJibPjHrJnq5ygqMKeR9dhSZwIxuo3x43EYlKkV10M53NhEfqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5x2IQtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5x2IQtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308C71F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368013;
	bh=H0ogUsk3yLXETZ1kFGN6sxtWD+5k1FJpE4XxoC7sWSU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=f5x2IQtYXNK5chU1Fc0dDj4JfjjYIHSDZb/bNV64CRfspDyPFRqUw7Eah2hu3+uvp
	 jo/6NlE1L2Kn3ZFS07WDk9IJ2X3aTZKXewzTqeegpSmnyjIeUY6B7TFqtRu17zEMn2
	 okuP4mSUu6IIrYfcO7bx/jP3QuIKr+mjEtEVtY1+SOqoPSdk8MeAaa+qSoWvxcXNCu
	 V00/fAG8bKiwW1p6ed0PMm6dqVn2YNsjy2Z28O3kk6L0y7WzVAg5bxGH0trZZ8Khth
	 pxIFgLWAqbiV5B5Ph3LSgoonRtOWdCrTa2KG2kDaNE9dknGQPEAxwwAMVaoINdpo4Y
	 FrfjQ1f054t9A==
Message-ID: <sashiko-outbox-162847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] selftests/landlock: Add capability restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-7-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:13:32 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/landlock: uninitialized read of records if audit_count_re=
cords() fails
--

commit 0b24b77e1134932d1209607c6e9bc067e8fb747d
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Add capability restriction tests

This commit adds tests to exercise LANDLOCK_PERMISSION_CAPABILITY_USE
enforcement. It covers stacking combinations, non-standard capability
contexts, and audit and trace scenarios.

> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/=
selftests/landlock/cap_test.c
> new file mode 100644
> index 0000000000000..07976854ec5a8
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/cap_test.c
> @@ -0,0 +1,1373 @@

[ ... ]

> +TEST_F(cap_audit, denied)
> +{
> +	struct audit_records records;
> +	int ruleset_fd;
> +	__u64 domain_id;

[ ... ]

> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);

[Severity: Low]
Does this code read uninitialized stack memory in TEST_F(cap_audit, denied)
if audit_count_records() fails?

The records structure is declared on the stack without initialization.
If audit_count_records() returns early with an error, for instance if
regcomp() fails with -ENOMEM in tools/testing/selftests/landlock/audit.h,
records.access and records.domain will remain uninitialized.

Because EXPECT_EQ() does not abort test execution upon failure like
ASSERT_EQ() would, the test will continue and evaluate the uninitialized
records.access and records.domain fields.

Consider either zero-initializing the records struct upon declaration,
or replacing EXPECT_EQ with ASSERT_EQ for the audit_count_records() call.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D6
