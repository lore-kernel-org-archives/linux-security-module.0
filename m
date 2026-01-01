Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B41A0728
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274878; cv=none; b=R+J02ngpObsiYQtTxiA2cEjAzZ3bsigBtfFu5IFRlV2KewtOPZLdgwH6G44PzSth+/iZQnFTZn3vtTJ5FjXc8YyPkeTo2ekjn6ZNLDWvi+N7Of6W2T4n1VYVoG5VmHVNEKhNMkq/rbPm/68SYt5toMlb7aZmC1BLHrjqEqnKJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274878; c=relaxed/simple;
	bh=fk3hO5+MNopcvLMJOo0E2JIdkVTzE/nE8liusL9U4y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1ekwQycSzgek8+z+dyzqPlyqX0NiPVRoiepJeEoNGnOEDGIttPEwr/mqoSXEfc7TGqZeKkFE7jT90qJs16OC9xawO/wjbqjca2vjwJxlDEp5VY2ug2g5L0fKFEbuKTk6RwyT/1u5300kSdC+CkmYcxFmKzjlyeIGb8DcNAqFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlD1/MF+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlD1/MF+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so2630584866b.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274875; x=1767879675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJc2+r84yQ6BsOKsDS6weRAaBDuecqi6qG4T9SjPqBo=;
        b=AlD1/MF+6H5wMoAz8nTSdPLIKD8Ri90dm99yPMVm1dZPWjEoPZlz4h5PXB+HohEb0c
         YwxBKrAyg11ySHpAFU+f4jz/MOw6dBI/r1tfBaJjy81wNeTsrxBaTT8QRBcv+z8WgSmp
         TRCNGps9vwmSpJMARcpXL+WOBwtL2IDLjcP7ENj6pJniOwqLC5hrHiawIFdfkdfNZO0m
         ialXVRbICJvxqi0o+i/GcWkDxDBzfb8fAIvN22c8HnX1yG/cJ6bt9LELp/h7ld0+HyZ/
         aWL1qGELg4LmPaDKghadGWEHZVvOtb8tyhAIa11lvJqllzvmBFAaQiaeN1UCkh9TpMSl
         F3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274875; x=1767879675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJc2+r84yQ6BsOKsDS6weRAaBDuecqi6qG4T9SjPqBo=;
        b=hZqY+i1cjJtBeFNgG3YRVKfG4YjxlUuGcEWfuTIXZw++WZqAnt806Z1K+00tC0ySts
         WTTkbze4usMV/lv3BgdFQPp37MFG1ND/0nBhM78v4TQ9Rc/yc2ae+C0A/bkxSNHy127H
         97+cUHwQkb4HqnyknHJCbP3lfuZHwjlOkjYAp4t4fKDaGHLucOzp86KQoRi2zIm1gKAI
         1GHz4XCR2TyqgmHgoLG9Af32ddCYRl3hgBvVoe9LtNDRWpdAMcHK2gxUX/4o0cEZEVH/
         ivH/LdFby8lsnvugkLAO4hHkPCW6DjXYjPFoZrqV3fHMZ95zs7yj9cTaD7spjIH4I3qF
         h/Xw==
X-Gm-Message-State: AOJu0YxsIAduYWORo0nfSlkCqzQu0bI/rBzn3DQLIZ74jDxzOS2ygoNw
	zL2VwovsZEOxF1l9z0IdBOK74t0P2+ejc4PhASR5tGjm7ZhqckqObgdR
X-Gm-Gg: AY/fxX759C6S3xya6LG6CS347spsJr5ydb5c1ENLnKIg+xQpHuAmAgkJgOJib8wLb0/
	2T3Thq0oN5R1FcFLzY/KmGPkMlyMAuPKnWykZE2zc+mE97BDWBB9I/EWQM2GtTuFIv627kIMZSs
	2RxeRGJS5SvX2W0YCxca6BEBuyFy6yyo1J6+Dk8a2NQI7ybe+Ha5GSi2noT+hNmvxYgWOJKWwCn
	6xw178VhRdR885rd3vvOHP3/iFSILowHMe9Dr2d/jRX1Rb/tVPO1IYVe/RWx/21XBF1Ws4K73ub
	bVGauItUtyATAEHb0wSDFIa2nPSM/Mau2Rtki3niJdEAPDUuHTiguJR1WmKEQ2nAnJXdvMGK/lB
	tJ015Eq7XhkaYVWQnDimzkgHZEWBLDYr921XIEk5ttYybPAhuw5FGKigS2em17du9GMRlgDXKgg
	dzMY3+MFWtYkZ3q3e5mq25M1U/QnsWtPE0UNFO
X-Google-Smtp-Source: AGHT+IGVF9mxQqCIbzTIRDR0jD9tFxcnJR0cH9eYVDx18guVLX1x+0HpU81Tjz1znq/d/RdpN4lJjQ==
X-Received: by 2002:a17:907:97cf:b0:b7a:72bd:ac65 with SMTP id a640c23a62f3a-b8036ec9e68mr4068745166b.9.1767274874596;
        Thu, 01 Jan 2026 05:41:14 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f3e271sm4306859966b.60.2026.01.01.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:14 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 3/5] samples/landlock: Add support for LANDLOCK_ACCESS_FS_CONNECT_UNIX
Date: Thu,  1 Jan 2026 14:41:00 +0100
Message-ID: <20260101134102.25938-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add unix(7) connect() support to the Landlock sample tool.

The "connect UNIX" right is grouped with the read-write rights in the
sample tool.  Rationale: In the general case, any operations are
possible through a Unix domain socket, including data-mutating
operations.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208b..b24ef317d1ea9 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -295,11 +295,12 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CONNECT_UNIX)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -444,6 +445,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 7:
+		/* Removes LANDLOCK_ACCESS_FS_CONNECT_UNIX for ABI < 8 */
+		ruleset_attr.handled_access_fs &=
+			~LANDLOCK_ACCESS_FS_CONNECT_UNIX;
+
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
-- 
2.52.0

