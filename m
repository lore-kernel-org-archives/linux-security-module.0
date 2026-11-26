Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697735;
	b=KO8mFSnn5yjZAAWnwd05Cj8o5UstlFCBXu0Nt3fls4D7qE97uIZMImPsAxQss+GwUluT
	 DJIJj8AzeVJrJb0dEPCNItI9nzkHlpcPnN/Yze5/q83f50G2OBFrev1tOT9aWB+cuTMmT
	 8fhGDp2bwCL3pWAR7SA0TJNmZQd3dLn7/NIhWsYYiTgOhNcYX+HT8raJ25LDfEMyq1V0j
	 XO46mjc3aXd1VtJVSl49I+1gErHW10p8YGPljC3YmHBHuV/ch36lNd0po6cIeGS7fWZGR
	 Az+m9zFJUDhPpoZYfkwzoDsOcwSwrbRhK57FUZgo/P1LRFil3Zj6Xn3TEEtfVQOEInQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U+nzHiJ88YOWpRwppN5sbLZe/c6Di7F1lgfZ3A2+xio=;
	b=MIWjozK9MhVR92gEHjx6ehG6nEYhj+UYK9YhlAgMPX0pPwKFVkKpz7KSXP4z0bcrb/nO
	 pBH80t8SfJ7H2dbecHj75wLW6LSBtGT50t6ThHT1PB+f9VDwLY5EzSnpxMBIx8ImCPqFB
	 tgkCnHHmeir0F4ok+jDs43J04pe+DN/NKNpfQndN6E2wOadMaWPZmlWB3/X9L+Yi4nyHz
	 tLfq4BRAKcB6cMO/rnvRIAzBPfojMxqqj3dzHRYY0LfAw1jsLC4C4gvmlApZX17a3emnD
	 w9m/kNCY9aBLk9X5vkxQB8YA9VYOurSDWRPIpbU61cXrhpjI1BaR1KIwIpfSqd1YSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAOMkGQe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE7606A31C;
	Thu, 26 Nov 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAOMkGQe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5811F000C0;
	Thu, 26 Nov 2026 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697734;
	bh=U+nzHiJ88YOWpRwppN5sbLZe/c6Di7F1lgfZ3A2+xio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAOMkGQe14Ub4YREQBETzHfioaEM0ff1RL+bshcEsZohMPmdyvs3Xch3i58InmLEW
	 YHkiijBZTNeHVsFaw7MWzgkRhmi8rMVGJ2nMd7d2d03AIutRW3BYOb7Aukzv6thRYZ
	 EjC4UHuvAsYdfLUfOJoTnmF+SYp29jUPDK9tnWMRn1tD6Yihbu8B0Rc2HPfDSVm/PH
	 z49PBf+FmD5n8LxIW0sZ6vldRZLBjU/+HrQf2VCTqkeajhIzG/BptuV/YLk7kkjCI6
	 QV+go6ZMUWNyARRqyqxtNu102YROkRypGROXky0jRpN3nQ+Q9Ic+pTHJ1igoJ6bFIp
	 sqCZbdKlGq2rQ==
Message-ID: <sashiko-outbox-235545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] selftests/lsm: add lockdown securityfs test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126131315.1256553-9-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
 <20261126131315.1256553-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:55:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/lsm: missing $(OUTPUT) prefix in run_lockdown_test
  target
--

commit ae0a97bf5c81e3abb82a38d806d0a81d48473b52
Author: Cai Xinchen <caixinchen1@huawei.com>

selftests/lsm: add lockdown securityfs test

This commit adds a kselftest for the lockdown securityfs interface along
with a shared file-reading helper and a custom run_lockdown_test make
target.

> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftes=
ts/lsm/Makefile
> index 3f80c0bc093de..3be7aa42761ce 100644
> --- a/tools/testing/selftests/lsm/Makefile
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -8,10 +8,18 @@ LOCAL_HDRS +=3D common.h
>  TEST_GEN_PROGS :=3D lsm_get_self_attr_test lsm_list_modules_test \
>  		  lsm_set_self_attr_test
> =20
> +# lockdown_test changes the machine's lockdown level, so do not run it
> +# by default.
> +TEST_GEN_PROGS_EXTENDED :=3D lockdown_test
> +
>  include ../lib.mk
> =20
>  $(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
>  $(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
>  $(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
> +$(OUTPUT)/lockdown_test: lockdown_test.c common.c
> +
> +run_lockdown_test: all
> +	$(call RUN_TESTS, lockdown_test)

[Severity: Medium]
Does run_lockdown_test fail when building with an out-of-tree OUTPUT
directory?  The binary is built at $(OUTPUT)/lockdown_test (and lib.mk
rewrites TEST_GEN_PROGS_EXTENDED with the $(OUTPUT)/ prefix), so passing
a bare lockdown_test to RUN_TESTS causes runner.sh to look in the source
directory and fail with a missing file error.  Passing
$(OUTPUT)/lockdown_test or $(TEST_GEN_PROGS_EXTENDED) to RUN_TESTS would
avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126131315.1256=
553-1-caixinchen1@huawei.com?part=3D8
