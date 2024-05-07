Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780B15FA67
	for <linux-security-module@vger.kernel.org>; Tue,  7 May 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090492; cv=none; b=h+sxhQkGAbHsEr59VcMhbATlS4xUBY2+6+T+eseF74yN3ESsjfgnaufVtVwyo+dhVdx2HSM8YdZBxL0BWxd72UsX1wuI7Ccc53J9/DtifXUivbcpt1k0LQXM08YLqjf4Rh8Nv5HTHl/1Y94MHpIcR7+ydlX6xH49AfUNTQBQ3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090492; c=relaxed/simple;
	bh=+g8grQa8IFxIKr6O761BzLF6WlW57k8wJHHqWVnea9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ko3P7PzhA3CYrAngmY4+YyzmgkjP8UFJdlDbKe6jSaD6GrjNQ5SK7x7B6C4F2z5lHOfvTNQqxqNQTUc0vbG06qLve57hlD8RJrFSmg1F3unompGY0c6S3ZJdw03pmk26kyBjsl+1TGNgII0PrGzVCTVFh0tDaerJ4ntx7AApVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd1+ndq3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd1+ndq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715090489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ULn520VtyFUFvINDBmnGTg2429ZFbTlPrrXCyiYuIFk=;
	b=Kd1+ndq37zhyznheef8AR0oqLzt7Su4QRVGFGPc8BW6GCeOAvoQCt2SmonKPJiQGljfyCl
	2jcvQ194fZgTqEp2SK4q3zP61TUrSDUTRidfN4whJ0+vjyLt4ThmCcjd9ArdVcAyr2IqnK
	atcFFhDnf1NILHKsZbnPnxshIeuTKDg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-BUMQdtV5MhuiuQE3RZcyJQ-1; Tue, 07 May 2024 10:01:28 -0400
X-MC-Unique: BUMQdtV5MhuiuQE3RZcyJQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a59d0fb7731so157905266b.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 07:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090486; x=1715695286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULn520VtyFUFvINDBmnGTg2429ZFbTlPrrXCyiYuIFk=;
        b=IMSi7i7JZIpxqh7RkR8tC7sZAiPSqy9C3Z6pv+YrOorWDZ9P6n23VGy9xhgpdZUHxD
         RWxNTb7EAeV0T132ww7hoJE7RsLK0C6ZOrMxFEXTxW4IQNVyTQIpZw3BD4/jmgMTejui
         meWMYZ249qDumbbw8WtfdSe7JlpyN7zz1qxDnfvPy++thK3DzZBfsfXdbzKC+b+5k4e3
         2RjvMesh8KFM24jCwf0M/G1pWnRrgTt0jv0NxGSpClh13gr7IkzQe/tvaNHVT7+7IcRj
         LF9G6OOMX4SABGiwawF891waZPbHzSzH3RnRejhv3REUfd0T24tHMC4CGVMs83BvTV4J
         d0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU8FC0eA2hewiwpjycYPPXTyvYNYULaInET0oGGuODKg5rzgdn/35//ci3iMFnupk2tPajZZImBUlpuUH1Glg0NnhQMVZOGPuyr7MZ/p+7PEbpy8EYS
X-Gm-Message-State: AOJu0YzBJUA2HEAQgu3Gi6pwmpsOhBNYgOhacr1nKxklq/AQvKE7j7SI
	mHV5VYksiNpQLLp5Do584PJriLKSUpn2snoIimw1BvdSDuCB7z0JISxRtrCSkYaa5vniZOVDzGA
	RjIoIV5b3mEA5GooKRDLm7PorOcKEOOg04CJOeIDi+8QyQv9Ztpb1c4KBVG6gPsmWD8W3QUPhuw
	CU5Ss46A==
X-Received: by 2002:a17:906:c311:b0:a59:b099:1544 with SMTP id s17-20020a170906c31100b00a59b0991544mr4636188ejz.42.1715090486701;
        Tue, 07 May 2024 07:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKHyguRFTZU0iJ+9SVdFZmCvdMPXw68yJmNWWRHcy4KBLCFlWQ0WOCjLrHyUtqT8caqLjSg==
X-Received: by 2002:a17:906:c311:b0:a59:b099:1544 with SMTP id s17-20020a170906c31100b00a59b0991544mr4636165ejz.42.1715090486292;
        Tue, 07 May 2024 07:01:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ag3-20020a1709069a8300b00a59a6fac3besm4341867ejc.211.2024.05.07.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:01:25 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
Date: Tue,  7 May 2024 16:01:22 +0200
Message-ID: <20240507140122.176304-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 67889688e05b ("MAINTAINERS: update the LSM file list") adds a few
file entries to lsm-related header files. Among them, there is a reference
to include/security.h. However, security.h is located in include/linux/,
not in include/.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this new file entry in the SECURITY SUBSYSTEM section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a37cca3c47ef..ca79616a4836 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20140,7 +20140,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/lsm_audit.h
 F:	include/linux/lsm_hook_defs.h
 F:	include/linux/lsm_hooks.h
-F:	include/security.h
+F:	include/linux/security.h
 F:	include/uapi/linux/lsm.h
 F:	security/
 F:	tools/testing/selftests/lsm/
-- 
2.44.0

