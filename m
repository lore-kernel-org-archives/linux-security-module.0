Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534512;
	b=2/1Mc2Xb5ijbveg/ktRKh0XSV6P587i1gk+nIPRz+U+hM/t5B07AB2kztTADNXf9d0tV
	 Tl7qmHgFxw6nizI7cXI+56pm4nHg8foshZ8FJRhUQwAsmun39IJZqdL8DIR8krtTygbd+
	 0tO7ExxzeXMGCnN7izQEyuMFpTu+11FJEmyz+TJw/wHnl5XgMrndGKRa3BKtrG2NJyqto
	 d2oeqCuBl77erMHYyPkZzOssGIoR4mCzZNKn/XrqjVXUgxknDyiakzK5gQ7ai9VzSXn3L
	 YSm6tO0JznDuk+DNVhkcG0/RDf3bCrkB6Q32vLgJmJgJ6k1vZ9jaO5V2MFHK6zHGCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534512;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=klZintxQyYJYwY5myxqCQjOAc4cylym1ddpi2+pureo=;
	b=FewwlfW6LfiAH2ich5oVyWjfwaFWNUwpYS+3Z4ALVsVVP59/Cab3B3wGhhKJRxpYQJE+
	 yD9Grb94ChFvLbweR08FsKXH8D1B8lba2FwC/OlfgNIAgJDfTyyWKS17HZfvBXGgpsrJR
	 6MqMRC8QSWhKNFMuzsr6UBFIGej5Ohgx4iPywHKLApbNZVNS8aHnaquz7YYGL7tLMUylg
	 iIE2YdpSdwDNdfV9Y4DvaO7Od2JxrE4IFrB9Gt4OGi+wtX60XXqt5thpteTL6UMV/qobZ
	 Xx+8A5cW5ddRZ1FumhHfz9HDpOfQGHu007kW8vt7ZQAp4wNq4svGgHTCtyUE3FdMGXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=m869IuFC;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA986606A329;
	Tue, 24 Nov 2026 15:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA986606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=m869IuFC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=klZintxQyYJYwY5myxqCQjOAc4cylym1ddpi2+pureo=; b=m869IuFCZ56sFzF6YGHIyLQyao
	acT+0/t10rbhtJs9aj1qffr17801dvFZhZEibRgF5f6veiM9Yp/QSpp79ckYa7UqSzoLah8+5LJY5
	2Oth4VxxvvY3trVPD1dccd2a/kBOt0pWwX47mAmxD3eOqsWxcoJApUbly1x+6ws7jJV/hwaNQAVKN
	Kgi7Md44Qb+AUL2jWlKd2qSOLPctlBb/VDkyKJx6yBeg9rPulx6TDGHDu24kaPh5bawR7hJBqvfFn
	K2menaiugLNK3/PxABZVALSgRkCrxgLfchiJ23hWCrvQXwGfKU3blpoucp+TO6AkUG2Ckw/N/+eCr
	djg/Yk1Q==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsXx-00000002UiG-19zg;
	Tue, 24 Nov 2026 16:35:03 +0100
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
Subject: Re: [PATCH -next -v2 0/8] lockdown: fix the securityfs interface
 and add tests
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-1-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449228.44882.5530794140051904297.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=268;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=PtCh7thz3Q2YttE8bAQqBYCLHdlzWubcG5d5XY0mS8E=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y3s9gw7d2B2nbJAk8ztoNroCXtqzML857Sr69+q1
 567Xk+jo5SFQYyLQVZMkWWT27m+2bnKj1x+tx2EmcPKBDKEgYtTACZy+wwjw3HxU5b/A/NFReKj
 p5ptWcwTM/fX7CfZ1psn7kov3tX/8wPDX6nWEytUj92SeFy8dMaJSS2LV6RvLf5YfMmyZuXquo1
 PNvECAA==
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

For your information, your e-mail subjects starts with '[PATCH -next -v2 x/8]'
and break tools like b4 that help tracking your contributions, could you
fix it to [PATCH v3 x/8] ?

Thanks in advance,

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
