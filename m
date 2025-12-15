Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962C30F932;
	Mon, 15 Dec 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813439; cv=none; b=OTLrNKSnBTp8UPc+r/XRlWe+IJKpZoY4KeFpGGbbB/ErxOFcIwKq851WoocDIXPqJSoo0/VGkMiHf2wH/zlREUnoqtu1vJHnS2/OJhPfQApCesfa0CE5I0m91ACUuiqqE3lBR5FMSlk/X7BlofU4lY+ZLQctDNgvFPDrNJAK2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813439; c=relaxed/simple;
	bh=2AxnBcqPgqXCnldBOy07VtuaCRIG8GxLYWiW94+3UqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cwVN5AGXhbYv36/qO9wCw8Xi8Wsz5I2GK6nODq1FJ9gkB4IecTC5rzuh/lyqOCky7SJvAkqUXJ/Np/NrnnMjraGYML8P+f0mL1k8AKqJlki6uTNYFXdInbYfV2VGowPCGA2h0tCaXdjktgdQPAjgEd4t9Wakti1lo1UMojmRj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQlYxjcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQlYxjcu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D80B4C116B1;
	Mon, 15 Dec 2025 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765813437;
	bh=2AxnBcqPgqXCnldBOy07VtuaCRIG8GxLYWiW94+3UqM=;
	h=From:Date:Subject:To:Cc:From;
	b=lQlYxjcuBzpRZCNQ3UcM8Y/byyN4ZJjnA2eo5fRbSRq9e0rwBdsIHEJGfr6JaE6sc
	 aqVTeg3a2xhHNULbIaKI0dO4Y3jHbe6f0+kJYsgCc8rTUY7GR4j9nbRqj/0Y+GhL9E
	 OYZIz06zraKD/O3RFbAeRmK9cT4LZLDK94XQX9k1FFcRa+Uf51iDWY/kuRE3196UIn
	 6rxXmoKSPcM0jLW70ZXbil31VeGvKLnvD/IaokGrSoiHrXLG5AsbsdnJj8xgBESFS1
	 DbaPN5zM4uxpVDsbJc9/rxdoEHuPTRRdRjo6HPTw7PcJJMznJhgYuGhrUyARQ/q9kJ
	 eO/RW8co5jrDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D3D5B842;
	Mon, 15 Dec 2025 15:43:57 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 15 Dec 2025 16:43:48 +0100
Subject: [PATCH] loadpin: Implement custom proc_handler for enforce
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org>
X-B4-Tracking: v=1; b=H4sIALMsQGkC/x3MQQqAIBBA0avErBNUMqGrRIToWBOhoRGBePek5
 Vv8XyBjIswwdQUSPpQphgbRd2B3EzZk5JpBcqmEFIodZmM2hnyvZzTuosD0KDxX0uvRDtC6K6G
 n93/OS60fj0rPCmMAAAA=
X-Change-ID: 20251215-jag-const_loadpin-761f052f76c4
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=2AxnBcqPgqXCnldBOy07VtuaCRIG8GxLYWiW94+3UqM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlALLxIt2tveNFT3YRDbt+neQRjc69SD6n9I
 S9XQDbETZnxFokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQCy8AAoJELqXzVK3
 lkFP2+wL/1ck/yY8LmBRUGMvwpAzd1p5neqnxyYSQ2FkjgFOUhPRkfOzCQpvkeJaeMX9rN5VAtV
 dQw3v7ccbroOolBMfNFuvtyVfzaxpOlKaJZpixsnrxr2lYBG55dPYYkpzpZAhSa1xTvrBg6FKkZ
 9yPs3wRfBBv5/eSDETe3bnWf2whX+if378GgwSlF1ICy89S1jPlkvObV932KWMPwNbeG/a3VoCm
 Bd6vOUYdUlOtDcX4hSbIyAP8usOBvsMT9g0Lci9p1SpkR3Yg+SrGLL5YnlAkhxhnAkIriNDm8BP
 eQ4Mh0JN9lEhQtpkabSJ2GTZfeu+7mg1tdRFNAnhE7xT9lAqHxnZxH23q9SsIGt7aaYJdup9yuF
 OM8H1SLPPlrfTbD8DdEHpxefSAzE9CZ4P3vRhxvHZVr0vD7ghHqpf0TYe1QHqyodFkHG19h1Eh9
 O/DIM7Q0qCYDPnjlw76E697PrfBbyBFCBRoDmQ1HdVqq8v39oz7bSEyEEbQMxSg3rBLg2udGL85
 Rk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

The new proc_handler_loadpin returns -EINVAL when is_loadpin_writable is
false and the kernel var (enforce) is being written. Move
loadpin_sysctl_table to .rodata (by const qualifying it) as there is no
need to change the value of the extra1 entry.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Const qualifying ctl tables is part of the hardening effort in the linux
kernel.
---
 security/loadpin/loadpin.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 273ffbd6defe1324d6688dec5f9fe6c9401283ed..f049c81b82a78265b6ae358bb2a814265cec9f16 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -53,18 +53,29 @@ static bool deny_reading_verity_digests;
 #endif
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table loadpin_sysctl_table[] = {
+static bool is_loadpin_writable;
+
+static int proc_handler_loadpin(const struct ctl_table *table, int dir,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!is_loadpin_writable && SYSCTL_USER_TO_KERN(dir))
+		return -EINVAL;
+	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
+}
+
+static const struct ctl_table loadpin_sysctl_table[] = {
 	{
 		.procname       = "enforce",
 		.data           = &enforce,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
+		.proc_handler   = proc_handler_loadpin,
+		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
 };
 
+
 static void set_sysctl(bool is_writable)
 {
 	/*
@@ -72,9 +83,9 @@ static void set_sysctl(bool is_writable)
 	 * device, allow sysctl to change modes for testing.
 	 */
 	if (is_writable)
-		loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
+		is_loadpin_writable = true;
 	else
-		loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
+		is_loadpin_writable = false;
 }
 #else
 static inline void set_sysctl(bool is_writable) { }

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-jag-const_loadpin-761f052f76c4

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>


