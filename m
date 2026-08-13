Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64039DBCC
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613552; cv=none; b=G70p5a8mewK9Z5oxO1p//TIafx40IOqIem/LUii0hfS6EQTAwR/CCNMmkKgxsp1cPZVZIAgqCmkL3tBpMC0zZ0jmCAOGtSY4npAS6S7NDMzUqLHF6how2J5MfjBmAqBwX4G/mT0g57IpHMDjjPlbaBD+f986xL9i82gQFACbuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613552; c=relaxed/simple;
	bh=uCnHqo8RAzz5qBgEQC0Ub6+nD0dja3CQWWOGLumKKTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KE6HStkMKmb+iVVzg02hDaMmn+tIsP6H7x793dKPKUOPDv4sXpPQ+bMnn/CvbhVvQ3ADgLe8q3Bw9tdCThkak4+rNtjjiDiYSlsV+51C7HtyJYv4xtm8loW24RCaiRK3srxY/PVZSWWK9hGD2kHPDFagc7DD/MUCDnFN8pELf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGZ9/Yk5; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGZ9/Yk5"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso4249395e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613549; x=1787218349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T09DsPeM2axLCSsVFFbln0Ie4x8Y1xtvaYU7qZUmf9M=;
        b=hGZ9/Yk5mN/zozmHLbmpp1VFRN5/FAQUdc35/M+vS6Sozd/rebhUjVsAX8P6kqnq4h
         a3rRrpTrnUELayQj9BBneAt3P8LRW31kfQ7ld2Vr327/2ltDovFxgkkXsUNXjRxbM3Nu
         mTX8Qm7zX8fhR5AgRZ8yaY9Cc7OBmGfGPNcIP0i3PqidPSuqpKmJ6l91v1atRzrJ2LnJ
         oWwvma8sIlkYtYOP1EQRRg2PRiVS6/1az1hKQA1dUCaqBDJtVUniqhcfHPAeMcqUjW2w
         paubaqa7WE2MLApL9DMZUYaPQ3KUR/ZlJ99Sm5RGgvjzacCbZy+C4IejulR012zjdWcM
         OmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613549; x=1787218349;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T09DsPeM2axLCSsVFFbln0Ie4x8Y1xtvaYU7qZUmf9M=;
        b=ockbsANKJM5USGKjbGJTAFIFhp0yxq57YFBvT8G28ehvKN8IFC8JimsZlLeOgP6poB
         s33lUfvFZChXxhO804DgdFpQHYwxgsRoyMElLTVDLDzfvoGQ3gTP0dNcavJm+8z4o/l0
         oTwAx5byaBT5b6DD2LmSX/QPwirhUBZYrsJCsqmmkKAB6Ey7C3j1ZRizTXkolW98Y4Pv
         PVJ58fJpFZfleXlcwCwPm+B5HT8BscBTXWkqDDrlkxHA00TycLzTa4lSOe+yEd6l/eZE
         3Zlhr+IH2L7TZzgRDEcbsctgqmPajuEaZbxrnbMJ82lSFckRfh1hFNwp+iGeY+stpqZF
         dbBw==
X-Gm-Message-State: AOJu0YwTgNzXFTzsPcX6HypNPihjn0t6EvLhSkVIhnQKN/xKM3wvj6ai
	DXMKWxx5ukht0uoVyG6ABbqfdCtYnRy7Lz1dnMhHXV2qrQNGpcfJD1Y/w9ozegProcFZmhY9fgg
	j79QO8Q==
X-Received: from wrrs18.prod.google.com ([2002:a5d:4252:0:b0:462:7ef4:d3a6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b19:b0:499:737c:ce4c
 with SMTP id 5b1f17b1804b1-499821c5a76mr52313295e9.6.1786613548826; Thu, 13
 Aug 2026 02:32:28 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:57 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-7-gnoack@google.com>
Subject: [PATCH v6 6/6] landlock: Link the erratum documentation for whiteout objects
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The documentation embeds the canonical erratum documentation from the
header file, which is already a self-contained description of the issue.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 5a63d4476c1c..df996ccaee34 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -556,6 +556,9 @@ in the running kernel.
 .. kernel-doc:: security/landlock/errata/abi-1.h
     :doc: erratum_3
=20
+.. kernel-doc:: security/landlock/errata/abi-1.h
+    :doc: erratum_4
+
 How to check for errata
 ~~~~~~~~~~~~~~~~~~~~~~~
=20
--=20
2.55.0.699.gb54405d56f-goog

