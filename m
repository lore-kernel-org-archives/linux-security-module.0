Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7932D7DCE
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808260; cv=none; b=UcMi7kNmZHitSUdRgY/7c7UUpVxw2cab0+0gZ+fovheaeaFwDhRCAGx23XlK2k2GRF//GpL8kehlWVTonhzwi+cNG4tRn1YhVeWTtIoPSkQgGpXjpLOWz8UCuMnJlMVZEzPLrUeX0RtI/gJEYuF6nZ/V1sam4m4o28yqiBW8+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808260; c=relaxed/simple;
	bh=KVuyHGeUtpLkpGJYZbfb5WtDJicjtg3giXBlS+vhN0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UxeKJE+r2mq52wtuWhcG++yXCI5opGiWFsPlYsSRMC6TzTfiPKPI3b0O0gG6T5wa7BEMYUUebyCUhIrRaCSyPOHpxhBl+lp6ni5Th8u4mCswNN/nhwAQgQd9K4PyhVzFXmgL4PbNhIWszMrQ17jQvID9eCxatAUw8P0BS1qSg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0/MwqUlQ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0/MwqUlQ"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso5527822a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808255; x=1766413055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=0/MwqUlQdu789oy/P41nfqLWb7EnWXY85sbaj1smEzYO15dtuHKqLxDRGab17o4MUA
         D9TVJCvajbSn5mubZh7M9K5h4OT9pI/1qbh3beoBI1s+cs7/fK/G4sJRfPkfXVwqwBh3
         SXWcXenTFagxpnUecAa9mbcMVNCQ0U0akf+J4xD5CfLDcNwb1vJBMEz8cd19gt/edXo+
         6prwzju0rCEY9Jjuz4PQX50jj8chQizO7srmUjvdHU5PwJBwJQDO9vd0BIIvgTsOQttn
         fOSTaGyo9VctrEKOw8TJvYNlkT8bhVXwWSOKvHyDcKwgwrFzGeqWEX80uILWCX3i0XTf
         hi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808255; x=1766413055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=hLbt261Ny50KvulsaOrupCi014bXeHhu7ANwj/0heYm4ASM+FQdZiVHDbLJxhtDWTe
         3dQHU5ppQTxmW1kVhwrfrjUxtZO9bMFkjVliXa8eEZw9vE5E2gsnatZCO1pOjZw6yY6A
         KsF/bmq2vJ7hYUOC6q+19BAMbkbwrnqKf6i13BHFKPuYcrS2a1HDICZvxRW+pd0z7UO0
         ysPA83N9AFDSHepgR8AM6mIToQA0bm6CMtpqg97oHhWDmiplLvhu9qqnUSHromgtYMXL
         jpq2fDb8C8x8iZBMpWvHCtWHlmkOSJTm2VZiSssvdIwiumUzOkzb4ch6PlzTD59PUmBa
         lwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV/TnmzvoGoLs47zYU17ml9mbEBMadojZHdO0Ee+5FnLGwxOWQlL4B692WeznuBUHk5+mNv81Ri+C/b53DH7uLNeyeWYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmjTn3iNMkr+uJT5xPHRfd+X1braA7JFMH/pVVa2LJorefMMx
	sPKJyITG7AaePEc/MwAjv7emjaqXVhiOIcY0DELRcINKvvRtow/ZQpxhUhCs/4xkEdQ=
X-Gm-Gg: AY/fxX4xAtLZ+pmz80OeZD+53uaef5BbcU6QWsOU1CmzrUYKacakQpjsnQAmnVqIqkb
	hz1RTKNJ2qXIiTprbhlZxOAhw0Q1JyMKd5Yj9g2iar1pD6nMZByoiSsL+lHN8A7H7hjrj5gT2Zy
	u1+VzAHj8T+3XaIFUiPMMGImxxg6HiVxw4UYR4fDIGOBC+RSrRfhb+/p/hQlVbdsreQJVxY0x7q
	z86DxTl8UYjt5ND4sLRJwRdMCQ6tV9pVeY2kiB2f92J4XwW1M7dvHD43PgPcItWal2wMcrouj0w
	8kOYfFp0sSkj8FDSOn2f5Q3Fu9jgIMYzt0yzKCbR9X+sTqcJhqlElxE/a7f/LCeojg8ewq3qiSc
	4inRI7+8VACgNwmTNfB7j2rX19pUat6iu/+b8AQ0oc1dA4cPcXcrZR3RvarM7iVg8Rs2RfrDykd
	t/johHJDYW/t+FGRfC3PncEwL/QqXjnEaV6adRQ23rP8tQqW5kgilxlBC5lw==
X-Google-Smtp-Source: AGHT+IF5kWl8asvVZ2gDn2/ukMC7FmJVzWuHgbBPUo4GSSTrWpKfiHxIiV3JEK3vNep6zj7EVQ2rxQ==
X-Received: by 2002:a17:907:a909:b0:b7c:cc8d:14ef with SMTP id a640c23a62f3a-b7d218d55fdmr1188092466b.32.1765808254923;
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa56c152sm1380034166b.56.2025.12.15.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
Date: Mon, 15 Dec 2025 15:16:30 +0100
Message-ID: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KVuyHGeUtpLkpGJYZbfb5WtDJicjtg3giXBlS+vhN0U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhBsL1Z+rYFoGFHUfEy6nbD85QotpwGnuS0G OxYNqNRFI2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYQQAKCRCPgPtYfRL+ TugUB/9E31O/wKyUkNJNEPUiyayhLen3mT/3afyja8AKlZtLRRSDYD85SklWs8WUYR25f620Tug HCQFCBGP6zvWFDFUJWDts8iS5V7u/2f3fzK4EwWEIO8RjWf//RCGbcOXzrjD+gHhyiO4ntF2NWr 3ospR0B/APcHFEMI3zfkmIaPNlyEhNrddsNRbaHKA+WTWhZm7A/yqOnVYIJ6MLuTrhjHLZZoL5u gBimMOyT/Dmu6TUF9ex7Rhk+vookCt9jpn+vbxsz0ArRtMIo0W8fVdouxPDFA9SMn/bCn6BBJ+B fl85F7WiQwNbfWoeC8/qrjWMCGDfxgyRZi39jRQ+nWgTC5V5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of this series is to make tee driver stop using callbacks
in struct device_driver. These were superseded by bus methods in 2006
(commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
methods.")) but nobody cared to convert all subsystems accordingly.

Here the tee drivers are converted. The first commit is somewhat
unrelated, but simplifies the conversion (and the drivers). It
introduces driver registration helpers that care about setting the bus
and owner. (The latter is missing in all drivers, so by using these
helpers the drivers become more correct.)

v1 of this series is available at
https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylibre.com

Changes since v1:

 - rebase to v6.19-rc1 (no conflicts)
 - add tags received so far
 - fix whitespace issues pointed out by Sumit Garg
 - fix shutdown callback to shutdown and not remove

As already noted in v1's cover letter, this series should go in during a
single merge window as there are runtime warnings when the series is
only applied partially. Sumit Garg suggested to apply the whole series
via Jens Wiklander's tree.
If this is done the dependencies in this series are honored, in case the
plan changes: Patches #4 - #17 depend on the first two.

Note this series is only build tested.

Uwe Kleine-König (17):
  tee: Add some helpers to reduce boilerplate for tee client drivers
  tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
  tee: Adapt documentation to cover recent additions
  hwrng: optee - Make use of module_tee_client_driver()
  hwrng: optee - Make use of tee bus methods
  rtc: optee: Migrate to use tee specific driver registration function
  rtc: optee: Make use of tee bus methods
  efi: stmm: Make use of module_tee_client_driver()
  efi: stmm: Make use of tee bus methods
  firmware: arm_scmi: optee: Make use of module_tee_client_driver()
  firmware: arm_scmi: Make use of tee bus methods
  firmware: tee_bnxt: Make use of module_tee_client_driver()
  firmware: tee_bnxt: Make use of tee bus methods
  KEYS: trusted: Migrate to use tee specific driver registration
    function
  KEYS: trusted: Make use of tee bus methods
  tpm/tpm_ftpm_tee: Make use of tee specific driver registration
  tpm/tpm_ftpm_tee: Make use of tee bus methods

 Documentation/driver-api/tee.rst             | 18 +----
 drivers/char/hw_random/optee-rng.c           | 26 ++----
 drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
 drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
 drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
 drivers/rtc/rtc-optee.c                      | 27 ++-----
 drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
 include/linux/tee_drv.h                      | 12 +++
 security/keys/trusted-keys/trusted_tee.c     | 17 ++--
 10 files changed, 164 insertions(+), 138 deletions(-)

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

