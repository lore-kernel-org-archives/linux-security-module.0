Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822ED28C2D2
	for <linux-security-module@vger.kernel.org>; Wed,  6 Aug 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490673; cv=none; b=nk3Kdof1IKOobwV3JEQaMw4xGBcxlZiHtER1OpyFx3VblcYF56k2jgw/0sGuvCn2IgDIcf14u1HoJSe9raXzab1eXqazylmfZEjqGG+l5MedKA7beuBu2+FTrwZCpLC2fq7SDOh+kgrw9PPkZOpeJMTcaxPsQG+cJ4nfFVCBLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490673; c=relaxed/simple;
	bh=InkPhHeic8qB1Cg9YLB67GOAs9m8OvwtVDVuqy0Xq2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=sB/mYG+3Ft67Yp4w8YBOCULfRUnFWUHD+7Vse0351Vib78c9cB+S1/qJ5tQwJiK4pIdQ7Ns4h16lpIscwyg16ZUl86A1PbhMrr8Cv0j0YqzyPmLcp0+p/qpSLCNmvycqMfPjE0FF8rO1napenb/8NoICFNooPFHx/vJYug6dYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NASi/7ND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NASi/7ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754490670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
	b=NASi/7NDsHuG2Gjmgy5MxXuzQT+hdnHHKPdpBJpuX0niIRASIueMq3tiMJCJa3Bj4Sh7IN
	+vCvAOttwql/IRjNoup0w0mLmBJEjpy69I3j130gcne5rsaiMOFlRiBV0lGlegdkzdxfhw
	TW0YmAgHlNV1OK+LKpeDgEjUbQP+4+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-57sx7xsLP6e80eKf-0qNcQ-1; Wed, 06 Aug 2025 10:31:09 -0400
X-MC-Unique: 57sx7xsLP6e80eKf-0qNcQ-1
X-Mimecast-MFC-AGG-ID: 57sx7xsLP6e80eKf-0qNcQ_1754490668
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459d5f50a07so18939815e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490667; x=1755095467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
        b=Z1/3vTLGYpnoopkNi6GtXH/rOCpty/L0+vaPy+vC+c4Whdze2lrCiTCO3DS0/qub4t
         hU0Pek01Lo0jV6RYApFdH/lVBhhbSiXte0NpB7OHyUGic+gm61sj0mt0nEqmlbp4fJU+
         oMwb/dZjDmyPv4Hmbz6LSd3CIiM1+Z6C6TKashODdZ0sS88eHba/k4mzE/kMr9BZAk8e
         J10OjwL/ARzU9XtSYZzkdbZtd1nn7+GOZvDtlWkZ4dSDzJrXx9tWOr4PMr89mN/BNf98
         rwU3yVMCfUyS0qzrfEN7PhDgxPN9cyfn/9BjSvysSpwM2pMLGum4Rpgr5iHxSbMzdrPi
         NvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/y/2bEp06QFctaoeQ/fORbqI3qAzw1L7XtHyvp+YHfRPRjZtB8knWd1IEhEfu0kxFllD6OxqdRsP57efnVSIySVgH1KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGUrF8/NmYgFCD5mLbULu2lPeIcb0+XLLU3rcdaBEp8EvbDYx
	Pnc4YRMo6JYPw+1hcvunCgvtClZzyq/nBWh/kO/MvPi72OURhVZzytK7HUq8rPaRNx4gIcKbkKv
	nxR1SmotSyTho2o1qLlEpRacDXLJseEpAHVySCtarHCHg/6FId+dm7bPdUAZI7HQoAq/yzbJZ5w
	H3AExyfRQDTg==
X-Gm-Gg: ASbGncstfB8F40oXt/PRD4lw6bs/I/yzfwjBep9ZNxczs1gnIFpg448ORJqBYroD0cM
	GdwiSpmydqXAZvPTUr5YafINZIVzFg86yyDEu27FdKcZqAJd6u0EhrJMLdjQIgVgPp+1QDHuLG1
	+Csbm1b9HYBUoHOYgPByT1OqWS7s6jrFIYUIITOnPytdPYWVv5TfgOURr3vCK3MbXP2v8hZTZlz
	gxLsakgzFql4Q5ilVR9wZx7sK5aLksE/eLOzAIWNGCMbP7mvfvOidok1g9vrlZ0g2c3SDEk6iQ2
	AAcPV4UF4VZIkupqrnsweOpWjbC8U93pEJ0=
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658544f8f.48.1754490667549;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiJBQ1yelVUM9E1lMgUijAACK9NPTXg6PpQUczFaIPct+wwXKaPFImCbN1OzlcZ3oUMOB6dg==
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658518f8f.48.1754490667074;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm14204156f8f.43.2025.08.06.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:31:06 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
Date: Wed,  6 Aug 2025 16:31:05 +0200
Message-ID: <20250806143105.915748-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJ8RDMjnYXZGW2VtvMIqpTAEQTGBQsmjS-UAAUQuud8_1754490668
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
use bpf_capable(), which checks against the more granular CAP_BPF first.
Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
under SELinux, as privileged domains using BPF would usually only be
allowed CAP_BPF and not CAP_SYS_ADMIN.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc1..2a825e5745ca1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2591,8 +2591,7 @@ emit_jmp:
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.50.1

