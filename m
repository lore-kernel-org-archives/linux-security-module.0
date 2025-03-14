Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C618139CF2
	for <linux-security-module@vger.kernel.org>; Fri, 14 Mar 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923540; cv=none; b=Yzi2BbsFb46bBJLFZX0yIFJJKzOGFsmmM3vvswH0h/ODVNwNCKt6/XOcxvI9IT3sLGfXi5SYMEfiRo0P3UtPHSO2XYIuH6/qDBIUIIAaWLXRDEoQEKcCQ6Mznx1Dq8VJBBpDGTAq1VBSJSbcgzdCYqQ5vp7rIxgJctdRrexuvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923540; c=relaxed/simple;
	bh=8JHzMdfE4QsKF+jeoF3fnKWev3swd8bxfaR+miqoZ1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCJav3VfdomiYng955ALEPSpkW2SsE8e3OsECzWc+nH7AcDrXZZZhRP9mipHzYA7uaNUJ6BpYYbLjkF0OShW+jFS6N9UiRnQuQlwkd6XKhEBb5+SxGsIP6Po2A8BLUk8eYqOh867BzmV+Mk9G3CDL9FRy3MDB6oAy9OFgnKURqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com; spf=pass smtp.mailfrom=inventec.com; dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b=Y61bDkNN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b="Y61bDkNN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2239aa5da08so33582315ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 13 Mar 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inventec.com; s=google; t=1741923534; x=1742528334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDN2ljD3O/TprnTqjIqiGuq4TfPVGZRHG8jgspTX61Q=;
        b=Y61bDkNNncBgBAQA3OIjBwNnb/GSh8g1F4ujCkfEmk9lBdkGHU4kwqLaWU3Q8/hWNE
         H5pjmHz1ny7dpbWk2ruA2nNIDfqwBlg8ABC6R/prs8sBdFvxW+z1vZsx95KLOGxTk3mt
         1kXRp/J88auzo2gAg1plbvXtSgG3tjuNRfpXXZOtTtdLPrjzkf2uRLQSnB+FSpw5VABC
         ISRpKHhM2RTU4eMWyUNu4cKASWNtKM4WlxU6sAt1JT6wIlt58Z4s3LtPiNOAxtyq50WN
         zPKrgDxGlpZpSbbQ7IX9oxqt3hm9cR602VUzn7XgGlnspf+QymFSiKBGdmKmazxdpnUP
         y6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741923534; x=1742528334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDN2ljD3O/TprnTqjIqiGuq4TfPVGZRHG8jgspTX61Q=;
        b=UcXIAAvJlYI8yGXnYttRxXq6fLWeO5bGfG8aqAt9xpHXQ/kQCldt81q7DCG7MjxE1E
         beY3c3X4SEFwKXtaQoJtcKzglSHHEUKBGpnOL7sOEco76PCNJDvtvXmBJ34pG1l3/epQ
         ZnFvRhCBTPS2Xyeic5nmrXmw13Pp8g0N2DwW5qlLEbISNUgXzPMaQJLntcc+ne+FyDRH
         MCS+RraZIEcVLhMnhz7xZozAU0o9Aggdj/83I09BwpbYBBPPFMYtt3InC26bKcGXjDKR
         Q/6eoUWt4spms3fXb+EHSd8frCzZImnGXWYXO6OroDjWKAaBmzGkqxV/068PRJR01jgB
         n7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwuwAwHgRzyC/3eRkGi3y/ZzKm8V3EpurehNInNiOTJd6ArfTJksuqDlXhnnNmS5EYkaiJL8fepei7kZLT4eMmcZzKFW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCx05LVIOcjZEZEl8BbrktFXjYovXwbx2/OzNm2P0xfdAmeM88
	d6ALp5zeBGFL2FQbljQ6gfDHy6t4p7ZsNy43dKZvCoRxLpEX+x+EA9lvn7h+pMo=
X-Gm-Gg: ASbGncscF89al55c0JEuljgzBBLZNk7ZVs4VIezNjDLLAqqHPQK4TywmvomGoo3vP99
	rAaRCJowP3hDT8rnxwwuo3WvH8yg+igY+uIpfqiKBTuWVRxfRLV5H42u0lfJVWkLQy6hAYVbIeM
	fYBn8IZ6uUGWbzepl2whWj/54pqq7CUEz9N+ZHHyOqQ4/KiZehDVwPCWnqWnahLa5Biv/1DEVEx
	9Femizg2HGbfIoUWexbCXyRwD0uitQz3amlLPvZAteUtySXj4a+l7m8rwJibWARVZsm0ByROmc6
	jn1NdUvr2UdazG/U+AmZR4aWfdAlIEcr6mBwCebcljZdADjsrNZfODdM7x12H+89V9NwwHUa0PN
	zlGCw/cDTK8T+AWJUD6hAsbSFuQ==
X-Google-Smtp-Source: AGHT+IGug59apytIQU5wXKY5h3txVPZOzytFDjvu2AUTdCjJjz9o/2yxtoZ6EkEpTMV6hyU22HPLEw==
X-Received: by 2002:a17:903:1b2d:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-225e0a8ea49mr15712965ad.27.1741923532978;
        Thu, 13 Mar 2025 20:38:52 -0700 (PDT)
Received: from localhost.localdomain (60-250-242-163.hinet-ip.hinet.net. [60.250.242.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm21543655ad.23.2025.03.13.20.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:38:52 -0700 (PDT)
From: Chiang Brian <chiang.brian@inventec.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Chiang Brian <chiang.brian@inventec.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5] hwmon: (pmbus/tps53679) Add support for TPS53685
Date: Fri, 14 Mar 2025 11:30:38 +0800
Message-Id: <20250314033040.3190642-1-chiang.brian@inventec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJCfHmW61d2jd_tYpNEqBG_Z58bEnVKAmsvhrEP1zXQoXqrUVw@mail.gmail.com>
References: <CAJCfHmW61d2jd_tYpNEqBG_Z58bEnVKAmsvhrEP1zXQoXqrUVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPS53685 is a fully AMD SVI3 compliant step down
controller with trans-inductor voltage regulator
(TLVR) topology support, dual channels, built-in
non-volatile memory (NVM), PMBus interface, and
full compatible with TI NexFET smart power
stages.
Add support for it to the tps53679 driver.

Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
---
v4 -> V5: 
    1. document the compatible of tps53685 into dt-bindings
	2. add the buffer length as argument for %*ph
	3. Add Changelog
v3 -> V4: 
    1. Add length comparison into the comparison of "id",or it may be true when 
	   the substring of "id" matches device id. 
	2. Restore `return 0;` in `tps53679_identify_chip()`
V2 -> V3:
    1. Remove the length comparsion in the comparison of "id".
V1 -> V2: 
	1. Modify subject and description to meet requirements
	2. Add "tps53685" into enum chips with numeric order
	3. Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81"
	   Add marco "TPS53685_DEVICE_ID" with content "TIShP"
	4. Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
	5. Modify the comparison of "id". It will be true if the string "id" matches 
	   device ID and compare with type char*,
	6. Add the length comparsion into the comparison of "id".
	7. Modify "len" as return code in `tps53679_identify_chip()`
	8. Output device error log with %*ph, instead of 0x%x\n" 
    9. Use existing tps53679_identify_multiphase() with argument 
	   "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one
	   tps53685_identify_multiphase()

boot-log:
[    0.000000] Linux version 6.14.0-rc6+ (steven@TAO-BU2-S1-Laptop-Steven-2) (gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Thu Mar 13 23:01:55 CST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+ root=UUID=9a4e0ebf-a137-44d9-acf0-a4b11d960b86 ro quiet splash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c70fafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c70fb000-0x00000000c7c7efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c7c7f000-0x00000000c7e7efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000c7e7f000-0x00000000c7efefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000c7eff000-0x00000000c7efffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c7f00000-0x00000000cc7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004317fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0xa64ec018-0xa64fc057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000a64ec017] usable
[    0.000000] reserve setup_data: [mem 0x00000000a64ec018-0x00000000a64fc057] usable
[    0.000000] reserve setup_data: [mem 0x00000000a64fc058-0x00000000c70fafff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c70fb000-0x00000000c7c7efff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000c7c7f000-0x00000000c7e7efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000c7e7f000-0x00000000c7efefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000c7eff000-0x00000000c7efffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c7f00000-0x00000000cc7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000004317fffff] usable
[    0.000000] efi: EFI v2.4 by HP
[    0.000000] efi: ACPI=0xc7efe000 ACPI 2.0=0xc7efe014 SMBIOS=0xc78db000 ESRT=0xc6fdf660 MOKvar=0xc78c1000 INITRD=0xaaa17898
[    0.000000] efi: Not removing mem44: MMIO range=[0xf80fa000-0xf80fafff] (4KB) from e820 map
[    0.000000] efi: Not removing mem45: MMIO range=[0xf80fd000-0xf80fdfff] (4KB) from e820 map
[    0.000000] efi: Not removing mem46: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP HP EliteBook 840 G3/8079, BIOS N75 Ver. 01.24 01/30/2018
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2599.992 MHz TSC
[    0.000829] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000831] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000839] last_pfn = 0x431800 max_arch_pfn = 0x400000000
[    0.000843] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
[    0.000845] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001231] last_pfn = 0xc7f00 max_arch_pfn = 0x400000000
[    0.008714] esrt: ESRT header is not in the memory map.
[    0.008721] Using GB pages for direct mapping
[    0.009116] Secure boot disabled
[    0.009117] RAMDISK: [mem 0x7417e000-0x95a18fff]
[    0.009171] ACPI: Early table checksum verification disabled
[    0.009174] ACPI: RSDP 0x00000000C7EFE014 000024 (v02 HPQOEM)
[    0.009178] ACPI: XSDT 0x00000000C7EBC188 0000D4 (v01 HPQOEM SLIC-BPC 00000000      01000013)
[    0.009184] ACPI: FACP 0x00000000C7EEE000 0000F4 (v05 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.009190] ACPI: DSDT 0x00000000C7EC4000 02654A (v02 HPQOEM 8079     00000000 INTL 20121018)
[    0.009193] ACPI: FACS 0x00000000C7E68000 000040
[    0.009196] ACPI: SSDT 0x00000000C7EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
[    0.009199] ACPI: TCPA 0x00000000C7EFA000 000032 (v02 HPQOEM EDK2     00000002      01000013)
[    0.009202] ACPI: SSDT 0x00000000C7EF9000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
[    0.009206] ACPI: UEFI 0x00000000C7E7A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
[    0.009209] ACPI: SSDT 0x00000000C7EF3000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
[    0.009212] ACPI: SSDT 0x00000000C7EF2000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
[    0.009215] ACPI: MSDM 0x00000000C7EF1000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.009218] ACPI: SLIC 0x00000000C7EF0000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.009221] ACPI: WSMT 0x00000000C7EEF000 000028 (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.009225] ACPI: HPET 0x00000000C7EED000 000038 (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.009228] ACPI: APIC 0x00000000C7EEC000 0000BC (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.009231] ACPI: MCFG 0x00000000C7EEB000 00003C (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.009234] ACPI: SSDT 0x00000000C7EC3000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
[    0.009237] ACPI: SSDT 0x00000000C7EC2000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
[    0.009240] ACPI: SSDT 0x00000000C7EC1000 0003DC (v02 HPQOEM SDS_RTD3 00001000 INTL 20121018)
[    0.009243] ACPI: SSDT 0x00000000C7EC0000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
[    0.009246] ACPI: NHLT 0x00000000C7EBF000 00002D (v00 INTEL  EDK2     00000002      01000013)
[    0.009250] ACPI: ASF! 0x00000000C7EBE000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
[    0.009253] ACPI: FPDT 0x00000000C7EBD000 000044 (v01 HPQOEM EDK2     00000002      01000013)
[    0.009256] ACPI: BGRT 0x00000000C7EFD000 000038 (v01 HPQOEM EDK2     00000002      01000013)
[    0.009259] ACPI: SSDT 0x00000000C7EFB000 000260 (v02 HP     PwrCtlEv 00000001 INTL 20121018)
[    0.009261] ACPI: Reserving FACP table memory at [mem 0xc7eee000-0xc7eee0f3]
[    0.009263] ACPI: Reserving DSDT table memory at [mem 0xc7ec4000-0xc7eea549]
[    0.009264] ACPI: Reserving FACS table memory at [mem 0xc7e68000-0xc7e6803f]
[    0.009265] ACPI: Reserving SSDT table memory at [mem 0xc7efc000-0xc7efc107]
[    0.009265] ACPI: Reserving TCPA table memory at [mem 0xc7efa000-0xc7efa031]
[    0.009266] ACPI: Reserving SSDT table memory at [mem 0xc7ef9000-0xc7ef93b7]
[    0.009267] ACPI: Reserving UEFI table memory at [mem 0xc7e7a000-0xc7e7a041]
[    0.009268] ACPI: Reserving SSDT table memory at [mem 0xc7ef3000-0xc7ef81f9]
[    0.009268] ACPI: Reserving SSDT table memory at [mem 0xc7ef2000-0xc7ef25b0]
[    0.009269] ACPI: Reserving MSDM table memory at [mem 0xc7ef1000-0xc7ef1054]
[    0.009270] ACPI: Reserving SLIC table memory at [mem 0xc7ef0000-0xc7ef0175]
[    0.009271] ACPI: Reserving WSMT table memory at [mem 0xc7eef000-0xc7eef027]
[    0.009271] ACPI: Reserving HPET table memory at [mem 0xc7eed000-0xc7eed037]
[    0.009272] ACPI: Reserving APIC table memory at [mem 0xc7eec000-0xc7eec0bb]
[    0.009273] ACPI: Reserving MCFG table memory at [mem 0xc7eeb000-0xc7eeb03b]
[    0.009274] ACPI: Reserving SSDT table memory at [mem 0xc7ec3000-0xc7ec3199]
[    0.009274] ACPI: Reserving SSDT table memory at [mem 0xc7ec2000-0xc7ec2728]
[    0.009275] ACPI: Reserving SSDT table memory at [mem 0xc7ec1000-0xc7ec13db]
[    0.009276] ACPI: Reserving SSDT table memory at [mem 0xc7ec0000-0xc7ec0e72]
[    0.009276] ACPI: Reserving NHLT table memory at [mem 0xc7ebf000-0xc7ebf02c]
[    0.009277] ACPI: Reserving ASF! table memory at [mem 0xc7ebe000-0xc7ebe0a4]
[    0.009278] ACPI: Reserving FPDT table memory at [mem 0xc7ebd000-0xc7ebd043]
[    0.009279] ACPI: Reserving BGRT table memory at [mem 0xc7efd000-0xc7efd037]
[    0.009280] ACPI: Reserving SSDT table memory at [mem 0xc7efb000-0xc7efb25f]
[    0.009461] No NUMA configuration found
[    0.009462] Faking a node at [mem 0x0000000000000000-0x00000004317fffff]
[    0.009472] NODE_DATA(0) allocated [mem 0x4317d5680-0x4317fffff]
[    0.009638] Zone ranges:
[    0.009639]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.009640]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.009642]   Normal   [mem 0x0000000100000000-0x00000004317fffff]
[    0.009643]   Device   empty
[    0.009644] Movable zone start for each node
[    0.009646] Early memory node ranges
[    0.009646]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.009648]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.009649]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.009649]   node   0: [mem 0x0000000000100000-0x00000000c70fafff]
[    0.009651]   node   0: [mem 0x00000000c7eff000-0x00000000c7efffff]
[    0.009651]   node   0: [mem 0x0000000100000000-0x00000004317fffff]
[    0.009653] Initmem setup node 0 [mem 0x0000000000001000-0x00000004317fffff]
[    0.009658] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009660] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009661] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.009684] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.015727] On node 0, zone DMA32: 3588 pages in unavailable ranges
[    0.040516] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.040788] On node 0, zone Normal: 26624 pages in unavailable ranges
[    0.040798] Reserving Intel graphics memory at [mem 0xca800000-0xcc7fffff]
[    0.040972] ACPI: PM-Timer IO Port: 0x1808
[    0.040981] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.040982] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.040983] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.040984] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.040984] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.040985] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.040986] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.040987] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.041013] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.041016] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041017] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.041022] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041023] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.041029] e820: update [mem 0xb8890000-0xb8897fff] usable ==> reserved
[    0.041040] TSC deadline timer available
[    0.041045] CPU topo: Max. logical packages:   1
[    0.041046] CPU topo: Max. logical dies:       1
[    0.041046] CPU topo: Max. dies per package:   1
[    0.041052] CPU topo: Max. threads per core:   2
[    0.041052] CPU topo: Num. cores per package:     2
[    0.041053] CPU topo: Num. threads per package:   4
[    0.041053] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.041068] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.041070] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.041072] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.041073] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.041075] PM: hibernation: Registered nosave memory: [mem 0xa64ec000-0xa64ecfff]
[    0.041076] PM: hibernation: Registered nosave memory: [mem 0xa64fc000-0xa64fcfff]
[    0.041078] PM: hibernation: Registered nosave memory: [mem 0xb8890000-0xb8897fff]
[    0.041079] PM: hibernation: Registered nosave memory: [mem 0xc70fb000-0xc7c7efff]
[    0.041080] PM: hibernation: Registered nosave memory: [mem 0xc7c7f000-0xc7e7efff]
[    0.041081] PM: hibernation: Registered nosave memory: [mem 0xc7e7f000-0xc7efefff]
[    0.041082] PM: hibernation: Registered nosave memory: [mem 0xc7f00000-0xcc7fffff]
[    0.041083] PM: hibernation: Registered nosave memory: [mem 0xcc800000-0xf80f9fff]
[    0.041083] PM: hibernation: Registered nosave memory: [mem 0xf80fa000-0xf80fafff]
[    0.041084] PM: hibernation: Registered nosave memory: [mem 0xf80fb000-0xf80fcfff]
[    0.041085] PM: hibernation: Registered nosave memory: [mem 0xf80fd000-0xf80fdfff]
[    0.041085] PM: hibernation: Registered nosave memory: [mem 0xf80fe000-0xfdffffff]
[    0.041086] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.041087] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.041088] [mem 0xcc800000-0xf80f9fff] available for PCI devices
[    0.041089] Booting paravirtualized kernel on bare hardware
[    0.041092] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.041101] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.041491] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 u524288
[    0.041498] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=1*2097152
[    0.041500] pcpu-alloc: [0] 0 1 2 3
[    0.041519] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+ root=UUID=9a4e0ebf-a137-44d9-acf0-a4b11d960b86 ro quiet splash
[    0.041592] Unknown kernel command line parameters "splash BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+", will be passed to user space.
[    0.041619] random: crng init done
[    0.041620] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.043545] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.044535] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.044609] Fallback order for Node 0: 0
[    0.044611] Built 1 zonelists, mobility grouping on.  Total pages: 4163737
[    0.044613] Policy zone: Normal
[    0.044619] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.044623] software IO TLB: area num 4.
[    0.105019] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.105042] Kernel/User page tables isolation: enabled
[    0.105073] ftrace: allocating 56697 entries in 222 pages
[    0.131978] ftrace: allocated 222 pages with 6 groups
[    0.132870] Dynamic Preempt: voluntary
[    0.132931] rcu: Preemptible hierarchical RCU implementation.
[    0.132932] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.132933]  Trampoline variant of Tasks RCU enabled.
[    0.132934]  Rude variant of Tasks RCU enabled.
[    0.132934]  Tracing variant of Tasks RCU enabled.
[    0.132935] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.132936] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.132943] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.132945] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.132947] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.136783] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.137009] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.137196] Console: colour dummy device 80x25
[    0.137199] printk: legacy console [tty0] enabled
[    0.137254] ACPI: Core revision 20240827
[    0.137427] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.137464] APIC: Switch to symmetric I/O mode setup
[    0.138665] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.142723] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257a34a6eea, max_idle_ns: 440795264358 ns
[    0.142729] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.98 BogoMIPS (lpj=2599992)
[    0.142751] x86/cpu: VMX (outside TXT) disabled by BIOS
[    0.142753] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.142758] CPU0: Thermal monitoring enabled (TM1)
[    0.142802] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.142804] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
[    0.142808] process: using mwait in idle threads
[    0.142811] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.142814] Spectre V2 : Mitigation: IBRS
[    0.142816] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.142817] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.142818] RETBleed: Mitigation: IBRS
[    0.142820] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.142822] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.142824] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.142831] MDS: Mitigation: Clear CPU buffers
[    0.142833] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.142836] SRBDS: Mitigation: Microcode
[    0.142838] GDS: Vulnerable: No microcode
[    0.142843] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.142845] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.142847] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.142848] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.142850] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.142852] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.142854] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.142856] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.142857] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.143727] Freeing SMP alternatives memory: 48K
[    0.143727] pid_max: default: 32768 minimum: 301
[    0.143727] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,ima,evm
[    0.143727] landlock: Up and running.
[    0.143727] Yama: becoming mindful.
[    0.143727] AppArmor: AppArmor initialized
[    0.143727] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.143727] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.143727] smpboot: CPU0: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz (family: 0x6, model: 0x4e, stepping: 0x3)
[    0.143727] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.143727] ... version:                4
[    0.143727] ... bit width:              48
[    0.143727] ... generic registers:      4
[    0.143727] ... value mask:             0000ffffffffffff
[    0.143727] ... max period:             00007fffffffffff
[    0.143727] ... fixed-purpose events:   3
[    0.143727] ... event mask:             000000070000000f
[    0.143727] signal: max sigframe size: 2032
[    0.143727] Estimated ratio of average max frequency by base frequency (times 1024): 1181
[    0.144711] rcu: Hierarchical SRCU implementation.
[    0.144713] rcu:     Max phase no-delay instances is 400.
[    0.144760] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.145293] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.145349] smp: Bringing up secondary CPUs ...
[    0.145463] smpboot: x86: Booting SMP configuration:
[    0.145464] .... node  #0, CPUs:      #1 #2 #3
[    0.147922] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.147922] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.147922] smp: Brought up 1 node, 4 CPUs
[    0.147922] smpboot: Total of 4 processors activated (20799.93 BogoMIPS)
[    0.148815] Memory: 15693560K/16654948K available (21146K kernel code, 4607K rwdata, 8468K rodata, 5116K init, 4420K bss, 952032K reserved, 0K cma-reserved)
[    0.149275] devtmpfs: initialized
[    0.149275] x86/mm: Memory block size: 128MB
[    0.151126] ACPI: PM: Registering ACPI NVS region [mem 0xc7c7f000-0xc7e7efff] (2097152 bytes)
[    0.151126] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.151126] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.151126] pinctrl core: initialized pinctrl subsystem
[    0.151126] PM: RTC time: 00:19:48, date: 2025-03-14
[    0.152116] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.152416] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.152574] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.152745] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.152781] audit: initializing netlink subsys (disabled)
[    0.152796] audit: type=2000 audit(1741911588.010:1): state=initialized audit_enabled=0 res=1
[    0.152927] thermal_sys: Registered thermal governor 'fair_share'
[    0.152929] thermal_sys: Registered thermal governor 'bang_bang'
[    0.152931] thermal_sys: Registered thermal governor 'step_wise'
[    0.152932] thermal_sys: Registered thermal governor 'user_space'
[    0.152933] thermal_sys: Registered thermal governor 'power_allocator'
[    0.152943] EISA bus registered
[    0.152949] cpuidle: using governor ladder
[    0.152949] cpuidle: using governor menu
[    0.152949] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.152949] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.152949] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for domain 0000 [bus 00-3f]
[    0.152949] PCI: Using configuration type 1 for base access
[    0.153046] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.153773] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.153773] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.153773] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.153773] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.153901] ACPI: Added _OSI(Module Device)
[    0.153901] ACPI: Added _OSI(Processor Device)
[    0.153903] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.153905] ACPI: Added _OSI(Processor Aggregator Device)
[    0.199289] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.201646] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.209877] ACPI: Dynamic OEM Table Load:
[    0.209877] ACPI: SSDT 0xFFFF8BD5C1315800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
[    0.210727] ACPI: Dynamic OEM Table Load:
[    0.210727] ACPI: SSDT 0xFFFF8BD5C1ADB800 000660 (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
[    0.213276] ACPI: Dynamic OEM Table Load:
[    0.213283] ACPI: SSDT 0xFFFF8BD5C0AD9240 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 20121018)
[    0.214709] ACPI: Dynamic OEM Table Load:
[    0.214715] ACPI: SSDT 0xFFFF8BD5C12D3A00 000130 (v02 PmRef  HwpLvt   00003000 INTL 20121018)
[    0.216711] ACPI: Dynamic OEM Table Load:
[    0.216721] ACPI: SSDT 0xFFFF8BD5C1AD9800 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
[    0.218681] ACPI: Dynamic OEM Table Load:
[    0.218688] ACPI: SSDT 0xFFFF8BD5C12D3E00 000119 (v02 PmRef  ApHwp    00003000 INTL 20121018)
[    0.220207] ACPI: Dynamic OEM Table Load:
[    0.220213] ACPI: SSDT 0xFFFF8BD5C12D3000 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
[    0.224540] ACPI: EC: EC started
[    0.224541] ACPI: EC: interrupt blocked
[    3.064032] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    3.064035] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    3.064037] ACPI: Interpreter enabled
[    3.064086] ACPI: PM: (supports S0 S3 S4 S5)
[    3.064087] ACPI: Using IOAPIC for interrupt routing
[    3.066160] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.066162] PCI: Using E820 reservations for host bridge windows
[    3.066903] ACPI: Enabled 8 GPEs in block 00 to 7F
[    3.068707] ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
[    3.069195] ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
[    3.069676] ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
[    3.076929] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
[    3.077217] ACPI: \_SB_.PCI0.RP02.PXP_: New power resource
[    3.193312] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
[    3.193751] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
[    3.194179] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
[    3.194600] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
[    3.195064] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
[    3.195486] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
[    3.195946] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
[    3.196370] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
[    3.196793] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
[    3.197215] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
[    3.197637] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
[    3.198054] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
[    3.198461] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
[    3.198874] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
[    3.199285] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
[    3.199694] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
[    3.200112] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
[    3.200518] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
[    3.200927] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
[    3.216322] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    3.216330] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    3.219482] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
[    3.219485] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.222159] PCI host bridge to bus 0000:00
[    3.222164] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.222167] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.222169] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.222171] pci_bus 0000:00: root bus resource [mem 0xcc800000-0xf7ffffff window]
[    3.222173] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    3.222175] pci_bus 0000:00: root bus resource [bus 00-3e]
[    3.222197] pci 0000:00:00.0: [8086:1904] type 00 class 0x060000 conventional PCI endpoint
[    3.222302] pci 0000:00:02.0: [8086:1916] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    3.222321] pci 0000:00:02.0: BAR 0 [mem 0xe0000000-0xe0ffffff 64bit]
[    3.222324] pci 0000:00:02.0: BAR 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    3.222327] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    3.222342] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.222630] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
[    3.222667] pci 0000:00:14.0: BAR 0 [mem 0xe1220000-0xe122ffff 64bit]
[    3.222705] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    3.223375] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
[    3.223408] pci 0000:00:14.2: BAR 0 [mem 0xe124a000-0xe124afff 64bit]
[    3.223553] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
[    3.223727] pci 0000:00:15.0: BAR 0 [mem 0xe124b000-0xe124bfff 64bit]
[    3.224228] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000 conventional PCI endpoint
[    3.224261] pci 0000:00:16.0: BAR 0 [mem 0xe124c000-0xe124cfff 64bit]
[    3.224295] pci 0000:00:16.0: PME# supported from D3hot
[    3.224589] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601 conventional PCI endpoint
[    3.224622] pci 0000:00:17.0: BAR 0 [mem 0xe1248000-0xe1249fff]
[    3.224625] pci 0000:00:17.0: BAR 1 [mem 0xe124f000-0xe124f0ff]
[    3.224627] pci 0000:00:17.0: BAR 2 [io  0x3080-0x3087]
[    3.224630] pci 0000:00:17.0: BAR 3 [io  0x3088-0x308b]
[    3.224632] pci 0000:00:17.0: BAR 4 [io  0x3040-0x305f]
[    3.224635] pci 0000:00:17.0: BAR 5 [mem 0xe124d000-0xe124d7ff]
[    3.224670] pci 0000:00:17.0: PME# supported from D3hot
[    3.225024] pci 0000:00:1c.0: [8086:9d11] type 01 class 0x060400 PCIe Root Port
[    3.225043] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.225049] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    3.225108] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.225863] pci 0000:00:1c.3: [8086:9d13] type 01 class 0x060400 PCIe Root Port
[    3.225882] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    3.225887] pci 0000:00:1c.3:   bridge window [mem 0xe1100000-0xe11fffff]
[    3.225944] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    3.226685] pci 0000:00:1f.0: [8086:9d48] type 00 class 0x060100 conventional PCI endpoint
[    3.227037] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
[    3.227075] pci 0000:00:1f.2: BAR 0 [mem 0xe1240000-0xe1243fff]
[    3.227371] pci 0000:00:1f.3: [8086:9d70] type 00 class 0x040380 conventional PCI endpoint
[    3.227417] pci 0000:00:1f.3: BAR 0 [mem 0xe1244000-0xe1247fff 64bit]
[    3.227424] pci 0000:00:1f.3: BAR 4 [mem 0xe1230000-0xe123ffff 64bit]
[    3.227466] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    3.227975] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
[    3.228100] pci 0000:00:1f.4: BAR 0 [mem 0xe124e000-0xe124e0ff 64bit]
[    3.228111] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    3.228429] pci 0000:00:1f.6: [8086:1570] type 00 class 0x020000 conventional PCI endpoint
[    3.228475] pci 0000:00:1f.6: BAR 0 [mem 0xe1200000-0xe121ffff]
[    3.228526] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    3.228882] pci 0000:01:00.0: [10ec:522a] type 00 class 0xff0000 PCIe Endpoint
[    3.228937] pci 0000:01:00.0: BAR 0 [mem 0xe1000000-0xe1000fff]
[    3.229043] pci 0000:01:00.0: supports D1 D2
[    3.229045] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    3.229593] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.229702] pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000 PCIe Endpoint
[    3.229804] pci 0000:02:00.0: BAR 0 [mem 0xe1100000-0xe1101fff 64bit]
[    3.229971] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    3.230597] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    3.233887] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    3.233962] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.234035] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.234111] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.234184] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    3.234256] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    3.234329] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    3.234402] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    3.235464] ACPI: EC: interrupt unblocked
[    3.235466] ACPI: EC: event unblocked
[    3.235471] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    3.235473] ACPI: EC: GPE=0x6e
[    3.235475] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    3.235477] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    3.235554] iommu: Default domain type: Translated
[    3.235554] iommu: DMA domain TLB invalidation policy: lazy mode
[    3.235554] SCSI subsystem initialized
[    3.235759] libata version 3.00 loaded.
[    3.235759] ACPI: bus type USB registered
[    3.235773] usbcore: registered new interface driver usbfs
[    3.235779] usbcore: registered new interface driver hub
[    3.235785] usbcore: registered new device driver usb
[    3.235811] pps_core: LinuxPPS API ver. 1 registered
[    3.235813] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.235816] PTP clock support registered
[    3.235830] EDAC MC: Ver: 3.0.0
[    3.235902] efivars: Registered efivars operations
[    3.236738] NetLabel: Initializing
[    3.236739] NetLabel:  domain hash size = 128
[    3.236741] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    3.236760] NetLabel:  unlabeled traffic allowed by default
[    3.236778] mctp: management component transport protocol core
[    3.236778] NET: Registered PF_MCTP protocol family
[    3.236778] PCI: Using ACPI for IRQ routing
[    3.243579] PCI: pci_cache_line_size set to 64 bytes
[    3.243673] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    3.243675] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    3.243677] e820: reserve RAM buffer [mem 0xa64ec018-0xa7ffffff]
[    3.243679] e820: reserve RAM buffer [mem 0xb8890000-0xbbffffff]
[    3.243680] e820: reserve RAM buffer [mem 0xc70fb000-0xc7ffffff]
[    3.243682] e820: reserve RAM buffer [mem 0xc7f00000-0xc7ffffff]
[    3.243683] e820: reserve RAM buffer [mem 0x431800000-0x433ffffff]
[    3.243735] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    3.243737] pci 0000:00:02.0: vgaarb: bridge control possible
[    3.243739] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.243744] vgaarb: loaded
[    3.243798] clocksource: Switched to clocksource tsc-early
[    3.244507] VFS: Disk quotas dquot_6.6.0
[    3.244524] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.244705] AppArmor: AppArmor Filesystem Enabled
[    3.244745] pnp: PnP ACPI init
[    3.244956] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    3.244960] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    3.244962] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    3.244965] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    3.244967] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    3.245343] system 00:01: [io  0x2000-0x20fe] has been reserved
[    3.245518] system 00:02: [io  0x0680-0x069f] has been reserved
[    3.245521] system 00:02: [io  0xffff] has been reserved
[    3.245523] system 00:02: [io  0xffff] has been reserved
[    3.245525] system 00:02: [io  0xffff] has been reserved
[    3.245527] system 00:02: [io  0x1800-0x18fe] has been reserved
[    3.245529] system 00:02: [io  0x164e-0x164f] has been reserved
[    3.245699] system 00:04: [io  0x1854-0x1857] has been reserved
[    3.245827] system 00:07: [io  0x0200-0x023f] has been reserved
[    3.245830] system 00:07: [mem 0xfedf0000-0xfedfffff] has been reserved
[    3.247362] system 00:08: [mem 0xfe031000-0xfe031fff] has been reserved
[    3.247365] system 00:08: [mem 0xfe030008-0xfe030fff] has been reserved
[    3.247918] system 00:09: [mem 0xfe030000-0xfe030007] has been reserved
[    3.248276] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    3.248278] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    3.248280] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    3.248283] system 00:0a: [mem 0xf8000000-0xfbffffff] could not be reserved
[    3.248285] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    3.248287] system 00:0a: [mem 0xfed90000-0xfed93fff] has been reserved
[    3.248288] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    3.248291] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    3.248293] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    3.248294] system 00:0a: [mem 0xcc800000-0xcc81ffff] has been reserved
[    3.248740] pnp: PnP ACPI: found 12 devices
[    3.254844] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.254909] NET: Registered PF_INET protocol family
[    3.255071] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    3.257916] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    3.257953] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.258029] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    3.258272] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    3.258536] TCP: Hash tables configured (established 131072 bind 65536)
[    3.258639] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    3.258711] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    3.258827] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    3.258947] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.258958] NET: Registered PF_XDP protocol family
[    3.258966] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    3.258971] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    3.258992] pci 0000:00:1c.0: bridge window [mem 0xcc900000-0xccafffff 64bit pref]: assigned
[    3.258996] pci 0000:00:1c.0: bridge window [io  0x4000-0x4fff]: assigned
[    3.259000] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.259003] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    3.259007] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    3.259010] pci 0000:00:1c.0:   bridge window [mem 0xcc900000-0xccafffff 64bit pref]
[    3.259015] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    3.259019] pci 0000:00:1c.3:   bridge window [mem 0xe1100000-0xe11fffff]
[    3.259026] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.259028] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.259030] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.259032] pci_bus 0000:00: resource 7 [mem 0xcc800000-0xf7ffffff window]
[    3.259034] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    3.259036] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    3.259038] pci_bus 0000:01: resource 1 [mem 0xe1000000-0xe10fffff]
[    3.259040] pci_bus 0000:01: resource 2 [mem 0xcc900000-0xccafffff 64bit pref]
[    3.259042] pci_bus 0000:02: resource 1 [mem 0xe1100000-0xe11fffff]
[    3.259588] PCI: CLS 0 bytes, default 64
[    3.259640] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
[    3.259775] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
[    3.259913] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.259914] software IO TLB: mapped [mem 0x00000000b3e88000-0x00000000b7e88000] (64MB)
[    3.259992] Trying to unpack rootfs image as initramfs...
[    3.263184] Initialise system trusted keyrings
[    3.263196] Key type blacklist registered
[    3.263259] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    3.263283] zbud: loaded
[    3.263668] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.263784] fuse: init (API version 7.42)
[    3.263945] integrity: Platform Keyring initialized
[    3.263952] integrity: Machine keyring initialized
[    3.281540] Key type asymmetric registered
[    3.281545] Asymmetric key parser 'x509' registered
[    3.281576] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    3.281652] io scheduler mq-deadline registered
[    3.284000] ledtrig-cpu: registered to indicate activity on CPUs
[    3.284344] pcieport 0000:00:1c.0: PME: Signaling with IRQ 120
[    3.284442] pcieport 0000:00:1c.0: AER: enabled with IRQ 120
[    3.284472] pcieport 0000:00:1c.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    3.284868] pcieport 0000:00:1c.3: PME: Signaling with IRQ 121
[    3.284936] pcieport 0000:00:1c.3: AER: enabled with IRQ 121
[    3.285056] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.285888] ACPI: AC: AC Adapter [AC] (on-line)
[    3.285976] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    3.286004] ACPI: button: Sleep Button [SLPB]
[    3.286044] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    3.286069] ACPI: button: Lid Switch [LID]
[    3.286112] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.286160] ACPI: button: Power Button [PWRF]
[    3.295202] thermal LNXTHERM:00: registered as thermal_zone0
[    3.295207] ACPI: thermal: Thermal Zone [CPUZ] (46 C)
[    3.299002] thermal LNXTHERM:01: registered as thermal_zone1
[    3.299006] ACPI: thermal: Thermal Zone [GFXZ] (0 C)
[    3.301917] thermal LNXTHERM:02: registered as thermal_zone2
[    3.301920] ACPI: thermal: Thermal Zone [EXTZ] (33 C)
[    3.305834] thermal LNXTHERM:03: registered as thermal_zone3
[    3.305837] ACPI: thermal: Thermal Zone [LOCZ] (32 C)
[    3.308782] thermal LNXTHERM:04: registered as thermal_zone4
[    3.308785] ACPI: thermal: Thermal Zone [BATZ] (28 C)
[    3.309267] thermal LNXTHERM:05: registered as thermal_zone5
[    3.309270] ACPI: thermal: Thermal Zone [PCHZ] (127 C)
[    3.309555] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.312110] hpet_acpi_add: no address or irqs in _CRS
[    3.312144] Linux agpgart interface v0.103
[    3.314675] tpm_tis 00:0b: 1.2 TPM (device-id 0x1B, rev-id 16)
[    3.324191] ACPI: battery: Slot [BAT0] (battery present)
[    3.327649] tpm tpm0: TPM is disabled/deactivated (0x7)
[    3.327661] tpm tpm0: tpm_read_log_acpi: TCPA log area empty
[    3.328015] ACPI: bus type drm_connector registered
[    3.329818] loop: module loaded
[    3.330127] tun: Universal TUN/TAP device driver, 1.6
[    3.330172] PPP generic driver version 2.4.2
[    3.330469] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.330476] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.331552] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    3.332013] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.332017] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.332020] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    3.332061] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.14
[    3.332064] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.332066] usb usb1: Product: xHCI Host Controller
[    3.332068] usb usb1: Manufacturer: Linux 6.14.0-rc6+ xhci-hcd
[    3.332069] usb usb1: SerialNumber: 0000:00:14.0
[    3.332209] hub 1-0:1.0: USB hub found
[    3.332226] hub 1-0:1.0: 12 ports detected
[    3.333215] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.14
[    3.333219] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.333221] usb usb2: Product: xHCI Host Controller
[    3.333222] usb usb2: Manufacturer: Linux 6.14.0-rc6+ xhci-hcd
[    3.333224] usb usb2: SerialNumber: 0000:00:14.0
[    3.333323] hub 2-0:1.0: USB hub found
[    3.333335] hub 2-0:1.0: 6 ports detected
[    3.333737] usb: port power management may be unreliable
[    3.334113] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    3.335400] i8042: Detected active multiplexing controller, rev 1.1
[    3.335637] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.335643] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.335674] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.335694] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.335714] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.335822] mousedev: PS/2 mouse device common for all mice
[    3.335962] rtc_cmos 00:03: RTC can wake from S4
[    3.336669] rtc_cmos 00:03: registered as rtc0
[    3.336797] rtc_cmos 00:03: setting system clock to 2025-03-14T00:19:51 UTC (1741911591)
[    3.336827] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
[    3.336838] i2c_dev: i2c /dev entries driver
[    3.336926] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    3.336949] device-mapper: uevent: version 1.0.3
[    3.336996] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised: dm-devel@lists.linux.dev
[    3.337021] platform eisa.0: Probing EISA bus 0
[    3.337023] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    3.337025] platform eisa.0: Cannot allocate resource for EISA slot 1
[    3.337027] platform eisa.0: Cannot allocate resource for EISA slot 2
[    3.337028] platform eisa.0: Cannot allocate resource for EISA slot 3
[    3.337030] platform eisa.0: Cannot allocate resource for EISA slot 4
[    3.337031] platform eisa.0: Cannot allocate resource for EISA slot 5
[    3.337033] platform eisa.0: Cannot allocate resource for EISA slot 6
[    3.337034] platform eisa.0: Cannot allocate resource for EISA slot 7
[    3.337036] platform eisa.0: Cannot allocate resource for EISA slot 8
[    3.337037] platform eisa.0: EISA: Detected 0 cards
[    3.337041] intel_pstate: Intel P-state driver initializing
[    3.337166] intel_pstate: HWP enabled
[    3.337352] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    3.338230] fbcon: Deferring console take-over
[    3.338234] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    3.338312] drop_monitor: Initializing network drop monitor service
[    3.338428] NET: Registered PF_INET6 protocol family
[    3.351620] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    3.566650] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    3.701033] usb 1-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.02
[    3.701054] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.701056] usb 1-2: Product: USB2.1 Hub
[    3.701058] usb 1-2: Manufacturer: Generic
[    3.702522] hub 1-2:1.0: USB hub found
[    3.703561] hub 1-2:1.0: 4 ports detected
[    3.807349] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    3.829457] usb 2-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.02
[    3.829463] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.829479] usb 2-2: Product: USB3.2 Hub
[    3.829481] usb 2-2: Manufacturer: Generic
[    3.833565] hub 2-2:1.0: USB hub found
[    3.834958] hub 2-2:1.0: 4 ports detected
[    3.935651] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    4.060885] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.01
[    4.060891] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.125684] usb 2-2.4: new SuperSpeed USB device number 3 using xhci_hcd
[    4.137296] usb 2-2.4: New USB device found, idVendor=2357, idProduct=0601, bcdDevice=30.00
[    4.137302] usb 2-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    4.137304] usb 2-2.4: Product: USB 10/100/1000 LAN
[    4.137306] usb 2-2.4: Manufacturer: TP-Link
[    4.137308] usb 2-2.4: SerialNumber: 000001
[    4.248651] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    4.270875] tsc: Refined TSC clocksource calibration: 2592.000 MHz
[    4.270883] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x255cb6cc5db, max_idle_ns: 440795203504 ns
[    4.270933] clocksource: Switched to clocksource tsc
[    4.372967] usb 1-8: New USB device found, idVendor=138a, idProduct=003f, bcdDevice= 1.04
[    4.372973] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    4.372976] usb 1-8: SerialNumber: 00a0d4e211a3
[    4.486656] usb 1-9: new high-speed USB device number 5 using xhci_hcd
[    4.640430] usb 1-9: New USB device found, idVendor=04f2, idProduct=b51d, bcdDevice=99.06
[    4.640437] usb 1-9: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    4.640439] usb 1-9: Product: HP HD Camera
[    4.640441] usb 1-9: Manufacturer: Generic
[    4.640442] usb 1-9: SerialNumber: 200901010001
[    6.591447] Freeing initrd memory: 549484K
[    6.599248] Segment Routing with IPv6
[    6.599282] In-situ OAM (IOAM) with IPv6
[    6.599338] NET: Registered PF_PACKET protocol family
[    6.599413] Key type dns_resolver registered
[    6.599771] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    6.599860] microcode: Current revision: 0x000000f0
[    6.599863] microcode: Updated early from: 0x000000c2
[    6.600065] IPI shorthand broadcast: enabled
[    6.602002] sched_clock: Marking stable (6596001267, 5593406)->(6678254712, -76660039)
[    6.602192] registered taskstats version 1
[    6.602331] Loading compiled-in X.509 certificates
[    6.602915] Loaded X.509 cert 'Build time autogenerated kernel key: 60c89a582e12fd4b78574273b3a1a97b9e7d33ec'
[    6.607427] Demotion targets for Node 0: null
[    6.607501] Key type .fscrypt registered
[    6.607503] Key type fscrypt-provisioning registered
[    6.607541] Key type trusted registered
[    6.625241] Key type encrypted registered
[    6.625247] AppArmor: AppArmor sha256 policy hashing enabled
[    6.625787] Loading compiled-in module X.509 certificates
[    6.626286] Loaded X.509 cert 'Build time autogenerated kernel key: 60c89a582e12fd4b78574273b3a1a97b9e7d33ec'
[    6.626289] ima: Allocated hash algorithm: sha256
[    6.628725] ima: Error Communicating to TPM chip
[    6.631826] ima: Error Communicating to TPM chip
[    6.634746] ima: Error Communicating to TPM chip
[    6.637449] ima: Error Communicating to TPM chip
[    6.639770] ima: Error Communicating to TPM chip
[    6.642675] ima: Error Communicating to TPM chip
[    6.645379] ima: Error Communicating to TPM chip
[    6.647842] ima: Error Communicating to TPM chip
[    6.651763] ima: No architecture policies found
[    6.651788] evm: Initialising EVM extended attributes:
[    6.651790] evm: security.selinux
[    6.651791] evm: security.SMACK64
[    6.651793] evm: security.SMACK64EXEC
[    6.651794] evm: security.SMACK64TRANSMUTE
[    6.651796] evm: security.SMACK64MMAP
[    6.651797] evm: security.apparmor
[    6.651798] evm: security.ima
[    6.651799] evm: security.capability
[    6.651801] evm: HMAC attrs: 0x1
[    6.652127] PM:   Magic number: 1:301:304
[    6.652167] tty tty33: hash matches
[    6.652511] RAS: Correctable Errors collector initialized.
[    6.652546] clk: Disabling unused clocks
[    6.652548] PM: genpd: Disabling unused power domains
[    6.653966] Freeing unused decrypted memory: 2028K
[    6.655038] Freeing unused kernel image (initmem) memory: 5116K
[    6.655186] Write protecting the kernel read-only data: 32768k
[    6.656019] Freeing unused kernel image (text/rodata gap) memory: 1380K
[    6.656725] Freeing unused kernel image (rodata/data gap) memory: 1772K
[    6.713313] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.713315] x86/mm: Checking user space page tables
[    6.762822] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.762830] Run /init as init process
[    6.762832]   with arguments:
[    6.762834]     /init
[    6.762835]     splash
[    6.762837]   with environment:
[    6.762838]     HOME=/
[    6.762839]     TERM=linux
[    6.762840]     BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+
[    6.970962] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.970974] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.970981] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.970987] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.970993] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.970999] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971011] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971017] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971023] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971039] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971046] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971052] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971098] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971104] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971125] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971131] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971137] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971143] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971150] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971162] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971168] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971174] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971180] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971186] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971202] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971218] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971234] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971241] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971253] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971259] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971271] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971277] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971284] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971290] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971329] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971336] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971516] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971529] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971541] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971553] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971581] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971588] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971611] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971618] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971625] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971631] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    6.971638] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
[    7.028647] ahci 0000:00:17.0: version 3.0
[    7.029028] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
[    7.031494] wmi_bus wmi_bus-PNP0C14:00: [Firmware Info]: DF4E63B6-3BBC-4858-9737-C74F82F821F3 has zero instances
[    7.031550] wmi_bus wmi_bus-PNP0C14:00: [Firmware Info]: 8F1F6436-9F42-42C8-BADC-0E9424F20C9A has zero instances
[    7.031672] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    7.041271] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    7.041561] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    7.043929] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[    7.043935] ahci 0000:00:17.0: 2/2 ports implemented (port mask 0x5)
[    7.043937] ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst
[    7.047944] scsi host0: ahci
[    7.057581] scsi host1: ahci
[    7.060841] usbcore: registered new device driver r8152-cfgselector
[    7.061671] scsi host2: ahci
[    7.061783] ata1: SATA max UDMA/133 abar m2048@0xe124d000 port 0xe124d100 irq 123 lpm-pol 3
[    7.061787] ata2: DUMMY
[    7.061792] ata3: SATA max UDMA/133 abar m2048@0xe124d000 port 0xe124d200 irq 123 lpm-pol 3
[    7.080623] e1000e: Intel(R) PRO/1000 Network Driver
[    7.080629] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.080965] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    7.155735] r8152-cfgselector 2-2.4: reset SuperSpeed USB device number 3 using xhci_hcd
[    7.217365] r8152 2-2.4:1.0 eth0: v1.12.13
[    7.217435] usbcore: registered new interface driver r8152
[    7.268042] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    7.331249] e1000e 0000:00:1f.6 eth1: (PCI Express:2.5GT/s:Width x1) 10:62:e5:55:85:e5
[    7.331264] e1000e 0000:00:1f.6 eth1: Intel(R) PRO/1000 Network Connection
[    7.331349] e1000e 0000:00:1f.6 eth1: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    7.372699] ata1: SATA link down (SStatus 4 SControl 300)
[    7.677313] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    7.678549] ata3.00: Model 'SanDisk SD9SN8W-512G-1006', rev 'X6103006', applying quirks: maxtrim128m
[    7.678885] ata3.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    7.678903] ata3.00: ATA-11: SanDisk SD9SN8W-512G-1006, X6103006, max UDMA/100
[    7.679126] ata3.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    7.684235] ata3.00: Features: Dev-Sleep
[    7.685890] ata3.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
[    7.692515] ata3.00: configured for UDMA/100
[    7.703193] scsi 2:0:0:0: Direct-Access     ATA      SanDisk SD9SN8W- 3006 PQ: 0 ANSI: 5
[    7.704259] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    7.704319] sd 2:0:0:0: [sda] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
[    7.704332] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    7.704371] sd 2:0:0:0: [sda] Write Protect is off
[    7.704382] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.704437] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.704533] sd 2:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    7.715347]  sda: sda1 sda2
[    7.715859] sd 2:0:0:0: [sda] Attached SCSI disk
[    7.725189] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth1
[    7.730092] usbcore: registered new interface driver cdc_ether
[    7.740420] r8152 2-2.4:1.0 enx1c61b47b81ad: renamed from eth0
[    7.775998] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input9
[    7.920366] EXT4-fs (sda2): mounted filesystem 9a4e0ebf-a137-44d9-acf0-a4b11d960b86 ro with ordered data mode. Quota mode: none.
[    8.305037] systemd[1]: Inserted module 'autofs4'
[    8.438994] systemd[1]: systemd 255.4-1ubuntu8.4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    8.439026] systemd[1]: Detected architecture x86-64.
[    8.442342] systemd[1]: Hostname set to <TAO-BU2-S1-Laptop-Steven-2>.
[    8.511405] psmouse serio3: synaptics: queried max coordinates: x [..5670], y [..4758]
[    8.541125] psmouse serio3: synaptics: queried min coordinates: x [1360..], y [1198..]
[    8.541152] psmouse serio3: synaptics: Your touchpad (PNP: SYN3037 SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    8.583886] systemd[1]: Configuration file /run/systemd/system/netplan-ovs-cleanup.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    8.595349] psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3139, fw id: 2000742
[    8.630331] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input10
[    8.733673] systemd[1]: Queued start job for default target graphical.target.
[    8.755122] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[    8.755686] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[    8.756052] systemd[1]: Created slice user.slice - User and Session Slice.
[    8.756134] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[    8.756355] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[    8.756392] systemd[1]: Expecting device dev-disk-by\x2duuid-48C2\x2dF089.device - /dev/disk/by-uuid/48C2-F089...
[    8.756417] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[    8.756445] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[    8.756456] systemd[1]: Reached target slices.target - Slice Units.
[    8.756469] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
[    8.756495] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[    8.756735] systemd[1]: Listening on syslog.socket - Syslog Socket.
[    8.756853] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[    8.756919] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[    8.757046] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    8.757199] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[    8.757402] systemd[1]: Listening on systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
[    8.757434] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    8.757824] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    8.757966] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    8.759555] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[    8.760502] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[    8.762019] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[    8.765704] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[    8.770817] systemd[1]: Starting systemd-journald.service - Journal Service...
[    8.772748] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
[    8.773935] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    8.775545] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[    8.780174] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
[    8.782460] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[    8.784528] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
[    8.786221] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[    8.789900] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
[    8.790097] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
[    8.792281] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    8.792314] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    8.794075] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[    8.794186] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    8.797079] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[    8.799575] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[    8.801610] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[    8.801879] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[    8.802153] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[    8.802671] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[    8.803228] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    8.803454] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[    8.805334] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
[    8.807099] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[    8.810189] systemd-journald[277]: Collecting audit messages is disabled.
[    8.816267] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
[    8.819584] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    8.819917] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[    8.824488] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    8.824735] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
[    8.827646] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    8.827873] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[    8.828083] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[    8.831310] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    8.831521] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[    8.836742] pstore: Using crash dump compression: deflate
[    8.837821] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
[    8.851830] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
[    8.852331] lp: driver loaded but no devices found
[    8.868017] EXT4-fs (sda2): re-mounted 9a4e0ebf-a137-44d9-acf0-a4b11d960b86 r/w. Quota mode: none.
[    8.872865] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
[    8.882611] ppdev: user-space parallel port driver
[    8.884072] systemd[1]: Activating swap swap.img.swap - /swap.img...
[    8.884910] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
[    8.887851] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
[    8.888047] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    8.900176] pstore: Registered efi_pstore as persistent store backend
[    8.901116] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
[    8.901335] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
[    8.901592] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
[    8.905188] Adding 4194300k swap on /swap.img.  Priority:-2 extents:33 across:4587520k SS
[    8.910864] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[    8.911075] systemd[1]: Activated swap swap.img.swap - /swap.img.
[    8.911471] systemd[1]: Reached target swap.target - Swaps.
[    8.911568] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
[    8.915775] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[    8.925464] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
[    8.934432] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
[    8.935009] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
[    8.956864] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
[    8.966835] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
[    8.967251] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
[    8.967399] systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
[    8.974191] systemd[1]: Mounting snap-bare-5.mount - Mount unit for bare, revision 5...
[    8.978699] systemd[1]: Mounting snap-core22-1380.mount - Mount unit for core22, revision 1380...
[    8.982747] systemd[1]: Mounting snap-firefox-4173.mount - Mount unit for firefox, revision 4173...
[    8.986139] systemd[1]: Mounting snap-firmware\x2dupdater-127.mount - Mount unit for firmware-updater, revision 127...
[    8.989775] systemd[1]: Mounting snap-gnome\x2d42\x2d2204-176.mount - Mount unit for gnome-42-2204, revision 176...
[    8.991092] loop0: detected capacity change from 0 to 8
[    8.991868] systemd[1]: Mounting snap-gtk\x2dcommon\x2dthemes-1535.mount - Mount unit for gtk-common-themes, revision 1535...
[    8.993797] systemd[1]: Mounting snap-snap\x2dstore-1124.mount - Mount unit for snap-store, revision 1124...
[    8.998747] systemd[1]: Mounting snap-snapd-21465.mount - Mount unit for snapd, revision 21465...
[    9.001838] systemd[1]: Mounting snap-snapd\x2ddesktop\x2dintegration-157.mount - Mount unit for snapd-desktop-integration, revision 157...
[    9.006257] loop1: detected capacity change from 0 to 552192
[    9.007938] systemd[1]: Mounting var-snap-firefox-common-host\x2dhunspell.mount - Mount unit for firefox, revision 4173 via mount-control...
[    9.008477] loop2: detected capacity change from 0 to 187776
[    9.010265] systemd[1]: Started systemd-journald.service - Journal Service.
[    9.012832] loop3: detected capacity change from 0 to 1034424
[    9.013058] loop4: detected capacity change from 0 to 21136
[    9.017469] loop5: detected capacity change from 0 to 152040
[    9.017966] loop6: detected capacity change from 0 to 21952
[    9.024674] loop7: detected capacity change from 0 to 952
[    9.026062] loop8: detected capacity change from 0 to 79328
[    9.068137] systemd-journald[277]: Received client request to flush runtime journal.
[    9.086357] systemd-journald[277]: /var/log/journal/e454872f0a7240d09e0b415a13f53b77/system.journal: Journal file uses a different sequence number ID, rotating.
[    9.086366] systemd-journald[277]: Rotating system journal.
[    9.536022] input: Wireless hotkeys as /devices/virtual/input/input12
[    9.574716] intel_pmc_core INT33A1:00:  initialized
[    9.651787] hp_accel: hardware type HPB64xx found
[    9.697881] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    9.732335] mc: Linux media interface: v0.10
[    9.760299] lis3lv02d: 8 bits 3DC sensor found
[    9.779636] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    9.779886] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    9.780433] ACPI Error: Needed [Buffer/String/Package], found [Integer] 000000006b67ca40 (20240827/exresop-557)
[    9.780446] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20240827/dswexec-433)

[    9.780459]
               Initialized Local Variables for Method [WVPO]:
[    9.780462]   Local1: 00000000a7b98880 <Obj>           Buffer(12) 00 00 00 00 00 00 00 00

[    9.780485] Initialized Arguments for Method [WVPO]:  (2 arguments defined for method invocation)
[    9.780487]   Arg0:   00000000e11a33f3 <Obj>           Integer 0000000000000004
[    9.780495]   Arg1:   000000006b67ca40 <Obj>           Integer 0000000000000000

[    9.780507] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.780521] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.785504] ACPI Error: Needed [Buffer/String/Package], found [Integer] 000000002318a38c (20240827/exresop-557)
[    9.785533] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20240827/dswexec-433)

[    9.785546]
               Initialized Local Variables for Method [WVPO]:
[    9.785548]   Local1: 00000000551b3f05 <Obj>           Buffer(12) 00 00 00 00 00 00 00 00

[    9.785569] Initialized Arguments for Method [WVPO]:  (2 arguments defined for method invocation)
[    9.785572]   Arg0:   000000007e8fef5c <Obj>           Integer 0000000000000004
[    9.785580]   Arg1:   000000002318a38c <Obj>           Integer 0000000000000000

[    9.785593] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.785661] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.787967] i2c i2c-1: Successfully instantiated SPD at 0x50
[    9.790783] ACPI Error: Needed [Buffer/String/Package], found [Integer] 000000005a0ed2a3 (20240827/exresop-557)
[    9.791137] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20240827/dswexec-433)

[    9.791154]
               Initialized Local Variables for Method [WVPO]:
[    9.791156]   Local1: 00000000f362aaf8 <Obj>           Buffer(136) 00 00 00 00 00 00 00 00

[    9.791180] Initialized Arguments for Method [WVPO]:  (2 arguments defined for method invocation)
[    9.791183]   Arg0:   00000000ffdaec64 <Obj>           Integer 0000000000000080
[    9.791192]   Arg1:   000000005a0ed2a3 <Obj>           Integer 0000000000000000

[    9.791207] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.791224] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.791337] input: HP WMI hotkeys as /devices/virtual/input/input13
[    9.795575] ACPI Error: Needed [Buffer/String/Package], found [Integer] 00000000c2f98307 (20240827/exresop-557)
[    9.796615] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20240827/dswexec-433)

[    9.796631]
               Initialized Local Variables for Method [WVPO]:
[    9.796633]   Local1: 00000000a635da8f <Obj>           Buffer(136) 00 00 00 00 00 00 00 00

[    9.796654] Initialized Arguments for Method [WVPO]:  (2 arguments defined for method invocation)
[    9.796656]   Arg0:   000000001cabc09b <Obj>           Integer 0000000000000080
[    9.796665]   Arg1:   00000000c2f98307 <Obj>           Integer 0000000000000000

[    9.796677] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.796691] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20240827/psparse-529)
[    9.816147] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    9.816153] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    9.816155] RAPL PMU: hw unit of domain package 2^-14 Joules
[    9.816157] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    9.816159] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    9.882344] videodev: Linux video capture interface: v2.00
[    9.885488] Bluetooth: Core ver 2.22
[    9.885517] NET: Registered PF_BLUETOOTH protocol family
[    9.885519] Bluetooth: HCI device and connection manager initialized
[    9.885524] Bluetooth: HCI socket layer initialized
[    9.885526] Bluetooth: L2CAP socket layer initialized
[    9.885532] Bluetooth: SCO socket layer initialized
[    9.917945] cryptd: max_cpu_qlen set to 1000
[    9.941712] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input14
[    9.973688] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    9.975096] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.975329] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   10.025348] AES CTR mode by8 optimization enabled
[   10.043467] usbcore: registered new interface driver btusb
[   10.046637] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[   10.053703] Bluetooth: hci0: Device revision is 5
[   10.053710] Bluetooth: hci0: Secure boot is enabled
[   10.053712] Bluetooth: hci0: OTP lock is enabled
[   10.053714] Bluetooth: hci0: API lock is enabled
[   10.053717] Bluetooth: hci0: Debug lock is disabled
[   10.053719] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.078485] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[   10.094653] ee1004 1-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[   10.131919] Intel(R) Wireless WiFi driver for Linux
[   10.134013] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[   10.155564] iwlwifi 0000:02:00.0: Detected crf-id 0xbadcafe, cnv-id 0x3000000 wfpm id 0x80000000
[   10.155586] iwlwifi 0000:02:00.0: PCI dev 24f3/1010, rev=0x201, rfid=0xd55555d5
[   10.155592] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 8260
[   10.177329] iwlwifi 0000:02:00.0: loaded firmware version 36.ca7b901d.0 8000C-36.ucode op_mode iwlmvm
[   10.197727] usb 1-9: Found UVC 1.00 device HP HD Camera (04f2:b51d)
[   10.207361] usbcore: registered new interface driver uvcvideo
[   10.222386] audit: type=1400 audit(1741911598.384:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=552 comm="apparmor_parser"
[   10.224183] audit: type=1400 audit(1741911598.385:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=550 comm="apparmor_parser"
[   10.224192] audit: type=1400 audit(1741911598.386:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=553 comm="apparmor_parser"
[   10.224254] audit: type=1400 audit(1741911598.386:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=551 comm="apparmor_parser"
[   10.229615] audit: type=1400 audit(1741911598.391:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=576 comm="apparmor_parser"
[   10.230371] audit: type=1400 audit(1741911598.392:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=575 comm="apparmor_parser"
[   10.232344] audit: type=1400 audit(1741911598.394:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=577 comm="apparmor_parser"
[   10.234397] intel_tcc_cooling: Programmable TCC Offset detected
[   10.236514] audit: type=1400 audit(1741911598.398:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=578 comm="apparmor_parser"
[   10.237133] audit: type=1400 audit(1741911598.399:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=581 comm="apparmor_parser"
[   10.237170] audit: type=1400 audit(1741911598.399:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=583 comm="apparmor_parser"
[   10.379877] intel_rapl_common: Found RAPL domain package
[   10.379889] intel_rapl_common: Found RAPL domain core
[   10.381718] intel_rapl_common: Found RAPL domain uncore
[   10.381731] intel_rapl_common: Found RAPL domain psys
[   10.459558] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   11.016531] iwlwifi 0000:02:00.0: base HW address: 7c:76:35:01:12:24, OTP minor version: 0x0
[   11.396797] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   11.443205] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   11.705752] Bluetooth: hci0: Waiting for firmware download to complete
[   11.706621] Bluetooth: hci0: Firmware loaded in 1589970 usecs
[   11.706681] Bluetooth: hci0: Waiting for device to boot
[   11.718626] Bluetooth: hci0: Device booted in 11695 usecs
[   11.719022] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[   11.722625] Bluetooth: hci0: Applying Intel DDC parameters completed
[   11.723632] Bluetooth: hci0: Firmware revision 0.0 build 14 week 44 2021
[   11.725616] Bluetooth: hci0: Reading supported features failed (-16)
[   11.725623] Bluetooth: hci0: Error reading debug features
[   11.725629] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
[   12.005097] i915 0000:00:02.0: [drm] Found skylake/ult (device ID 1916) integrated display version 9.00 stepping H0
[   12.021776] i915 0000:00:02.0: vgaarb: deactivate vga console
[   12.026105] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   12.028192] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
[   13.099856] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[   13.103363] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   13.103685] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input15
[   13.122940] fbcon: i915drmfb (fb0) is primary device
[   13.122944] fbcon: Deferring console take-over
[   13.122947] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   13.139644] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   13.178439] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
[   13.179021] snd_hda_codec_conexant hdaudioC0D0: CX20724: picked fixup  for PCI SSID 103c:8079
[   13.179300] snd_hda_codec_conexant hdaudioC0D0: vmaster hook already present before cdev!
[   13.181743] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20724: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
[   13.181751] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
[   13.181755] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[   13.181758] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[   13.181760] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[   13.181763] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[   13.181765] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[   13.181767] snd_hda_codec_conexant hdaudioC0D0:      Line=0x18
[   13.218484] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   13.218555] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   13.218631] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   13.218692] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   13.218752] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   13.218812] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[   13.218869] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[   15.419659] kauditd_printk_skb: 125 callbacks suppressed
[   15.419663] audit: type=1400 audit(1741911603.582:137): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.hook.configure" pid=888 comm="apparmor_parser"
[   15.423153] audit: type=1400 audit(1741911603.585:138): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap-update-ns.snapd-desktop-integration" pid=885 comm="apparmor_parser"
[   15.634721] audit: type=1400 audit(1741911603.797:139): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.hook.disconnect-plug-host-hunspell" pid=890 comm="apparmor_parser"
[   15.643381] audit: type=1400 audit(1741911603.805:140): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.hook.connect-plug-host-hunspell" pid=889 comm="apparmor_parser"
[   15.909059] audit: type=1400 audit(1741911604.071:141): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.hook.post-refresh" pid=891 comm="apparmor_parser"
[   16.041313] audit: type=1400 audit(1741911604.203:142): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.firefox" pid=886 comm="apparmor_parser"
[   16.047470] audit: type=1400 audit(1741911604.209:143): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firefox.geckodriver" pid=887 comm="apparmor_parser"
[   16.138189] audit: type=1400 audit(1741911604.300:144): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firmware-updater.firmware-notifier" pid=892 comm="apparmor_parser"
[   16.311079] audit: type=1400 audit(1741911604.472:145): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firmware-updater.firmware-updater" pid=893 comm="apparmor_parser"
[   16.312646] audit: type=1400 audit(1741911604.475:146): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.firmware-updater.hook.configure" pid=895 comm="apparmor_parser"
[   17.025082] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   17.025087] Bluetooth: BNEP filters: protocol multicast
[   17.025093] Bluetooth: BNEP socket layer initialized
[   17.041834] Bluetooth: MGMT ver 1.23
[   17.057172] NET: Registered PF_ALG protocol family
[   17.283082] loop9: detected capacity change from 0 to 8
[   17.341287] NET: Registered PF_QIPCRTR protocol family
[   18.402482] r8152 2-2.4:1.0 enx1c61b47b81ad: carrier on
[   19.007099] systemd-journald[277]: /var/log/journal/e454872f0a7240d09e0b415a13f53b77/user-1000.journal: Journal file uses a different sequence number ID, rotating.
[   19.325241] Bluetooth: RFCOMM TTY layer initialized
[   19.325250] Bluetooth: RFCOMM socket layer initialized
[   19.325256] Bluetooth: RFCOMM ver 1.11
[   21.001211] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   21.576077] kauditd_printk_skb: 32 callbacks suppressed
[   21.576081] audit: type=1400 audit(1741911609.738:179): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=1688 comm="apparmor_parser"
[   21.645466] evm: overlay not supported
[   22.092289] Initializing XFRM netlink socket
[   22.508544] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   23.178748] rfkill: input handler disabled
[   23.306602] audit: type=1400 audit(1741911611.468:180): apparmor="DENIED" operation="capable" class="cap" profile="/usr/lib/snapd/snap-confine" pid=2109 comm="snap-confine" capability=12  capname="net_admin"
[   23.308636] audit: type=1400 audit(1741911611.470:181): apparmor="DENIED" operation="capable" class="cap" profile="/usr/lib/snapd/snap-confine" pid=2109 comm="snap-confine" capability=38  capname="perfmon"
[   23.316708] audit: type=1400 audit(1741911611.479:182): apparmor="DENIED" operation="open" class="file" profile="snap-update-ns.snapd-desktop-integration" name="/proc/2184/maps" pid=2184 comm="snap-update-ns" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
[   75.920558] audit: type=1400 audit(1741911664.082:183): apparmor="DENIED" operation="capable" class="cap" profile="/usr/lib/snapd/snap-confine" pid=2595 comm="snap-confine" capability=12  capname="net_admin"
[   75.920612] audit: type=1400 audit(1741911664.082:184): apparmor="DENIED" operation="capable" class="cap" profile="/usr/lib/snapd/snap-confine" pid=2595 comm="snap-confine" capability=38  capname="perfmon"
[   75.928339] audit: type=1400 audit(1741911664.090:185): apparmor="DENIED" operation="open" class="file" profile="snap-update-ns.snapd-desktop-integration" name="/proc/2727/maps" pid=2727 comm="snap-update-ns" requested_mask="r" denied_mask="r" fsuid=1003 ouid=0
[  168.838003] r8152 2-2.4:1.0 enx1c61b47b81ad: Stop submitting intr, status -71
[  168.855914] usb 2-2: USB disconnect, device number 2
[  168.855919] r8152-cfgselector 2-2.4: USB disconnect, device number 3
[  168.870749] usb 1-2: USB disconnect, device number 2
[  171.990789] usb 1-2: new high-speed USB device number 6 using xhci_hcd
[  172.134312] usb 1-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 0.02
[  172.134319] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  172.134322] usb 1-2: Product: USB2.1 Hub
[  172.134324] usb 1-2: Manufacturer: Generic
[  172.136099] hub 1-2:1.0: USB hub found
[  172.137085] hub 1-2:1.0: 4 ports detected
[  172.237663] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
[  172.264793] usb 2-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 0.02
[  172.264799] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  172.264801] usb 2-2: Product: USB3.2 Hub
[  172.264803] usb 2-2: Manufacturer: Generic
[  172.269679] hub 2-2:1.0: USB hub found
[  172.271021] hub 2-2:1.0: 4 ports detected
[  172.565453] usb 2-2.4: new SuperSpeed USB device number 5 using xhci_hcd
[  172.578068] usb 2-2.4: New USB device found, idVendor=2357, idProduct=0601, bcdDevice=30.00
[  172.578074] usb 2-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[  172.578077] usb 2-2.4: Product: USB 10/100/1000 LAN
[  172.578092] usb 2-2.4: Manufacturer: TP-Link
[  172.578094] usb 2-2.4: SerialNumber: 000001
[  172.658862] r8152-cfgselector 2-2.4: reset SuperSpeed USB device number 5 using xhci_hcd
[  172.740515] r8152 2-2.4:1.0 eth0: v1.12.13
[  172.772510] r8152 2-2.4:1.0 enx1c61b47b81ad: renamed from eth0
[  175.726314] r8152 2-2.4:1.0 enx1c61b47b81ad: carrier on
	   
 drivers/hwmon/pmbus/tps53679.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index 63524dff5e75..091d5eacbee0 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -16,7 +16,7 @@
 #include "pmbus.h"
 
 enum chips {
-	tps53647, tps53667, tps53676, tps53679, tps53681, tps53688
+	tps53647, tps53667, tps53676, tps53679, tps53681, tps53685, tps53688
 };
 
 #define TPS53647_PAGE_NUM		1
@@ -31,7 +31,8 @@ enum chips {
 #define TPS53679_PROT_VR13_5MV		0x07 /* VR13.0 mode, 5-mV DAC */
 #define TPS53679_PAGE_NUM		2
 
-#define TPS53681_DEVICE_ID		0x81
+#define TPS53681_DEVICE_ID     "\x81"
+#define TPS53685_DEVICE_ID     "TIShP"
 
 #define TPS53681_PMBUS_REVISION		0x33
 
@@ -86,7 +87,7 @@ static int tps53679_identify_phases(struct i2c_client *client,
 }
 
 static int tps53679_identify_chip(struct i2c_client *client,
-				  u8 revision, u16 id)
+				  u8 revision, char *id)
 {
 	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
@@ -102,8 +103,8 @@ static int tps53679_identify_chip(struct i2c_client *client,
 	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
 	if (ret < 0)
 		return ret;
-	if (ret != 1 || buf[0] != id) {
-		dev_err(&client->dev, "Unexpected device ID 0x%x\n", buf[0]);
+	if (ret != strlen(id) || strncmp(id, buf, ret)) {
+		dev_err(&client->dev, "Unexpected device ID: %*ph\n", ret, buf);
 		return -ENODEV;
 	}
 	return 0;
@@ -138,6 +139,14 @@ static int tps53679_identify(struct i2c_client *client,
 	return tps53679_identify_mode(client, info);
 }
 
+static int tps53685_identify(struct i2c_client *client,
+				 struct pmbus_driver_info *info)
+{
+	info->format[PSC_VOLTAGE_OUT] = linear;
+	return tps53679_identify_chip(client, TPS53681_PMBUS_REVISION,
+					   TPS53685_DEVICE_ID);
+}
+
 static int tps53681_identify(struct i2c_client *client,
 			     struct pmbus_driver_info *info)
 {
@@ -215,7 +224,9 @@ static struct pmbus_driver_info tps53679_info = {
 		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT,
-	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+	    PMBUS_HAVE_STATUS_INPUT |
+		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
 		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
 		PMBUS_HAVE_POUT,
@@ -263,6 +274,10 @@ static int tps53679_probe(struct i2c_client *client)
 		info->identify = tps53681_identify;
 		info->read_word_data = tps53681_read_word_data;
 		break;
+	case tps53685:
+	    info->pages = TPS53679_PAGE_NUM;
+	    info->identify = tps53685_identify;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -277,6 +292,7 @@ static const struct i2c_device_id tps53679_id[] = {
 	{"tps53676", tps53676},
 	{"tps53679", tps53679},
 	{"tps53681", tps53681},
+	{"tps53685", tps53685},
 	{"tps53688", tps53688},
 	{}
 };
@@ -289,6 +305,7 @@ static const struct of_device_id __maybe_unused tps53679_of_match[] = {
 	{.compatible = "ti,tps53676", .data = (void *)tps53676},
 	{.compatible = "ti,tps53679", .data = (void *)tps53679},
 	{.compatible = "ti,tps53681", .data = (void *)tps53681},
+	{.compatible = "ti,tps53685", .data = (void *)tps53685},
 	{.compatible = "ti,tps53688", .data = (void *)tps53688},
 	{}
 };
-- 
2.25.1

