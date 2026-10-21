Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616546;
	b=lylvVuyVC5rlzuotQ1GIbJTD0+Q6o8lj4/P53/iO328Ay+CwFkVEFZrZBtGw8P0Tkbap
	 kNtEVSWAtR2ostCFWlfwlouGqTZlbvkuphx82y2ea/aG/OHGNbqEvqNsaeUnpIebmrwEe
	 giiA0lB/NBgMvGB09SK7CREWYyeiaiHmoFV0JQQPpcJqaA3nZYluoetXcGrfPGpMk2BTu
	 ZbHsQHNbUJXQN6/nyx353ncgfbBfh4HsDoqtcNnDRhP3QmWNx78QLp7k/Py+j/aeL1eRb
	 bMnehyz9RRzPTKpj37cqU0olIROJzQ2LYYhh4BWZ9PkWla0TN+ESctZD3PSyd7AfDqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616546;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=6c300qt73sA98//Lr65hEgnfC/Y2y3DlaEkW45zDMNE=;
	b=cekI9UYr2Bn2k3mZT6aWY2aN8B2qJnGEVqzbSyQXWyPB4cekeSkYJT3tUVayf9MuSru5
	 XfjU1ciK4TiqJ0jutCWmHWLL8ZBISHeDnfWbVPH7p06TLG/FKde6XLi4wbVAep1Th0XMV
	 RUDx5ys+r92FrVm+MhetF/gvcbD4TqkI10Ct8sg2fspMFMy91FHRq5JPmX/hy/oWyEaFX
	 TtoEngoiyfRJa0dzn9S5tQ145CkEG/magwvnt43PSQgKGMlAX6R8SAvg/L+zn3OB4l370
	 V9DV5IO9mwKYlzk3v2/q0vwxjCH7vs9kb3TGuKDeqL8i7iAwxdt/tyQtyg39rRWjBSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kOu9SbjX;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B16606A322;
	Wed, 21 Oct 2026 21:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98B16606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kOu9SbjX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=6c300qt73sA98//Lr65hEgnfC/Y2y3DlaEkW45zDMNE=; b=kOu9SbjXJCir6uD2aanrqVvOXW
	NeerG8jPaNVpqQrd+nd76HfRtiSLLTpfUza8hiCJPP6DR+ESOU3JGiPC2RbZ4vW1anR0SH5jUWmbC
	4mEohhljprw7ZjlBDnVBum00wnNn2HPPjOvYu8bRGD5YgU7c/BW9vp6qiCi9+TzQmUnKNyVbTpq0i
	jwzMh/xmAtym/LkTzUfHdNNuk5KUYUluhEePNEelO8O2069PqKFhNsWVyp7VmHcG8PLudxCFAmwpP
	ZCtMD0AMp1W2Ugnx3c7tiZZwOi2gXzhFSuB/I3LI1zqa76K5sciGelPSqWMxtoo7+Rltb0iDD9ecV
	EUFuJhVg==;
Received: from [151.115.150.205] (port=53842 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xJdS5-0000000EZvy-2sVa;
	Wed, 21 Oct 2026 23:02:23 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v3 0/2] ima: reject modsig when detached data cannot be supplied
Date: Wed, 21 Oct 2026 21:01:44 +0000
Message-ID: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
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

ima_collect_modsig() supplies the file contents to the parsed PKCS#7
message as detached data. If the message already contains embedded data,
pkcs7_supply_detached_data() returns -EINVAL, but IMA ignores the error.
ima_modsig_verify() then verifies the embedded data instead of the file
being appraised. This could bypass the crypto check if one supplies data
with an already known valid signature.

Patch 1 fixes the verification path by discarding a modsig if detached
data cannot be supplied.

Patch 2 keeps the exact pkcs7_supply_detached_data() error for a
separate failed-modsig audit record. This part has been split out on
request from Mimi Zohar so that the verification fix can be backported
without this audit change.

---
Changes in v3:
- Split the verification fix from the audit change.

Changes in v2:
- If detached data cannot be supplied, discard the modsig but continue
  hashing and xattr appraisal.
- Keep signatures without exported digests; leave d-modsig empty.
- Audit failure to supply detached data separately, even with O_DIRECT.

v1: https://lore.kernel.org/all/20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/all/20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr/

Jérémy Jean (2):
  ima: discard modsig when detached data cannot be supplied
  ima: audit failure to supply detached data for modsig

 Documentation/security/IMA-templates.rst  |  3 ++-
 security/integrity/ima/ima.h              |  9 ++++----
 security/integrity/ima/ima_api.c          | 28 ++++++++++++++++-------
 security/integrity/ima/ima_main.c         |  2 +-
 security/integrity/ima/ima_modsig.c       | 16 +++++++++----
 security/integrity/ima/ima_template_lib.c |  4 ++--
 6 files changed, 41 insertions(+), 21 deletions(-)

-- 
2.47.3

