Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DC2F5A2C
	for <linux-security-module@vger.kernel.org>; Tue, 21 Oct 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049686; cv=none; b=psdIPz3xe1aVqPnF3JCNgmUnza2vfhveI9exFo8RbKvjNpK7iQO7S2EPgNoZIdPtLxc0sRtImMUESF84xpQE7lYiIOESt2ZDvec4FkcNagy7gOA5vrPafF5QK6Xp/vRBtXaOifJhwo/vS1jRNxydKVVmeE+SkB+IIpvJcVzjVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049686; c=relaxed/simple;
	bh=x3tqhV9Olle7rmOnzByYzJ9ESWOMGf4vmEoK23iSpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tQ2d7caCBL0tAPNZCd6FdC+PEp2dTq6HLmGdminzO8gMCoiqP26zglauN//exMXdHTeFpobEaxOe/gAhVSNuQgmQZ2ceoEGm2RszHoagp9nX3HqQRDB5rOSU6fPFwdPN/90wwCycfBr1zBt587WjGoVdm2bFaKNi0gcQpDE9ZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3yhpWXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3yhpWXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
	b=L3yhpWXmfwvZzAGufvBNeAh2A+R+gbhDI506RH7QoboLAAE2QWYnHcBHxrmAQE35Ou6WKC
	tkh8EW7SyrgHThLvjYJkqxBaBhkt82erGBC243gpw7gUPPb9LFQCfnAoCKCcL9E/KQeiju
	CE7sn4Ilp08eiiewKcP7G51nprWUhCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-cp27nNzDMWqxfbhZH-sA8A-1; Tue, 21 Oct 2025 08:28:01 -0400
X-MC-Unique: cp27nNzDMWqxfbhZH-sA8A-1
X-Mimecast-MFC-AGG-ID: cp27nNzDMWqxfbhZH-sA8A_1761049680
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so3324520f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 Oct 2025 05:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049680; x=1761654480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
        b=p0dBAgRR9pvudxlElPiyQjIGGWdF9Uj+qEq18IuAtGGuic7OSksfnN5B+DYa1unrrN
         J2/SaxFrDcObV1tIdoEtnu+Uk8RqV+iANQec1SZHYFwCQsgbUT446BvTEPn1NYtOOYUi
         +uhGDqMzvwKkgGKzWR+QjC8Jn1JZFgbI3Pi6gaaOjC3JmQ5Ml7nvfYAqLYEcM/kYEufa
         0pkamV5sunjnkzU0V7VwbO8RSjbA9H5iak4CV7+hnWduBlNSwQc5Fyh55IRTP2HMzCrF
         4STY6qbUR/eqmvGXI1BSwPLiS+fGtm9VWkFaRExAOL69ebriiIuNAlxsC/JfFyztouHp
         Ytyw==
X-Forwarded-Encrypted: i=1; AJvYcCWsiuX0KdqxlGvc9xQc+ePRig8ZjfKwUls1ALcvcvq4nOArIAYXnAL6bielI7VzeTEFDy0tf1s9hWmCKhc/8XW6nSZUhO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxOJQ2yAaKMdLEczk5yqpau4eEgHXmJ7xtzFxgk+LTzGf2/2r
	y476huj5uuspgZtUUmJvsCth7te1OKU8LwmYUZ/8QhCQ5T9YCrqi0BzaC3eJA/fwhScld6QY39s
	CUval0c9dzxyYEU28qhYI0+pZ3cVA/v/BX5/pxvZFy8AUcKn+ct5wIviJ5Mt0qlAodNTUUfHyKV
	Kl8g==
X-Gm-Gg: ASbGncutnmW9cJOxYT/xaorXnH7uN32I7KRN03LXkXsPyMXEmcnK6h6TbVp6K96oWUh
	7ej6QRCo7EIZm6OIpovZ+sW7FvlAnBclYbJ9S9+d2op+XzKVAJck+8IQOry8POXiLieUxtcMOl/
	o9doE8O8v6yJb6Nmj5OI2c/SkrLJW2Q3Onkjy2GvKoHQADl8u0u0yyJpsAScrqhL1t7PjXwzqK6
	8Ovhq8KpWdA3GvJPCm/slYNZvDuv4GVcia7B9MFeYczk5MCT5WAC1wq9EnBUGfSxERQnjyUDteZ
	luEYrlRzUgkh+iLVCxgg+xVLZ+Y/Zxow11kTFXnkJIiBhwgkPbk274hAe9MotDnkrw==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668348f8f.18.1761049680414;
        Tue, 21 Oct 2025 05:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1T4QV5qRlsX4CYwsG5oN1xf2PIguQmX22CXcPAmlJ9zIRBsNadHzlZspnxlqbPcWGqFc5PA==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668326f8f.18.1761049679993;
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
Received: from fedora ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm20425188f8f.21.2025.10.21.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
Date: Tue, 21 Oct 2025 14:27:58 +0200
Message-ID: <20251021122758.2659513-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gem2gMBeLn2ld4iHhMf-oYpFcdlG0HsnFXhfQBAfAyI_1761049680
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v1: https://lore.kernel.org/selinux/20250806143105.915748-1-omosnace@redhat.com/
Changes in v2:
 - just silence the audit records instead of switching to bpf_capable()

 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e40..de5083cb1d374 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2701,7 +2701,7 @@ emit_jmp:
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.51.0

