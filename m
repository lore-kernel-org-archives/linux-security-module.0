Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534522;
	b=qLgGtjXjp0OXFWvaFS5jSeN/R2yh0yROHPW4NfcnBZbMKiENt1MyGkLnRXZ0nVkzvaTX
	 I2Wk+r7eI5zlR2F+RnUDNwWauNXYONeKOmM31kFrPlARVCiQCc049TErR0tYjuMCl1ERg
	 vz1X6G+iFtSlvioKShOjOci4Z/bcqy+IvGlOVW1LEGxXqDlDFQPSnyQQs1vGrFyTZkIIz
	 fc1aeluIQ+MAu7OAXoTvEba6+yWVKg7RQJ57JYCNqoPW4nburIgOZQ7vPz/JufaY+OX2C
	 a1mdP/yjTVSmPmoY/qWW3t9mVJ6JwUJWhBDex7+IZ816s6VH20BskP5/ePGhBNzABzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534522;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=6bbY7vd5NwL+6Vriv6mfb0SsFpRp1+XhUCVFLucctF8=;
	b=m3KZwa5wbqBvmFbYpY7oPk7tO83C8g7YBemCX2qYTXH5pSr172lSwD+sxOyC4AVda1E6
	 ytTMjHCHIvREkjmTnBScPOJnUvCvvDS0MPVYMU4UO0xAzo2Mm04ENDTQRCZhiKMfB/PYl
	 bb2VSD7pMrAzxKDPIuQPi9c4P+aDn0+4UTF8p37ozHSujowV/G/QbPmhbm7iBkfwBH3WC
	 Cg7PpvMmDusAwwl6zrqQXLuQW2sRJ7staoCWXMfmXX/L6jji4Bk9MS/KGNceCk3meXrWn
	 K+zPukAhDKSyLPdUF2aQ7M1ws8UgfOmlQI9jeMUPY3fMOAzDAvYCYZJF1wgbbd/yO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="aBt7/SVn";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246B606A69D;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A246B606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=aBt7/SVn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6bbY7vd5NwL+6Vriv6mfb0SsFpRp1+XhUCVFLucctF8=; b=aBt7/SVnG14O2pw5dAtI5LeXRY
	BeGnBCVKy+UaS3LMm7tAJChuW8UrsAWrXdCcQ2skzTcx7sW+lDnNOLQR4CYfngntx3uobE2D9wOUN
	s8SVS/KjGVCHz1viyoSy2rH7OBs8uc8xHs0XPv7Gb3SwHaT62YSY4eiOKQVeruBsvlx9BHWHMig+q
	M+Wus+FBctP2+JFfvYsU3bvr/f0CENsg4goVG8eNEq6BuYk8JGqlrG5ph7PVmgSC0ThQqUlHqYBq7
	jklsbc8xaSZQhzMXkb3Oz6KV/pyLGMUVC2MhT16lwscw/UGlOWqPQeYBdDFjOvDOi+bZJkf5yO/ds
	pN3t8l7w==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsYD-00000002UiG-3P9U;
	Tue, 24 Nov 2026 16:35:20 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next -v2 8/8] selftests/lsm: add lockdown securityfs
 test
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-9-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-9-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449235.44882.11974736188520062001.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=ZaDtPDq1+Lz/VS4CLkHW2wkDkVO14tUCWhnwfCttqoU=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y3u/Ka0U+SeZV7J1n1qSZs+iQiKKZwMt9AQeGmzu
 e+BqFVYRykLgxgXg6yYIssmt3N9s3OVH7n8bjsIM4eVCWQIAxenAEyki4GRoSNjTn3BLLPsj9XX
 QxdEqzZq3oy4E/6wdIf5fDmZPvO1yowMa99Eyxh4eW+0XPpwdcuSF42u0QqdTcbLnq/58ltr1al
 oVgA=
X-Developer-Key: i=nicolas.bouchinet@oss.cyber.gouv.fr; a=openpgp;
 fpr=FB48DC6D172A3DE30BA94B0DA548BF06BE454ED7
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Tue, 10 Nov 2026 21:28:18 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
> index 927dce4f04cb2..e7d5cdb101375 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -50,23 +51,39 @@ int read_proc_attr(const char *attr, char *value, size_t size)
> [ ... skip 26 lines ... ]
> +		int err = errno;
>  
> -	if (red <= 0 || red == size)
> +		close(fd);
> +		errno = err;
>  		return -1;

Here you change the return value of read_sysfs_lsms function, leading to
hypothetical test failure, take the
lsm_list_modules_test.c:correct_lsm_list_modules test as an example, in a scenario
where the size parameter is not sufficient for the read string, your
function will return 0, thus passing the test (obviously, it is
currently at `_SC_PAGESIZE` and should not fail). The previous
read_sysfs_lsms function returned -1.

Nitpick, in this scenario, you also read one less character than the
previous function.

>
> diff --git a/tools/testing/selftests/lsm/lockdown_test.c b/tools/testing/selftests/lsm/lockdown_test.c
> new file mode 100644
> index 0000000000000..fed050551cff2
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lockdown_test.c
> @@ -0,0 +1,230 @@
> [ ... skip 206 lines ... ]
> +	}
> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));

Could you synthesize those checks in a FIXTURE_SETUP ?

> [ ... skip 10 lines ... ]
> +	ASSERT_EQ(0, write_status(next));
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_EQ(0, get_active_level(after, level, sizeof(level)));
> +	ASSERT_STREQ(next, level);
> +}

Since this testsuite is not included by default, because, as specified in
the Makefile, it will change the machine state, you might move the
upgrade test before the same_level and no_downgrade tests. Hence those
two will never be at a none state.

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
