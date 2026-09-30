Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BAE4E4C4A;
	Wed, 30 Sep 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775867; cv=none; b=bhVtIceTL3jPzzb2FmPEE7BfM4mgPzZHjn4ZNBZcP7gs4U2HtOm9v69WJwanqjx43wNiKe62XeQoPA+RsjZ4vxCbMziMf/1KS20UXRtnohH2z9XBVzgoIZJjAEOZzivYK+JMuY9c6b5dp0k0QzlShcd3S+RN6laeZYeMNBgYoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775867; c=relaxed/simple;
	bh=50jIGHRovgulaRzsZdJ+9hsmELKM5EQY8FD4RXGMLmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JN8LeXVpVeoYQrhfFta8mUIvBKx3b0NklBkuiVAUFU7lzQsd4oZQsNfz/ajYptEvx26DD4T37OcZxpfi1z6sVNlCRnmkwsqtRG1nm/ZKWL2ETq3cYuiNTYfbuDfFRVznUdD3CSnYcKjCZbywdXjfFF4tKzTBFJYbxz514tGZ6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UdifEflo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UdifEflo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A297C143D;
	Wed, 30 Sep 2026 06:44:14 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE623F86F;
	Wed, 30 Sep 2026 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790775858; bh=50jIGHRovgulaRzsZdJ+9hsmELKM5EQY8FD4RXGMLmM=;
	h=From:Subject:Date:To:Cc:From;
	b=UdifEflorOYp62Nqvk4tFhdyMXy9j8gS6jmQhun8yH8M++ipjsPz4Nu9ycK7RROvu
	 wCDP3DMvzc5ZFTfIxACNNtfFYZ4pOfYojMKVjCyCiHTnCkaxCyJuRoOacws36jTTdy
	 atAk+TDQDTGOg9rAdAKX9b4COnHkuv4RuURGMmMo=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Date: Wed, 30 Sep 2026 14:43:58 +0100
Message-Id: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4SvWoC/4VNSwrCMBC9Spm1kSRWJa4EwQO4lRLSOLazSCqTE
 Cqldzf0AvJW779AQiZMcGkWYCyUaIqVqF0DfnRxQEGvykFLfZJGG0HB2TzMlmLGgV2ueVu0UP7
 YOkRXgVDLH8Y3zdvwEx73G3RVHCnlib/bWVGb9W+3KCFFb+ThrLFXsm2vjsPeTwG6dV1/fGhx5
 b8AAAA=
To: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Cc: Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4233; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=50jIGHRovgulaRzsZdJ+9hsmELKM5EQY8FD4RXGMLmM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqvRItDKXo1GJ0JydGpbq9sQNylyJhoC3dgOo3z
 EgWR8tQ0q+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCar0SLQAKCRBt1cPRWsUx
 M+J+DADJZth8WYIotyPlMv7pmFYbJAqKoBBkJXDbEMO+1GzlV6KGweVkMuOPsaxoFc8MG9YqBu/
 PRnIJnYFbeXAI15UTJ3/YqioPd1pOwAngZwNKhEhpKqBI1FYIEktxqvz/A/fn5iA3vHvy3xXFRE
 LMqYuohG/NxZgEvhXSoZ8OGCWYLoj5t+v6dd2ib562yX2L3iFQeA9CJhu7HmM/Jw9a0+dgl/ikT
 uB/OfV1E9QBkOL8SppLY5TUN2tA76avr4T+X9TyOMYWgXv6arHKpekU6hjo2DKpnYchfKLslaPf
 f5yo5aM0otTRrz/645ZsLf2aS9xVesY1cmT8dKN6n2tX+NIFGLq6ZJK0ipqZ3dHEG2vHy2cBKgi
 H4BJXflgzb5aa97zmZia/mIMFAmHwcPVc45/PepBB8OcEh2jyNn0+K405o36FByrMpj6wpiBXU3
 c9UP6zHhaH/lZmmmeBT/NwO+UuvjfhgjUplWoZE6ckWClGsEDPa0B5I/LU3wHlYaG9+p8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Confidential computing guests without a TPM can use TSM measurement
registers to record IMA measurement digests instead of TPM PCRs.

This series introduces in-kernel interfaces for accessing TSM
measurement registers, abstracts IMA's measurement-register operations,
and adds a TSM backend for Intel TDX and Arm CCA.

The following mappings between TPM PCR indices and TSM measurement
registers are defined for Intel TDX [0] and proposed for Arm CCA [1]:

  TPM PCR index | Intel TDX register | Arm CCA register
  --------------+--------------------+-----------------
  0             | MRTD               | RIM
  1, 7          | RTMR[0]            | REM[0]
  2-6           | RTMR[1]            | REM[1]
  8-15          | RTMR[2]            | REM[2]

These mappings allow IMA to translate PCR indices into the corresponding
TSM measurement registers.

The TPM backend remains preferred when it is available at IMA
initialization. Otherwise, IMA falls back to a supported TSM backend.
Only one backend is selected; IMA measurements are not extended to both
TPM PCRs and TSM measurement registers.

The attestation proccess for guest with TSM measurement register will
be done with Confidential Compute Event Log (CCEL) which is exported by
/sys/firmware/acpi/tables/data/CCEL. Here is brief process in arm64:

  Verifier                 Realm guest              RMM / Platform
     |                         |                           |
     |--- Challenge (nonce) -->|                           |
     |                         |--- Request token -------->|
     |                         |    with challenge         |
     |                         |                           |
     |                         |<-- CCA token T -----------|
     |<-- CCA token T ---------|                           |
     |<-- CCEL event log ------|                           |
     |<-- IMA measurement log -|                           |
     |                         |                           |
 Verify token T:               |                           |
  - signatures                 |                           |
  - Platform/Realm             |                           |
    token binding              |                           |
  - challenge freshness        |                           |
  - platform/RIM policy        |                           |
  - verify measurement logs    |                           |
     |                         |                           |
     | ----ACCEPT / REJECT---->|                           |

This patch based on arm-cca-mr series [3].

Link: [0] https://uefi.org/specs/UEFI/2.11/38_Confidential_Computing.html#intel-trust-domain-extension
Link: [1] https://github.com/tianocore/edk2/issues/11383
Link: [2] https://github.com/tianocore/edk2/issues/11384
Link: [3] https://lore.kernel.org/all/20260929-arm_cca_mr-v2-0-1d98bba187fd@arm.com/

---
Yeoreum Yun (3):
      virt: coco: introduce tsm_default_tm() and tsm_mr_read()/write()
      security: IMA: introduce ima_mr structure
      security: IMA: use TSM measurement registers

 drivers/virt/coco/guest/tsm-mr.c          | 159 +++++++++++++---
 include/linux/tsm-mr.h                    |  26 +++
 security/integrity/ima/Makefile           |   3 +-
 security/integrity/ima/ima.h              |   7 +-
 security/integrity/ima/ima_api.c          |   4 +-
 security/integrity/ima/ima_crypto.c       | 137 +++++---------
 security/integrity/ima/ima_fs.c           |  16 +-
 security/integrity/ima/ima_init.c         |   7 +-
 security/integrity/ima/ima_mr.c           |  48 +++++
 security/integrity/ima/ima_mr.h           |  76 ++++++++
 security/integrity/ima/ima_mr_tpm.c       | 155 ++++++++++++++++
 security/integrity/ima/ima_mr_tsm.c       | 290 ++++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c        |  39 ++--
 security/integrity/ima/ima_template.c     |   4 +-
 security/integrity/ima/ima_template_lib.c |   2 +-
 15 files changed, 819 insertions(+), 154 deletions(-)
---
base-commit: b561246f45174b7472c24b75358ea95bae72b7b8
change-id: 20260929-ima_tgx_integration_v2-1c54aeeaeaee

Best regards,
-- 
Sincerely,
Yeoreum Yun

