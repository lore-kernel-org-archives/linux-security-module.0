Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534516;
	b=G2Ml7o0BlP/EZLs6gDbmjyPVTfIIk802Y7mabtxzAXOTNMN7/06EkL2QyhIGGMAQguhX
	 oFDnRcleHjkwwO1aw1/GO3bfrAyJBSnq9kWo5MCKWucjpIv+s4ZmIQkhQ0j5S2kiWmow+
	 SfiPz007/BFU4EMCRGlzXoSNWdUSocNYzvcLqPY3JO3Tgk62U/L6xR9lbdMsjFgf0vK6o
	 Xc/QjiWVw6HOjmKNdI6e+wll4cWkNsX9velmeqHS2rd4VLQkN7dHJTzOCk9NvZgSHhWXw
	 KBGy9Dt6CFYWLsxxcA2sKbgdqowVOE8x72OidtfykSRMkdng9tg8i8Pnei/XWFFRaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534516;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=HP8ffLKyWMSuXN5BRZz5JEfDRVGBX0eU5k14nx4it7o=;
	b=zT+efYbZSVXcPGgw08x0yLC3dYFS2X5u2LnrMWLSfP4PQcf1QySe3eKHfWQMrupuZwpp
	 UaPkSzQMfipyXB3kEJEtPoUa4b0ImiUVpgzmkOUwwGxk38ntf5isgc6gY+1HPXFuZEdB3
	 BVe/z3HfF3cUxT2nertam4HJEFWHP9V5olDjagGgz1vBK7iidtO9M80Rrd64JsfuDRVhd
	 YPGvWVRZV9HQzSyn/GD+jnwGhfNwYJetU5u1rdGdJNZKyLjCyR/nPVtEUNVk7BEY5NwbG
	 sugEjix9Vh6WtijyvycRKC8Rodb96S9P7LC58jxPqq6APLc+5dEXwVqXBI8ExcWMp6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="k/s6ELYU";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1E606A6A9;
	Tue, 24 Nov 2026 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE1E606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=k/s6ELYU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HP8ffLKyWMSuXN5BRZz5JEfDRVGBX0eU5k14nx4it7o=; b=k/s6ELYU7HTNllOhgO6iKxbHU8
	NGhFmMkhHLDkOvV3mmL3Ukt1TDn0R2LKjbm1OFoUqH0VDav0E2dyD99G5Xb6wUAsdkNFLUJenseyE
	9og+AlBvMgu/sH3mdCvZwX0JLOczPZvFQ5esCWgxfwm7SL7uIGuWf9QU22T6NNiK6OjQAObZ7mAWB
	c5+AKJZYOk1chU10Hf18WNofHNMlX9RwENnOg3RxOFswglXjMRoDZnR91/QvqjmuSOYCAbyV8kn1b
	/byvsxdmn46d8boh7sktNi64TTERFP3Bd7xm0DMqc4RVuC3svZHKWKMdFC7V9U4k3FG+wWDqCaWMH
	IowsLwKQ==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsXx-00000002UiG-22bz;
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
Subject: Re: [PATCH -next -v2 1/8] lockdown: Add break in lockdown_write
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-2-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-2-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449228.44882.7548116099942288445.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=344;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=0MJqhhXawMPdnwjwINqfuGC8pWiDbBYlySCxhWfw1Zw=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y2MctGbY31ERHCt3PqwPynlXVtuL4xrSpCbOk2/Q
 vT2SYvbHaUsDGJcDLJiiiyb3M71zc5VfuTyu+0gzBxWJpAhDFycAjARzgaG32x8nrJXH3yLWcnP
 yHzW9fCEX5s08lalMdi4LZ58dokfRzTD/0JpppMTQ6K60i23bv35gbdc+abamsPl4jfWHGNryBf
 q5AEA
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

On Tue, 10 Nov 2026 21:28:11 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> After the label is matched successful, any other levels judgements
> are meaningless. Therefore, add break to return early

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
