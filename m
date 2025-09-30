Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7321CC4D
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199232; cv=none; b=cyv7lBkWCLi+FSYRBlittCJkWSjZftPxyxuewUXjCKai6+lO+/2chAtaFND5xvc/rsymunIDrMP/tR5CDJydWRrb9G4yF06Gz5F87vOIcW5Ef7mPARuSigm36HYzWc75zhgpd6j50fToU0reKy+gwggJMRHu9JSHb6FuMdXa4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199232; c=relaxed/simple;
	bh=Lsy1EfnzyO0CBijxsBMmFHw4zdAL6NpN8K8QOCc72YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cnNAstkM5oa7V+oLgFp5SJpaqh58Sowkdl2tQDlCznwn8yHIP2w9NgrGovnXLszihYdI8RWokdzWvDO4PnbiODGMMe5leUlV7fKgpH29SKltP0VA1fv5hEzjhGBGLc5s6U25X/hngg9fTpGkOCMpER8EcArYsLSumvEx+EsyOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5g2bvJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5g2bvJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9PxpAte8R5b+6XB/Vocei7ItJ6+uCKlMHpeePkzmeU=;
	b=C5g2bvJ+dhMfWyUtWwRbx+Vkc6quPGBHf+S16yyhT0e40RozhtBiUQs05vR7+4qG39AzUg
	pzSv8Jsu6G+/CDzUkRcCut15cOa+PSvnXSXg7y8w7WjCkdZaYXF+UWvGBbYJlVTmVZ8st7
	es1TWcmncPLHbJsYLpF7bF7WIdm6ydc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Xp18BA0LNJqcDj9w_va0Ng-1; Mon, 29 Sep 2025 22:27:07 -0400
X-MC-Unique: Xp18BA0LNJqcDj9w_va0Ng-1
X-Mimecast-MFC-AGG-ID: Xp18BA0LNJqcDj9w_va0Ng_1759199227
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so10814116a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 29 Sep 2025 19:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199227; x=1759804027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9PxpAte8R5b+6XB/Vocei7ItJ6+uCKlMHpeePkzmeU=;
        b=kg921WwZ8x4jyC/hwho4gBafKnvKMuFCDZumJEkNu3NX16eYIDIKLZvzFdNkEbxWLO
         9HKyezLKQhWkMuNhvoAls72BKC5FmcfFnxXOG5Wn2i4MF86yjZnOHm07lfYJDh+zrdvC
         KJu8LOutmLXUqZSh6eXhxEBRUjUIkpkP4PG34XrrzkVo4/K94JFeFdLGynUYdbsFQofn
         VUP5scIsBoS2pZAWnyVjysEE7gSjDRs57qqvvJX1uB2F/yL4Vsk/Bwl9kmeabKp4BpQB
         EqdhZLMi7khVeWAOwXg5YGTWY8zS64LgX7K1irvkaOnbUvxqM+eZpvAEj1EL3vULmCYF
         VdaA==
X-Forwarded-Encrypted: i=1; AJvYcCXGjO3lpWIxXdn8Ab/v10beGpGOxUiP3ogspajhouh6oTbqxyGmR7pw9A5gKf9znU8e5BNxmbds7kLlZGyzjYLNcSJ4l9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfVuz1Vf6aDVrRhfaIo8HyEyWd31TJ4GsRxCoI2k/ANiDENMC
	tsCRfH6597h89C/E9JB/Gfh0ieGCxQAfFSr+OyMLa1ZFO2s1YcHeDEryda4RJJy9AVBNceNH96s
	quxsdJp0kfRqw99n1ZcQI8FoXa40SNz8fpvNyQPW2GYbdOWdEZrefFxwFx3p5EPb4Dvso5sEtm2
	2Zdg==
X-Gm-Gg: ASbGncs+LV+uhssW+oNCKUNUES3/G7iQtswPWn3m5xHLw1VkQkZ5tE8Qve8VxPiMAo4
	gGSPUmCHICbdkCD83Nu5WQU+poE9agN+n4UdGEo5CLQbUIehNJbezGLElt6x5XHMg/HMF5CE/0k
	Iiyvq2XkkslsYLN7DMW9Fl5U0y1JJ/pXJ79DKR05KIjDWHMjptz2zlTiF7lLerRW37nWRWEgdJH
	I3Ay071Xbk4cwloi2c8G44JD++2P4CeyLiOb+A/w760qptsynIMOzkDNJhBdPhqdM0bDDb6S5u4
	J+YZfY4S5kM3OUp3nXtyDDfLFNouSd2yZ4Jg
X-Received: by 2002:a17:90b:3b4f:b0:330:6d5e:f17b with SMTP id 98e67ed59e1d1-3342a2ab8c5mr21107563a91.21.1759199226679;
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqT2WISEHZgxCaw7vrR75/tCyagm44J9wKFkRkbX3gbIioJ5YpqGHoSzaLt/LIIa3JwJBSpA==
X-Received: by 2002:a17:90b:3b4f:b0:330:6d5e:f17b with SMTP id 98e67ed59e1d1-3342a2ab8c5mr21107536a91.21.1759199226315;
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm12285975a12.13.2025.09.29.19.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ima: Add code comments to explain IMA iint cache atomic_flags
Date: Tue, 30 Sep 2025 10:26:57 +0800
Message-ID: <20250930022658.4033410-2-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.4033410-1-coxu@redhat.com>
References: <20250930022658.4033410-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OQL8wySpqupybmtF5f0qnWLmYtiKXUmANb1_T9PjUHo_1759199227
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Explain these atomic flags to improve code readability. For example, the
flag IMA_DIGSIG is to indicate we mustn't update a file's security.ima
on close because the file already has IMA signature. The code comments
for the first three flags come from commit 0d73a55208e9 ("ima:
re-introduce own integrity cache lock") with a minor tweak.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..2130d3764f6a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -176,7 +176,32 @@ struct ima_kexec_hdr {
 				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
 				 IMA_CREDS_APPRAISED)
 
-/* IMA iint cache atomic_flags */
+/*
+ * IMA iint cache atomic_flags
+ *
+ * IMA_CHANGE_ATTR - indicates that chATTR() was called (chmod, chown, chgrp)
+ * and file attributes have changed. On file open, it causes IMA to clear
+ * iint->flags to re-evaluate policy and perform IMA functions again.
+ *
+ * IMA_CHANGE_XATTR - indicates that setxattr or removexattr was called and
+ * extended attributes have changed. On file open, it causes IMA to clear
+ * iint->flags IMA_DONE_MASK to re-appraise.
+ *
+ * IMA_UPDATE_XATTR - indicates that security.ima needs to be updated. It is
+ * cleared if file policy changes and no update is needed.
+ *
+ * IMA_DIGSIG - indicates that file security.ima has signature and file
+ * security.ima must not update on file close.
+ *
+ * IMA_MAY_EMIT_TOMTOU - indicates to add Time-of-Measure-Time-of-Use (ToMToU)
+ * integrity violation (a file, that is already opened for read, is opened for
+ * write) to measurement list and to also emit audit message.
+ *
+ * IMA_EMITTED_OPENWRITERS - indicates to add open-writers integrity violations
+ * integrity violation (a file, that is already opened for write, is opened for
+ * read) to measurement list and to also emit audit message.
+ *
+ */
 #define IMA_CHANGE_XATTR	0
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
-- 
2.51.0

