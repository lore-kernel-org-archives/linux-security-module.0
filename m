Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793596;
	b=Bu/IigxpMK692wugE65mgWADQS3cpolzsQ9CL8Ac5e/Z8EOuP7zFkKeONiwuS7HdGE+0
	 tqqKjuKG4aw9FQuPLNoIRmam40kmPUp7ZUUosdzDpkQ4jDUZHQmfUY695HRDTZCtYubyS
	 63J9Cv1AkCKBO9JCX3+95nSJ+nL+wNjUZqNtrHMwmcpd+Q9uzBKDYtTnt35WFEpVOn3wH
	 HpnaY4S8/8KSWGYUgTo1DpHH7x++RzmTbntT8m1v3EFMCEn/btS8RV0QfBgpF4HFp8hT5
	 vddUa9BFlrmG6BRl/WKZLqt58FJsmC+IczYgu4Mbz5KhIR0JDc3hNFVQ8YIGwzpevMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793596;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0E5oFbfWv4al6ZhXYQB+Fc2jmPL18RQBBfOHqivCMnU=;
	b=cU9BWilRgGTulPclKV2EB2sV9QTmPZvfHpX6LelKpvw3ZC4VvQtdcwQ9cC4iOm3372Md
	 xtReWRd0q9pvarMduubm6HzNXhSfh7LBHBV1hIGjpffOeDWc9aBJJlfZJv42281UA+sTg
	 oLaFyB4JSNfusY6U3FZrCCLwcxh8Hxoy0+AAOmMHilTmu7TBuVP0Q2tYJMwNw35KRE2MW
	 UoaDLECgZFJ58wkkzBpJkABg5ejuOW2Zo3gYrya0ciJVXEMYsyK6JFG3gQV6qWL0vdY8U
	 nHj7nHbWmwM6Edexh+VyBG0my+X96oES3yJIODNTnk9xcn0YZ+VtQS51kwaP19CwRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bNYggG6W;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F946606A31F;
	Fri, 27 Nov 2026 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F946606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bNYggG6W
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F16169E;
	Fri, 27 Nov 2026 07:33:11 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422B03F632;
	Fri, 27 Nov 2026 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793594; bh=CREZT/iY5Maoixa1IibuDtoXUQI0xrQeRjPWVOFSKwA=;
	h=From:Subject:Date:To:Cc:From;
	b=bNYggG6W7pYvzbEvPWfcDMwAR0kUCLZHnsj/qbFyAnIGNAE1k/FTdOUVO+MbIjUiL
	 Bt1iz4axqpaEidiwhz0tkxHw5/CCUg00sNrmBm+0qsIqKgqBJYBWbhCTjyGgHbe/HS
	 FPT3VzxkYqeqpvRJs428DDnng4TvXLls3+uYj/yE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH RFC v3 0/8] attestation: provider: add CCA Realm Guest
 provider
Date: Fri, 27 Nov 2026 15:32:55 +0000
Message-Id: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKiiCWsC/22NywrCMBREf6XctZHkKrZxJQh+gFspJY9bm0UaS
 SQoJf9uyNrlzGHObJAoOkpw7jaIlF1yYa3hsOvALGp9EnO2ZkCOJy5RMhX9ZIyafGRKyKNGkmh
 ED3XwijS7T5M94H67wljLxaV3iN92kLGhf66MjDNh5aC1EkM/20uFexM8jKWUH8uK1lOnAAAA
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 thuth@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
 Pawel Chmielewski <pawel.chmielewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Gavin Shan <gshan@redhat.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=CREZT/iY5Maoixa1IibuDtoXUQI0xrQeRjPWVOFSKwA=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaKyr1sL7I3GjufUXjAqUdNumg4Eu4t6MmqHp
 tAOy6CS0BiJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmisgAKCRBt1cPRWsUx
 M/DnDACUjQ9s+JwuutCXoESK7Y3sUXsaRo4m18QvFHFWdANC8ghLblUcU2RbSsyopDlIC4GHgS6
 3o8yvxhAQUlaN9p4PY1Tf1JdklJSW7hGM89MCOFo9sfffrbHdjc/cHxEv9+I+qqVJ7mUBeLkMkQ
 6TiH5pDeXFZDFg14WE5H2C3XlQJmzwdD8HA3GA1MYq7NY4OmYSD1xmdZU1k1bc8VNOL9dGidfsB
 xQMXxlY1YIG4lxIVNL+tbU7ZBR+66zsMB1+bkuZ74j/+H4aWIxFbail6XTCD6yBdpQeleTUymbS
 JR5D090Qdxj8biSqS9Tx/OgdaFrsgFLzf7FxCAeggOK9kDfUCF3r3YoCMwrlBplw/aX/GBpXWM6
 sSZ7Z6nhzocO8wMYU9rSt0Aqz90ARhYLbgQCkkkQ33Zx7I9PQcO8UR1PtHmJScFk0SWSlWhgngX
 9kkMuWVDVyFPjKIqlwpGRVcZYHoLv7JaJpjGHSUrmGgG+Q04OeBWS5PjrzsKLRrSLbTZ8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

This series adds support for Arm Confidential Compute Architecture (CCA)
measurement registers in the Linux kernel, enabling guest Realms to
access, extend, and expose measurement values for attestation and runtime
integrity tracking.

The Realm Management Monitor (RMM) defines a set of measurement registers
consisting of a Realm Initial Measurement (RIM) and a number of Realm
Extensible Measurements (REMs). This series introduces the necessary
infrastructure to interact with these registers via the RSI interface
and exposes them to userspace through CTLV attestation subsystem.

Also, this seires includes the CCA attesation token generation interface
and CCEL event-log exposure through CTLV attestation subsystem.

At a high level, the series includes:
 - Helper interfaces for reading and extending measurement
   registers via RSI
 - Definitions for Realm hash algorithms as defined by the
   RMM specification
 - Support CCEL table in arm64
 - Integration with attestation subsystem by introducing CCA Realm Guest
   provider

After applying this series, measurement registers and relative interface
will be exposed ctlv interfaces.

This patch based on arm64/for-next/smccc-bus, attestation branch[0-2] and
firme patch-series [3].

To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
To: linux-security-module@vger.kernel.org
To: linux-doc@vger.kernel.org
To: linux-kselftest@vger.kernel.org
To: linux-acpi@vger.kernel.org
To: acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: thuth@redhat.com
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>

Link: [0] https://github.com/jpirko/linux_mlxsw/tree/wip_attestation_all_2
Link: [1] https://lore.kernel.org/all/20261113155515.2510194-1-jiri@resnulli.us/
Link: [2] https://lore.kernel.org/all/20261113160838.2512652-1-jiri@resnulli.us/
Link: [3] https://lore.kernel.org/all/20261127-firme_interface-v2-0-ab88b2d0b4e0@arm.com/
---
Changes in v3:
- rebase to attestation subsystem.
- Link to v2: https://lore.kernel.org/r/20260929-arm_cca_mr-v2-0-1d98bba187fd@arm.com

Changes in v2:
- rebase to arm64 tree's for-next/smccc-bus
- Link to v1: https://lore.kernel.org/all/20260413084957.327661-1-sami.mujawar@arm.com/

---
Sami Mujawar (2):
      arm64: rsi: Add helpers for Arm CCA measurement register operations
      arm64: rsi: Add realm hash algorithm defines

Suzuki K Poulose (1):
      arm64: acpi: Enable ACPI CCEL support

Yeoreum Yun (5):
      acpi: add CCtype value macros for CCEL table
      Documentation/ctlv: introduce ctlv-attestation-cca-guest family
      ctlv: add auto-generated files for ctlv-attestation-cca-guest
      attestation: providers: introduce CCA Guest attestation provider
      selftest: attestation: add cca_guest_attestation_test selftest

 .../ctlv/abi/ctlv-attestation-cca-guest.yaml       |   19 +
 Documentation/ctlv/abi/families.registry.yaml      |    1 +
 Documentation/ctlv/families.yaml                   |    1 +
 Documentation/ctlv/generated-files.yaml            |   11 +
 .../ctlv/specs/ctlv-attestation-cca-guest.yaml     |   20 +
 arch/arm64/kernel/acpi.c                           |   11 +
 drivers/attestation/Kconfig                        |   10 +
 drivers/attestation/Makefile                       |    5 +
 .../generated/ctlv_attestation_cca_guest_gen.c     |   64 +
 .../generated/ctlv_attestation_cca_guest_gen.h     |   40 +
 drivers/attestation/providers/cca_guest.c          |  582 ++++++++
 include/acpi/actbl2.h                              |    7 +
 include/linux/arm-rsi-cmds.h                       |  118 +-
 include/linux/arm-smccc-rsi.h                      |    8 +
 include/uapi/ctlv/ctlv_attestation_cca_guest_gen.h |   34 +
 include/uapi/ctlv/ctlv_families_gen.h              |    1 +
 tools/testing/selftests/attestation/.gitignore     |    1 +
 tools/testing/selftests/attestation/Makefile       |    9 +-
 .../attestation/cca_guest_attestation_test.c       |  517 +++++++
 .../ctlv_attestation_cca_guest_user_gen.c          | 1547 ++++++++++++++++++++
 .../ctlv_attestation_cca_guest_user_gen.h          |   49 +
 21 files changed, 3051 insertions(+), 4 deletions(-)
---
base-commit: 55e9f5a2188b97fd2e3ef949b0e52910aa77d940
change-id: 20260929-arm_cca_mr-a194b2e92c17

Best regards,
-- 
Sincerely,
Yeoreum Yun

