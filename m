Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD84F6463;
	Fri, 25 Sep 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369726; cv=none; b=OarrNgPtIzpJCZUu6kG3M+t91RmJWA9L/sazMI/5phAUy+NRq4HFKblJle5kfBBvF9pQQnnW3lR44J1N8Q3ejTHz9G76omx+8nQQlM3IV0+mK5sgyVrNrMs5yEiy3s4S3no7q6GCvfwQTEieu/T8kptuATogqiFTDpbvZXdyFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369726; c=relaxed/simple;
	bh=jNJwy5TYDSovTv0p8YwMBLqUkTQFQS98pa8IFGosqsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQZw2MRFlCaSsM4wsXmBY1GO9B2we+CC45omdUTH1XLNNONKH3dwb93mkg56VxleW+2roC5MDZpwID0nhV4MOse+bxp5eX9kthMok8o1CTfyMhQ8+mKV/XkGyqvCnXqrzoFEvtuYe62c2+7PwQVsM7gch4hksPoD7I+FNF3hAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=hRMBk/CZ; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="hRMBk/CZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=bBDGuJ49t3zKk2lG2TIByVfPl7yxSk6xy9H8SQ4q68Y=; b=hRMBk/CZ/IMugfL0IgUD17SXun
	KXU04QnlPX82vGFelmOyo8nCuO1uBoPk+nHiN9JOUCKVVP6+HblJjfkspcoXTu8lFsfPVBXVZcm6O
	3g41cSMyGeWwMpzGxe+Yssd2i2P5fI8yCXsZ9LEa7+JXxZDQQ6C/EczUV64SDjPNzYwOv+WYr53Wb
	t45oo4C15YTQIJ+RW23OkF1zNikfLqkZg2ja499yvx7YTfZw5MnZqNOxuoMympAY+PLWzXgudf99f
	QZl/ifIBKSDKg9sMQB9zjq+CfB5YxyqaXvr5Fknq8JX0vPjWaQs4bJ/fBXoXP6JxMGkzQtTWQ/+f4
	j5Ci/2YA==;
Received: from [151.115.150.205] (port=51460 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xACwu-0000000Bapv-3Kec;
	Fri, 25 Sep 2026 22:55:15 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 0/2] apparmor: check connect permission for SCTP
Date: Fri, 25 Sep 2026 20:54:46 +0000
Message-ID: <20260925205447.1244190-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This v2 adds a regression test for SCTP connection mediation in the AppArmor
userspace repository (2/2). The kernel fix (1/2) is unchanged from v1.

v1: https://lore.kernel.org/all/20260925193842.1208132-3-Jeremy.Jean@oss.cyber.gouv.fr/

Jérémy Jean (2):
  apparmor: check connect permission for SCTP
  tests: add SCTP connect mediation regression test
