Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D067368299;
	Fri,  5 Jun 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670622; cv=none; b=i3XEXRcsbnrS216OqY5mP7KDH4LpVGjPBGn8dj/mtEtROQevDl77DixVZM24t4DE7CbIqQLQntUFt7Uy9wYYlSNbeeimbB8yjWYJjWPfJYw8Xw30lxN9FIwX98EBUKSfkKJ8w/ix7HTLAdykYYBN4Rly9cOR9nZFSXRmzlAqViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670622; c=relaxed/simple;
	bh=OMQjeAoCepwlcTOllxIGRjOyfmXjVBQjlhbICvD3SAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o5hORbMXy+RA9LXEVqg0dZ/sITJyDoMT4Qz/3NHwRwdLtZVJsyV+zzgS9bshwsPH56BvnFiOTyOXNQaghKbmEF6lV4FO3MNt4gL4mfgGxX/rLLDURdysOuWSLF2jlEwrPcW95DUzJe1xNEsKSV/z/m8zuGSp3wWyUeLxnISSt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LQ/Yoc1o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LQ/Yoc1o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EB56237B;
	Fri,  5 Jun 2026 07:43:33 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F7293F7D8;
	Fri,  5 Jun 2026 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670618; bh=OMQjeAoCepwlcTOllxIGRjOyfmXjVBQjlhbICvD3SAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LQ/Yoc1oX020uC06MsmCzMuwvoLO75RatEVWIl8KrXjqJVsgK4GP8O5nKdqglzkj0
	 45saIGgOCkllw6LgERHphTDGDWxja1IOaHgJ3T+7R4MNf5Qd2PAnOd2QM1n2BkwFyL
	 3nZQfqPb/GkshatfXjdDDOad4hC79o6hKcCc/594=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 0/4] introduce IMA_INIT_LATE_SYNC option
Date: Fri,  5 Jun 2026 15:43:21 +0100
Message-Id: <20260605144325.434436-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
the TPM driver must be built as built-in and
must be probed before the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using
the CRB interface, probing fails and returns -EPROBE_DEFER if
the tpm_crb_ffa device — an FF-A device that provides the communication
interface to the tpm_crb driver — has not yet been probed.

To ensure the TPM device operating over the FF-A protocol with
the CRB interface is probed before IMA initialization,
the following conditions must be met:

1. The corresponding ffa_device must be registered,
   which is done via ffa_init().

2. The tpm_crb_driver must successfully probe this device via
   tpm_crb_ffa_init().

3. The tpm_crb driver using CRB over FF-A can then
   be probed successfully. (See crb_acpi_add() and
   tpm_crb_ffa_init() for reference.)

Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
all registered with device_initcall, which means crb_acpi_driver_init() may
be invoked before ffa_init() and tpm_crb_ffa_init() are completed.

When this occurs, probing the TPM device is deferred.
However, the deferred probe can happen after the IMA subsystem
has already been initialized, since IMA initialization is performed
during late_initcall, and deferred_probe_initcall() is performed
at the same level.

And the similar situation is reported on TPM devices attached on SPI
bus[0].

To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
IMA at late_inicall_sync so that IMA is initialized with the TPM
device probed defered.

When this option is enabled, modules that access files in the
initramfs through usermode helper calls such as request_module()
during initcall must not be built-in. Otherwise, IMA may miss
measuring those files since they're the file accesses before the
initialisation of IMA [1].

Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]

Patch history
=============
from v5 to v6:
  - add rb tag and missing SOB.
  - https://lore.kernel.org/all/20260601142749.3379697-1-yeoreum.yun@arm.com/

from v4 to v5:
  - rebase on v7.1-rc6
  - apply boot_aggreate name patch from @Jonathan and align it with
    IMA_INIT_LATE_SYNC option.
  - https://lore.kernel.org/all/20260525075404.3480282-1-yeoreum.yun@arm.com/

from v3 to v4:
  - rebase on v7.1-rc5
  - introduce IMA_INIT_LATE_SYNC option to control IMA initailisation.
  - https://lore.kernel.org/all/cover.1777036497.git.noodles@meta.com/

from v2 to v3:
  - Drop ff-a/pKVM diff (this seems to have a separate set of
    discussion)
  - Rework IMA delayed initialisation to avoid delaying when unnecessary
  - Ensure IMA log clearly indicates when we've initialised late
  - https://lore.kernel.org/all/20260422162449.1814615-1-yeoreum.yun@arm.com/

from v1 to v2:
  - add notifier to make ffa-driver pkvm initialised.
  - modify to try initailisation again when IMA coudln't find proper TPM device.
  - https://lore.kernel.org/all/20260417175759.3191279-1-yeoreum.yun@arm.com/#t


Jonathan McDowell (1):
  security: ima: rename boot_aggregate when ima is initialised at
    late_sync

Yeoreum Yun (3):
  security: lsm: allow LSMs to register for late_initcall_sync init
  security: ima: introduce IMA_INIT_LATE_SYNC option
  tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in

 drivers/char/tpm/tpm_crb_ffa.c            | 18 +++---------------
 include/linux/lsm_hooks.h                 |  2 ++
 security/integrity/ima/Kconfig            | 10 ++++++++++
 security/integrity/ima/ima.h              |  1 +
 security/integrity/ima/ima_init.c         | 15 +++++++++++----
 security/integrity/ima/ima_main.c         |  4 ++++
 security/integrity/ima/ima_template_lib.c |  3 ++-
 security/lsm_init.c                       | 13 +++++++++++--
 8 files changed, 44 insertions(+), 22 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

