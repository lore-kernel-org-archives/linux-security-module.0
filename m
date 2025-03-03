Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1901FFC60
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031131; cv=none; b=fDQaFSm6tFzTKc3w3TOAbsLjBG7Op0KIL96Ae186XnPEogRGqNdA/rH1WL2s15cGM8eeYyiXGrJtIwjl4UavCbZGlXLkAFDv8gzscMey1ipCV4lq+L17JW9izQN4pMPTGlHL5tfHhGUvzi8q7VL+vX/uLULN1/3yMRK0aSRH/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031131; c=relaxed/simple;
	bh=NbmZBK2xkm7K/Ecw8ES6SyLyBZH30wyyvNplWdHDcrY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VNXPt2mvl6rYYJYqtKmTizknaDwRlJb06sTc5aST1vy9kpD9B8+BYN1SElbauEHck1ixHQ0vVKMP88zoJtQ9qYa5A01ozWr34BedgBROLWUVo4XMolWVxWsnL4pP0o8oaW3cLUAs2lEJLz+9RkMo4Nqs7Igk2cc9yIgGUiGcYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tS+omRVA; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tS+omRVA"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e4c2618332so1303894a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741031128; x=1741635928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsfLGXpV6rQ0o2NY7gVfznfkHxTeDivdFJ9+ifBlQzI=;
        b=tS+omRVA21xTNzOhmiFxDlANHKgyCfhrUn1kmXze8PLVST78tq9O1sGkaz74UUv1p3
         vJGE/EEmuMTSQg7OiR08WfSA0Yhguss6aMJVsSGBg56i1u8Bj6wSS5/IRJzVAfWremeH
         6zRiSW36z1nrvIR0S+suDiZFJ5jmLmQ48XATSAy7h05PbjPZau6bu9J3mLCYaCs4Sc9S
         ogvZofCd3umOmNcQ+9Qwj8apR+43MxbrYHkACobaYdgLXzsaqqTy09KfAW+BBzuzraEs
         lgykhypboX3cfNBbKv20iTF3a4D4o3xzqyf+s03mgRCR3jG/FpD/bS7sEPxRWx7oT8On
         hvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031128; x=1741635928;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsfLGXpV6rQ0o2NY7gVfznfkHxTeDivdFJ9+ifBlQzI=;
        b=VSCVbFvVXHhbQQGPTgMyUDsnuHE7rQ5hen5Buy40u4wz1+rsQ4eDimdiaPAWpEeX0P
         Ggxx2TYjJU00ALAwXOwBNZItFnmwXoGjm88k8w9qXSD6/HDFlIp9eXlwkLCgKojx9s+d
         46RCO3geWcBTuAP46HTSiRlP3EaCwng6c/r9bJrxiHCb/pM0tK+XVikenfQbMSeKmOYS
         J0yBFBomaXfkInMilfMcod72QCy3S480h7IC3lk0m0nRLHkFOL5JLEKN69hxP/aY2QIM
         Lv3btYh5Ao5QLDqZL9Fdngtp1xO5hZDOU8dmMEKarZu4oikzDv0FKoaMl+hF4Rju3ddq
         63mA==
X-Forwarded-Encrypted: i=1; AJvYcCX+vPNnYdRiudRXaNuASFI3BSkmU4j4E6fN8Q2cZoAdf2/1PAh/+6B8r8S/4cp+6hACnqkFFdaio2r7v/G04rYgbgrBdJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wawMvno1xZwN0gIiYnjQJdIkX7Ue52gxuWS7QtjR8LibLuj5
	ObZfb/DfE7fqvVgE5ZauamO9rfQLZNXt63yc/9Zf+lkvygMd0TzcqA9CrRRNSmlIQMitPic7HUc
	/0A==
X-Google-Smtp-Source: AGHT+IFHklQwejqpmOUxryvT3a8PDCrvJzrEIwH36jW9fRyIFacuGwFmtV12mOCE95wWm07nqhcTyq+O3cg=
X-Received: from edbfe12.prod.google.com ([2002:a05:6402:390c:b0:5e0:963d:6041])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:84e:b0:5dc:cfc5:9305
 with SMTP id 4fb4d7f45d1cf-5e4d6b4ba4amr13090569a12.25.1741031128668; Mon, 03
 Mar 2025 11:45:28 -0800 (PST)
Date: Mon,  3 Mar 2025 20:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303194510.135506-2-gnoack@google.com>
Subject: [PATCH v3 0/1] landlock: Clarify IPC scoping documentation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Alejandro Colomar <alx@kernel.org>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thank you for your feedback, here is the third version.

Changes in V3:

* Various man page improvements suggested by Alejandro Colomar

* Squashed man page commits 2/3 and 3/3.

* (No changes in the kernel side documentation)

Changes in V2:

* As Micka=C3=ABl already applied the first commit ("Minor typo and grammar=
 fixes in
  IPC scoping documentation"), this one is left out here.

* Applied remarks by Daniel Burgener, Alejandro Colomar and Micka=C3=ABl Sa=
la=C3=BCn

* Replaced reference to send(2) with sendto(2), which is slightly more
  appropriate in that place.

=E2=80=94G=C3=BCnther

G=C3=BCnther Noack (1):
  landlock: Clarify IPC scoping documentation

 Documentation/userspace-api/landlock.rst | 45 ++++++++++++------------
 1 file changed, 22 insertions(+), 23 deletions(-)

