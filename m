Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A72641D1
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126996; cv=none; b=cg0G8ev+CaxjhSmwJm3Gu8Ona+x7Mpoxvf2nCJ7Y/AIMrS1WgcGi9P1QRtlr4GAEE+xP9EKbia2T/st+OBq4ZgJCNFZ/TS6VX+xXcUnsA7hCnW2Zr2x9UxJkgDDmaomnJInb5aGmcfFO4VQmleOrwbAb5qV3jfmwLn4pp2Rdob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126996; c=relaxed/simple;
	bh=gH0QN/FxHO7p9TT2E0NP+y8EnZdj1mQdjZnq4O6Oizk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qAOwlDk4p87CGDWHACGDaHBytCYJiJchdaRTQev0PYfMvLiKleM4sbLHa5uytx98o/U5SRLiNN28Lhcx6mWouJyzV5h2KliBobAn+w2ByV7ktYHDw9rzyRi4q6e0ZAbfGbRzLh6APz5PfxfxYaQk208KJxLSYHhaAiK19yLHmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VasXPYa8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VasXPYa8"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6df83fd01cbso27876656d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741126993; x=1741731793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmq34kBJv+f5hjtuShVzV/BO7DYgPX5xprtY/iVs9qw=;
        b=VasXPYa8laidYtMhS+c2Z9TSv9fxjEWxPKJ4UUAAyBiU7uJ1arLbTjPf+fZF/jgAeu
         Hhd7UVr5LOAVJ5/SiU2jNZxpifp/dSiK/C3AMycVpzQjNTD62tHuSGaAODlXjIE1xwem
         TUOPC5R4mOBCgoijRlLCwkWNvTMMJ1H/hm7QmndqQi1trsIjQKplJ8Z9XNTnrm5yohG5
         WzcKATrX7fSQYzTKYNy/KaOn5hg9fw+Ytq2QdrV09C7iu7laIgoOkT+llJOwVdBfNzK5
         oUySC2esFF00LNmAUE4ERdhmlFoi/JHdPnjHnhY7fyKo2+ay8L3oJHnhVD7fUMr4N8MF
         vSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126993; x=1741731793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmq34kBJv+f5hjtuShVzV/BO7DYgPX5xprtY/iVs9qw=;
        b=FSe9sfsoAXuBL4rDS2j0cuzT3j5Mrox86YVceoKPFMcrlPtCbgIxajd+atp6G0+l9r
         AOk6wU4nqU13KruwMtWOGakNqE7M4biccRRzI7oVgUMsoZ5dTs7GwuN4nQxJG86Tw8sM
         9n6VuiNzeWzgWP6O+LjQgKOcM0anOrrHmaJw9X1YLpyMtWb2LQoocqA8j3BZaXIStpT0
         7TrUhl1BBw7C4nquoIG5CnrOWG7LLIPLOINmJ9N/lHCi+hSG+eYLO4alvmgDy6u27nPy
         Aejv6k9Ik02mN0T4qnTjUe4J43To8McfzBD2kd9UYCbJ+7Ug3fwOq6NmqAhD634wFSJL
         8JJg==
X-Forwarded-Encrypted: i=1; AJvYcCUolJVb/1nCkHTgk2HwNHR1gtE9AHNHq9UlaHJBaeqsrf6FkkalcMM3lz6b9X8MEhcqKrkAuGfIIaPiul1MU1mgRBu5LMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydv3mAq+T6i9wRIyr/HJH1mbt/Mur7t2zUzhCqEddoCyMFeGSm
	IGMIV7PxugEovGEQ7azuOcjEeKVtW8iCmj+SeZ4BlbtbYXzdnwIRbNgkFcCqVQ==
X-Gm-Gg: ASbGncucDNgIBeWHiAagXybCAoczoFAW2pDJF2Ed3eVjx5jNHBycoCcc+5ZfiVknxru
	yqSPz7kXg6x99bJmElbDU+oihEQyA2lodO0G+GBy5zPYzoJ7EWR0/0a8Pv9ESDKLlV4KiblkjTC
	tz0sTXuK57T+5wfsvg2HSWUywoz226WSdQoIjD8RjrR6CTdYoC654xx3/iCYjFMdbUttnpoQTL6
	/Leps+VuGr2xy3IF+0yFxdxIKy/KceB+B1dqXV2xruPA47Ec5jidLJOo1bTKlPTdL2A+Z3KFRb1
	8uKXG4YDbZhqt5IGyuz7cgJ0CAvNKGpoTzjzzIssgfhWKogAIMXSSRg0TpQ+0GK86/Gu9zBvXER
	RfHlhhAqi/QY5fQ==
X-Google-Smtp-Source: AGHT+IFq8hQi+YryCL3sXqHWMM+g0dSxsUPNtOppkIaSWuf4Ia3nZ6I3ItXFRnBMOuLDKhcd1Xkpew==
X-Received: by 2002:a05:6214:da1:b0:6d4:b1e:5418 with SMTP id 6a1803df08f44-6e8e6d43748mr16343776d6.33.1741126993210;
        Tue, 04 Mar 2025 14:23:13 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8e0dfc272sm10175186d6.17.2025.03.04.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:23:12 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
Date: Tue,  4 Mar 2025 17:23:05 -0500
Message-ID: <20250304222304.214704-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=paul@paul-moore.com; h=from:subject; bh=gH0QN/FxHO7p9TT2E0NP+y8EnZdj1mQdjZnq4O6Oizk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBnx31IWXl01geg3RExV36vOIe9OgqQ05PFBNITc aBHkpW/luqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ8d9SAAKCRDqIPLalzeJ c43qD/9EA1jts12wX6HK0HRkLPO+TRnqTzmDPj9JMIBLm4oaqTVmU1zqpszaKW4Mzrv4/hcwq3f yEshgiHPbSZuDCHbSJkj+lZrzRgBJy1PiQS4rJLNLdpmQrFVXcJgBAo58wEXUIrrhFpeDPexzZd cDHA36PyWYeVaL28a4wTNUDQqmfW/ND9jHkLIRxVCAZaBEygkfMTb2oMuScFQSmemCeQKurVA6K /C6iZQaozoGao8TTXv53pT5VCjIxIN4EtI7e1/oUq2ihzlsdDchCWLUR9PWFEWcmVr9DeEIpuZe 7QB5xe6FhZeMDlMkBGazNIExdIXoWRh/dq1CVG77rBS2qjyZJBH0srZ37ELsKshtQ9L4qzdiJzm izJHeIRG+3MTORVhNqfFU6POxnK1MX4xx+TWKF3h7ZsCR8mmuD7hAzgrSFf0L/D68GllglKd/yS nNFqadr2Jl+fVWQ645zLpyC3/R7iUYOYG4kknwnfcVGdeEofjfC2CoiaLHmEFbjqvFqKDtRcQaW s44ymhbSPR+PyfN6f/i7NROE12o5UkGYcZKH9RBDYAI2yjSIpi0qgScQ0omYhzoCFR9QYmawTMc OxHqWxiMPWjaZ5oO2U41oyuqm/M/TvdpdTxID5b48nfDSGdHTXCrZAVM7YiuIyTQLiXGhG8zSv5 /LCw/zGVFUa2O5A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The lack of an explicit credential (kernel/cred.c) entry has caused
confusion in the past among new, and not-so-new developers, about where
to send credential patches for discussion and merging.  Those patches
that are sent can often rot on the mailing lists for months as there
is no clear maintainer tasked with reviewing and merging patches.

I'm volunteering for the cred maintainer role to try and reduce the
confusion and help cred patches find their way up to Linus' tree.  As
there generally aren't a lot of cred patches I'll start with simply
folding them into the LSM tree, but if this changes I'll setup a
dedicated cred tree.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..68e4656c15ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6139,6 +6139,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-creative-sb0540.c
 
+CREDENTIALS
+M:	Paul Moore <paul@paul-moore.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	include/linux/cred.h
+F:	kernel/cred.c
+
 INTEL CRPS COMMON REDUNDANT PSU DRIVER
 M:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.48.1

