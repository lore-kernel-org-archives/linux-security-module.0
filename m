Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5834F49C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812679; cv=none; b=fgzWcEqzyWGLH72+GWhMr0CHqcDorOPY1iskGCerZiy9SJ5uZf4gQ2ov+DQOzWcWhKc2rTyqGqmqP04TLZ6StsmehvNQLuq0BhFD9q1POL2MHajeS5+GuGJu/4Nmxlnm9TWX8INVVpOUauQ3rM4lgGKFcKa1tDNYOdgugB08XjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812679; c=relaxed/simple;
	bh=Ax8wgaK+ez15fxYYZiVX8seyZwmcTdJyLJpygBaT6qg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T2x0y/6Qu40C30qQAN4PjqfReu2/o/5rLvR/uVGJDo3dS64ERamTE5hi4RmsEyCE/3CuKsMWVBNN/U0RS5vMBGAqSlfI94qUowJ+KZswdwaNp0Eu7dxiuAyx3ZYoHAtzKnJl1LavwN+R4rG4fMU8mjmi/5dC+ntBP8iVJyEhGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaSVgH3W; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaSVgH3W"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4310062d97bso2406267f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768812677; x=1769417477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e6YT/SSIHC+I60myLHN8wqfFYBBYrwfHUs2Kiakqa00=;
        b=zaSVgH3Wnpw2bKHfgqo6elwroE+Sw8kZjNBesFrsgXb4R7J1OKyZLnXV7Ez/jLVCsI
         /wQg6e4roy1RLeEmzZA5b8iHfq1yNrFiQzpxPebHQ+1jyQbyeySbW7wCywrxB/DsxRYK
         xbp8h18LKNdDFaJ9hpaUkz/tvRNtIuK0l4eZhS5V/3goqUWUAT/IU9TE1SUBEknPd0we
         2NBBm2haB5Qfo91e8v3wUttMXbwkGv6klAOjqDnbvXcta0KaqKCPcKbMzjfGgHRTqlIz
         Sw0vE441T8Ud1ANj+vEClvC9Gi5zzmCB8dYKgVj4gSV5eBbh21+Eb5kmHm1orLLBmiDG
         fm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812677; x=1769417477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6YT/SSIHC+I60myLHN8wqfFYBBYrwfHUs2Kiakqa00=;
        b=PGAD5rqEhTcUoZZznEvvIZrANyodLI5wNZcR+pmZyCfMYZ86f7ltO9RN4adrzMj3YZ
         zwpBs6jcElwgb0aP+KN6hFSMRp6JV09a3X/9aDpm2PGPfWyDEkE1MIjvVfHnPkDHmTH6
         bi2OjqZESgAXRSl+PqNZOU9JjVJhlsi638PT4WjCCnrjS+tV14fw+iDlkAk0OYtXImSA
         qJ0DutMu2KlVc/QDxA59+cMdUQoVqA8RV8t/NvdOMxf1EfW9GIpwPx37ojMPqiemoudR
         8ll+ukpWiicPvrYkqKTZV8vnC4rkxtCEs8VFHdvdhi+aq84TP4unRUQyxFP3dLg8gAN9
         HJ6g==
X-Forwarded-Encrypted: i=1; AJvYcCVV15ovpLFO1XS4dq4p/0AQAl9LsMS0JK5to4yxno5Crx8jGhCDPHhu0IOHRj0U621WfziLRnTHci445bI4uMs5NzMgUIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcuQFdroUKOoO4z35DzVH78jbIE8/SGIM6R2HNwh0/+s8I/vj
	0i1gUSKA/L4tfBq4j5ATdi0hKbgiltUXPvvoXrGhVeVSnMZ2P0X2JllyGGHTpM/Ru2C+Q0Ogk2o
	YocRAVPcv/stn4QbPEA==
X-Received: from wrwq3.prod.google.com ([2002:a5d:5743:0:b0:432:c091:266a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1787:b0:431:104:6db7 with SMTP id ffacd0b85a97d-4356a02c9f0mr14599765f8f.26.1768812676695;
 Mon, 19 Jan 2026 00:51:16 -0800 (PST)
Date: Mon, 19 Jan 2026 08:51:07 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=aliceryhl@google.com;
 h=from:subject; bh=Ax8wgaK+ez15fxYYZiVX8seyZwmcTdJyLJpygBaT6qg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpbfB0H6u938zFWwZxBk8W9injxH0DUlnOu6hQr
 I9pSqjICDCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaW3wdAAKCRAEWL7uWMY5
 RpEPD/9s0mWghFgMzJPD/QM93dAQDoNAJOGO/mppcLzJ6KEcbUO8WdVMFqw0HNIgLpmwQGasgOl
 rvTeycYj9P9eaJDRd0ByV+iNF5El8QgqIUPbVfnEHQJG+Ck3ZXpk2/u0UVxQ1MPdF1xwPO+6IqQ
 XepW+bMkOtv8Xq1rzJD+xjv3io1GiqI5AnklqE4mQJkHlOSmlSxQNH7sge4YA8HyaKtPmXdHA36
 RCEeR9nLDud9oIFWbSfJhkolbktNopYMuvJRylPFgtPbVQRVj7FdDyES/+pIPpoTyEesVRN1CUP
 s56VYZoKQIrQVokgEYeeIi2E12cNj/4KqOM8peQBi9oZiA9oPOTln9DhbB/kS51aITYWyIFasVY
 otTv1uuwc7h4BSgqqW01+OaDAm2fdyvcHWa/LcQGQtY2nmcVAqTO+Oy9N3HI8MBZ3cWpSt8pvl0
 e/s4qn3CyEZJEFgx2A05UUHW+hXp0i3wJGnPp9WqpsJDqEfXh42Ow2MrPl/KIKW/xdAuzL9mner
 pIC+pDjlGGH3HGd75Y+PBG6gtdLV2goWtIoEpjPZYwbO2pAu49r9smAml+uvuAdsy9m1fPk52ep
 PdZoGYtzCBrYEtl6lrFOoycgPw8nIBwBS2OQJFGBmnbWTkvaAh6RB1hHBWzSo+xwqiruJ/c+726 HkrKPpFUUsLgLjQ==
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119085109.2238878-1-aliceryhl@google.com>
Subject: [PATCH] security: export binder symbols
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To enable building Rust Binder (possibly also C Binder) as a module,
export these symbols.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 security/security.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/security.c b/security/security.c
index 31a688650601..b4776f0e25b3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -479,61 +479,65 @@ int security_binder_set_context_mgr(const struct cred *mgr)
 /**
  * security_binder_set_context_mgr() - Check if becoming binder ctx mgr is ok
  * @mgr: task credentials of current binder process
  *
  * Check whether @mgr is allowed to be the binder context manager.
  *
  * Return: Return 0 if permission is granted.
  */
 int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return call_int_hook(binder_set_context_mgr, mgr);
 }
+EXPORT_SYMBOL_GPL(security_binder_set_context_mgr);
 
 /**
  * security_binder_transaction() - Check if a binder transaction is allowed
  * @from: sending process
  * @to: receiving process
  *
  * Check whether @from is allowed to invoke a binder transaction call to @to.
  *
  * Return: Returns 0 if permission is granted.
  */
 int security_binder_transaction(const struct cred *from,
 				const struct cred *to)
 {
 	return call_int_hook(binder_transaction, from, to);
 }
+EXPORT_SYMBOL_GPL(security_binder_transaction);
 
 /**
  * security_binder_transfer_binder() - Check if a binder transfer is allowed
  * @from: sending process
  * @to: receiving process
  *
  * Check whether @from is allowed to transfer a binder reference to @to.
  *
  * Return: Returns 0 if permission is granted.
  */
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to)
 {
 	return call_int_hook(binder_transfer_binder, from, to);
 }
+EXPORT_SYMBOL_GPL(security_binder_transfer_binder);
 
 /**
  * security_binder_transfer_file() - Check if a binder file xfer is allowed
  * @from: sending process
  * @to: receiving process
  * @file: file being transferred
  *
  * Check whether @from is allowed to transfer @file to @to.
  *
  * Return: Returns 0 if permission is granted.
  */
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file)
 {
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
+EXPORT_SYMBOL_GPL(security_binder_transfer_file);
 
 /**
  * security_ptrace_access_check() - Check if tracing is allowed

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.52.0.457.g6b5491de43-goog

