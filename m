Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.93.178.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222258;
	b=Tw5VphnAmNWKIFy6Ixtd+HrTisQEu8hq5NLBxaSAK5KRgYL/OeMUM6ObncFtCM6owIHk
	 +omCfiXPmTY+EGY6ttQTRmGT+JmwuKS0DI9FphJsbRZ9vHhpUxdvQuAOSdCF1Q+WQVpsz
	 +P1aUCo8VdL1uIHhYaYLsPSW2DW5rCBAdyjzR3WHNkzJwP7C85sC+xRWVRSZSXCDC4/vM
	 8UZoG5tyo9A7G2j0Q2ZzRvA5q9Rf+nb0UXPGxrETMxaOcG9i/yw0PBxh77G6zZvegtVB+
	 61aUxfDbO+7nIfrUuneewjz6DxnTnMkvfdQCrIEZON/9V3IXKEahwJrDCLPAAS9zDTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222258;
	h=DMARC-Filter:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IPAS-Result:
	 IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:X-Talos-MUID:
	 X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:Received:From:To:
	 CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=IAvdkeYbWNqPuHgLOFIbTsl4llsltzOBBEnlGn0o0/Q=;
	b=GwAK+keBeAZM8vf49TcKOGS+hx+zqxV7RluwghDEZD5GkfhJIPl+lK4zNT6ADiBskJXk
	 5jRy9uHWKaN2PUosArytUCZLvjeWCdOwxkALRqKGcNNLkxtZLZKZFOSojEubkoBNitom3
	 sEaqr15Hk/DSA0lmuhbmkMlHGlywKVixFKC+s/PpdFe6w0e2xCT1Y0PRotDF4Gt4VLAo1
	 Df+Xuiyy3xb9CHJzFIiqw6mVfZTe0ro05HXUdRMzXlWS3Fy5cdhpiueFfLGWm8rRxXsPI
	 w0pnndKkgxJVrTpLywdEr7ZHyionaf8xHT3WxAAnfQdgh7D3B7RluQJIppX13YclHRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hs-mainz.de;
	spf=pass smtp.mailfrom=hs-mainz.de;
	arc=none smtp.remote-ip=134.93.178.243
Received: from mailgate-3.ZDV.Net (mailgate-3.zdv.net [134.93.178.243])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CC606A31C;
	Mon,  9 Nov 2026 11:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E93CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hs-mainz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hs-mainz.de
X-CSE-ConnectionGUID: E54ZMBywTUO/zkDaGLm1TQ==
X-CSE-MsgGUID: yIURpLAaRHiP40Wn8DkPug==
X-IPAS-Result: =?us-ascii?q?A2APBABwp/Fq/z72XgpaglmDTIIJli6eJIF+DwEBAQ4BP?=
 =?us-ascii?q?RQEAQGFBQKOHic2Bw4BAgQDAgMBAQEBAQEBAQEBAQEKAQEBBQEBAQEBAQYEA?=
 =?us-ascii?q?YEhhglGDZATBjIBRhALRlYGDoMHAYJ0FL91gQHeSYFuBgkBgUOFdIJuAYUDh?=
 =?us-ascii?q?XM2gVVEhEA+hCEBAW2FeQSCIoEMl0BICnh4LAFVEw0KCwcFgSVDAzUSKhUjS?=
 =?us-ascii?q?wUtHYEjIR0XER5YGwYFEiAqQUNbgRKBB12BKyhdAQIfRi0VgXYCglGBI10CA?=
 =?us-ascii?q?UlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJgQ7FQxkCxoFGkcIAgsCDHQoE?=
 =?us-ascii?q?RATHR4kLwUcJj4bCjYYDUgRLDcVGQQ+bgeSQoIwghxYdRE1H0iWFQGvbzQHg?=
 =?us-ascii?q?jmBaoFgCAyKMJU6Tapxkk6GOo4Kmw8CBAIEBQIYgW8IggYzGiSDN1IXAg+Wf?=
 =?us-ascii?q?MVogTUCBwIHDgMLkkgBgR0BAQ?=
IronPort-Data: A9a23:mT7UGqqGsGZHOcXzWvjWkIJH8GVeBmJ4ZRIvgKrLsJaIsI4StFCzt
 garIBmFO62PNjf8fYh1Pd+18k0PuJbdnddkHFBorytmRiwa8JacVYWSI27OZC7DdceroGBPt
 JxCN4aafKjYbVeF/kv9b+e/9RGQ8YnSG9IQ3cadYngZqTdMEXln1FQ73bFp2uaEuPDhayuVo
 9T+vsbDD1Gs3j9wIwo85rmKwP9VlK2aVAgw4BpkOpingHeEzyNLVctHdPnoR5fFatA88tCSF
 rurII6Rpgs1zz91Yvu5n7DydFE9Q7K6FWCmlnpMVqG+tQNJryo037xTHKJ0hZB/0mjhc3hZk
 b2hhLToIesbFvSkdNc1CnG0JxpD0Zhuo9crF5QdXfu7lCUqe1O0qxln4dpf0Ycwoo6bCkkWn
 RAUxaxkgh2r34qLLLyHpuZEq5l/HuzBLZwjh1Yn3zL1BNkCRMn/evCfjTNY9G9YasFmD/rAI
 scJYjoqNlLyTyMJHFoLYH48tL7wwCijNWcE9hTL/8Lb4ECKpOB1+L7sO93Rc93MRthTglSVj
 mLdumHwAxcIctCSodaA2ij33LWWxHKqMG4UPKyZy8RypHSa/EwSMEFOal3rjfqBl0HrDrqzL
 GRRoELCt5Ma8E2tU8m4XhukrXGevwINc8RfHvd86wyXzKfQpQGDCQAsXDlBYcYOsM4wWCxs1
 1WM2djuAFRHkrSQRGnb3LCIsTS3PSUEBW8LYzQJSxMM+cXlrZsojhPXCN1kFcadlNr/FCvsx
 HaRpTMlmp0TkMcU2qT99lfC6xqgo5nVVB9z5QzMV36m7wVRa4usZoju4l/ehd5NNoeSCEKHu
 2cOltKRxOcUBJqJmWqGR+BlNKmg+vKtKDTBhRtqGJ47+nKm/HvLVYJV5ytkJVxBNM8BdD6vZ
 1Xc0StK6YVcMVOqZKtzcoT3AMMvpYDkFNL4RrXPY9FTeJltZUqC+y1zYUO4wW/gig4vnLs5N
 JPddtyjZV4eCKJ63H+1Sv0b3LsD2C8z3yXQSIr9whDh1qCRDEN5Up8XPEXLY/Ay7Obe5hfZ7
 ZBZOtfiJwhjbdASqxL/qeY7RW3m51BibXwqg6S7rtK+Hzc=
IronPort-HdrOrdr: A9a23:93f/DazCXS0knN5j30RYKrPwHb1zdoMgy1knxilNoRw8SKClfq
 eV7ZAmPH7P+VEssR4b9+xoVJPrfZqYz+8X3WBzB8bGYOCFggqVxehZhOOI/9SjIVydygc079
 YHT0EUMrLN5DZB4PoTt2KDYq4dKaG8kJxA0t2utktQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AruK6XmhqefTxDlM/F99WVkoLiDJuXyCB/lL6MlC?=
 =?us-ascii?q?ENEEuWr65QHC0/fpYqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AcBzv5A0eJj0rN5/2p6AM632ppTUj8oWTMlgpuJw?=
 =?us-ascii?q?8m8i8aXRPPWexjwyqTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,203,1787004000"; 
   d="scan'208";a="23221199"
Received: from zdv-exch-2.zdv.net ([10.94.246.62])
  by mailgate-3.ZDV.Net with ESMTP/TLS/ECDHE-ECDSA-AES256-GCM-SHA384; 09 Nov 2026 12:04:08 +0100
Received: from MacBook-Pro-von-Nicolai-4.fritz.box (91.37.89.206) by
 zdv-exch-2.ZDV.Net (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 12:04:08 +0100
From: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>
To: <linux-integrity@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.ibm.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric
 Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
Date: Mon, 9 Nov 2026 12:03:36 +0100
Message-ID: <20261109110336.82654-1-nicolai.kuntze@hs-mainz.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cf79fc0314c1984e68f683d26cbee3ac0859b5d6.camel@linux.ibm.com>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de> <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com> <20260822193833.98211-1-nicolai.kuntze@hs-mainz.de> <1805cb973c0e38e1ca8cbeb6dadc4f46f9475a0c.camel@linux.ibm.com> <cf79fc0314c1984e68f683d26cbee3ac0859b5d6.camel@linux.ibm.com>
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
Content-Type: text/plain
X-ClientProxiedBy: zdv-exchfe-1.ZDV.Net (2001:4c80:40:70b:21d:d8ff:feb7:30e1)
 To zdv-exch-2.ZDV.Net (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92)

Mimi,

Sorry for the long silence, and thank you for the review.

A short status note so the thread is not left hanging: I agree with
your direction. I am reworking this as an IMA critical-data measurement
(ima_measure_critical_data()) triggered by the securityfs write, and
will send a v3 on that basis once it has been tested against the
integrity tree. 

The question about extending unchanged digests in that mail needs a bit
of consideration on my end but I agree that my earlier justification
for it was not correct. 

One correction: the repository URL in my RFC and in my last message is
stale. The reference implementation now lives at
https://gitlab.rlp.net/trusted-computing/memory_attestation

Nicolai (drafted with AI assistance)
