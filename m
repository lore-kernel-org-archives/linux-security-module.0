Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704F1BD027;
	Thu, 23 Jan 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660949; cv=none; b=dAutRtbOL0wB8cV+QHVlaMd6Sa6wIarCoMGK2/PYVHFcym43c4C/i/jfYer8sLIQikKz8rn1374wivjIAsf56UGG1UYf0tfrtOpLvC6B4yyckJPfiT+geoCyGREtHd2w+jcQJFA2oIc+ETmnJsXJsEfV3drBuBY1s96CycmnSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660949; c=relaxed/simple;
	bh=22JbdsQ/o8FxW7s6cjOJlXkC2QWrIuv7vZ+BPQQ4gmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5K7EG70+GG/pIbVmdk0Tt9joNSo7q/Gt8PWsJQ+CKITbXPwlH6FaAIRyOGrj0l/ZA66pyk9ShywuUYDHxKPudIG6VmEtAO+CxA4zMujo18jlt/Dx3CsNdLNoNnoxeH0gG+KAoBz4/VbKlteLOIYoDOcxKGdcc5p4xzVKf6d7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Pw6YiuLb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Pw6YiuLb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso1974254a91.0;
        Thu, 23 Jan 2025 11:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660947; x=1738265747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3O4RMrkq7tIKB75geYtstjDVTI4Ef93aSfh6a6JCCiA=;
        b=JMOlrENG006AAmf+22RrqkHMFwCUusNWl1mmMiGG59cXJnzcKZ52N6PqtGZFhe89Mc
         tytSscG4yPuHW4DLpgl02yL0peRSox94gHCvN19nW1lcuMQnB3fnbwGAta1K2eBIu7xg
         518GnUCGdHAI8PxlvzVDALo/SL4s0GUSBURYM2zl5UdNGRHmWq58Q4+eAtyZF+Mh2/fb
         xOF3tewar7SBPkE7iyFMR8d2+00I8xJ+YJIDSeO7sXurIc1zwQ5TqL2ZdF+q4u46vy0X
         RNavamPtwMfWuh0pzgAnoXmcNSNImY6rphwARc2D7SnPd5BfD+HrJFNWk+7HRrfxypia
         vRvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxPm1m34pYljIij+8rB7AaTUKuSC87yrLReYs72Gvzdb6HuzFfYbm/K0e+lbN/L1ebofWZXVMBC9NxeJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+pTkeqSQ5GoytY0fZhtN+D+zrzkEaEoBnUUgB7ARs0GvRPod
	4VZcYok96RPMykEZ9s/TUrdUzvt59p/L+//VwX6ISyQdjJlWOVKX
X-Gm-Gg: ASbGnct5POO5aB0f1PZ6INLSvJOfkKMK4PPq72OBniy/kYmXjdsdypAzmtFwIgaa3VL
	dLTiS0IPVDbdTVoXFjTYIdRkh9XF30yj2NQmFXSfc14OCB3z3yPYFwA0qGhtOutVfZXSVgH/z0K
	3xei+8mF+YZrHFsXVCI3eN0rNX8buxf/fqTQkZF3M1MqSVk4zr/pgL47cnGO9GkdnGZNTP9gK96
	Ky09he0UV4uJwa9ZO44aEeQq+cJBcYbSwgp7U5/B1AH7CRzQ/f8qD8tGiCrwrR2r23EmE7cvto=
X-Google-Smtp-Source: AGHT+IGKtnn2JS8AzBVyiNnW2FRX+gRDHoYKuHg9u5W+PgS/XuNi0YIa7ySgnWyLotVI8NdLH8kRQg==
X-Received: by 2002:a17:90a:7141:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f782c70237mr45182271a91.12.1737660947044;
        Thu, 23 Jan 2025 11:35:47 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6b4c7sm83521a91.27.2025.01.23.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:35:46 -0800 (PST)
From: Ricardo B. Marliere <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1737660945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3O4RMrkq7tIKB75geYtstjDVTI4Ef93aSfh6a6JCCiA=;
	b=Pw6YiuLbEFSvf2vz5vK5r8ReodOVcUcM3QZZ6HUdIPQJCaIDRy96uaDaNBSS4m5Iw4f2+z
	H0qQlLSmfM94YNNp2uDVvbiG4KA538rRiwHdXvVC7qyeDWfW/wbJZ+PtOhKnd9EMtvZixn
	MGeUJIt+qO8Tmt+5JL6tLdtM7WIt2Uw1QX07Y1CxdzkZjsCHYEA5zSgjH1i+l0ljgjGxoM
	eMcMj+5xE0WAdk19ttuQEtllv2+GP8XgPrf82+g25q4te1VEpCF8tjr1RGkg1K92orASIJ
	0N1Bzgg6+OWIEprRaUV/Je63VHRoG256mI9D+hEkBlJqfa++VWylXAc5Cnuimw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 23 Jan 2025 16:33:35 -0300
Subject: [PATCH 2/2] LoadPin: Make sysctl table const
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
In-Reply-To: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <rbm@suse.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=rbm@suse.com;
 h=from:subject:message-id; bh=22JbdsQ/o8FxW7s6cjOJlXkC2QWrIuv7vZ+BPQQ4gmE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnkpoFtfSMZOmiG6MGCbIEfkS11ng1B9MdZyflJ
 IvBn+5y4auJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ5KaBQAKCRDJC4p8Y4ZY
 prezEACiRnfKDnQyexZoYsGZplTbzzcwpcvjPax6+26+WoIzs4NDZb9436LdwtMlFdklXY8pAzR
 JWN+zRdpaIwmu/DRGVojDQZX37xaM6AbgNmclDzHby3NIi641ykyKjk3bCnS+Iuw7addRDM2UQJ
 968tgzRajIzHpLaMRowe/f+1mMDlRjfiuUh6GtOHwT9R4NOu5P5MyUgbP8t7D/iNIaOsg2A31+d
 t2ivAkqhFeRQh6WEUsow+wFg8/F4tc5Us1tOcTuGNbDNx60hP5U6vk2WhvfH9gYxbFyhf8xoyz3
 6YxrBVdNArHZl7upFmQQ8hXGqpk7Y0lh2mMI8rXf4IfI/CxC4vbkTpR0kJkaW3Ynwlz6FGvBegv
 FmglxE8xDEhVZY22StDDvVOrCNiAZH0g6qRJ/v1j0OkULhtuCGuPMmWSrUXF/R42nZQVep3wDzw
 mGEpfzNhpDjfHvMBKq13Sqgm3pqy5cYdk9Su09t/9hDUE/Jm42yZ5D3R663I/ouUY74dwYU8dzd
 Jb1NHP4Ayj7XyVARd3wf9S09LNtc2piMxgm4Rwi0SznK0lwcRJ8se7b9HN5/gUL1BjnAS0Qu5pU
 eYa6Sm6Z47qlu++BpHJbPeepQpKeQX1+0cvvY66C6qWBOcEv/FerEaR3pRCtE/GdXmIL/eylcDx
 iyeTph2wXvFC6Xg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move loadpin_sysctl_table to be declared at build
time, instead of having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 security/loadpin/loadpin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 68252452b66cb913638abbca2adea26219e77d37..e2d664b7602629c08c86d6d02158a4e9dd189b1a 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -53,7 +53,7 @@ static bool deny_reading_verity_digests;
 #endif
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table loadpin_sysctl_table[] = {
+static const struct ctl_table loadpin_sysctl_table[] = {
 	{
 		.procname       = "enforce",
 		.data           = &enforce,

-- 
2.48.1

