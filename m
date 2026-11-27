Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793608;
	b=EamWBjJ+iYwyb1oLDBDyCSZ4kxdECrivp/GvaKpuYmu2ESMv+019ub9b5rHeBRj6jc+W
	 QwXDajESpZIYYkWOAFXaGjxBaYTdYHmY7tetTBu84lof5UCuUJO6I0hlp3hV0ZiWpoXQC
	 PtbKoBcE9QQRwroEGEiagxqA7rUr9Qf60oUdJ8HXWKH2fstTX08H5nbZFs2pwOimhxXqa
	 BeOjcKi410dnul/mHQJQ0q3kxEp4bp6sKTcPLQOkPRDI+s5UHipAGbqtfDw4XWLRzawjz
	 0AdZPet14SDy1aPso5J2AB4BskqpTevG6VNdBpTY5orr3fmI0RMBEB0f2JgWqd4oAOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793608;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=UbxRM54/x3gsaWN6jkFOgoIZhRMewegV72A+3q3F3mc=;
	b=1FLCxFl73rcBKRlKBM7x7pYBjPxgPeMrbLanvpZaiHgggNEY5yKb7UyZr2j6tvbCPB1h
	 Q2H97YEtN0QPDDT57wTlgdhW05JK5prxd8krFo3yeaTlf9OgJoHpHylzEupAkLffbFncs
	 qGOgGRZ+mOf1bF6W+YVXkPZ5CaPLLsW8xscZXdBPXsPuIY25LB3wv28JAynwRQf6IXwkJ
	 DSDEuKn28MTj4kDqqXYaJ82Oib41flM2tZGKYAOPU++jYWLtZ54rxa2MskjkNo/z2FUL9
	 T0zZa+52MPYGLVAIveaxcdk7rWULKMRV6urwY3c7VNPdFd84Fy2qtJqrKrfUdO+UtWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yg3r4HXa;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758A4606A327;
	Fri, 27 Nov 2026 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758A4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Yg3r4HXa
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E2DE1E4D;
	Fri, 27 Nov 2026 07:33:25 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEB413F632;
	Fri, 27 Nov 2026 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793607; bh=ZYYAWoxKreiy1oLbAXptBMHxGm45wgu9yoV+MxOg3ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yg3r4HXagVrv3zl20I12s8HoFBmHuH72UcKqi9rQuzUlpUciR7eDUV37XMbjpwrkj
	 Pc7MewOHm6Z8N6/9OGvMDhLazIxhcNZh25RZcBDsP4UWUrZDTwJHEvRrxF0Pd9VM7i
	 OtwrHGIegGCxZkSYGCBkkdTYvQ9xm+zuWxwoI7TU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 27 Nov 2026 15:32:59 +0000
Subject: [PATCH RFC v3 4/8] acpi: add CCtype value macros for CCEL table
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
Message-Id: <20261127-arm_cca_mr-v3-4-df3230afce8f@arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
In-Reply-To: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
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
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ZYYAWoxKreiy1oLbAXptBMHxGm45wgu9yoV+MxOg3ow=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaK0gZOUA742VqK9FJfMhVcJaXrr7xKAygARy
 x13Y7F9iu2JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmitAAKCRBt1cPRWsUx
 M8wnC/9VJBXCWG+gOzZuz2ss/tFA4X+la5ksWYTxTfHm5ve+cobHAcb1Zo4GemS5btOdabBxcoh
 7QbP+39jdw5hj/IOMwOflVHAV+XaW2QWkEcK4chkBa90FX/oZv6/BrrgGLemi+hUkRjJxSP9KeA
 5zkHNhTIKPjfCqBBwxIBELeW1sMIHqnh5Z8GBTmLLfX6al+BB4w4I97bypqyRuW/4fWZFggzjmz
 NXeNVNr5hmDvVmjTjDfaV3gL/HOtFnUQxXI/VJ71SX7Lp+mYkU9MornF3dqbr0CsaCw918OS6Yn
 zoPv4TDe1n+71g/AIG8I2mkkarcnDFhw2FgZZEU1BCpPWa9HVV1xC33GpOENp2Yn9gQYO6PJ0Aj
 QSMYvXWMZHfHMIQw7+cG4dAllTMdTI1ESVGVNOHEvceR7l9fsMoJRc41UF0e5pOL5QzF+SFQBHH
 CifCMNmWDPNlmDBCOV2n6MeHoH0qt5GjF3EM4faTMg1rjcvy0yVkCfoHYf2p6umzUlpfc=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Add CCtype value macros for CCEL table.

Link: [0] https://github.com/tianocore/edk2/issues/11384
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 76e4a5bc79b42..44810b9b9ddc5 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -454,6 +454,13 @@ struct acpi_table_ccel {
 	u64 log_area_start_address;
 };
 
+/* Values for CCtype */
+#define ACPI_CCEL_CCTYPE_RESERVED	0
+#define ACPI_CCEL_CCTYPE_AMD_SEV	1
+#define ACPI_CCEL_CCTYPE_INTEL_TDX	2
+#define ACPI_CCEL_CCTYPE_RISCV_AP_TEE	3
+#define ACPI_CCEL_CCTYPE_ARM_CCA	4
+
 /*******************************************************************************
  *
  * ERDT - Enhanced Resource Director Technology (ERDT) table

-- 
2.43.0

