Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E233C1B2
	for <linux-security-module@vger.kernel.org>; Thu,  4 Dec 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853167; cv=none; b=TY6ql8LBrLicnecvc9F+3K8zSLrZtA5YlfcvQUanc2XYylBbTl9YzmeHr0Z3/2mMba6ySu5xo5Ms7f0actx+SthJrUxfOYZi3yn6KdTdxQZs9xpWq20/1TMc406fIo6Z4GEjR5UZVbidfrYaQApaFjwy3Z/tpFXKe1J2KB+s7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853167; c=relaxed/simple;
	bh=hDClTYUke+S3lw1Dam2zNOlSPw5NHSqYQafCDHsN8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Y7yc46M6QAHsMwuUPcadS8gKSFIl1n6YWLzkH7s0PMoDS7X9UCAG88IOZ3Av44lKnuWxRgNGiLxPP7Kf8++R+bog3uvFIX7IF8j9xTGYrZdWNvYh5rUlNy4kkdlNMCemhR53XKDO0mtTD7ZHSwJJq2lEgjEgmX5f4xfm+fJMJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJEx2/Yb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJEx2/Yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764853163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
	b=GJEx2/YbyeHR77qrUX3OabNYjs4ACdrSEoGp66gBxhPESAXJmwAsVDP8BE+LBhEMkkQh+t
	5zse8tFRIJPSr3+LbWSiquGD5aHTpOk8u4e8nY+5Q0Ygeo5xLkxUL8E+0wxHwHL0jsVeag
	mJfpBOVexEhfMfSFMbU2tF4E6WC3JyY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tsGbpAVZOjKefj3N3jQBvQ-1; Thu, 04 Dec 2025 07:59:20 -0500
X-MC-Unique: tsGbpAVZOjKefj3N3jQBvQ-1
X-Mimecast-MFC-AGG-ID: tsGbpAVZOjKefj3N3jQBvQ_1764853160
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-640ace5f40dso958156a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 04 Dec 2025 04:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764853159; x=1765457959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
        b=K1Zc3MiusRo7YTUokxFcNf5ZBriSH8wmi8c7PRtmGAqT0X7lWhOrWZ5OiQpIvIGjDb
         zfQdcPclhFG1FPkkjPD0sSoJbSuZY74nKKrl5LOXlZrjFK2yNjbF44pdi+tCDGi/GWFH
         DDlLknknuSPpMSfQKNYCMB2H/Hid7Bq4RzMMXJa3T/bVsA5xpDUjVzv82gcgRUjOanfh
         hLvOAfNBbg+h4IIEHNsgDAzn96mvrHQzVH5lY2MDs30dyE8V5+gEWEImfZcQADCGZ54A
         qG+3xAvmzfM32aeA7Uzb1rxxbBtHLYyAnwcwVkbzjluS8/UROGWvrbq+sD5VtBoBQVUI
         8ysQ==
X-Forwarded-Encrypted: i=1; AJvYcCVImc27tKxfr53quC7ALSV4W+bSPQ/Uv/o5BSBOlsaigXX+5DKA3s/kIXvR1gvwhgTS1959syvAAaA/6g8St5lsuulw87E=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSseor97+mQlr6OERM99UCNmBQIEGOd+VDWOhBquBMR2R/5bq
	jgZlUPi/+SZ53CHa2GGBygbNEX7h9wzCejzJtbGBTHeo+u4uPR304IVgQ1iz5+tCet4na5zkCLY
	WL5JZQeo5usmwZiQpNI0SpNRg+z8GS81KrxyuRfo59m13MXtFSeh+4mGRgWXMJ34EKkUHrUup7p
	7D3ed8lNBRrA==
X-Gm-Gg: ASbGnctwmFgl/1+/Z1RsF5T6ResdpJvMtf1KsD/ohYn+hxFoTX+a2JheUx3kSDoadmK
	0LATTME6sYWn7Lo2k3o1SY/N5s3l+glPh+IzuQIuiTWEUvegR+F1TL18WS9G1L+zrScv9GYHI/l
	rRBZzlhGcoDgTMKAQ0IIkNLsSMAwO+lcq3ZMQVvsnkXDozYrVINvTGSaJsc3VawEQqrXvO3Ecp6
	Bvz2g1BzRR/FbD5yJi5dUOBKkRpx5XuYnMzXoJDMJKP/PvuftfuE/GeHMxD0aNmcSF++M9zPzgE
	GwfXqLTBeYKC9o2nt2gob8AECH+96H7O6QWwTY5lHXf6911+2VJEktMSxP/5sT8y6QBpCMBMGkB
	T1oEvlA==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458532a12.18.1764853159310;
        Thu, 04 Dec 2025 04:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpIWeVg+u1yy1Z+F+69TkiJ/5ziYNykTKxahwDIMAG7zZcbakM3dgVe2ZnEUxhIOcGKQFi7Q==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458514a12.18.1764853158907;
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec319csm1251929a12.3.2025.12.04.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH] bpf, arm64: Do not audit capability check in do_jit()
Date: Thu,  4 Dec 2025 13:59:16 +0100
Message-ID: <20251204125916.441021-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ia0EsXkACSSi4wVngO2UzZmnx4tAIpFWP10qvm0aALs_1764853160
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Analogically to the x86 commit 881a9c9cb785 ("bpf: Do not audit
capability check in do_jit()"), change the capable() call to
ns_capable_noaudit() in order to avoid spurious SELinux denials in audit
log.

The commit log from that commit applies here as well:
"""
The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.
"""

Fixes: f300769ead03 ("arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index afd05b41ea9e6..5823f2df204d9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1004,7 +1004,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
 		return;
 
-	if (capable(CAP_SYS_ADMIN))
+	if (ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
 		return;
 
 	if (supports_clearbhb(SCOPE_SYSTEM)) {
-- 
2.52.0

