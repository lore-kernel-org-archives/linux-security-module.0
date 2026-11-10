Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342269;
	b=IQZLaNqZaUcR/yO8G38urNmq56KK5G7RJoG+pIC44MXSFx6qCRFPd6jO23AwA3g/TclL
	 Fh44HKfLj/Zyqmq9QRWP7NVo5rbuOuG3LXeH7yv2rK9mHuyI9BkRqrmvE3LcuFyTLcfq1
	 d986iJvoLPWrzp4sJ4GOvn9NZXbDKaBxo1ZXe98pk0M0vkDxCiefnRb2HEKGeFiTl23ol
	 Y8ZU6ZWS0ujujPTejpTpSb+024S6ZRuhTaWNeu2iXu9k+d8hi4fXo8gWZ/suoRxddjnKE
	 wecuNZKbn9Ks08TWDrA/STy7TdDSCCb0aDOCI+uc28C3Em65SmsQ3Hqae0AmhkU79IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
	b=Vbv5uy1UdHQFh2wJp3BxsVeHsWwSq5BjQqar7R136g6LDf6ygUuOXiAFD6CX+4Yg0sw9
	 CfASYAv5BCsuQfZP/ylfQYkqNOPhRzKY2fhCvB5mFQh+1fvNW4t0zQgm5durm7ceQVPGg
	 +m9sw9QuAQRavk6TmQXp4GSNQmyQBGP0g0iUH31D/JMnWbgTfWaRldyNUtv/24cZTIw9L
	 37EePy545xT4z6I/1Miq0MkflSivUWRYPWuxbTgPhNzXLPxKAhlRa4Q0CZsuC4iI+JnM6
	 khOGHu7W3S/vKbFa7U5Hd8Eq9aRJkhGFaSIn1FjT77bGflFjPAXnTVXXKBpMWbRqbRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jcqBjeP9;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF660A2609
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BF660A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jcqBjeP9
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f6295304dso3277522eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342268; x=1794947068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
        b=jcqBjeP9L1xp1JklGYM0b1vT5HG9543QwujHEfMVyjAPCMy1Z6a2WjLK/Tl762SFJi
         UfnBKtuHG7xIgvrcmWziQRbrx3Rl1pipPKXO3jAvVYOuhTQKXa2xyePhgc4jFBdyGKJV
         0OveURAQ+4+DKhtsqgMTu+6eiAg5d3BIrjSN4zl8G6KMfMYX5zo9p94MxmLBvOVFsjat
         FFEeM3SLOz7sUsMavU/8NkBT/oDHo1q+OEuEgBY5m1b8YIWPzvPr9EZWFUkvsmeruKGp
         RdTI4f0y9C5oqjnmTfd+7FvunT0vn04W+FqOHN0fvZf8UAAhYAx3SKfSg8Jit5ew2VTt
         +WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342268; x=1794947068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
        b=mC00bJ7GKf0TbcxoHX+OA9NgkO8vMoM2JXryszr9bYS6VRObr5FGpiqVcZvOf0EoLa
         /5SE67nmiRswosgtSMs/pUAA13A9rRzQLiiH6y2pnknA/mRMmwjdNNM8mURbKq4RhCuf
         eNm9Gozg6DzVpO3lbXCn64sHL8S3k0FQm1+56jaySVIRwYOoAFPfTkWpYHclc/QOHrXy
         yQ/RTCogRj+k+saBaqkQ1MFhOYnLd0CmMjqnb34bsx9DlGji9Y4sYlrOl3yTiD0UWURC
         HzG1xze54+JtYvB7AO9AqvBG1IUYo+BpUrDFd3iIEc6c2Nk+cKGsJBGD2xfH3QdWE8cL
         bP8g==
X-Forwarded-Encrypted: i=1; AL+hErE3Nr24SRRxK1dRdhI783lfr4NBkCzXFMJmMuS+0R/KXYgaNDn/6FL4ty5sVRcOc31+d+JZvGJ6soeZy1FW2uVnyaYTF6I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lo3986/f3KAH6OK5WAK1fvdP/ZJWfllhKT1Tk6w2W0U3N/w+l
	Mi/upio1R9oZSyG8WJCg9YesmKpNhD6EqGdW9U3+Su5QlD7LyZr94hBuVgP7XilLnB77
X-Gm-Gg: AYBFou1mFsjJgKY5Lx35My6RqyD1bUXdx+VSYMvdY/8tbZK94V0MjYq/N7Z76dO40Sq
	T8YlQb2j6JUVXWnNyUJ1saBsOs2r4S19Z/qO3Zan/N7159m2yfWorPQ7MPX/cKKFw9h04HpPt+b
	DkLztZ8UFe/yL4xc3Yw4tO7V6kh+ySksOCmg9dN7lAykDtXJtRO7c1LL/W+hifjHkjbbg7B9U86
	9VmWbB8DolbK5Baptq77zsdQQLPYzlVeBT7As88r2p2ZXFXBREEpI8EcUzQxVHDOQhGISR51Lqr
	eJX9f+fXhs5A3e4kk4HAG8hdSKEOmoJoQsFpZE2PklkyDUs6vpqzUZAjkdsH/0/HEmcV6xReWxL
	y9mQL+fNyYQ6iy/V9BBnNicLOa46yK+WufNs4/UHF5iVrzEuzb8jpq0M9Tblp7hKPnVSwK+Vn7r
	iI6aqImPPoMzHjUWElSy8m0OgaPzPaWH47UB/kmoRLKQjQEa7pFLu0n5Ina2I9Db96qI4kiamMq
	gtj2rXd2pYdsGerJO7zJSN8uR2d7CG9ZpNKzTR5yMKJlcqjIjYKF4oK6a+y9L+QHP2fomwGZQgd
	dJKXa96HquNqUkIob+vEOtfo3MhPCjzd5OwPHEOUZdg533vWHUZAu/z5j3T/zy54dvqiiXxH5z1
	d2oYZA2fahqQB8hu7Meue/nPC+rFYqnxRUz94tuVbeXOzF6lyHzBm1A==
X-Received: by 2002:a05:7301:488f:b0:376:2859:5b2f with SMTP id 5a478bee46e88-3768675d705mr516619eec.25.1794342268101;
        Tue, 10 Nov 2026 12:24:28 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.24.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:24:27 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 6/6] MAINTAINERS: add an entry for the Kernel Assurance Plane
Date: Wed, 11 Nov 2026 01:52:46 +0530
Message-ID: <20261110202246.274-7-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the KAP maintainers and the files they look after.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047a..0946d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL ASSURANCE PLANE (KAP)
+M:	Ketan Bhardwaj <ketan@armoriq.io>
+M:	HARIHARA SUDHAN. R <harisudhan@armoriq.io>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/securityfs-kap
+F:	Documentation/security/kap.rst
+F:	include/linux/kap.h
+F:	security/kap/
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
-- 
2.53.0

