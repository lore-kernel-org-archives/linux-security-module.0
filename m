Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810312FB3E
	for <linux-security-module@vger.kernel.org>; Wed,  1 May 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579657; cv=none; b=GUaTrKweUVJ8Nv4DYxRx1ck8eGyBoAt90T5YNY7E4PqKs+4t5NUk7LZHP+cIW5UhWhZIpetWYaqu3q5x8R64ofu6Uot6eVDDpEMr8adfX+KEsk1cur7XWJ0wyomu9VUtKIjsFG3CZfcRaN/Qee89B80mz1RoZvM8VyVUU1yRtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579657; c=relaxed/simple;
	bh=dRXa4bw+GATtxw0bRfM1WzfRnRgWnofvYBW/yVCFBMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NQ46mGSPciz/SczFSIunLlixf5W4mv4Gy3J0f5roOCQ3m1GbR5ogpzjv9N7sGuZnVEHseI9SDPBweKqZLD807s8dkDYVnrEKnCX2xpmI4tUB4vi+VdvPAbDzVPo9TeBPZ1pF+cMB9Nd42NQ3jZOwexARJuVoXW+6EkbelqX46QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LwVSzVKP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LwVSzVKP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7906776e17aso502324885a.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 May 2024 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714579655; x=1715184455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr5rU3ocbYfiYtig96UWUYPMJaWC0247tB/Z3CcHCvY=;
        b=LwVSzVKPBEuXhCB9sczewjUHjTl+bnf7L1NQSTHxEuA2XdN9qVTgheGBCCsW1+3fs+
         hoWFjuzm23+oLGoPbAWxdm50I1VDUYFqTUWr9TCkoJIq6DJaD8TcTeaky9nR/th1xsdb
         qgN8QpUyzg1MG2q2ZfS55ay/dbPeKGSw+jNKz2JoB+lhpVynzMfNJvP6+FetBWhlsc3q
         71K2coamgReDn6zAG296/GHE5M5lUH8unhWdH4r91UE/zeUP94fMi73OFmaqqRh8RRoz
         s729GyWWcdVBk1Kd9vYL90kpvqcKzzUQpWrywCO5JBDrF25jivL2kEbQDBvmGXnEh/Nl
         8K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579655; x=1715184455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr5rU3ocbYfiYtig96UWUYPMJaWC0247tB/Z3CcHCvY=;
        b=Causof245B09B5iyJ42q0qKYsN+j6P2GC/SRUc4F+xyCIhqEKwZpNH3Z2tg23frvZB
         6nO/ogNVL2NbhRegoWk0hTaef498GVXvu7pcatoKbUdiCLCypG1K+tyj1GXHaz56Kedy
         rq5JE+gqlhYF4bLANZCsUT5ncREYf/WaZshIRb2mFYbwA4nFMcRzWf6NsFJ7QP8Ao3Zf
         EynIlwiaHdmK/cux5z0xHfIiii2LZAuKD0tXAKY6UPWtGpTP++jPAahTEM4VfDoP7BHQ
         9O0sukF1bCybKJwSZoq8ufN5iLR2meazp6jdz88y/94OF3KHMVJ0g3RCm0EVeh7lEZBT
         /1wg==
X-Gm-Message-State: AOJu0Ywl+L21jBYjaO1Z2ojKTcgd0IRhhiPQv5h61iRRFSPwgr/2+XtY
	XnQyH5abFGoTyaI6/nuYExVUd53SL+kaNWb+e7at4FnGveD9W+DwrdCqZE4EKe5ggwQ17NOzULQ
	=
X-Google-Smtp-Source: AGHT+IHidFKNZyq9CC2VpN9w5ehXO037jXkq1Hwr7bh6hegIPAkX6Gw2CIoBK6zIaGwdTH0K61z9RA==
X-Received: by 2002:a05:620a:2491:b0:790:eb01:ebb6 with SMTP id i17-20020a05620a249100b00790eb01ebb6mr3192197qkn.42.1714579654969;
        Wed, 01 May 2024 09:07:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p2-20020ae9f302000000b0079088fca179sm7267281qkg.76.2024.05.01.09.07.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:07:34 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update the LSM file list
Date: Wed,  1 May 2024 12:07:26 -0400
Message-ID: <20240501160725.12027-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=paul@paul-moore.com; h=from:subject; bh=dRXa4bw+GATtxw0bRfM1WzfRnRgWnofvYBW/yVCFBMU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmMmi9gHSbfAi9vHeBGARj8ha8tVc9tIcw8JLs7 xDb+CdgUsiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZjJovQAKCRDqIPLalzeJ c6i0EAC3NH62Ehb/jxLT4NQuMiB+La4UKZWy1rnrjmYHlXPrBFhE2zjUG9h5AThkE08xASIn7Lt WTRhJ/frT9sKEL9YaKN7vD2TpsuCPO1E61Nk8K2u5V5H2pLeWMRxto6c2+Za4RoKQlWsDF3XvXP 86MdD3mZhxR4Frr+bT91VYWMGHJIKNA1gjnrwmq+g4XLDiaGvALYfSVDzraMCu+9hxz/Z1PNvyg 3aSlnzvN8cW006cnGrCka4tIeV2EBgfp7im4F2nJYUAm79fhnWSeDXHnBschGoqNE7SoksbJUrD bI4zrW7G+3bmxFLk0KlHfVOCVZ+dLqPRoNS0Wo2UEivOXQCZwU8FCHjblK99enM4zGF3nhDwVAr HZdLkE0ElMy00i08/wRn7oiAjRT1CB5G61voQyPqhgt5tq5sv5i8DL1bjMVNL+DiCRdDTFOzhMD ClBs/R0R0Ccae87AuuP6ieGJAecG1UEC8iwxGWFg64/vE8vVlGuc3FVu7g0FEAPjfKLh3QHHiEf F6uTBhwWwzWvXby4EjrDPVMUW4cvbkN8PXXcvjoyCW2YMUtiOjVLAGqf5ZXyPh9Wnd2WEhre7TN oCBKnnd/DEFvaZcFMokyCN5LL3AhGggxve+LHHKuxotbPRikRQoexFh6XsiiDNfRn8cbc64oXsR cpYV+Xta8AsNiNA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM entry was missing a number of files under include/.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..fa55c4f4c732 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19818,6 +19818,9 @@ Q:	https://patchwork.kernel.org/project/linux-security-module/list
 B:	mailto:linux-security-module@vger.kernel.org
 P:	https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	include/linux/lsm_audit.h
+F:	include/linux/lsm_hook_defs.h
+F:	include/linux/lsm_hooks.h
 F:	include/uapi/linux/lsm.h
 F:	security/
 F:	tools/testing/selftests/lsm/
-- 
2.45.0

