Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194437;
	b=COd9rSAXX3/nXHlgBeUzgReC/J2aujgNMopow3WcLC5jNk8Aix7Dv84HRDgvJM+2ku0Z
	 M5i0+UXYq25TaWigzSMObA+z7jHfl29uVzHd6eOlWN45oA+pvFvQOutz388LhFzNRrYWt
	 22iSJvMRGOe+Qirc2wjxMv6I1k0jVJsO4WfmVCkqv/sxkbxvUJrrw8CQ+MhS+FQ1/G/pS
	 d2iMQ3QWO0QN2YdT/smqaE9I+kKN+V3juEQ3u3QTyeKwv2Zoo1ByVJ2dBmCBY7RFcTWPE
	 QLPQ8YQfLKnxqwoMBvFaIorvRKSDN/3hsdJcameYkrDQqvpkPt4ivB3+QUpK5lJP0Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mHBWVyhcqxaC5vumFhxxpKEuhD3213M1GsePKvUPh1Q=;
	b=dI1WLw9Pclm+UEXcA+BVJsy3L6BQP6ea2kP8f1fZlK9VgPvHwrBvVlUq0VP1jvQcJW3q
	 QHWvwxpibHi1HKMYgRiAcVWqzkHJ6l2TMASPXE5YPNc/mhDjguvXQceM+ArbTyH6T350e
	 gzJfXyv9FqagCaBWxA6YzC7hVbhpm9j6NNy6RStHCsTzvnsLupD7uNxCQsUVqg03x4gIM
	 BnL6vcfUzFM+wkGChI2aaGB2y/SB245oZiqVm9x31rk+5QQDxVOYe2Re0IOk/CcbP1CIr
	 eQu3EUBM5Na2m4uPW25zIGOdZBDi3cfRDgQI6Kdfjzhit7AGyZcDUrWrdf2NsTqKI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a0tLEIZV;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41A60A260E
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F41A60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a0tLEIZV
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0db268bd8so6596397b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1793194435; x=1793799235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHBWVyhcqxaC5vumFhxxpKEuhD3213M1GsePKvUPh1Q=;
        b=a0tLEIZVYyhkTlIJHtgGbFZONiiDQraHICSs8nIr1Mw8HVsHHaim+W21SJOURks2cx
         61LO/g8DvIxgQhaGuocD17ZH/DA4iaOHyjQrLqvDuajbQoadCuwEJCYzv6ytYZ488PyY
         6RP5RF0HmPdnKboB6PcfpwOn894vMmmRnBEgJgJHkKN20mHnSrwCmpTy9nNQaa76UAWN
         NpNmbx2oRjFr0n7ImcBB7NpIjIxHAYO1AHWj0PGm8ai11QqqZC4jA1qSo7eoPgwI0ndQ
         cBlclyvHvowc6wQkBzpllidO02OCyWxupMHOBYWp76zlmeTbU415dVFYLCJd5WjoD/Bk
         ik0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194435; x=1793799235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHBWVyhcqxaC5vumFhxxpKEuhD3213M1GsePKvUPh1Q=;
        b=Fc/Xrv8dEWYjxYlBFkIXfUpAiyGtmZsyh0YYa/v1f48g24IdnjTZSj2t6oxehJARFu
         Mq6ydCsCV2om/Dr0XhXAh1+rhzuva3H6Vlgj+Hyf64DF55/uM2vu77wUQKSl0XB2yK4A
         Tz8jtmsWH5krN4T4TzjAyJvyak7VcLarAMeRrrbpURuyDIHUYfPM5wvY8ZecxWaJMrZz
         39XxZOv6eKRwD2GnIZ9ZZLFtCakqGqcHaImDfUS8ybbHhXl+qTJM71/RWjYCLDEGa7Yf
         vK7IDBKai42v52yoyeD66Mqs8Z9MzzyNQoZFqVAlC9Mt02Y0V2fd33PjPVFt0Ta4YLcN
         j1Ig==
X-Gm-Message-State: AFq9FYJ5qd3DprPRhqS23I8O4zyAv2KFi+iML4YlhEVCPq2edoV8K7+/
	HJbxW3zVTM8gDlA6PV+WUaM7uUFDbMvnDCpwgl8J9hN/Pcp6MAzCF1PAmmDWxoOrDAXZ
X-Gm-Gg: AYBFou1Aa5PPVsA9BswG8csuxBEStH91Np5+JD3SjftCVnHBjllvLSDRBpZ0RmStsY0
	BF2vZwj8Bb5bb10/I+/UKHCMZYW79jqEn350F5/3qJF1MsVy8Ng2e+U5QvnRYt43LB1YGWfiRsR
	OtwLueVilOrnr6mPJSODgg36HSvuadh0zLCy0ICTtWWp1lNPMFq1rEg1d3sg1zZyBnhJ/XfEt65
	D2DvU0RQho5+yYoEvfRo44eU+l/6wbHTLzdJ66mxfGFQnOk5HKuC7EURHd4U591LWAzbftOxNRM
	NZoWvkv9xmJ9cNo0zQrxhKb2/NpQg0bd5uQ7Weeb76vMEXHYTKy90dXHV3OX1+yQZxTT1ec+CI5
	aw+A/dKZjo3PBmtPk8zVo0hPHhJaT5bmfIQIxs2HqHLd/1QqENIA+KXriXRmtpqfADytnQJLR1O
	bd1mN2hgvcjyIgluajGccYJGqWI8rx2mKcopRZ/q6rawTSVi7gHtNZPAVw/wOycMjc4FWvj/3GY
	AAEVmoJNSus1EHhPwRYofvMauRNxVBq1RXPGlsuo486CZrcLBbrXtbKEB+foPwCngMq0jR5RQFD
	625t3tuZuKsFqUmK6WeB53ztuxBtUGlI9sOdIg28XC7WSzdrqrr+Vo2p4LYjWDjiGT0zgggTmfQ
	JBjcPrIqfkM5H+hQVuvboMbt1LL8hKMFu6RS4m4zzDmI7MXo=
X-Received: by 2002:a53:d60f:0:b0:679:992e:3ad8 with SMTP id 956f58d0204a3-67a7bd3cbf0mr1120504d50.132.1793194434760;
        Wed, 28 Oct 2026 06:33:54 -0700 (PDT)
Received: from CC-KJQTV599DQ.attlocal.net ([2600:1702:7b5a:ab90:103d:30e1:1f09:a9ae])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a79f38dfesm1694911d50.1.2026.10.28.06.33.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 06:33:54 -0700 (PDT)
From: Ketan Bhardwaj <ketan@armoriq.io>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kernel@vger.kernel.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>,
	Ketan Bhardwaj <ketan@armoriq.io>
Subject: [RFC PATCH v2 6/6] MAINTAINERS: add an entry for the Kernel Assurance Plane
Date: Wed, 28 Oct 2026 09:33:35 -0400
Message-ID: <20261028133335.75899-7-ketan@armoriq.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028133335.75899-1-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
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

Add the KAP maintainers and the files they look after.

Assisted-by: Claude
Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
Assisted-by: Codex
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047a..0946d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL ASSURANCE PLANE (KAP)
+M:	Ketan Bhardwaj <ketan@armoriq.io>
+M:	HARIHARA SUDHAN. R <harisudhan@armoriq.io>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/securityfs-kap
+F:	Documentation/security/kap.rst
+F:	include/linux/kap.h
+F:	security/kap/
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
-- 
2.51.0

