Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA726E6F0
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769335563; cv=none; b=Ob6vsimlNaLLZ0tJh29c62jMU3/t0nXggwDQ1DylTmU6g5n5tfxot6LuzFCEWDnjaphktAAzqvvkKzIAEUUgYCvMYUJ/3el1zVeoYbz9mWVCSn4nWWYTXgJruhu09F7AkeUN2hRFL6vz6YYt44rhf/0renNDhxtwFFHaPaxH8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769335563; c=relaxed/simple;
	bh=teGMtQjbidAgosVFHe0BOkRblG+sCic3y+HWPvpl1UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EUaZsdhQWTDjWtqDxdkr73bBzySuM8j8f1e//Pcokmglgf4l8crS1G8fcXKeUzDHcQaHDLeCa0jDIEGb8HVL3yhKf6D7gK+zPhSvUKLUUMNu9PMNRr+1QvJnssFlQbixMFXioCpLaosr9qAOaauVaVyptwaAKajqbvCBKAa5QRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu43Zi4a; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu43Zi4a"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a1388cdac3so28005775ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769335562; x=1769940362; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Xnf6p+2Hlq5eWfuvYyYtXu3LZrwEbd4KRfL66TNxW0=;
        b=Fu43Zi4a/jYijmDqKOnOTr+mwtJH0cJcYb17ugtRkXgwnULWnUZyc2d1+dCO6qhz7j
         yY6I4GfRLXXCGKFs/JSGHbf90iTFA2drb7oS6houuRl3kaerk1mwzVCm06nkvbewPCL9
         PTiV6FsRxkVuOz26Gn3/bporyBm9dnrgfJTi68wgzFkg+1D5h1heUS03FxjK5mWvWwgS
         CcEoEgwJmlXc54E39QHzaZzomaX+whvVZHTizIhhAqf2h6yGQNObWT60LKcGPnhRn+IA
         NsVBNATfA2X9sqtkwvpAWFrBjPmJ59bOQi0k7I2e5O7dKqIgiAz3S/AX9b1pjiR3b0g3
         H1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769335562; x=1769940362;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xnf6p+2Hlq5eWfuvYyYtXu3LZrwEbd4KRfL66TNxW0=;
        b=YdEuNBe1NL7IcIHjlRTibHXQ2uUcqYFE+0Q45X0wkJELGe3jHmthV13FNBwi7ogXIW
         ZBvAr4+uiIstagf7Q29SYbZAzKKr29aGt6TfNVwatahMb7MUeZBNCIoWX/jD1u8x8OEa
         MpzHxqydmka6wo6mbcIPXr3rPbKuLxwK9XHQlET7ZsApDnqYInyp0X/sT9aWoYdIf1hj
         QAThrnV44aAgvIRGQeBmjBdhERNVirdCvHnx8KSG+lWLbz+YURfw7ikjiaJTQRG/RyBh
         O/Itp0erzR7HSOEmDJesCnJ3rtH54zvnodlq7qWdBmWFndv//ttle5FN5RIVNOzm5gJM
         YeYA==
X-Forwarded-Encrypted: i=1; AJvYcCXjxxWRfUiL9M5CnQz0rFlCEuUU0yMovdGXYwlqg02in6iDJzoOAab/4aD56yhKvsgdT6cz2svV9Lto5k4JMA5F7gb/mJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdClrZitBdACJIaISVqxfmkNWtNO4ZdGhq5g7/BsQJ/YXesLpt
	DXuD7oYHdH8bn12sLydZdIUo37qd7y0EgzqSs6nupwJ8F4kdjuU542D+
X-Gm-Gg: AZuq6aKSygumoHjKaFVYnriJuDeIi6W2YjSCeIN5xQ3tIWTsZQTWqjOfrMPurOCb8Wr
	EDuo8hClKAnIwWrcnJRRctif7lBRtGeG69f1pLj92Hupp3VLprbQATbcP36G9tae9etzW4ilu3F
	L/Hw90LmZFh8VmSk7Ar0huIizfrDrbxzNWxdKECjZrnUEtbkiFg9JceSnglwy1v8YfH1lADE7EL
	fxectdUrgpHpf6IHxKOEg3KBtAbHFCv+FludveVc79unl/ripcWCC3ON1ximsTRLlSm9HG6XspZ
	rC9Du7gdSAK1AhI/vzR/af2a+O1U/UjliA9dQy+E4r1/2k5ig4FzL49I3vRNJLexcsLVs3XLDyQ
	oVuXDuygkwE341SeIzQ8HdhpV3EKC+3Vjp5hnIpZ405EfsVs7d5Ew/Y3OFaaO0C5tUM4Ks0F+Vw
	saJlou+7Pclz75luWWoB0=
X-Received: by 2002:a17:903:2351:b0:2a0:c1be:f436 with SMTP id d9443c01a7336-2a845336da4mr12371785ad.59.1769335561700;
        Sun, 25 Jan 2026 02:06:01 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcdb8csm64627475ad.31.2026.01.25.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 02:06:01 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Sun, 25 Jan 2026 19:05:48 +0900
Subject: [PATCH] apparmor: add .kunitconfig
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-add-apparmor-kunitconfig-v1-1-e815cec415df@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqDMBBA4avIrB1I4g/SqxQX02TUoTQJE1sK4
 t0NLr/FewcUVuECj+YA5Z8USbHCtg34jeLKKKEanHGjsW5ACgEpZ9JPUnx/o+w+xUVWdBO9qO+
 8HSYDNc/Ki/zv9XM+zwtQAe6dagAAAA==
X-Change-ID: 20260125-add-apparmor-kunitconfig-28aba43c1580
To: John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, 
 Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

Add .kunitconfig file to the AppArmor directory to enable easy execution of
KUnit tests.

AppArmor tests (CONFIG_SECURITY_APPARMOR_KUNIT_TEST) depend on
CONFIG_SECURITY_APPARMOR which also depends on CONFIG_SECURITY and
CONFIG_NET. Without explicitly enabling these configs in the .kunitconfig,
developers will need to specify config manually.

With the .kunitconfig, developers can run the tests:
  $ ./tools/testing/kunit/kunit.py run --kunitconfig security/apparmor

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 security/apparmor/.kunitconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/apparmor/.kunitconfig b/security/apparmor/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..aa842a0266e9d33c3333ec2ea180206187b0eb4c
--- /dev/null
+++ b/security/apparmor/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_APPARMOR=y
+CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y

---
base-commit: d91a46d6805af41e7f2286e0fc22d498f45a682b
change-id: 20260125-add-apparmor-kunitconfig-28aba43c1580

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>

