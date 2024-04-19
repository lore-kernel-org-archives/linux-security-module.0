Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCC13172D
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543117; cv=none; b=AtCT0dTHiR3wwRzzP/D5e1JjqnnxxbEWFjthZ7AwK58l9pPDj3LAjTWEp2t5FBMdzTHlgwXrebz6/c6+bHuTK90nMkGQJa7547bEJkEsWQqQaAkIHrP0L1dt/0Qqpgkj31Y8zaWcGK4u4D8oCzHZa7pgUK+e7oum6Q1YpgJM14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543117; c=relaxed/simple;
	bh=JGHfnorzKyjPYbTCQHV6WC4mgXFe8OWcyk7jdOEJxuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=akIWGelKu2Jkck/+RonC8mL1PhlWi6l26vj/yzsGthgrSIVqaXNVnW8lVaMqrca1FoO2lxGFPOZBEsmmShHIlVYR9jVyyeGCRFHs8Au7x1OUX/959hX2kDNl79dWL7fBnPMM52pwOGQ85kSmx2eQFgZtbcS8TqvNELoXuFqN0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6DfJIPm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6DfJIPm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b36187e6bso8713587b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543115; x=1714147915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCoDsQ7XD45afcaMZJLZHwcegiMaHQmobdPwX+hCXpE=;
        b=Q6DfJIPmvK8xHj01v0jhyPIw4NpvVCJEmE++BpuKANXlSNM87cFdbNPk2A0lRlhcCF
         8olfdpXt/+2PVuZjGH7xDn6g23VS9giCEhqMifRfv7I6BBhiaGwafWlPd77VhuxV1gCw
         QJOtXCIO2gE0ud9kV4/PG6DMDbSMCOFQ4c19MkkPTXMvvFvLp3rQera0nB+wx6xnXTU1
         gKYueedtl8BDPDmfbU6F9SrSL/iHMlYXTwMpTBG8ArB6svtG6gNDWD64nUh6bg5Apl3Y
         3e8ob4FudBOZoJE7liQj+q7TM19kGclwfOxw0+egurWlFGChD66gvOGoOToluNSSPExx
         ScIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543115; x=1714147915;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCoDsQ7XD45afcaMZJLZHwcegiMaHQmobdPwX+hCXpE=;
        b=FKj3AB5a3kegSN4K7znkoN844gl0k14mDci4qRqVMw3VI22Xs9pkSKHJwchSJRUFlE
         X6SVr5f7X+ILFDs31phdodhStPl9NaTT4NEiW539ZsEX2kXuP5pzXif9omQH160kS3+p
         LL2FAcbb7LcJVQXpKWLW+n6HoPwscVJ9E2KfmaFbCIHZ3pki6/W9gc1lQovg8VcU/Ady
         O433oc1ELhD1reQKkaUmQcxJrB5lBOYOPyLd7w5f/I6hB61dz/Y+YO1DJFv87wzX5v44
         Mbe0rE8DJ9+7cRXk4V0gdee88fzL5sW3RoJBPwdyntQxNhJYXhcy8PDNN+tNt/b+jTB4
         ajeg==
X-Gm-Message-State: AOJu0Yys9Zu1O7Z9SQnWVVsWiU/TSAYOiFmZgINrvE+5ogzHtuHR55Vh
	MjkQTIuVTyjJ0nT1G9PkPpII5XeMURD0SUY6wMIewoc0eUz1Ay/YUvRUgnkvdKwVhFoYbORNuQ3
	fAjkvVCRT+6jud/IKPD6NYx8NELQR/ALMWtZrPmtpXML2n/l8CfXUbUkvDRLM6t71H4c+nKjOZ4
	RZn+E96S4hsy7BT1Ixejpz0cmnVOZORFQ//AsOut6ur7tAwkmlgcCY
X-Google-Smtp-Source: AGHT+IGDj7hCCHr63zw4z/0pItHtM9agU4Yatj8GBpkc9lMWNVcckNPIVAM4if8OXD8TF/ChBL9OUINVabg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:2606:0:b0:de4:6b9f:1b2f with SMTP id
 m6-20020a252606000000b00de46b9f1b2fmr1068950ybm.6.1713543115010; Fri, 19 Apr
 2024 09:11:55 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:21 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-11-gnoack@google.com>
Subject: [PATCH v15 10/11] MAINTAINERS: Notify Landlock maintainers about
 changes to fs/ioctl.c
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Landlock needs to track changes to do_vfs_ioctl() when new IOCTL
implementations are added to it.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..c95dabf4ecc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12222,6 +12222,7 @@ W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
+F:	fs/ioctl.c
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
--=20
2.44.0.769.g3c40516874-goog

