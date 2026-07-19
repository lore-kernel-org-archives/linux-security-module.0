Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC63B2FE5
	for <linux-security-module@vger.kernel.org>; Sun, 19 Jul 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484234; cv=none; b=lSUrgYB7CqRGsJdtqZcgPzGuj9mWXcsu9UBsot1rDhY1Kmwk6/EBVICCahncXDB5H0wv+fGwo4gupn2hLR2o1V6US8RSIapdk7M+yT7jsKtrdMgtnupr8emDWqqC01wOHNpIeyfJ+YS6adLYgk5gBkUzpxTIFzac/v7mmA3mNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484234; c=relaxed/simple;
	bh=sVlAnhzfkzYQa1PcZYfpNzgJJd87BozZZNakBNALqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRP1j4T3P97olTth1yA1EziQDjVewpSEno4FFGWoRR+w3rsQJn5wxa6sYdkmEInw7Lu172E4jeLuzVesJ7sGigqlby+nemfxSAZBykam+XaVTNDmymhyXW6dbRc582ky39pSrTbVHvAmYsV8qewLjiakksibOZuM17rj8mlsDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO41oVYo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO41oVYo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso3607798a12.2
        for <linux-security-module@vger.kernel.org>; Sun, 19 Jul 2026 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484226; x=1785089026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=VO41oVYojY5nNLDlQiMn6nnfXahXoClP/cwC9XHBUJf/aNsn76YDQYHUlyO81zd557
         YvWIt5o0EWh+URbiaqycX6C7b4JQt/Jkzlwh8vd7xrZXTmKfEfuwHMSGnTkXrDaN7FE2
         jSZFoJRDwcnJip5qO88NGfDWikr7Cx+J5uULPkgBrEJWj6uiMOdjQ6rzsYZ/1KKRU7RC
         1BVYN7Zxn4jAfRXOB8M5vEabMD6GvZgJYYREyQE5nBg4nf/rgZZkgSgCRUcqXBJbJHhl
         49JfSkQ30IgEDQQ63i5kq6otw8ArRObpqTIcFtA6nlbIUih6FG2u+71BRPxJlAbaoVwW
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484226; x=1785089026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=VY4um1+lNCcPn37EIlMFcdGbQo049g6GIkEJSBzkDzP8loJSm67foRM1VXjzkHPPFu
         9DSw+xZs0ub3l+dCkHPd6HNua2N1Hqvoylhd9+hXwd6M+iW2Tmlfp37zq2qEIMioNUcp
         w0j5rXI4GiIdStzmCGu5qfcy/9aqmHmHirlcsXRaH9J8JzwTRofei0Lj5kBLCKhfvPEH
         4g4F97pIa9QxeJdLbQFBdptqIdRMCE4vKSh9Yyjr844Bva8CsBaM+xPx8mIj6xeYKSG6
         oug4IAu4pzLmVsqywCpvGtTqdFQhYfXiT95Hfv92CCCIoo3ftqdSWIdH6x6QgPzWyNrg
         zE9w==
X-Forwarded-Encrypted: i=1; AHgh+RoqA4F5qwD/tGuC0pDEzBdqkVvV8zgPHAvBblKiEY3ONkqS7Zz4xL8Tw6vNcS3Z9Wq6VIwUFfPXD0wQCdtWSqNvr4vn3j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvLrOWAokajbBbqD379pNscJfqJ5S8vWQRD0bZ9s1L8gxg4Rv
	kBPVQYJrY0sWSbgbMEKDAeIwKpZBjmC0W3UKNHb6a1ZJNolAfO+lXXk=
X-Gm-Gg: AfdE7cnzn+T3v4Wokiu7J5oIoUEz37PgLtiTOaw6JfzFFqajzvzBrFlGmjWZrFfXUt8
	c/Rp4VzACxKfnpdfvAIxweOoB+Uhkld48DtMhUbNlD6eygSAJ10kza7yCYlbb4VbNMi1hqh8vGC
	6ZcBBTnUDCGArRbNyMoXIL/ijNf5tLWClqLfSZ23bShDIUrE8KGsNeVMR/JIFqMy8Y/rjJJQTGN
	MHJsJp2LnteNBVawie5X+a+DOVZw786DzrTBlMOScGDuzymlCuZ368wUoNK7cenrpSlPHczmEmJ
	kJCV6p+DFHJXpT5zs0982+2hIMgZbb/D25CMZY6PxkvG7fL+TJA21ulj7yOuzNVJHlNnfD7+yib
	XCh4272QNa4Fc12gWECT3VpMMYxDF8L0Tg+WFcvxMn0xbapSprVwpWI/FZ1qxNXhHwBt6COo1o5
	X9fjzNQ6L+BeYCAQfnrgZzAGWE9QgXcbynK7eU8eCQk7ZIxtMRipg=
X-Received: by 2002:a05:6a21:6cc9:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3c3ad7ad65fmr11766169637.28.1784484225791;
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] Add Apple T2 NHI device links
Date: Sun, 19 Jul 2026 14:03:02 -0400
Message-ID: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a cached flag to detect Apple T2 systems, then uses it
to create device links for the Thunderbolt NHI.

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/pci/fixup.c                          | 10 ++++
 drivers/thunderbolt/tb.c                      | 49 +++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |  5 ++
 security/integrity/platform_certs/load_uefi.c | 38 +++-----------
 4 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.43.0

