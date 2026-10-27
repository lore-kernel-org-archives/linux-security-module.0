Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101410;
	b=mrvOcBAKgprYf6YUdqaglox4hADarrukrpxIKnLeZvWk8qcWPt9TuxyILFi5RPRoeAu0
	 pxl9lAxz13WIeRPOPZ5bTj8z9OXrN6tp1oiQnfbahbH6pbQWu8iJOckGBDk5SBr493rqk
	 +nnRctVFnKoTlt/z0yrzY5cWOH9skjPC8dkT9cQu+q8HqBWNFuaW/uHdIH1hpGuH6E9ev
	 ACdPWNWpsHcnGkmvZ+OEDbfeIDygGZ2xST/L9l45k5ufGPEsHnsGH1DisKlksW4vlcCQs
	 oydYDyQ4IpOdccKc7fzZU/YXOWfpENoUwvXljoWDm9q7y6vfwxTEMsL9lceMJVdVSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
	b=AN3O4QAXX+++vAORrhG1EM72AKYo9326nFlfEZQRDsm4ymyRrgBqioICtE6RK6hDwQPX
	 8AmxjYVpFklr6g6qOLTs8KFgrT2WyeefWx0ENBgbYevYQcP5F7a4sUtFqtt8G2RdKUNzj
	 soYtp/P5F95lVDMq4NmVqmgsICRRCDubi6HWiolLrvDGlXRB/tSii7fYEqvpOVjIZdXug
	 9cPY47pvI7N4g4Yd6yredXyUT/mr+EpJ26rOVSk50jOt9Nq8DGVgslFEkVAVOLvaSeNlh
	 EjYqO4/7jKy9XUcWM/bz8dMSKBWSapg3H9Bk0oJfX6LbHskyCPOqlB8q9mr0dAS9EkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="iBOg8BS/";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7B606A87E
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 11:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13D7B606A87E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iBOg8BS/
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9eb579c0eso22918825ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793101409; x=1793706209; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
        b=iBOg8BS/AfD0VOTVMWP3REB+11vPV7w0ToTM56EJrWZAxVXDxPmG2MqW8hvNvUbI+l
         YLBtKH1cr2sx6cgkWNqYFi3Vz8TZKPEM4+mP4lXO1mL58LsaQeFs/aZsyjGzeSlcZ0Lb
         r9YN/CYxzdAX9OSGZqJcz9kVZHtlPumWOo/gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101409; x=1793706209;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
        b=ujuc6hl6y4l7r5yAWuXulmZcG7w6hTljBssSDstaSv7qGDHVHJfp2r9ZccEZEo5oq2
         9CKpWVui1ut4lM8TAHzN/lvAMObSVEf2ciQBL2XHXx3UnCrX4cb/+H9vnCl3b3QC76om
         OcdSR/71UmEW3d0Pz9VCiKxlRCUbdkQeYjt6T/xiqAUvZGl9pIIYnznG504oFwFAt61j
         QcrsUPdjcv6Oc5UNGxYUibY9SwwH076p3zTSbHn0tf3pjvjpxCbWQFebiXvxLT3aHDkC
         zaGPusFIpIrKl4DXMMipQTNcLqkZNCikqjkzBInMvhXAxSuyoPIUeXHwzJcaLouVjQKd
         4TZA==
X-Forwarded-Encrypted: i=1; AKwUvBw7WciCPXSBOwXDi10En1fKWvdvcCUu2NKkeoAPSgjvbNUwP414FQBaIOZWUFWGsrgDZWUbf01WpZ7/A1phDLpW/K3SmGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQy50WM2ZcQ9iq09dzuNTNoDpbWRILtkE60QrqlSpTb0X8RB+4
	No5rKJut2ZKRqRQ93v2OnUP+JKctD9+ku3XzbL5IVMEcUguSSjQkxspRGFrF4nPm7lc=
X-Gm-Gg: AYBFou37Sq+hSRQ8UHkzOPZVGSGifzOimObXJHEseqkctN2Gi4L7ewzI4MaXaYRplDG
	KXvcSn18Ehdigj5a1rOxiAyhDdAHbhZlPrIgUmAWalt0xgtgZ5j3P0jHhtRB4BF6inxbHDvtOrr
	gmdmgdzaEewGXwoj4tv+b/hj85+8JY28jib9kzoGvUOd7ICO46vOqVtRfYyRl2NnT/RjvtU8c+W
	B2p8aUbEU+bmOPagJ1ASQ3mkBAdjH9zgGdnCfzz+Pj2JqvjITTPzQoI/ABrLSOIyFa7nhax4SVH
	YXLnWKrajwVg1gsPaiDmZjEqRR56h8/LgI/PlBfjJa3Kz1zXcsL1F6fcZjQqKrtlH85ez8th0jA
	14FhELTmIGnWYskPMEFn+xvBaHBRiqCodvZy3CW2IbPeZhb4XJi8wBIAvjUuXwBZZn1bpKIah1W
	WCVWG2z0FQfWqGvOYhyxgYt+Y+jxsEem1UhJlpdQgZYm8L1RMUdpm6iCrIr0tHmUzIF2/n3kF9f
	MHmdzVo6L3aFYWA6bqwfd+Y1cw70DK4WtP+zKyK6OliB8p4jq4NCoNt8WD0zohvta3G/Ua1jyET
	C5zyPnjn52hNuch11GxJRLhLOV18AsZAh8XX5KeNOTKq4tcSMVp5D8K3jVMmS9JLoZ5w0a2h3N8
	NGUzdqJBNvBAAIkVIBMIMNS4=
X-Received: by 2002:a17:90b:35c5:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3adeafb079amr6566975a91.34.1793101409391;
        Tue, 27 Oct 2026 04:43:29 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adf8f3f22csm7120822a91.3.2026.10.27.04.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:43:28 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:25 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793094611.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
index ea75ad537620..83b4fadfbfe7 100644
--- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
+#include <sys/mman.h>
 #include <sys/utsname.h>
 #include <zlib.h>
 
@@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
 	EXPECT_EQ(expected, sealed);
 };
 
+static bool find_vdso(unsigned long *start, unsigned long *end)
+{
+	char line[MAX_LINE_LEN];
+	bool found = false;
+	FILE *maps;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		return false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, "[vdso]") &&
+		    sscanf(line, "%lx-%lx", start, end) == 2) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(maps);
+	return found;
+}
+
+static int vdso_is_sealed(void)
+{
+	int sealed = -1;
+	FILE *maps;
+
+	maps = fopen("/proc/self/smaps", "r");
+	if (!maps)
+		return -1;
+	if (has_mapping("[vdso]", maps))
+		sealed = mapping_is_sealed(maps);
+	fclose(maps);
+	return sealed;
+}
+
+/*
+ * Unmapping or moving [vdso] must fail with EPERM when it is sealed. When it
+ * is not sealed, it succeeds and leaves glibc with a stale vdso pointer, which
+ * is fine because each test runs in its own forked child.
+ */
+TEST(vdso_munmap)
+{
+	int sealed;
+	unsigned long start, end;
+	int ret;
+
+	if (!find_vdso(&start, &end))
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = vdso_is_sealed();
+	if (sealed < 0)
+		SKIP(return, "could not read the [vdso] sealing state");
+
+	ret = munmap((void *)start, end - start);
+	if (sealed) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+	EXPECT_EQ(sealed, find_vdso(&start, &end));
+}
+
+TEST(vdso_mremap)
+{
+	int sealed;
+	unsigned long start, end, size, new_start;
+	void *dst, *ret;
+
+	if (!find_vdso(&start, &end))
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = vdso_is_sealed();
+	if (sealed < 0)
+		SKIP(return, "could not read the [vdso] sealing state");
+	size = end - start;
+
+	dst = mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, dst);
+
+	ret = mremap((void *)start, size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		     dst);
+	if (sealed) {
+		EXPECT_EQ(MAP_FAILED, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(dst, ret);
+	}
+	ASSERT_TRUE(find_vdso(&new_start, &end));
+	EXPECT_EQ(sealed ? start : (unsigned long)dst, new_start);
+}
+
 TEST_HARNESS_MAIN
-- 
2.54.0

