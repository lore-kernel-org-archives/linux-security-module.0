Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36934F48D
	for <linux-security-module@vger.kernel.org>; Sat, 16 May 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958093; cv=none; b=ay7edogpu1g1H+63RLvMcGXkZZ+Dkv358ul0aTzg/HWTcc67Mbr7w9V32ZSaA1CaeDh1xysNNjLMEiMPHFoqK0WppU2mZMC+s8feQU4zAAEkYCgSdcOQJDH2BxqGPF8PdvQI/L9G9czbMDB9cK7MBiSYxjR3n/ZD3azqMwB1H3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958093; c=relaxed/simple;
	bh=Q7hjCK61LwuTQY6yskK+p+41m4W+x20RkOQH4/PG+CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlavYvqLv8bg3LjMlwSQzh1dlUkaH6IEGUyke4LfWg/zZxNzyzpNQ5b9Z/uAPgYfbBBK3hi6AA/Zn/4dbuOmGhMP/xuajqvziQhXT4cD4fyM0v5/+QSZXqj+zQz8z2X2CoxJbexCSeOS9pZprTm4Y2FYMl6+Bu1V1oJv1Bdggzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4cnHym+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4cnHym+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so10350825e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 16 May 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778958090; x=1779562890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGHSLr5Q+XDF70m5E5RqpezGDL6n6KDUo6T4Dn6m/jo=;
        b=Z4cnHym+Xz9wylFWNGaA59njZ60zDBghEiGBO5M76J8QS3x2xFNZf+MjEeEhvxUFgh
         +EdWFJfjs5+oEp6W5RHDbJ+s7xiBRrrnROZ3hUa5GNh5z4aKzgAs6pSnnjninHdI2DOX
         r6BQ9BNxKf9yLeWzD09XD73retwWBVFs39zjyP1kF6CpIxvFQ9x+IDMfopLVo9fM8mCB
         cbU1Q4korU30UilNBdsi2BMwsUdEkNOfnGtxIrVbYNLxfTMpTNmIC5jV8ODQuSXIYAs9
         W/bUIV4FCRTXU7epFF89lZo74IpCpogpzRZptrabvlJrJqx/DUCwMbjV+nys1QmUWCrb
         mrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958090; x=1779562890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGHSLr5Q+XDF70m5E5RqpezGDL6n6KDUo6T4Dn6m/jo=;
        b=Ngl/lJXbN38i0+wmxqIq6Kp7vIyK/4xmeqo/+PBVe5zJSbOwegrpTDplHniF75iwWl
         EKiEW1QEh8bybFfzVtpCRSkSFAZYAK4Bq8WnJaFUStxIJZNz2C1cdEO1YIu/FnrTzyEi
         wpdhze8GUU9KEpBcuHxYxPQ/YhyxzeCApu3RjcgFpFK6w9qCbbR/SO3p4OYnjxcIQLIj
         AwrY3KZi8rg+Sj/1jUbiOUb2qTX3PdDfmYrhMQoK5D+pgSgfJAKt4DguFIxtf6wWS8nk
         lX1CKJt2lc7jbR7Rhg4NdJDODkNSmnX9XB14+qeFDw1frnIDqoOmsjKU5ptyqKog3Ua7
         /ivA==
X-Forwarded-Encrypted: i=1; AFNElJ8edh42iGlRfOeu7MYDITVfnvyYAS36QwbhKAV6xg4jf9PKgkayid0avIdhq4L6sjdBw74GRVVAlHTCwS4kGEEeWlt+wnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvfCU786BOQDR0Pw3OEh+G8C81rpN/F5mCLszbbM26SwJK11B
	j2gNi4R3NPIvB7XYbitYN9ebiJJGCqsjB6zgR9fSEe5hgqWVawrhWgP/
X-Gm-Gg: Acq92OHIgV495bE2xlbQujy/RbbAJYMpo47HEsJq3ewVMm0fFPiKHMSzGlK3Z2dZPIJ
	QNP4cPt5xahN7cNCWoG7WMx8WV1MYawXlTjRRrDKQ7+TGlXukkVmxKPZT+REq+Y07ofTZHNveHX
	Vv8MqaTYxhyewyKosV8w0vJkAQOkKrUYWU4J1XDwdizAFHCcxeWt1C1hahLdya5w/b+uCewDOsE
	P/uwrwEZwOo+kMpAoZ1l1nakhV2UXpLVAupPDzowMcqgZpbCARg/j5Gy6p3IKFcNGbH2655AFbP
	uSVguLVYdwMwP29BRWDUmq3Pop+bRQuKqG6Nuo6SvyO1aOVEdn79d1K2SJVmAjnnkfEVYlym49/
	DoLf66Av0UzGwU1Qpn069sgKk8jU69c9fYITNYprOaLcfEmYZdJy64j9AFDiA0sM2XMErSC9muN
	3imh3vmOYPntmJxn1IU+4yCdieTZJw0Zl6mF2dRMcfpW1RUg+3QqAVJpR13ygptE0YiMq2QQ==
X-Received: by 2002:a05:600c:a406:b0:489:e126:b757 with SMTP id 5b1f17b1804b1-48fe63297b9mr106298385e9.25.1778958089810;
        Sat, 16 May 2026 12:01:29 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53804aesm138278265e9.15.2026.05.16.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:01:29 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alejandro Colomar <alx.manpages@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] landlock: Documentation wording cleanups
Date: Sat, 16 May 2026 21:01:12 +0200
Message-ID: <20260516190112.4924-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Documentation cleanups suggested by Alejandro Colomar,
which we have also applied in the man pages.

Link: https://lore.kernel.org/all/agW4yMK6CinJGqXt@devuan/
Suggested-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..48c12ddf1108 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -255,16 +255,16 @@ struct landlock_net_port_attr {
  *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
  *   explicit recipient address.
  *
- *   This access right only applies to connections to UNIX server sockets which
+ *   This access right applies only to connections to UNIX server sockets which
  *   were created outside of the newly created Landlock domain (e.g. from within
  *   a parent domain or from an unrestricted process).  Newly created UNIX
  *   servers within the same Landlock domain continue to be accessible.  In this
  *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as the
  *   ``LANDLOCK_SCOPE_*`` flags.
  *
- *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
- *   in line with other filesystem access rights (but different to denials for
- *   abstract UNIX domain sockets).
+ *   If a resolution attempt is denied, the operation returns an ``EACCES``
+ *   error, in line with other filesystem access rights (but different to
+ *   denials for abstract UNIX domain sockets).
  *
  *   This access right is available since the ninth version of the Landlock ABI.
  *
-- 
2.54.0

