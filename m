Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF315320C
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jan 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak+XmUIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704759877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBgrmkRdNGMcly6vlN7IHOo4uqMRRCrvatkr8PlQXzA=;
	b=Ak+XmUIefHSyqmX8dBh2Oeusw9olcX/jqrdvzo9iaH1+AtVxNAxgaP4QO5aDJnOYX+6mmq
	yP9b8vyweBlWnNDlzpa5s533HU9aL4h/ee4A0t+L25IjJWQDZGfzomxeCH2UVVGUgh+RJ4
	cEFIhj0ZMIC3KmmU54c72x6tND3LOKI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-4XFYRMVDOXWgmQI1QwwePw-1; Mon, 08 Jan 2024 19:24:33 -0500
X-MC-Unique: 4XFYRMVDOXWgmQI1QwwePw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d9bd4fa279so1321377b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jan 2024 16:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704759872; x=1705364672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBgrmkRdNGMcly6vlN7IHOo4uqMRRCrvatkr8PlQXzA=;
        b=oqYW4iZki72piOY1Bzv+7xxZYTiVaka6vPAiaV4CXt5wsECJk/pdLiS8Bfa8ZQine9
         Td7yhHXrtVXqowDxJv+mcvBFTbc6MX4U4/oNwipw52Ca53qlRzKwxuIjqrkPN4sbDcQC
         KvnF2lpdfJlnJM30+fFcnxzgk8Ur6/zkZ2mYeshPQtGgRvz7m+IWv+slNe36J8zSmgAo
         EpYR97ZHaG2ofiZiG8He0mAA8MkYHuK+tXs0XpgoZItsd6VdqNhFJ3GkmPoI8MY8jTgG
         Io+teUFsIZd2yQhzQjLkVFPUiUZnRia9sDA+TPyOYTEksRg73hFZnVEuXAd3MAZke11M
         hsjw==
X-Gm-Message-State: AOJu0YyASOlPNk+8Xf5RhOly3zQYzbOBJD8hC3G1yZLxOWlG4IkbVscx
	NMSkYVDOZ93x3/imqMZaEOhfPQggBtQwCPx0Zo1ThDJ0nes5LpC4cUH0RJyYqjp+xnW3uc9IcsQ
	mXD+Q8sFMOPN5xfCwakbVI7vDdKTGxQXvAA072F8qfSZI
X-Received: by 2002:a05:6a20:1044:b0:195:192c:e5a5 with SMTP id gt4-20020a056a20104400b00195192ce5a5mr1584016pzc.56.1704759872388;
        Mon, 08 Jan 2024 16:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAYwqOIUUbzS4Z6Wh9myf9nF6QYMlenNKzdIdCeZBN2nChQ2/gE/uHykLmJ60rmWnGCpKmUA==
X-Received: by 2002:a05:6a20:1044:b0:195:192c:e5a5 with SMTP id gt4-20020a056a20104400b00195192ce5a5mr1584007pzc.56.1704759871993;
        Mon, 08 Jan 2024 16:24:31 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001d403f114d2sm459444plb.303.2024.01.08.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:24:31 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: itrymybest80@protonmail.com,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] integrity: eliminate unnecessary "Problem loading X.509 certificate" msg
Date: Tue,  9 Jan 2024 08:24:28 +0800
Message-ID: <20240109002429.1129950-1-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227044156.166009-1-coxu@redhat.com>
References: <20231227044156.166009-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently when the kernel fails to add a cert to the .machine keyring,
it will throw an error immediately in the function integrity_add_key.

Since the kernel will try adding to the .platform keyring next or throw
an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
so there is no need to throw an error immediately in integrity_add_key.

Reported-by: itrymybest80@protonmail.com
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine")
Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
 - improve patch subject [Mimi]
 - add Fixes tag [Jarkko]
 - add Reviewed-by tag from Eric
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index df387de29bfa..45c3e5dda355 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -179,7 +179,8 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 				   KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
-		pr_err("Problem loading X.509 certificate %d\n", rc);
+		if (id != INTEGRITY_KEYRING_MACHINE)
+			pr_err("Problem loading X.509 certificate %d\n", rc);
 	} else {
 		pr_notice("Loaded X.509 cert '%s'\n",
 			  key_ref_to_ptr(key)->description);
-- 
2.43.0

