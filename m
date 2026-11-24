Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534522;
	b=XRXpeASr6YvU5WtY1cXyhtcDPfzItjlp6HL9XC4m4EWl8/oQJ+665dSsQm1GUMhKXm6O
	 rbRnD9wJLUCFeeAWBSVjiFKzq++Ap6DZrKNb9BRDPPJ7tSqft8qqtQDLzysoC6hGVH8Qe
	 6tY6sGb1ZVxFXW/Kx7NQjIVpe+hGjYLtzVA30QWLyssUP/ZCLMAxjNBUR06Xdn1bFh6P2
	 NU3kN6lsqbnFO4vDIXoA/csrWph+OeuXeu0Y5Udwp/57SDJL2Z0aa9TjSW/xStq1HllEy
	 674WBRNGzR4hLsCYsd4AVMg3VtnLWXeA0MWVo24PGvoG9LYeJaklKMR3gxgDL0nrQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534522;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=U2MCwmFuzZcD88AeBP3IL0AoWwTIvmkurYHcid1t5WM=;
	b=smKOYfeewYv3Or2wzBnMn1Unri5NdCycbyivLleaBmgIfMVU9/1Uo0kzAmpPKDvmiVZY
	 jUOXIlwNYeTleMKKZgroIdfBHHbWsXU1yAF6DTop2HD87E7rHhtNjaMrmoxgn6TZCKWuQ
	 jjSjnffcq1SXL924kMGwBNS6O04JU0R7r7946ZILhBQpn9m7CO5aHjIGm7IlgY4ovL5dF
	 UZ5sJXHCuza06jYz7ihMh5V5y+tkDrfYrY6aCrOHppJ+14IcqYkVew4PuHJ/88evttwfG
	 CBLV4H9/vhHrKzqpoqmnT9xFLagYdirwb6/fd0HOizbx41D9VLYclk2TZF60lG0oJPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ksuDRqLZ;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC7606A690;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42EC7606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ksuDRqLZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=U2MCwmFuzZcD88AeBP3IL0AoWwTIvmkurYHcid1t5WM=; b=ksuDRqLZ3d1DtiWQi9F2d/IXl6
	PsRh86d71QYFWFefc7b4VXtiDdMG5MU18vSoQBVUjczhcd7YIhQRlkTINK7F79gE/jBDYWO6QYoyz
	9tL0Cqat5KYFP8B/LpHx5Q3uW3lxs8/5v7djaWGOgf7ddczL1BqDqcAG1izSu9kI2KYwwpZCy7opm
	UAlBKRpfty0En8cnFdhoXKjiaWQ6kqitcI0R5op7rddngOzEcOkopaE/NcDRyrFm1NZpM4w9AlsNk
	3JpkyY6rl2Kt3CUcbFlIB8VQHb0O/x9CXc1rZv9BNtXN26jXrIGGN+sZGxGdORPjD72acXVHwKeHT
	jpCr3Yxw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsY2-00000002UiG-3bNc;
	Tue, 24 Nov 2026 16:35:09 +0100
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
Subject: Re: [PATCH -next -v2 3/8] lockdown: select SECURITYFS
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-4-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-4-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449230.44882.18203870627005417923.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=595;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=HOOyPXxPJeNY/2PCNunSPI/yYvb4LR6i8+eHMEk+AJI=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y3afVTY8bp0cYzV5enLy4qMD57N9V74JzRPs9uW7
 aRhx9XlHaUsDGJcDLJiiiyb3M71zc5VfuTyu+0gzBxWJpAhDFycAjARsRaG/4mrHW7ellO+2MCl
 d//kRuNYvp3Tl3srCNa9Df57uJMhyJnhr+C6921352qy6do0S81P8NJ6uySyStlQ/4bMbb03dy5
 u4AEA
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

On Tue, 10 Nov 2026 21:28:13 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> The lockdown LSM exposes /sys/kernel/security/lockdown, but it does not
> select SECURITYFS.  If SECURITYFS is disabled, securityfs_create_file()
> returns -ENODEV, lockdown_secfs_init() fails and the LSM framework logs:
> 
>   failed LSM lockdown core initcall with errno -19
> 
> while the sysfs interface advertised by the Kconfig help text is missing.
> 
> [...]

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
