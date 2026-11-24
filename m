Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534522;
	b=0r38FFIpL+28VuiCbB20ELzS15e7T5535dZNmRQc7CiHUBHc4LOsT/183QGt78MwKpU7
	 VZpOkwz/kQyHyW8EIWvAsYY0joHwBxN+nQqNb9+Ct/+UKGOeh7O58CwZ9/rJoUv8j3EOk
	 RjBahajnGZvOtLv3zvt4pr/giLdLfudSDpk3R5IJ4jkxPJ5spc5rpmWRJIoxjALRQYCSK
	 WFFxi+1Lf05zyRalvYp/v62yMRxHGEt1UtbBLcBo3s2Y7shkQQgoBueQEhSfRnu9l4dRE
	 4D6tLV5cA1Nyas/uh8aK1WAPEi91IdqUeY7CFmzJDKwKWMm21277SNcl3E+uQi/r1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534522;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=dTANOfapry/kWMG+qtlg/HvuY3epqWUAxsYeNAz46d4=;
	b=qiuYbZ1SAkWoSMZi6qR9ajSDQSiqhaQo36uD8JikfAJXeyh/iFUeQDWsDoKr23Ay72SJ
	 wMN+KTymIf1NftthIozv+GfGK+WMPDgO+S5v3qhxba5/BXKa8PotTf9REvXV3gdqO7qq8
	 2E9Fl7FpfHMaWoELJwJZOvlXwIFcohByHz8q3PPyhVawUXvBoZL+wMZmKGpjfUVRp7D2Y
	 xrRzKcFilJDdB9euShfHr8ewYW7Ftx0Gr7r258rQOnCdBw8bFq+kRvB6OEtBGAwR3sqXv
	 YPgeVZmkfoUp3LjCq5SxQqzmyQ8fJiW2edGYJOuiBW7lpDCfoqxDJcfqEJmz3MEw3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=DWrGM6T4;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF4606A68F;
	Tue, 24 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DF4606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=DWrGM6T4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dTANOfapry/kWMG+qtlg/HvuY3epqWUAxsYeNAz46d4=; b=DWrGM6T4u/5ZdOs86jhYZ4DRid
	HQWinb1JRW/E4B11To6FV728COB0MllmLCp22S0trhpbgKfPcbLFOrsP6mnWSoj9n5Uxd6Q7ZFDEb
	iI49eMxxETZRa2ZQmW6l5eV4TcCe04+lawvD6bp2LHY9mFECa0M3dMvlCbuybcqR7sxCc33qxRphN
	a0+BSNEGY2ecMZ5cKdOqVR2Rv3PNm5n2DQyNftTRxavndbszfwqj6Y9aspMhUoPrGKYbNM+npV7c0
	IuqDLkG9ZZgsiQULRDrnMD7pqKypJWbNDWWupAl754GDxE+cyFoaZxyTkfqGFbYRluVlY5jKiRTw2
	u9FiFeHg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsY2-00000002UiG-2uiD;
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
Subject: Re: [PATCH -next -v2 2/8] lockdown: remove useless decrement
 operation
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-3-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-3-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449229.44882.17479514791910514460.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=223;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=0qDO9aJKognLhxKS37b9xZ34cC3VV94jLC+9gnb7q2w=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y3inP3hYahQ2qfXDz8tz+yy/zVj1+OsR0FuAkxf+
 0JstRhdO0pZGMS4GGTFFFk2uZ3rm52r/Mjld9tBmDmsTCBDGLg4BWAihs8YGT71/Lu86K5999PT
 W1+5SaWvkHd/JBpzYq2oUWPC1D+7Nl9jZDjl0HjBL/toQ99uz2/MJ9/vL2FZ9NXHkDVpWfcL8e8
 3TzMAAA==
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

On Tue, 10 Nov 2026 21:28:12 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> 


Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
