Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52641E1A3D
	for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206850; cv=none; b=Ydx4cF4iLo7Fc2PBBR7Wo7T3ysK1XFxJZ0GVl8LV4OnFCgu7D8KwAyMLqfaOxrcfGH8cHIdzGfbY/l5ah7XHQOsHan4hepk+/QxhLi+/glmSmGYZ0U33puzEPS+SJzPEBx7DBF87/13GFCf3dFVfSCmzl/9G93K/4jqOnX+AoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206850; c=relaxed/simple;
	bh=OHBXANHyL8wcBVrw1yfldbqVN6opWC3OshMz6uT15OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=DQdAeM8BRdwthPqkO81CnGzF3mPTQQIggSeOAzTxlTY452JhFsaRoGdnSa1YWeb4/QezgxdnA2eSgA69ewJdDEFWgX2rUWw/Q8NBm1AILNsnKkGaQQTVQAPgUST3ZciqiTr296jxmHqdxXYp6GA68mwwYz5nkvZwQb6E9LnkNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gY5GM660; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gY5GM660"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747206847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RhtvBP/MCitR1ftSZRMeSHLdRQ2xIQHL23q4ybZlF48=;
	b=gY5GM66039XKzoYhoxhWqBSxnUz/ry9OHKv/xLaiWyUpofIn4rMsQL5+epoKqby8FJqT4Q
	S/btuhdMwAQ971S2yRCanyD1LZh38FsXmzkNFalPZCE6lZ2o3MpFjUZ56Q4lCV8/Nu+tXk
	vfVmEvSx/fD6CJPn6qPmKkbBjKFt98E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-UPg2-j70NzmPIWInLVQmZQ-1; Wed, 14 May 2025 03:14:06 -0400
X-MC-Unique: UPg2-j70NzmPIWInLVQmZQ-1
X-Mimecast-MFC-AGG-ID: UPg2-j70NzmPIWInLVQmZQ_1747206845
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acf00f500d2so491880066b.2
        for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747206845; x=1747811645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhtvBP/MCitR1ftSZRMeSHLdRQ2xIQHL23q4ybZlF48=;
        b=xRUYY5Ks0paqLkyIFPAsiT0sI47JRJlYi/+zqKQOUYLm4mgVAImfIBSyxnmN5sbppd
         nPwfVjjZCK4FL27HkYU+Ols7GDZG4T/OwspVnyKXG1VIBjxKY5AfhwxTu+NkR0TRuRhM
         7PZCWItdRa6HtPexBH7LzHduZFO1w4GivqdvwDj0zgGoje5dWai5c1ZC2AP86xoNLM8s
         +vuKbuNN5mTp33PpRJhNhCF31Gs+O0mMr6oeiSA1RipgXCAU6v+0cmS/lqEPjJ2eMG+5
         8yYKjYV5DePdsQw1mG8nRXIkP3SjcRnDXG9lGshMb3ksDbLicRm4cfW80LQPzNu+M2+n
         9mww==
X-Forwarded-Encrypted: i=1; AJvYcCVdFTj11X+MgHXxsnQ5/6ASQSs7Jw4OILE1aaYh8qPEipO2voPXmm67U3lpHIkRTDERHPE0W/G6UFWhh+JPuSdlMuklQqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wTpy9vDX7W+JRtTgBzI9QqDmQmrw9joFlpu70eXie6JpPi0B
	ToSxZ7PWBw1JKNwF56nAlmAwDEPYCnqeShuGIP7qQ8fgTnudWGVaoEtcFBje/WD3t2wLnSYo3AS
	o8BzBtDlH68b6etXYX3gYnMuQFPsVhcRMflZRGfzptxqHTOiTQrmL19pFnJXColn5O1t3eB3w5A
	==
X-Gm-Gg: ASbGncs3Sf9RgYG8znu41H41TDKpFULvaUyUxA09v4E37V6C1gMo+2gGQfvVTFOOdQU
	UOiM8Gf+fM44cmHX8FIsu/VG9GeExOvDv9SAvh99o/+vq6AEhf7DhcQzX04nIKAdBTZIjpeQSBm
	3cPJ3GLy4oGzX1F2HsKIzafuNmgU/2OU7Gdjv0rctYq0I13YM2OQOrUGeR/ewVX8WRb2rIu13I8
	9ORbNNvg7m3s6yebDV2/2JBaXB5qDx2eJ+848uXmMSrqXgg3YZVJ7ELxasSE4f0YgH3WT3GdlwZ
	At2x9DbutqAFaq5xe9a/W7XL5SzVT2KNaSPipOOP0WpVmDrkcc/Zs845ow==
X-Received: by 2002:a17:907:1908:b0:ace:d986:d7d2 with SMTP id a640c23a62f3a-ad4f74c9000mr222006166b.49.1747206845248;
        Wed, 14 May 2025 00:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxaAR2Q+5d92tWC9EC6K77qjGuYdoWqzESwAbtU31oqD51mMNX4L5oV+Owa01qzyfNoY/kiQ==
X-Received: by 2002:a17:907:1908:b0:ace:d986:d7d2 with SMTP id a640c23a62f3a-ad4f74c9000mr222003266b.49.1747206844830;
        Wed, 14 May 2025 00:14:04 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23f5f6fddsm653162866b.93.2025.05.14.00.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 00:14:04 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] apparmor: Remove obsolete config SECURITY_APPARMOR_DEBUG_MESSAGES
Date: Wed, 14 May 2025 09:14:00 +0200
Message-ID: <20250514071400.465055-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7tmSnctygIF321ZRT8b2Mk6BnbApBmD3fdb8z0oVpAo_1747206845
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 71e6cff3e0dd ("apparmor: Improve debug print infrastructure") makes
the config option SECURITY_APPARMOR_DEBUG_MESSAGES have no remaining
effect.

Remove the obsolete config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 security/apparmor/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 64cc3044a42c..3cdea783b6df 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -35,15 +35,6 @@ config SECURITY_APPARMOR_DEBUG_ASSERTS
 	  points. If the assert is triggered it will trigger a WARN
 	  message.
 
-config SECURITY_APPARMOR_DEBUG_MESSAGES
-	bool "Debug messages enabled by default"
-	depends on SECURITY_APPARMOR_DEBUG
-	default n
-	help
-	  Set the default value of the apparmor.debug kernel parameter.
-	  When enabled, various debug messages will be logged to
-	  the kernel message buffer.
-
 config SECURITY_APPARMOR_INTROSPECT_POLICY
 	bool "Allow loaded policy to be introspected"
 	depends on SECURITY_APPARMOR
-- 
2.49.0

