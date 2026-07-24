Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E042BC54
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911626; cv=none; b=eU8yar/I/kn1OAT38xDacvEDCpcyXj9GSyVPrcxDfvZH/yPZgnAfJ5BFk2hsZzVqeUOA7WHwQp/J1Sf0jH3rGWLINd6SffVQmPA28tKZWMIiqOg0C1MjM1xLwTTTu3W4bdsIPODLou7qQ5bYrCHHhXj2NgaGiaf5YPoxz7L0ZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911626; c=relaxed/simple;
	bh=9NYcmLdbUWrP+mU//pO/mmqOOgJ12dK5s4oIK8p5CTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbYDMKE+HMuu9ZSECMVeLhPqHcGW8YSZEaxb0Tgy/iQDdnA540zFARauM9XFE/aooQMjJ82gkuHNHE5HsPiudm5DekpXHIiOZqO8tVFrNvLGF/BPRlOk7bN70E+0/xj7aYvPlto8sVinO4AIOUnJEflRNPSuEr66U9TqnQ/9FLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKXCZ1Hg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKXCZ1Hg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cca0c5799eso7172515ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911624; x=1785516424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXWL3A5rMUnEz/bSY0B31M4CG2x+3yDzIFpO8mfVO/g=;
        b=YKXCZ1HgtcYariII6zoa/8UO6Tz/vHBoKWTJ7d7XJBhVx5r24ZBlIzzrK7zPPXOTkw
         0DlufLkPARRIkjTfSeIwC5WeO48xZtjBbSTAD5mJsAzKcw1A2NUOjerAqYCHAolmPBC+
         YT0Kd16OuLm4iq4LQjfvPqUkjl6OW6c13xBPUe9Nzoj/ZDSn5uz9rFgZsaMw03iEg3Ms
         klP8G1ZOmnxcNn2zv5Do7MepEgxnBnM8XHHMvPRhqObt6gqDdD4iRHtYlbhuDy4fvA/h
         u3KmX2ATr3nGrVqjVvpVDyqQnyas3MzUCDJO2pxOxssyHvci2PmjxroCwvKQbFwD13+6
         Etsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911624; x=1785516424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXWL3A5rMUnEz/bSY0B31M4CG2x+3yDzIFpO8mfVO/g=;
        b=MKPEt0pp6oFEQnFs1wH7dbPNMlcItDSHN7vUH7EFHovrMUO7QGiphGvZ7gP/UksjfT
         h3K1YCbeQpNRGIu3/iY9ZMgFqbNen99vvSE88fnydJOcW7tdCVYQD0GcB4wDQjOVpbnU
         TWi0FbSGHzGJoz8P6Xf1TRO1AUSw+8jF/wPUHl7uQBk2XFFoTbhhqujt+VkdDi8TfJ+p
         Il/n33Dqr0pDIv9qcx2bQpNTNBDA9A6KyF04y3B76zD/p+xv/EpEkgdoDXuyZBreNq/o
         GR2pNM1K7mWYHfJSAOivbpHNd5+W3bp6zGB5sCgZBARZlCnbwLkh71L1aTqHryA2zOKc
         1QHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDw7PpbzK63Y60PQojzgUVrU3GUq27Lq2syFRlwOB8kRz4zG2a7KPOlUA4C80rFJhkx3yoLgLVKQq56e6+RyvRqmX0UDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvVrpimhYZ6vFDsmFpN0BkqPzFVrHdX/U4wyo692kGeQmGEII
	LtwrIAQMgm+eJbPLa7mtqxiithkQWPol5V+UDu8NvznVd0nkLrVMNVA=
X-Gm-Gg: AR+sD10w3TZBK1Sxo+6cuPAZ1300HAsn4xmtxTlPf04Ka3eDJdxGERVCAbbbB9xtGUS
	nb91XDzUKg6MTGhmJ3ABkgY2HhSVRrmi/B/izJNdBUTe1X+US8jd3F4hauVdQATWqZ3W/jqTGfa
	Yt45RVSPHEuBk5EjPBysPGu08Koytirxpf0qlU9b9Vi+VbnxYIuZw9KOogNF1Hv4GMSmnrN9b/f
	vzaF5/p3JnZJ5bsDSnotE6iURTq5QX5WVG2LYk99nVYqQNU8TnaPaouIjPKOVHGh5ao0uMcti79
	0CczWgUczjN0S5r/J7SgLf73XBD9TdYYxSMapFG4rLIxnyF0tLDTt2j+Lj2b23+EgE9mun2xKj7
	N0vLkCZ5NYBCwvwrEnO22x9dx6PTBFc4rPcZOnDGmM/V/jjb39wlkJMaB4c31bWF6lY7j28i71k
	Nz+5zLfJNowtcx2xpLDxcGkZjn2tuza2aElc/9Aw==
X-Received: by 2002:a05:6a21:6f0e:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3c44af6dbdemr9141519637.14.1784911624220;
        Fri, 24 Jul 2026 09:47:04 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.19.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e29sm918244eec.15.2026.07.24.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:47:03 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add Apple T2 NHI device links
Date: Fri, 24 Jul 2026 12:46:35 -0400
Message-ID: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
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

Changes in v4:
- Limited TRP check to T2 Icelake systems only
- Optimized has_apple_t2_chip check
- Included pci.h to drivers/thunderbolt/tb.c
- Used __free(pci_dev_put) to avoid label

Changes in v3:
- Fix build errors with non-x86 machines
- Used __initconst for apple_t2_devices
- Removed UEFI_QUIRK_SKIP_CERT as its unused now
- Used IS_ENABLED(CONFIG_ACPI) in tb_apple_add_links for the T2 part
- Removed !bid check to remove warning with -Waddress

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v3:
https://lore.kernel.org/all/20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 37 ++++++++++++
 drivers/thunderbolt/tb.c                      | 58 ++++++++++++++++++-
 include/linux/platform_data/x86/apple.h       |  5 ++
 .../platform_certs/keyring_handler.h          |  8 ---
 security/integrity/platform_certs/load_uefi.c | 38 +++---------
 5 files changed, 106 insertions(+), 40 deletions(-)

-- 
2.43.0

