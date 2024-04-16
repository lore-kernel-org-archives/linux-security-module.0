Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAA12C7FB
	for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281362; cv=none; b=IucGhvNYxlZScBdia+E1xs1gGxtT4WcYq69Oos2qMaFEhz9beEkvEQQOXgIwoBYhshhZ5ec3EaPkJsDCavO8kWwCHy8Fd/Um4/zYHxlGb7H4qKc7i+HZMepTJWMmtSln6wuOmDUnukEpQ3QVYpts82hUqtKrKFvf6ELL/gerYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281362; c=relaxed/simple;
	bh=81l9LahQytujb7cMyosnjzKZfq+r5bccBitCOg1Cmxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KpbVG8ahiDEWj1PnkLKAiBP4SFhr8wRPMNHBikdxOsh4XGsh0JFCblAIQq18GEoZ2y3+xOwaeb/94QO6VedbA09Cm1aq9hXM4SWMtLrV+Tn7cLzJbUbn1YFgzxp4b1Z91z0uGrvWVF3Wj3vfMkC2z2Lbd3TlQlCZ5s+WcHJsLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhzfpJ2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhzfpJ2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713281359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MxeNWUp9JUwY9cuS12LnzHtAblKzNIcTzbXO97988qc=;
	b=hhzfpJ2bc37Vx3wMfvCWxwZNf6hhuzBhWbrQsTKKbnyryt61Y6BpaRRv8rofWeedb9RAiW
	tA8RTCFU4Mcpb0/Ny3gsS85q66OLpfedhVU5E8vFqNzCcrh9IVCTrqy4ZwSufp+tIbEDFN
	aS0G6n3gzoeaZ/TMeZOZ7FvJzPH9a4w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-h88hBsQ5Oaq-ilEoi53PXg-1; Tue, 16 Apr 2024 11:29:18 -0400
X-MC-Unique: h88hBsQ5Oaq-ilEoi53PXg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d884b718f1so41097351fa.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2024 08:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281357; x=1713886157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxeNWUp9JUwY9cuS12LnzHtAblKzNIcTzbXO97988qc=;
        b=TjbghG9/JzhbLt+Ssy9YLXj5CDkq59GQox2rozDKhPNt2ICg6Mh4eKAKuwdDwqGz/p
         kyjMs3QFc3xknhiiwF8ertSSaM2D4kuvLstN23LM6m1LAdICI8lZY1oWys+9Efz+IDYb
         mM5cFC4IYPxz8IfgeVPCNhsTQEwpqvqn0aOdwQOay7cpomwXQgCSDFb8dPat1S104P+A
         baSsmTtPVDTWYzItV4aDQHV3qpSJPt+wm0wc4uKsaW/jIoq3O6DzGb+KqGpbqSIadwoA
         TiuVnP5+kLdT2KPEOAVp/VmhXra0RjE+quOwumgjxOlasR5IfUssQ+cVW4r9bf5+8VOT
         XY7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0RfaPXCX1tSNyb9aOZRtAgqEGuWrslh0g9W2CIqfr09LZ5AXcPbNbrHgKzx8k6iTkPl2F9P0l1VHCUvfsWGGph8xkmVwMKzrCu7GWA/i0ERZrILfJ
X-Gm-Message-State: AOJu0Yx8qcQoREOcJwFMOOhneC/jLaFEPzQbt9BhBjDFhvUxCS04TY0a
	y43M+lL2l64HP2Sfbp2/xXrp1mYx25oh9nfRaDoE0tjNjeUt8sO5fDJYSnY76te18+tS4I3D9PK
	fqNyPVpMnlZzxDbt4UzB4ALKjpOQkLHpIrbmStnNl1Qr6dyunq5/i5aZiKJop6gpX2ftHVjoRyg
	==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr10016691ljp.39.1713281357088;
        Tue, 16 Apr 2024 08:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa0/Mtd7fT8GMCt99FDYYrsTJTdiHZDQfVgiPIlVTRCX5bZs8q+LO8aep+PkaKfMhdbxmpjQ==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr10016667ljp.39.1713281356669;
        Tue, 16 Apr 2024 08:29:16 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm14695155wmq.11.2024.04.16.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:14 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Tue, 16 Apr 2024 17:29:11 +0200
Message-ID: <20240416152913.1527166-1-omosnace@redhat.com>
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

This series aims to improve cipso_v4_skbuff_delattr() to fully
remove the CIPSO options instead of just clearing them with NOPs.
That is implemented in the second patch, while the first patch is
a bugfix for cipso_v4_delopt() that the second patch depends on.

Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
https://src.fedoraproject.org/tests/selinux/pull-request/488

Ondrej Mosnacek (2):
  cipso: fix total option length computation
  cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

 net/ipv4/cipso_ipv4.c | 80 +++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 21 deletions(-)

-- 
2.44.0

