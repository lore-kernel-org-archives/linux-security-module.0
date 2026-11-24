Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534521;
	b=ZsG2H4ripzAYLzuSE4jDCHVuJZnceiuchs1SlZUv+gw8z2oy5o4YOJi7DbOtG+l6pyHH
	 lwTmcb73fyQ+0Nn30/FIF8Khz8ZhN6x/R6ZycYt9pPBBOrV1trsn2pE7UfL6BNAx264Ao
	 ksXQwlkpmB5ohw3faRquX0a7YsX3vmCOBBUOl9eFCkNDNvwqhwuwZ/6w2iTqwA4Fd1xZm
	 7fthTLhPiRkYTbL9NU4zG6QkERsRg5F/MjjCr3zQ32njdwUEKWj+kqwSO94VwrxXmnTD/
	 BbYpHkb5Z6FhePFmsZ/7yOd06dsPNXnP6jA44JUGyh2zvoBU/pSrGP2GHDdnD0qomcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534521;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=d6GVqWaqNAqNeLw2Ue4FcxoN9CsQsPwYzn/VCZH2Svg=;
	b=JfT/POWu70qat+hAcFMcjyy4F4bh8gi4JgDAE5eZ4IjCfomRW9cP904SlG9LZ/cTRBJK
	 dnRtJ7xjA7zwedwGnd2b8mPDYmDZfL2kcRy26juN2no0ZIxV4YRU8+0YBM6M1+WTCB3DL
	 z75FbrkyLimK62CgNJqXtCdABJ0oaRJme/Q7qrUCphD0akMNllp13P21l9tfcVzVFOOIc
	 lbD0h2gsNTCSwdfnrQp9rdxl+4wgPKkWpfsuHS6C5vmclNsDVkQCJowQy83Q3sRz3Pp93
	 ZYHvJGdO3k6/hWoOvbKx6hM8cXnQneinZfFB7CUOnLuvB3fit8eJhEOpTTyhwzTsM1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=e0MDkH5f;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299D606A697;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5299D606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=e0MDkH5f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d6GVqWaqNAqNeLw2Ue4FcxoN9CsQsPwYzn/VCZH2Svg=; b=e0MDkH5f1zeVuQoWo0a+9q0Dvm
	8TH0vjRjHNOf7+eZw+KvA5xvDJRxlG1vv8YruOeBkEbPnNbC1ASaVrJMAR/cD2F/0UgE2AxvslVQ4
	KVzwWq3pNgSwtYRPhNPZ6YsoQxOtNZdobPEGM1ZqB5/I9o2xG2B359r90dd2et8A/XQwmSEeMuymZ
	IsA+U6V3h0G9uo8RaettiGRsvxYnEGf8jmwxaZQM/QT1qTfEmyuDWk7nMfSi6XHecprgHvbQm3I98
	1aWmp6hCChxyFCwSshy3dgOlSSeEtBrPGml9qzKg9YLoz5XZk4IE453olqdfE3vRlyD3RQPKKI9N7
	tjHDuwgA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsY8-00000002UiG-1FRI;
	Tue, 24 Nov 2026 16:35:14 +0100
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
Subject: Re: [PATCH -next -v2 5/8] lockdown: drop an unused include and
 move lockdown_reasons
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-6-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-6-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449232.44882.18141947722779080657.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=TaJD7L+9QNLX1XJg9ryEuRQ83UbGqYdJepw44FNIt+Y=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y1adiBgfnH9yzv7F5yqcNi+gnGvkJSgzYkTbzJ/R
 J91mxuq2VHKwiDGxSArpsiyye1c3+xc5Ucuv9sOwsxhZQIZwsDFKQATeXCYkeETy5rbXAHX78x9
 xOL4u/zJCwHPAxVpjx/taE902t0o/8qb4RcTk/e5Gzc3nbG473GgZznjkhshBaEcb/mPCFbGvL3
 +6QsDAA==
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

On Tue, 10 Nov 2026 21:28:15 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> linux/export.h is not needed since the file has no EXPORT_SYMBOL() usage.
> 
> lockdown_reasons[] is only used by the lockdown LSM after the audit data
> was removed from lsm_audit.  Move it into security/lockdown/lockdown.c,
> make it static, and drop the now stale extern declaration.  The existing
> enum comment in include/linux/security.h already pointed at
> security/lockdown/lockdown.c and becomes accurate now that the array has
> moved there.
> 
> [...]

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
