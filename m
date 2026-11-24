Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534516;
	b=Qp3H8TNQssPHqCqYqVbVleXjsmVyGEz4UrcBibqxczF+J9pvHAcAdJNor8c6CW+OX4W2
	 i2lf/AW7exubIwjc8a2ncnVR5O/D1IW70fLxWsfjKaXSPgvSM++n0rjZ2+5XfZirSEJcg
	 A596ulAP9h8X+O+hq5IkiVl0J46dyFSiuMTesIRvYlne7ORCb9JCRIGsCXZ2dNDw7rzHU
	 Dzs9JFuiwBIF6GwdwapClh76eYCmiUBSWGdO3QwFuchOCspxl9b6esvYM9oG7vdG6EKJX
	 SIVQl6r/teTE4MQvYs412b4UCkTx3u0rvrDsPVji+HnnmNdqk3I1CHA2XOzct8IgmPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534516;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=Hiqgug4PLfmLDouml7XZwwm2cHGCt3nBLWMYNqWgmZU=;
	b=Lan4c4lrr7wMyYO6rw+TaBWVBz0fptlIMeqfpj1uMY9cSTzTUTmQqP8ghRqwie5Y2SFS
	 WDUyoECg9/9ZfjRdgzCsvq2s9pbRG/Y3+usAypG5B76UJuunKEtNRDyeOMpI05BUc3Ul5
	 NTnnfaGMYV6e0zDqPJ5WFkw2XNZW38IXYY3y4J9JZSLkHU60Nl7zqsy8IXO9fpcftzwVB
	 MbE7gLeYn++/XsypMkmqB73OKX2mL+fbjVyE1u+xLDKKCXYEZda1GTndalHHQiY0szash
	 V7vJMkdY/hoyDYjsL98ExzW8gjoXTVvcevM43zIa/h39RMz1xmM4a9C4TWuQCYod9Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=rpf5wJ6H;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9E606A33A;
	Tue, 24 Nov 2026 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD9E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=rpf5wJ6H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Message-Id:Date:References:In-Reply-To:Cc:
	To:From:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hiqgug4PLfmLDouml7XZwwm2cHGCt3nBLWMYNqWgmZU=; b=rpf5wJ6HKM2U0Bkg2lR2sWD4r0
	TPKbTGapxIKn0UbBs3zBciczAwcaifVwHL2PpG0/eRYhoQnQLJLfXxuHObdd1FqYIMRs9M8nGdcG8
	LZfZpmZVLDAad2lKdXYF5Zc3xtkndvbRh22z0fpItfESLDJY4Uv1s0S33lO8g8pEhBD8rppZst0UT
	VukA61p6oXV8XV+3V6IxssOzXpsqm0QveevkUTr2jGkRXPLNpHJWeoZ7xaVZYXdwLK24UWkAI1xeC
	AVpbCqtx7yOCI54s9EtFIoZ/iGT9bdZ78v+8nmVx40yWu5ESkt0JnTeWeoqz3Amg7l+DRdKFbMSwC
	Q2o6OXBA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:31657 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xVsY3-00000002UiG-032I;
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
Subject: Re: [PATCH -next -v2 4/8] lsm: remove unused lockdown audit data
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
 kalevi@kolttonen.fi, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, lujialin4@huawei.com
In-Reply-To: <20261110132818.2231593-5-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-5-caixinchen1@huawei.com>
Date: Tue, 24 Nov 2026 16:34:52 +0100
Message-Id: <179553449230.44882.17183853283881298076.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=453;
 i=nicolas.bouchinet@oss.cyber.gouv.fr; h=from:subject:message-id;
 bh=cIPn2SAg6D/Mntt5Ahor7lDCbXGolIJx7mRdJypxNNc=;
 b=owGbwMvMwCU2peIRu9mVXWKMp9WSGLJZ1y0Kva4Z9KrGV01qpsnu+3tt99lb6nikN1UIlV5fs
 N8+1OhVRykLgxgXg6yYIssmt3N9s3OVH7n8bjsIM4eVCWQIAxenAEzkeCojw4/nobzyBzXPVv6K
 WSDQN2+XSVMZT67Rf0+BXwG3AysYZRgZ/n/459L+lf3wj8drrZvfCwveW8b7NGnJv6Bn7jsN9XN
 6eQE=
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

On Tue, 10 Nov 2026 21:28:14 +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> Commit f5d0e5e9d72d ("selinux: remove the SELinux lockdown
> implementation") removed the only producer of LSM_AUDIT_DATA_LOCKDOWN.
> The type, the u.reason union member and the audit formatting case are now
> dead, so drop them.

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>

-- 
Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
