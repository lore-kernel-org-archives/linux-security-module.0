Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9877175A8A
	for <linux-security-module@vger.kernel.org>; Sun, 22 Mar 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177834; cv=none; b=KYfTqhHhzxGFxIugpj0bgCnF0667NtB9NkRjqT2kqyqN+Nhax06q+sHsTd6qUF6fQsIy7E6RV3SW+9d5cjvk8aBEDGIN9KSDPedc3OeuDUmRQ7OaQ2zo4BssV/o4S0NuGiXm2fziqkXsoO3/pgQxcIWoamAYaVCZvpCjT+D8HX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177834; c=relaxed/simple;
	bh=NLIEw1ZR7mTPpeFnQNrEtJKL+JrWXPexTzwN4Rbrlp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ZecUJjOgyKqRuN1Iva6Rv1p7Sdu40NqqBzxSAV2l6om17KPpktnN0eiw53DsEsO/WOrIl9YnYpOsf3lQi3N3py7tRtm9GTnsvpG/rnssKx1idNLaK4z/uvBzuJcNxwjHEdloURW4HTSz7HBrPTz5tY3Z9bFEBI5i5eUe6q3WYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKCq2hEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKCq2hEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774177831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pD6rEELAAr02II5508NHP6GW7PMLu9br7i436TBlft0=;
	b=NKCq2hEJ8jeYgf2vAATbvKSC4T9PITMDc7f1grc1r+c4tXL/ONNVvYbCRVogUJkLmyfphq
	TPGxmJe2wuqHApK73Vbwq9KeND1g0OUibQ5aSYvdYeSuOiGhUy5Ynfi6+zQmAq1ya7xAwq
	09iWOvyzw9LzibxZQGWXG7uFi9zUbhI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-6nUaabfvNkyKuHY-5iD1QQ-1; Sun, 22 Mar 2026 07:10:30 -0400
X-MC-Unique: 6nUaabfvNkyKuHY-5iD1QQ-1
X-Mimecast-MFC-AGG-ID: 6nUaabfvNkyKuHY-5iD1QQ_1774177829
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso1176914a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 22 Mar 2026 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774177829; x=1774782629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD6rEELAAr02II5508NHP6GW7PMLu9br7i436TBlft0=;
        b=caCnwQAtV1rYmYQ0u8wKm+v4SVLEud3EheR7UoPuujDfajKn6Epjh1eqJrOY1nioSi
         Z2L2XQasa0RLVHH5KGJdiPuvYkZj9mGkDd+PdaiYeIlICiNVwT926A5dnt4PfyM6w8Cr
         5pIUEG7Yo7O3iz/wHePGdQKHbiXBsHQxY1BvZe9zcGPZ97UtK265Xlt8F42Dg5xXBTwc
         nBu1s2mzbbJETq6EFLutR/6A3zpm0g2P8jqV9aRiXXha02yMnPlOh6LEkn/l22mUr8vx
         5YI5I4+u+FcBOaQ4mhDk8fIdZ+bhZzR8UWpHGdbX0DCJzpKpklJjqCusO9DJYMIn6IUZ
         KHAA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMaHNXL3TjohOAWYrZ8h2wcNSl2qPt1gtYFchrdKb7u2eJXRFvpFqKTVowMu+UeBeeszCtgVL4NLdR5SThsin2+W2ilo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3a0MSVJ3TDuNict188RrQoKJKB3kUkI/mdAJudv15ezBE2RJ7
	g8lD7mXjel04WhmhgJo3uQKSCdjnW7X9QYoXPy24YnC08OTa1i8e7MZXk1Kg0GZIQkWoJyvv0bI
	scXlmaYJ+/QIjWPACXJ5L1gGCRIlkg+leB4UbYLdvIOJMtUN1CvBx4YIIsrtDwQnfeGFddA3tvh
	/oUA==
X-Gm-Gg: ATEYQzyHj3yKEslZxCItCdHuejNuORbbE3Nudm7OzFOP8V/r32ICPlLZAfHEuSMUTSQ
	0G9AI2PTzw+QMFT3UIbthpTQ2S3jIsJg8lmUIOgCY/ad+L0Gcn9g4Oi14rM2eI4YfWiW93WL+d0
	YJtq+yc6HY060pTuKShTHQQ0lDmt+fIGlx7R0IQgtLhLxf7oKIYBzgwpXCiMm6ev57L251+v5dt
	zV65jM5IMBTbZNiB6WHFHlcvvg5Mw10Ehe1TphMECcOhKzpGI5c+KqUU+2x4vxJIpaH8IYMWCN1
	zw2wBc1CMhCoQJfF/6i7sHxeGi2JYVImckIoS1o9fEjwDehiBCEQ8siSm1vzc2TuP2NrbFdBptM
	ijqAVedh0PndlwtHhl5D+kdnrIUrcj1WjwDj8WaBd5jua0w==
X-Received: by 2002:a05:6300:8b0f:b0:398:981e:2e13 with SMTP id adf61e73a8af0-39bcec310bdmr7945008637.62.1774177829500;
        Sun, 22 Mar 2026 04:10:29 -0700 (PDT)
X-Received: by 2002:a05:6300:8b0f:b0:398:981e:2e13 with SMTP id adf61e73a8af0-39bcec310bdmr7944993637.62.1774177829069;
        Sun, 22 Mar 2026 04:10:29 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801b79sm5277794a12.3.2026.03.22.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:10:28 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: abort file hash computation on fatal signal
Date: Sun, 22 Mar 2026 20:10:19 +0900
Message-ID: <20260322111019.2815601-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LIPBRfxSZ0OCyD75xplT3T9FtSF-dTSOmVvun-F-4r4_1774177829
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

ima_calc_file_hash_atfm() and ima_calc_file_hash_tfm() compute a hash
over the entire file contents without checking for pending fatal
signals. When a very large file is being hashed during mmap (via
ima_file_mmap), the computation can take an extended period. If a
coredump is initiated by another thread in the same thread group during
this time, the dumper thread waits in coredump_wait() for all other
threads to exit. However, the hashing thread cannot exit until the hash
loop completes, resulting in a hung task.

Add fatal_signal_pending() checks to both the ahash and shash file
hashing loops so that the computation is aborted promptly when SIGKILL
is received.

Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Reported-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ed94e81a1492fe1d512
Tested-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 security/integrity/ima/ima_crypto.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index aff61643415d..7b721b9c944f 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -17,6 +17,7 @@
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
 #include <linux/err.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <crypto/hash.h>
 
@@ -416,6 +417,12 @@ static int ima_calc_file_hash_atfm(struct file *file,
 
 		if (rbuf[1])
 			active = !active; /* swap buffers, if we use two */
+
+		if (fatal_signal_pending(current)) {
+			ahash_wait(ahash_rc, &wait);
+			rc = -EINTR;
+			goto out3;
+		}
 	}
 	/* wait for the last update request to complete */
 	rc = ahash_wait(ahash_rc, &wait);
@@ -491,6 +498,10 @@ static int ima_calc_file_hash_tfm(struct file *file,
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
 		if (rc)
 			break;
+		if (fatal_signal_pending(current)) {
+			rc = -EINTR;
+			break;
+		}
 	}
 	kfree(rbuf);
 out:
-- 
2.52.0

