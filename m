Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A9379C40
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082708; cv=none; b=MApQ5RmEle9BwsoarvEllm9eNEt2vNL7IIbZ+T0dhtJF0vqqF+DJJC2DoAGYwtaFxNdjuS4O4bEwBfgm8CzP1KOBHpzQuFxLwQmHSYaDmfkm7WL1uWaKw6LkpUFT0ypFuIj4vJQk1i+IDFaKo3sE0hadsSshXCeP+4Aw+OED7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082708; c=relaxed/simple;
	bh=zSdAoshV6PguyX7bw95N4A7c09eJSx5mBc5Ua6Jl6bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/Bv20FpZ86dQvBRC/Mnze8ZSXKkV2IFMyvWEfacGVef0HDyn2nXMUyPE62AKSUuQxOqbbZRnw6kK7ujG/hwk9V1OGBPkiT+29pVq+wA0Miz1VdAtgSQJ0hiMxUlNkobOVFQGWcPJJth9As72BAif2vb//2V+R5F0OYlANIfE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c++GlGGB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c++GlGGB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso2985e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787082704; x=1787687504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgP6lQOibHlCVKVmBeaw+pleu+P2xINjgIC2sMiWwBc=;
        b=c++GlGGBK+doUn7LFPs21SC8bvcP6KRoJGN2RmCuselaI/4uem8v86Hssk6aPdBOij
         F0aF7gdKV/eMRO/2Vd7+i6MdcSGx6UhQ65wtM+LAm27ND1nLM8b0kpfL3Lb3G2AhXoEW
         OkHR4kclpgOgHY2aSjXs2v37jW5/RIf6iqtqc8Aki8KQ1eUv/pU6C/XcBthEC9MFC8JD
         Zdh5ErUBsMkOG3AEB/tuIYRtW65xt20j4XeLrXcApFmTGvOf6tOJlZWQM6Tmeh4CdVdU
         0vK6gqjmYhmHsXleXDlKE9ju+wDRajBwjT1xfrU41KqN1U5JhhaWgcbghv9KvR3f4D+R
         Lpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082704; x=1787687504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgP6lQOibHlCVKVmBeaw+pleu+P2xINjgIC2sMiWwBc=;
        b=CbvIGQnOL796RJQq0RmIrlferD/Bb2UA9YCz8BpwRzTZlIFmfZd4/j8u+4IIPgsbH4
         regwaVMgpM77/yDR03KMHTVMLQJtegKvnl/u6eG6avp/crL6bq2rc1lEw9XBzvK3u2Pc
         NIPnBIOlkf24mtGzxmqVWONLdv+BkcOlJlOC3ZvYQf+mZB9nXDcpUx+YExrBjkHAOoL9
         b5D7Dahj9NMyUWV1LB3PfSirFh1IpVg1sxnF2WmZqF5ryerzZMm8F0jy4Sn4KGg0oyy5
         M3AKVe6WSmH3sjcE2RgZNUzeSagTCYx/C0cRRqJmI5C5ATBXQOau5mZEz5+MsiWL525t
         neIw==
X-Forwarded-Encrypted: i=1; AHgh+RrgIoL8/jSe94wnPvpAhc+kQC94ORAnvX07/8f7kYCkFJZ2IUO4Ln57eEgBI9XUrA2ACTD539Q+hrfSVXOrO6xEzfLHOw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfQ4h7SZ4Vkp2JZm73amMc/D2/efyNuOiLxrJy3shtti978tt
	EFBx2FWanmlgE8TdApBb74NJhqmlYxJynmjPaZRo2fhE9hIMdQ0QZ6z1yFsCYuH8OA==
X-Gm-Gg: AR+sD115EzfgusjteK8FIH+FU+3nfUUle/sGwvyuWliF78KeUulapez+Sc12y8t4RB/
	jgQkpp7+EblHxhfZ0BQKXGTpZUWhL7edg4sefrsqehPSP4Fe0Y/buFARMi5OG1FM55VBdSbmIfW
	mdirA7EjLKIf7CSy0Ll2uNpLZ3iYC56shG4y2UOBN+xKI3D/kw5Ve43AYZAncBfbYg7vBrfQmmE
	6qqv3N4nDL/mamYczca2QwV9eKlz/SXWm/E6uTYPGyjRr8Xf3lmLUkvDMjGhnuQ7Qcg/uWsBPVs
	WNE3Y+coalUvhTMM2ykqIjLQRMXqFEWo87ISM1ReYk0AquKWEPEGZvLIK0HJXL5nEPFy0FBKLyf
	aLWWt/vdLdymd5fbHx0+YtBrwzrFI8LIP3C2so+RWqxvJDfBzUy4Pb6Ou7bz8fBatei/1nsQeLh
	ZS++BujrA5KkZ9DOEjf+UUtfeNxMJLNArNpXlKOWlw7ThljDUeHeLuarIAiOULQll9ePsMlTwdy
	B6n0SeKUGm6aB8YyzI9l0whrvxlMI2D7tS5cB9kWbgHQSBC
X-Received: by 2002:a05:600c:8905:b0:493:b169:784d with SMTP id 5b1f17b1804b1-499a98b8974mr38235e9.8.1787082704117;
        Tue, 18 Aug 2026 12:51:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:f466:5a15:1301:318d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm13393110f8f.27.2026.08.18.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:43 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 18 Aug 2026 21:51:07 +0200
Subject: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787082694; l=2735;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=zSdAoshV6PguyX7bw95N4A7c09eJSx5mBc5Ua6Jl6bA=;
 b=Lyhniy9H5W1G2wuKZtV9Z+ZJwr+oTZ4Wxkivk0swGQT5TVkCUpGEnUh4di50Ud5ofYDrM8FV3
 hG088NQOnE8BjBxCnVn9kU0SPcGSVr57AdYgL4wVzDxIO+bERsoFvU6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
only create anonymous executable memory via /proc/self/mem if it has one
of:

 - EXECMEM (like for other methods of creating anonymous executable pages)
 - PTRACE (like when using /proc/$pid/mem of another process)

This closes a hole in EXECMEM enforcement that Project Zero has used in a
remote Android exploit chain:
It was possible to use a memory corruption bug in a service without EXECMEM
permission to overwrite executable code via /proc/self/mem, which made it
possible to load and run shellcode with a kernel exploit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..905137c47321 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/*
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
+ * triggers on accesses that are not visible to selinux_ptrace_access_check().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_introspect_mem_foll_force(const struct cred *subject)
+{
+	struct av_decision avd;
+	int rc;
+	u32 sid = cred_sid(subject);
+
+	/* Allow if the process is generally allowed to have executable anonymous memory. */
+	rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM, 0, &avd);
+
+	/* Also allow if selinux_ptrace_access_check() would allow it. */
+	if (rc)
+		rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+	return rc;
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7584,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(introspect_mem_foll_force, selinux_introspect_mem_foll_force),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.737.g08866a6d13-goog

