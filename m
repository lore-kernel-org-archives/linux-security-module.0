Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834776;
	b=sHN03wvCKse858OwWHKKXFbW72AiASe33wDhg2oSXL3MpWmlvtrDmsVjwuCARSxe5hyG
	 8GiEjFw3k4GhIWrOvL0tajP/UsqGqgBU68yhTI/9tyN67J+C41364jlKZu8umoGoNXdSp
	 al9luvTd/mIZCUb/AxmKKLdKEHAzVHQRjVU5acii16MV3cj6OLbdg5QWf1brme9Q5jMSY
	 8uK5375EQ0wmxRM1jGEJo/K2fk8zt6G45loURWLhkPIIwRsoUYKQ+WErH7i3A60xLf4Te
	 lq6YCgeQo548n7z0k1BjXXUSgNs2wxlTeBoT3tCwgqkA5oH0bTJtDKcqjTjy7tWTHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834776;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=KS31rkiTulpWJCx3QTCIFROUZoxI1bFNTGmeAsZs3cE=;
	b=fQZWT3Ea4GyhVEcJ2qwqdqrKOlisiOKwZNQI0CKtzPPyvsAm7MYZZ+p5FAPv0bLiKYdk
	 CXIn60NGfo+tomu/rgiWiKbL5F4v0Ak2X0JppZ6wXKubNxqlq1/Bj8+HU/M3tTQK+Pau0
	 yF7CL8baBfoVdvWR2cQpTP7/42PBLskjy/EWpQGIR019RFrDapf7EM3flYgCCVmLFvtp5
	 Il+OWl30+Zuvs71vM6nHIEObe5yNY/rRNKonoO3N7yiZz5FZGtqZm8tEYGmoNuZTMiA7x
	 QlSR+HciLpmuLGA+ycVf92di7sjQhiOoYVgv+Ey39YQyTxtsGuJ362D0XFLPMgV+Z3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Pl24gv1T;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5E606A31B;
	Sat, 24 Oct 2026 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE5E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Pl24gv1T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=KS31rkiTulpWJCx3QTCIFROUZoxI1bFNTGmeAsZs3cE=; b=Pl24gv1T2hbzNxupm5svHroa9r
	X+nosB8WhrbBMFEN13UXVNmQ21J6Yu2hH8ShKfacGrmdfN9hRIa1FtezUAncA3zepiTpgUohq2l2a
	MLtvXDqiJXoKkCktiV6Mepn8/eZUrKyCvu70faFj3InmbVcBz95zrMpLiTnPam6R2c6SWvzx8m5Wx
	fyBh4Er/pxgf/UIxZrs9D50zSc8KNn+nwga4uepqDCpx+qj0yY0tqvvlZNwOTdO3MVqSvlsVDdENC
	8PfxalZ/ze72FpAmzmP/Wprr2AaQ6hOSPJ9coJ6fGs8qOrVKQNVd2hUsp0L3togk+DqLZ0TBas0z+
	l/JS8RIQ==;
Received: from [151.115.150.205] (port=36518 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xKYDo-0000000FNZU-05ud;
	Sat, 24 Oct 2026 11:39:26 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v4 0/2] ima: reject modsig when detached data cannot be supplied
Date: Sat, 24 Oct 2026 09:39:16 +0000
Message-ID: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
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
Changes in v4:
- Keep the call to pkcs7_get_digest() unchanged.
- Adapt the calls to integrity_audit_msg() to ca1e0f3cce8a4.

Changes in v3:
- Split the verification fix from the audit change.

Changes in v2:
- If detached data cannot be supplied, discard the modsig but continue
  hashing and xattr appraisal.
- Keep signatures without exported digests; leave d-modsig empty.
- Audit failure to supply detached data separately, even with O_DIRECT.

v1: https://lore.kernel.org/all/20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/all/20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr/
v3: https://lore.kernel.org/all/20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr/

Jérémy Jean (2):
  ima: discard modsig when detached data cannot be supplied
  ima: audit failure to supply detached data for modsig

 Documentation/security/IMA-templates.rst  |  3 ++-
 security/integrity/ima/ima.h              |  9 +++----
 security/integrity/ima/ima_api.c          | 29 ++++++++++++++++-------
 security/integrity/ima/ima_main.c         |  2 +-
 security/integrity/ima/ima_modsig.c       | 10 ++++++--
 security/integrity/ima/ima_template_lib.c |  4 ++--
 6 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.47.3

