Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117163;
	b=zU2X/seNyySukXxT2qHuv5RSpcp1XTy+rNuEUvcuto6YoVmuYQFaIIqd6n3G7oQReGwS
	 MIXo01JlQ29evQ2IA6MwoILdFKaMASh9EHIBFbTascnlzTj9KFS3bj18+OA9BhmhS7gew
	 p2ml7HudS5gM+TvZgRVptn/v9yocgUDXq1jdxHk8HWo6Yt3J5AeGQWTEoKs6/SwuoCBI3
	 T8i5pGEkhCGWq6kB3EIvEMv7htjs52UGIyTptFNa8RwoeOoCKnuvRoAIiUqjzu1bLb61W
	 NBg0UcdNBrr4KcbUnGZrK4nNTQoiP+AtwCofAGgu4aq9iMBovS6e2LVD4tmoOyKXwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117163;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=wJ532/N0M0wnt7q6KhDKefrX1ZSyj6uJXC5Arq09eUI=;
	b=W0RvNGwG8/dOct2+rbc9f1sTR7dJV4PIqTT+R4Xniu/tCPi/EfEVMuxBsDSZioGmdcT1
	 rHyDt6rDip0lX1jrBRoBGsBvpqXYhDr/SSDcZokYubikWyOsYVnSYA66LfeGhaIt30pKh
	 gQl7ZOpo9p4RXW93inKG9aKHyVW4UqTm28cZQzagavcJrdoSNsiRAuF/Urkx0qNWS0Odu
	 fFFz7vK0JNq2pF2lMi9Bn45wBRxWKokmDGViz7CjHg6HdFFCKZS621HLB4z4ach+wK6uz
	 ZXVw5a8jzdDxItVZJ7cmfTx3qK4D0aA/xKC9WpF++zTZUmsUCSyBuvxRHW3GZHdqzEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=WxhToX1E;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F6606A31C;
	Sun,  8 Nov 2026 05:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=WxhToX1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1794117058;
	bh=wJ532/N0M0wnt7q6KhDKefrX1ZSyj6uJXC5Arq09eUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WxhToX1EcZ+IZx22spVnFDnmGEg92a4iFCrdwRkd4fxdyv/TQU4wphbvbpAkaJHtg
	 ue7yuhCwyIggXJfc6O2bT418CYOu930oH4RNgF1XLBz02ghjV4fMrsBzRytXx5nF0t
	 gp6qLHBeRTozrOU2Mcs49O8YP1jSvl1kWlNIFbAE=
X-QQ-mid: zesmtpip4t1794117050t07935af1
X-QQ-Originating-IP: 1lJSXOUT8kmD4Vn3xBl3BqwdvkbHzRNN+2oG9aO9Mko=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 08 Nov 2026 13:50:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5347852784624739240
EX-QQ-RecipientCnt: 11
From: Shi Lecun <shilc2025@mail.sustech.edu.cn>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack@google.com,
	Fengwei Zhang <zhangfw@sustech.edu.cn>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: landlock: clarify F_SETOWN signal scoping
Date: Sun,  8 Nov 2026 13:50:48 +0800
Message-ID: <4C69C1457B12AD80+20261108055048.3745750-1-shilc2025@mail.sustech.edu.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107.2f1fa9977739@gnoack.org>
References: <20261107.2f1fa9977739@gnoack.org>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:mail.sustech.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NG2b9TD0vVV2ttcOoRNNKfnPKURIOduJW7QZLFHDe30V6PFw+Gp/Ibg6
	x0YQ6Sh48kIGPiBDKIWECv4NYhpGkN8+PYiZc+PgARI29TVX8TEeOizc0fu8bqOT1oyAEia
	gzvoAx5Ua2mDKPnWp4aytGYN2NdKRNEBoY1yF3hYfXcnmbmbZ4VHi4sd0J20gUHjZvttQOI
	AOWhyvtjp24z09pw6VTRHR5sScjce8jS8oMgBBOxcvPvWIWgZJ32jfGyD3ipPYuRyekHRPc
	bzoB31CWbSMRDvpHui48WMDDKuxVj5ViMPdntCQKGSxDcuSh2vVeWxtUWyOk03uAkVTyd34
	uJJ+w/TAvjeZntQq9rgSXgrJAfjy76fibJBlaO+EdXWbtoRjNto3/PdBN9ioNcm/Ck9Ho5M
	sdsucs+YkXUkYuY4vR5l3oiFGhI27TopsKaIoKX9dkFs82yXL2wicYckdIIP7wYtfJfcGdo
	tQrsEmFGvkjdc1+Io29c5rwmiZ5zur9ZrxD86H/dY/k7aJhaODvOf8Zzjn9F2ocWyLtp7LW
	80hhhyavf2dNnYtbzNjgjLYihOhEPYMugLYEgiUSOYCETFfljuNFFzzYikYa97JUDQFumDe
	JesguWi5rvLsh1sm+44IlchCHEo4Acvf7OTT/MDuUfb3RbCCJg0LxOo/xPaOZzWjbgzqWaI
	34p/kD2tfmoH8jvLyt68+f22vzzwbIYG1Tuwhpu0JlPZ+g7TDnuE4p5n7qNAYf9CyRcnPHv
	kfPgR7K7KCFN1funsed4hiecOixyKugsZhWxRCoB5tPOPP3eyrOqecz4j646ZEhW18uPx3e
	BAFsPBptqRgiOUmCWfGxtxzg3hJWoKBs8YpGpmCQON+c8CT6di4AUmdtNEVxsIYta80rCY+
	SqG/M5Ti/rlXWItNLL6gF46mm5n81DN/12JxPCTNW+qXZamPwb4DrGYcPL7tGkKajT/3KPm
	4F0BgEJMKYIM1hDfLDyrCE0Eu16SWaE1wmb4mmqFWVL7JoMTyhvBaN+6C0Dpbkt+xp36OQf
	WrcrcSFQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The signal scope check for asynchronous I/O notifications uses the
Landlock domain saved when fcntl(F_SETOWN) configures the recipient.
Adding LANDLOCK_SCOPE_SIGNAL later therefore does not retroactively
restrict these pre-existing registrations.

Document this boundary in the IPC scoping section and link to the fcntl
documentation for I/O availability signaling.

Link: https://lore.kernel.org/linux-security-module/20261107.2f1fa9977739@gnoack.org/
Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
---
 Documentation/userspace-api/landlock.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 3d45b956b640..cc9c5b102b8d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -499,6 +499,10 @@ The operations which can be scoped are:
     This limits the sending of signals to target processes which run within the
     same or a nested Landlock domain.
 
+    For signaling of I/O availability (:manpage:`F_GETSIG(2const)`), Landlock
+    checks are done with respect to the Landlock domain at the time of
+    ``fcntl(F_SETOWN)``.
+
 ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
     This limits the set of abstract :manpage:`unix(7)` sockets to which we can
     :manpage:`connect(2)` to socket addresses which were created by a process in

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

