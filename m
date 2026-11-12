Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487984;
	b=GMBPlwHb2iJBUTeK7rJs0guH6LnWSnP4rR1w352G9yyj1d4JE+j71nvTsAC0GmP7oc5Q
	 FYIV0HrNQeH6GKHCdh5n7hoBxTujK5fWl3mlcPNR5cRz8d3lww+GzwhlkHIl2v3VXZvwb
	 tV54m6p3txrgw02vnomPu9frh6mppxcI342Zv0+yR06O6HayDUigmsLCTdFdqpLOTUtv5
	 WGiN99wzfFKErhGm9H29cd56a47nhoGWYVHYU8L6W5Bxgr4kTodvoExbVRxJSxhGM7aHG
	 MMvAyPMF2dmuAfJKDhLcNsCgMzNZ2zCzvG9ribwL77bWfQMPMxsEzioKPr/n3nC225A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487984;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=E1g/koE1ml+lLoV0N9qQIwCAVIBPrzzGP9OirE67XgQ=;
	b=u06A/h5kk4cTl07lmuaMiLzVZoJktvHeXBOGyi5Y2Bliegrx1FbqNa2hoJ+RUwhxVZNR
	 fwpMy6E+i7kStkjrx5Sc72LNJUYo3Y3isgAL8vdQGRYfckNdV//gnxPcP8tw0vlGQMYFS
	 YI0KbpwT2bafURHKbU5b32+slx6Edkso44oD3+Y/Jj/37AKD9CmV+TFTvCoUIwcF8plQ1
	 g5gCBoj99s4ero32N5nbL83ssKDyZT4FKxn7Hatjz6mMK6Fqf4ZYPmE/oQznizuPj893b
	 c0k0a0Eo4vIxVG0o6YchirRkcMPznAWlOzrTIUFs/CI5CpPP5EQhgFr/NR9Pr+e9c7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=C1IMuzwN;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD8606A331;
	Thu, 12 Nov 2026 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFD8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=C1IMuzwN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=E1g/koE1ml+lLoV0N9qQIwCAVIBPrzzGP9OirE67XgQ=; b=C1IMuzwNMw3boErsCqy6m26VMd
	XE7shx8hcHXbONV3VTHr2Mf61XDWfRzkk8g46vvMuSIOJgnf2Dr3oSUW8tUSqSJLKLB7Dfke1gYiF
	lt4NlKj6L6ljuw1wboh3LhXDBpsWhn+mKPq+nAyBUho7hEskAfTEY99uCNpuzHCkUzt0N+giCC7dT
	uMV8VxFT6TsttY7SyOnMEpzBK+y/PXjzpIIE3hhrhXdI98lseHpgJp3XEGEekKNJGukmG1bdECW3m
	3HD1cOtEljIpBWrccEAZeqpojB4wpRNbHJbUl3HB12IsiIpKGuI65PaNhuoDTHhuT39iZ1BfVU5p+
	tWgYHfCg==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIZ-00000003H1G-09c5;
	Thu, 12 Nov 2026 13:53:01 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 0/3] ima: keep kexec dump state tied to installed image
Date: Thu, 12 Nov 2026 12:52:44 +0000
Message-ID: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

kexec_file_load() can change the global IMA buffer size or destination
mapping before the new image is installed. If the load fails, the old
image remains installed with this mismatched state. Unload and legacy
replacement can also free pages without clearing the mapping. The later
measurement copy can then overwrite the installed image or freed pages.

In this v2:
* Patch 1/3 updates IMA only after the machine post-load hook succeeds.
* Patch 2/3 keeps the dump size tied to the installed image.
* Patch 3/3 checks mapping ownership and clear stale state on unload or legacy
  replacement.

Jérémy Jean (3):
  kexec_file: update IMA after machine post-load
  ima: keep kexec dump state tied to installed image
  ima: clear kexec state when replacing file image

 include/linux/ima.h                |  1 +
 kernel/kexec.c                     | 11 ++++
 kernel/kexec_file.c                | 15 ++++-
 security/integrity/ima/ima_kexec.c | 98 +++++++++++++++++++-----------
 4 files changed, 88 insertions(+), 37 deletions(-)
