Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6731E11F
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633536; cv=none; b=Xo2T4GsXWw1pviav+O5S4+PptCbdoLxGo84gx7vLKZu0Gq0Kvg0Ky5XmM+tOvGIJdK42ZTDId/Cl1XmXiu49zEUGYCLC0A+lIwNPKsNd2b3LReoUXd26hyJu/ZgYXRQdvxu2QFwoTxRkx/IOLq6VwBNlAcbbycazEvno+FWFy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633536; c=relaxed/simple;
	bh=J61fvA2iXrVD21XQbkzqcjs16RvBAtSpF1+CPDgbUSM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L67cx6j6rTff8rXhHexvu3JAjopHOnSZGKUj15LzAwpwH1rOvGOD3n0UZbAEhfhKLAc7Z7UBciuRCsaRFLlCKvJcn1NFx2bvz9QdLohDyi4bZdLbmTm/CYysilzCgm7NdRehd3ML9osX18R8v0RIAnfnHzgBgWPbGAPDHsh5qTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YIIGyeGz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YIIGyeGz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e86f90d162so32340085a.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755633532; x=1756238332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3AATlN4RjaPp/BmcCfGWuwT6L7Llca35dlDVr1vzeUY=;
        b=YIIGyeGz1AtwTIZiKarDMEPmjtovwYhK/873tcZgXim/asOsAQlP+j/flYdRoJ359S
         AoDASHrIBsNT+t9kIFJUTnIJfJEagtmpNt7PGkDyc1WAuLOwqSD3djGlUPnn0SbOOr5h
         ye3zWFpjqKb8kJyavGVIAfFcNjdrs1OAHNLQ+uGJ+FfM8Za/fGWuWiKtAvWJEAZvdIGj
         oSRqjEPqfQ4ROgak9shnGQBlHNPfH6U9xI+0VTyZF586sdB4LRyOI09guab6Hmu3ZN81
         dwe7xE85tltOedcmCCS70yJNMPjSKG7mxWuoJzejkhUIR5ohdAodci50MhO1Lu/jqU9U
         3SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633532; x=1756238332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AATlN4RjaPp/BmcCfGWuwT6L7Llca35dlDVr1vzeUY=;
        b=viGLVFqTaSWkZpmjoHU7ElW+BTBh9Ltm62i8IPIPdXbqONoQ1ulW+wNugtwcHKZwpS
         xBYrP2IOWXnL5tgb3P1h/qt2ZZLHuKJvEvrswgzGNVj4DzROIsguuuQuagKRKXcssyC4
         gCIytpZX8c1B1KK9eWjgZjloQ7K4mhJA0Hv0leVCI7VYonRLEfk1CdOSJqSJS1A4kL40
         mEQYt4Sv0JigsNizTYgQZlKOF6Y+ztEynSBoNc+nIJzWksg/mUyn/dwK5BQfB/DlaTuv
         NStOB6+IaOMTcegXYIPjJ1EvkPwkpcnAuqIOOyasIWbeFvTaAWgVbN/wfYH3gAkWtHpM
         VGMA==
X-Gm-Message-State: AOJu0YxORr8FE2qhkvaXo3ZfmDAMC4YjWiNmmeMIuU74bHUebVaP+H7h
	yY6dmTG44SX4ehURygsqgZkehzHHkxc+ZsrYkZ3WQbbm9lNsP8caYnd8CO/VdOC3RucQJoaXo9E
	ziiQ=
X-Gm-Gg: ASbGncshrDMcNq/JyNqpfN98NVaARuKOsu+UiHBsiNa6q/ffyH+mlnJUfYAbBrP/wls
	boHsA10eYnniHrzkwgG/42P2F31jZx2ACTWsLsaDrsUjVUaswov/S3lCRGxFArHil0thRT5hG2w
	VZhHvHjDBxVeIuyZkDoSkHd8qLTHsBPEU+mKxYylJrPtFD8c2PBOXALRrtnrfjD0pmPyg98p8QI
	9+sNofgdpiAumDoQUeKl6LuzbCCFvKe/BplnWDEfSyDOkXCmMKccUmYhOtKxU8hfoyEoo1O71d6
	eGqCgxQ59RCg5DSspmSuk6WI/njnbX1kNjIvKPpnWRjsNVEHNzuj4b5BBCtZp5Ytut6I/V0QcVj
	VCTb/8lxmN8p+R+IcU8u5eUA1h/VhEJxLFFeBGaL+sZogda8uAAhEBTu6jPw1pl5AUUV+
X-Google-Smtp-Source: AGHT+IFS/QUC45IHhF9aldAbHK+T9irz6orjXWT+YBOPHvacTzA0aofgYRnmI0pzG7KLS05TpCkK9g==
X-Received: by 2002:a05:620a:28c9:b0:7e8:38c1:eeaf with SMTP id af79cd13be357-7e9fc756801mr76873185a.14.1755633532343;
        Tue, 19 Aug 2025 12:58:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e1c14aesm808639285a.69.2025.08.19.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:58:51 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add the associated Rust helper to the CREDENTIALS section
Date: Tue, 19 Aug 2025 15:58:42 -0400
Message-ID: <20250819195841.238246-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=508; i=paul@paul-moore.com; h=from:subject; bh=J61fvA2iXrVD21XQbkzqcjs16RvBAtSpF1+CPDgbUSM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBopNdxPv64wRiqm1kKy+qoA+I9VL9oXEvM8RhQG naTYdrLipSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaKTXcQAKCRDqIPLalzeJ c2y4EACUy2EFUOmCE0x9xyuv0x6l+B0eLdeH5jKYhKmmvmbU2Jd3xttE1SP1bzmub4NBENH6Mjz FqEGdIMfQJpV5zjgp5Ammxgxeh6KJ2W/CrrHXgklSOeFvXUWNFmrLTJUqHvQ4zhF+UIPAOD+NB2 tlVTxLLsmtHFRbv8oGMfBUN4P8JtbdPTRxsTgvgupFXQlOXxD+6cGdSb653WvWP2FDqnDpnzz+8 +Eh9O+iX22PI6Jj20HYXSBWlbpu6XMJXL0XGvIiZhaiM+gSsiWB1vgTWtfJ4GZqPAjeGEYO66Fe Q6uDJ7kU43YYJ7PQkq194+CONUTD6eaq2kSlS7+imM6VpRHjSsCaAcZkA6g72KhYtdheWN6CuVD o2iCF0drLiYuYJIZwf754TkkZ5pyQl0r/RnOdNVfWsNOOmxFJ5e09c4BXlH7isL7VIs0QhbyHEY SfsFEeTqttQOzOJ6J8TuErZaAprFwL5u8yfjOqrubwRRcbXJEhL+ikK432gX94b0X99PgnfsvDv 5+4CZdmQeRYykm4aPfueQXg5qBls/6vq2A9y80pAXP3kHYtIuvSwttYLhFt6tso8PlEqsQTygQR jidbxqhYEf39vah32q0manJUBA5Onu5mXx/6Gni6YmHxRfIj8KVk8lUuICfP7LaZRaKdmYRfxX3 DzLDd5aWOhDejxw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d61f7246e5bf..0ee0098f2df8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6484,6 +6484,7 @@ S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/cred.h
 F:	kernel/cred.c
+F:	rust/kernel/cred.rs
 F:	Documentation/security/credentials.rst
 
 INTEL CRPS COMMON REDUNDANT PSU DRIVER
-- 
2.50.1

