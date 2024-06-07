Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107419AA62
	for <linux-security-module@vger.kernel.org>; Fri,  7 Jun 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776485; cv=none; b=ZUUzV9odf8PKOL06fGMiEIA1iYfS02TdQsvZkcxNllezLpUVzqIt4yEvX8XoyzJMUwpv/7Ri2Vmjz5J3VequkzF9p+uEN7sxEbyuhgYeXnAoB/2dAL3WKpqYvVFJ6UZrWTmus43LtL+kg2y6sI3322vRuDs5LagGZGsZvswhBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776485; c=relaxed/simple;
	bh=YgmzlEZajTJwWqIWiRCWdSe8ddo/mS7cu6s5R2/CTYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6q2R4RAb2OTzG/nNp11vgAOwNB2m8GqwM5hu+VGw/QS8KiBr7KqgdSyGklCpgFhlIgxwVkIIxk5dJ4jwkFXUmvuEDNkYgNErMiQEYT2xnmIcmJuf1tXaiUmUfHk55HuF5nK2meDOpMTgIa4i2bIgC4nPQiBqAMRXnrfDWQHvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBLTm3ya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBLTm3ya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717776482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TBI1j6kx25TFs50gZy5PJ7jXuDWillUKGNEfVq7Zbs=;
	b=RBLTm3yaIqiVi8U1p+H5zg1S2kifVItFs1ORp2ltXEhhfhpSCI9Kf4s8LLjtimXuouMSXi
	jlE3MWN278nsOV6kfJt12AiHoyIWc0w2XxUG82tCORJJw941VYkjYAiiRHYwl/WUK8qMPR
	hjhaapp3zG/cxLcQG+zf3t4zvTKEgFs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-DlTiC_uPOyC2nXqvB5TglQ-1; Fri, 07 Jun 2024 12:07:59 -0400
X-MC-Unique: DlTiC_uPOyC2nXqvB5TglQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a592c35ac06so229307466b.0
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2024 09:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776478; x=1718381278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TBI1j6kx25TFs50gZy5PJ7jXuDWillUKGNEfVq7Zbs=;
        b=dS2qx2OppZkNOq7hWa8YgFqHWLVirTCbAplMktgANlMZMio/80k9is03BPmv3FQcUR
         wbaXZ4CW96vdHAKDkZZtu9kAsjdp27H1++INxI6I/iIg7G9A7WX0bP7J5ii/m1Gxop4y
         mx/dAQEsagIYPyxMt3hEB8xOX6X4wQk4C3VQcX0OKjD/ucsj5S0/C0tBvYIk7dvaoDc7
         IaT4wiW5mE4faal3QSJAQAgho2XP+26fcFpK4XHbJur35Tdsc6GFkLsxdQAs8q1Qp2Mi
         5VBUhLECpryJPIdfOSgReKfxNlR9iYKnKYNgxMdNOdQhCJgrrVLYyV06BwmxHTIwuq5n
         a+5A==
X-Forwarded-Encrypted: i=1; AJvYcCVkV01d9mtZwBhf5mT2E4xUjpgGUwLxv2cPr/Kad9ays6qrL68UiY0KKcAIyRCjHNoLAiNT3dvnV2T77+Wzo8yd2ntBs3A+26dvRFaRkFXs0pFBX9nu
X-Gm-Message-State: AOJu0Yy36lnGGVln7nGS02eR1Wu+IaSQhpcEbFAbaDEfZWZNAi6nHrDr
	gkhaaemi97LnAtEDOpM4PJMDN8zKTYgtcpjmUkiUukpgzbgYdjk/ZsLKrqD4vo154FRzuFMUrMf
	txsSMmcbCEFHzRO6bG8b5P6r338vhkreYV5pdTtcx+6Cs+if4xi27ZvlHmfXEU00+/O/32j7ZPg
	Tsif20J2mW
X-Received: by 2002:a17:906:3c6:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a6c7651abf6mr482856266b.35.1717776477948;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KUiDsNlI7ASi3MzLgO1C/g1AGhrUFu1XlKQH6QLi0peo0XwsPFrtQxIXKCBtcB44XE8hlw==
X-Received: by 2002:a17:906:3c6:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a6c7651abf6mr482854966b.35.1717776477630;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
Received: from telekom.ip (adsl-dyn127.78-99-32.t-com.sk. [78.99.32.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ebd59sm264672166b.116.2024.06.07.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/2] cipso: fix total option length computation
Date: Fri,  7 Jun 2024 18:07:52 +0200
Message-ID: <20240607160753.1787105-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
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

As evident from the definition of ip_options_get(), the IP option
IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
the loop that walks the IP options to determine the total IP options
length in cipso_v4_delopt() doesn't take IPOPT_END into account.

Fix it by recognizing the IPOPT_END value as the end of actual options.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index dd6d460150580..5e9ac68444f89 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2013,12 +2013,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		 * from there we can determine the new total option length */
 		iter = 0;
 		optlen_new = 0;
-		while (iter < opt->opt.optlen)
-			if (opt->opt.__data[iter] != IPOPT_NOP) {
+		while (iter < opt->opt.optlen) {
+			if (opt->opt.__data[iter] == IPOPT_END) {
+				break;
+			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
+				iter++;
+			} else {
 				iter += opt->opt.__data[iter + 1];
 				optlen_new = iter;
-			} else
-				iter++;
+			}
+		}
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
-- 
2.45.1

