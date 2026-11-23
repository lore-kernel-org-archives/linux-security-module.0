Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436057;
	b=lkjWZsu51TbopRHD4OHsvl906W7KnlQmP33Ik/Kc22zNhC5W80tn+WS+VTrf1J7bUck7
	 5tgN3OH19BRiceI3uq0yxUd+M08N6wUERDFaxMPL+5PVbmzyCPSQZW/oLdo+HSOSsB2ro
	 ozHtDLCfgDKHJAwGzH3wxW3f/uiYePBA7XSY/sTq3pKh7O4RXZTXnSAoslT0vW31N58EQ
	 Epm2oznA3yfSKei6CLJSlsxbViFMMIQrV9XKMta6c7JW7pyAY8O5LXmugiqF/0m4OBPvi
	 AlrRnsFQrCh13g7D+ipx9NxEKWzRFqht0ICotYRlrkEnn/8z+dAhdXAQdCOQtqT5KAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436057;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=3QWgbE9JTgCNI8EuJiLgYuGNI+x7+zvWM0IxDoEAQu0=;
	b=kiLvdVpMHu05qeVAIS3v2c628demdfZiFB15ez0fAgX3Fn09WuOjtCHDeyhyYT4Mrdzl
	 91CPZ1bILEsiBPKlSt9+/F7OMFDDXLtfqIoY1+8hzhV7uiA5WAJPN+Ppir+4TeNHWxlhw
	 T6mYAPuRg6sCzVAalEnpcY1N2pPLILWK5RoBgX54j/2hJwmsfxUCJQJoV1683nboocwgt
	 ZlLR3R+J1xO9XTpriVUPOBghspiezGrtZnRb5T87VQ0TyoDJB5uNKtTxzXk+6c3djwcCi
	 chUE18H7eB8qG5FW+YnOI4VEVUWefZE4XdUKPkrLJ+KA2Xj7HIFnPhi1MzedBrgB6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=NaKuHQhR;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E22606A31A;
	Mon, 23 Nov 2026 12:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=NaKuHQhR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1795436029;
	bh=3QWgbE9JTgCNI8EuJiLgYuGNI+x7+zvWM0IxDoEAQu0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NaKuHQhRJxM4jEiWgf4dZmN857FLsAO+RSivFPnZT/l4Z0iBfzg6Cu606Vi83zLEK
	 kJTmVXFODpH5G2kK/xZ+IeLj6tjRpvJWR8MDWaf5cEYCf2IHmMiCLx19m38797l3J2
	 FJRiB/oUqlx/nf017BclRNVu8zyFGU21ucHtrkPg=
X-QQ-mid: zesmtpip3t1795436021te6e3bb2a
X-QQ-Originating-IP: Sj26k+D6uYcfCBTX6NHi2eIOb1plH40EHm6kfq5R6RA=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Nov 2026 20:13:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4516808389515707458
EX-QQ-RecipientCnt: 18
From: Shi Lecun <shilc2025@mail.sustech.edu.cn>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Seth Arnold <seth.arnold@canonical.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Jan Kara <jack@suse.cz>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fengwei Zhang <zhangfw@sustech.edu.cn>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 0/2] apparmor: mediate asynchronous file signals
Date: Mon, 23 Nov 2026 20:13:37 +0800
Message-ID: <ACA178EA434CEC59+cover.1795434950.git.shilc2025@mail.sustech.edu.cn>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:mail.sustech.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OcJU98wqb2KenZJTsuJv2H1WV1fxV5qoVzFFzanG3py9zFhKZkTu4NjM
	QEna3IBPZJgjq3liqIrLBqnT9dWm1Hq8cpmEBMRDBdGfzW09CwK33fvmoyyGIHXG1tRpD21
	pTcUEavF9q/4eoLPrd6PqwKDR7mKV+XwqoKUcB6g0xBPATMuzkAa8ypTkW97TlB+aw3GhIm
	x3LGZhKXNfL07vchpoi9HklUflGg8t7+73FLnJuaPMGCg2yhsFs1ZTFTfhw90Tnnz8uNSJN
	QYMywQ4UL9vlbf3vvrSYv2Hv1pSoXTC0QsbldFfVwep/Cb8Bsx0XIowlpfSAWZXZoEOwzcc
	FK2HpNpRtEVVAB4hKDEI5BJ/bhwsLUWcF46/paTa1uiA7P5NRcNVsq/WKIfPmc3biTYL1Hd
	rY7mMIj3eErqBlj+IKEh3ts3y/Y1626AMqXP9pAV9b6L4B8M7qO9ofPZ5CR3i38/JYPyHr+
	lFxz4kNTKuyvhv0MzZyU92BKJ6EWlkxhirVqoHenUNP2L9QX0+mGLR3/K/lhwFYsyNLhIx/
	OkIVx5wCto1klOeZ2HHUQ1DIlO5wI0i3vmi6vhfLriocw4HGyI2geXhNKwx4W6aPAlh3U1S
	UPapUIem/uZpOAYR5RcwhhP9LC2cq+G6yv3C+qx8XjQDm8ihDduqFqNm6jrNNg2WF3nA/9l
	wT0rrA18CttHYpmGZzWeSHzAGsIbkXlxWQKVIy1SbrkLsu8zMNl/n61djxV9b/vLs/IobO3
	coXBbS6QGHuPEFVwgxM08e5ZG7ILiDcTwaUNu++lFVOJwGz6GAhiXLPtGhNpU1lrZ1003nm
	xndDAvi1NUykViESbdpdH7h57HC4elS5BmrOgsfsSHSRlOE2//doNwfA8idRb2xQTbm/UIm
	x2wwMvo+Hhqtt1+7m3ChpQ0vHnV6n+0TbAbftM3Y35BG+jSUl5kvCzzlGVzHyinTg5bDbGS
	W8yFs2p/E4rGHfhHfI3A3ntriVHcQX6oZJPpy+Y6BkCHGneMUXcxCcTjjuocsJ+gJGIClxF
	UBUqyaQDCnAYtzOXXCDlJbs+ru9lCiy03hICNLlobvzQMb0V4BtCiWy0WGyzdNp2jMXRGld
	soFOc2Ucua/R0sQ7wh5wD6t8NtapxT5Gw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This series rechecks permission when asynchronous signal delivery falls
back to SIGIO and extends AppArmor signal rules to file-generated
SIGIO and SIGURG.

The AppArmor patch uses fown->cred, introduced by Josef Bacik's
8a1e6dacbe37 ("fcntl: use cred_ids_allow_sigio()") in the VFS
vfs-7.5.cred branch.

Build-tested fs/fcntl.o and security/apparmor/ on x86-64 with
CONFIG_SECURITY_APPARMOR=y.

Changes since the RFC
- Move the fcntl fix to patch 1 and carry Christian Brauner's Acked-by.
- Use fown->cred in AppArmor and reuse its existing signal permission
  check. Drop the RFC's file_set_fowner hook and private credential
  storage.
- Rebase onto the VFS vfs-7.5.cred branch and drop the RFC prefix.

Link to the RFC:
https://lore.kernel.org/linux-security-module/9F545A02F22B16BB+20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn/

Codex helped adapt the AppArmor hook and revise the changelogs based on
the RFC and Christian's review.

Shi Lecun (2):
  fcntl: recheck signal permissions before falling back to SIGIO
  apparmor: mediate file-generated signals

 fs/fcntl.c              |  3 +++
 security/apparmor/lsm.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)


base-commit: d2b2489b608fab4710734de727430eb6b590f025
-- 
2.56.1

