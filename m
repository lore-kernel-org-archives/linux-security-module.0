Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B7411F9D
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405776; cv=none; b=D5evqFIQ+6MGT2mKC+VUaGPuU++tnfidoqxyVz6xAo0EhJ++3+5DhHKnWf0783i55Izc2vUfh5xfynGH4EGUAdf1XmCBZ/xlXjm/0A99C0yWdd6DN4sVpULsrJKjfO80Bl7E83bvlhLz6MGsfaLY2kluzEA6w8k3Hg+4XUZi5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405776; c=relaxed/simple;
	bh=qcrvjeZJeNSTn9Fz8mvN7hQmR3JSJ7hXiLENlRyYO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/3NpPxLUqQG8BFCR6S8JKuq2jzF8xkG6HP8wmST5Aqft/4dTLiqf1Ql6FfCo0lc0oaEzgGDWxLaGJSIUFKHGXvEBrPWb54RiL+Kae+k7E7eNiR386uPc498vwRgUHhKAmJw/ruNnPcRNrX1tq6NdeIGq0IzYiAZcTRKYciiXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VhwGenem; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="VhwGenem"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so2288980c88.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791405773; x=1792010573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWyewnJ/gWz839fiiYscHDhAW+308Oy+O5Fj0veyk7Y=;
        b=VhwGenemPVKHfXNyFOpuH2EVRsR0zGQZwpRahxi+WfPxdaTTfDBbw8BGHe2jTyLsTq
         zLXluYYsJcYRXOFZyr3yhA9u79ao79LdwfBJX5SuNZvOaz8GDbkAfPnRX1HOcSe4off3
         oJJDqXvaznaVZ9Q7FuOfQ7oPEVRhUJ/f0M5XFUs3+K0m+5PpCy50VFzxJY61nIbauSo0
         dIOBHoFQivF8ivpuODq2hiCP4JIhS69xxdCKKh3bFnYtlWSI7GTiiasLrlDaslEo0d11
         rHOTdL2D9vyGlEQxRL3rcYi4h+hwY0M+XJrL8oVaGV2KrNt2wc+ECf7HBuIUbVN1Kr8m
         o8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791405773; x=1792010573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWyewnJ/gWz839fiiYscHDhAW+308Oy+O5Fj0veyk7Y=;
        b=Db676E4XxDvoS8KAv1gw5pSJj+8rn3PhAfyFKbuG9SvKFUxO8Gd2leZmhbc7MLMCHr
         hejUbRaLf9v5q612ld3Z/XUq2D6hPQmiOKsh0QKdhoCtLrMfc9WllYS3JpCJeowH2HWQ
         /NbgtyUzuIDod5EgSIJphgZqVvaOBSlq61v9mvms1/v5GxFtVKUQnIt3kzjevR0fYPs4
         JqoQXXb6Z8GfqG/hIWXaAnAf5PQzJhP1DuI/VwfNQU6o0vg/TxYxiCQo5poTqj15b8Mc
         NwpS9bzNog3J2LEEXEq0oF5Az9niMjIa2YuunetDdstVRj//9VjY8sny4shx7Bg9WXam
         4FDA==
X-Forwarded-Encrypted: i=1; AKwUvBzLzAjc/8bMKWH1tAWOq+RzghMqHXDuyHEKNYFfAE44caPU2YTDkyDruBqqI0zFAUHdQAT8IqM5HG+tn3hI518IjxAyWMs=@vger.kernel.org
X-Gm-Message-State: AFuF++lCItfLF36/z1UryOnezppchivDC4dFnTaqlAxdSI52MyVxW7GF
	0/gv/nDrfVqZ7196wJL+iRpdFJ/jKzPESBCzNUKaPgUxdfXP9f66MjEy95i06cTF640=
X-Gm-Gg: AYBFou19ASuplONjhAhO2sBTqTgZ1aIftujH2K+xItMm8gvv8H3sPT64/iZBb9EfuiL
	914NmbKpy5skUlIltxWQ4ptAm+H4EVFwzoBzp/s37Ibu8azM9cf/m/ztV2iTUrfzT0UhDt8H7wV
	R27LYIl8LLQCckw9ErL2ww5i8fX+cqKUboFAp3gexlhngncU1hKaOXpqdmiSVQjqxIwzG/R0Hjq
	u5xoP7gfH+bxEqvikC7BTepAl7093yNoNjmjRTavaz+HDMnQLf/YpN41DIMxaKXWQ1B0iC3xw2u
	C+1t7ctvCIf4Zbmf6YxmpJSLlIMOy9BJjbJw6a48w3swLXJNfzD8rFlYyy6TzpR30e4dchHRcF1
	TjrTcKsaEknIhhcetIwvDchId4RVm47LKwx+bX4b1QKPHv7hHPOvob4ZILLIZMhH0961tRQNghM
	kpsRORJjG1zYyqCwBGH9ic64Zl4Tc2WrDMHX1BTK1hRbNg3fLQ1aE+9i4xf0zTv2Nz/Css88OlS
	zHMvWXKFYwwZx3FO9iqXtPpQl98AcnEA5ZPqvEuy3T0nDHrCaFs8U3kRHbOj8waQTQ0GG8=
X-Received: by 2002:a05:701b:241a:b0:152:92c6:8b10 with SMTP id a92af1059eb24-16208ebdcd2mr3213456c88.45.1791405773303;
        Wed, 07 Oct 2026 13:42:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:7854:1520:fd4f:2a94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16167ef2e54sm7586938c88.10.2026.10.07.13.42.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 13:42:52 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Helge Deller <deller@kernel.org>,
	Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: [PATCH 6.6.y 2/2] apparmor: Fix & Optimize table creation from possibly unaligned memory
Date: Wed,  7 Oct 2026 16:42:23 -0400
Message-ID: <20261007204226.47033-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007204226.47033-1-artem@trailofbits.com>
References: <20261007204226.47033-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@kernel.org>

[ Upstream commit 6fc367bfd4c8886e6b1742aabbd1c0bdc310db3a ]

Source blob may come from userspace and might be unaligned.
Try to optize the copying process by avoiding unaligned memory accesses.

- Added Fixes tag
- Added "Fix &" to description as this doesn't just optimize but fixes
        a potential unaligned memory access
Fixes: e6e8bf418850d ("apparmor: fix restricted endian type warnings for dfa unpack")
Signed-off-by: Helge Deller <deller@gmx.de>
[jj: remove duplicate word "convert" in comment trigger checkpatch warning]
Signed-off-by: John Johansen <john.johansen@canonical.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2026-45893. The userspace policy blob may be
unaligned, so typed __be16 and __be32 array loads can fault.
The source diff is identical to upstream. 

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 security/apparmor/include/match.h | 12 +++++++-----
 security/apparmor/match.c         |  7 +++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index a86f74b59360..14c0401f97c1 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -102,16 +102,18 @@ struct aa_dfa {
 	struct table_header *tables[YYTD_ID_TSIZE];
 };
 
-#define byte_to_byte(X) (X)
-
 #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
 	do { \
 		typeof(LEN) __i; \
 		TTYPE *__t = (TTYPE *) TABLE; \
 		BTYPE *__b = (BTYPE *) BLOB; \
-		for (__i = 0; __i < LEN; __i++) { \
-			__t[__i] = NTOHX(__b[__i]); \
-		} \
+		BUILD_BUG_ON(sizeof(TTYPE) != sizeof(BTYPE)); \
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) \
+			memcpy(__t, __b, (LEN) * sizeof(BTYPE)); \
+		else /* copy & convert from big-endian */ \
+			for (__i = 0; __i < LEN; __i++) { \
+				__t[__i] = NTOHX(&__b[__i]); \
+			} \
 	} while (0)
 
 static inline size_t table_size(size_t len, size_t el_size)
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 19b44e705b26..0a3307cd4107 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -67,14 +67,13 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
 		table->td_flags = th.td_flags;
 		table->td_lolen = th.td_lolen;
 		if (th.td_flags == YYTD_DATA8)
-			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u8, u8, byte_to_byte);
+			memcpy(table->td_data, blob, th.td_lolen);
 		else if (th.td_flags == YYTD_DATA16)
 			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u16, __be16, be16_to_cpu);
+				     u16, __be16, get_unaligned_be16);
 		else if (th.td_flags == YYTD_DATA32)
 			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u32, __be32, be32_to_cpu);
+				     u32, __be32, get_unaligned_be32);
 		else
 			goto fail;
 		/* if table was vmalloced make sure the page tables are synced
-- 
2.39.5
