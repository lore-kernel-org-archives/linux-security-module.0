Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534521;
	b=qHgALVPFVxRL4xChBV9n5Psi8rAd+tehayB9bEiDa9dg4c5XunR2WCJOrM23LLBUtTHb
	 t7dquxeFD9PhJnxtfgktUrqK07w7u3jvu24jEGrvmYcPi/UkKK0A9CpwXHAk3qxXMJP8A
	 MbEujpsn0XcjsnIANbBm+Bg6V0L8Avs3We2t4qTuU+8hvCc84LvTrMWhSzCQvEzHg9+ws
	 LmMiHekfNwVGJwJmsLyjvY2iVbt1WzLhTcYwnV+J027/mWxRhPzz4Jmgrckj5itKGIBUC
	 eUYUUDMposw/JxOZb6Hh2fAWeEzQnoYlwg19GcEo0q/GhTgQlFiqkldJirgx3PahcbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534521;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=ve9D1sw1D7pLPb9ETk0iv+r+Kmih/khP9QwJdW3CUW8=;
	b=2WMXA8o01c47YtSNe+YFi9+3o79aa8U3PdDcvbJa4kvOJIGnPphij6h09LSRagDvlxXt
	 FZBEs10lcWhTinfgSXzVLosgVOQqRv4F3Fdrw2PJs6juGRSYg7SUe+BiWhLQE7GXotwBF
	 9zv+qRhpc+z3U5F+cy/k+MKo69xvaNLn2WuWRfWDzv/LAEkYuh2myE/Z0aEdhQyaWGX+C
	 zl/0n7aKTua+boG6O58euO7a9X/wp8S6VuRgV33oUePODeoMCkUh1wsF4DN78CkXbl+eF
	 VyrqEpbs5Bu0e8uVqXAgRdifnQ124/VE8b6cQ4Lqw4ceJTsrPlgNw3lrL1q24ojvXsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=oEEjeYFO;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E122606A69C;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E122606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=oEEjeYFO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ve9D1sw1D7pLPb9ETk0iv+r+Kmih/khP9QwJdW3CUW8=; b=oEEjeYFOJqglF0U2F2mUhUpV/U
	C/PsgXH9G2RqT6UfC0Czx/Upq7ajOvWRMiJpx3pfG163B979k0p8KCH1e3LCVww1r5JIphtuNaNuZ
	22dq67YLsNZ8DL+v36FordWljAiV8/vWCuRLhGJvuEQi1yZ0qDcRKxvRVTLAe9ZMTA/Ce/Tdkllnz
	RWYmv/YzmjqtyfOdwcpTftIchU1M7UwXkvsEzzO21hwCIlYLUInpk9kQ4SQ8KzVLk5bN5nhQ0iMgo
	O5cTMD4u9uCKND+grErgBJ1BRg8IYaUWG5M8TvWrfEdTYClyjtmS+Jg0BiBV6UoMxJPoN0NepOGh8
	5MWyq+7g==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsYD-00000002UiG-2ftX;
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
Subject: Re: [PATCH -next -v2 7/8] Documentation/ABI: document the lockdown
 securityfs file
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-8-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-8-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449233.44882.1326744310769826577.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=579;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=6tQ934HG6QceKZ4JfAxeFz1R4zUOmBzwBGYOmz4V50c=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y1iWjBvPZ+tyOKp/4/z7HIu4nl/Y8+1u99eBFgFV
 TCG35+l3FHKwiDGxSArpsiyye1c3+xc5Ucuv9sOwsxhZQIZwsDFKQATUfrM8D/Ace++s4v2r1E/
 N6NmTf7TXbeOTLhwduE8ux/Kb7PDRGb+YvhfeHBhSc+J+qfdvhzuBRu54u4k8jG7XWebd3/NxZq
 uc1/5AQ==
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

On Tue, 10 Nov 2026 21:28:17 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> Describe the /sys/kernel/security/lockdown interface: the levels it
> reports, how the active level is marked, when the file is present, and
> the write semantics (escalation only, EPERM for the current or a lower
> level, EINVAL for an unknown level).
> 
> Also add the new ABI file to the LOCKDOWN SECURITY MODULE entry in
> MAINTAINERS.
> 
> [...]

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
