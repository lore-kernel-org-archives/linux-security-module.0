Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F323AB9C
	for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563307; cv=none; b=eOKevpWhC2gbyE3WdWEteaq2mJdbc7Px7UsKR5ahmevng7whztM9TJLez6yVWUEfURVoESqzijq63lw3Sed3t7yc/ZwMXC7/94BlZd+8dwD4+yqkpvIu0kW+58j80Tx9hDLXaeomNusxE64aSbt2EWMJlTTRa2yXeczXiK3p7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563307; c=relaxed/simple;
	bh=KuCuDDtbZx5h6jDsIe6rWJMOFMPLouEnCPQ+GeEgm68=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ka01rMYlXa3j4R2oAuuhoCFN6rzCqJr0jDA9sJpo8Bwjam5vd4ShWHORL8DJCwBh7edlo9MBYuAkViIbcJjpHBhtJVIs9qtyGG5NgrKlssfdHF4XD7RyhU0IVtefMSIJKYuXBnV1Xzy9XeysywtTHdFzbJv3Y2qlR50nsm6hh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MBobF58f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MBobF58f"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445806e03cso32575635ad.1
        for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563304; x=1757168104; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=MBobF58ficgNIc4oGrX19WVOGq6XLpZ8mh3kNK71TfrwdMap53XGAezhYuuypnEfQS
         6FexMpO4xuB1mVdLrLyyrAqCbIOauty20DTaXNgZhZNR+sw5C+RFK8NYqp3Oks1SLMSa
         8+P+kYFI+CCfQkAbMWU6m94Y84k+ntXZ+4MpDs5iZ0738PmdI1P7fKmxCb+nt/PEaQ8x
         V8LQAxvINYAlqLC2edlBjecg/ZIezwiXS1WP1a1V1/UiziUXUuHCOFsC43wdP150Td3B
         SqfKR0l7gJHVAZgfvYyUC847n0ZFZiuiITi9EbirCmdhtNgP81fS+0plKp1C1BScJ7Rf
         szBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563304; x=1757168104;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=UPN81LkzMwta1yyF6tEEni3D/sOhZ0VdNVdV90D5cmkRZ2SsBBK262kFxqqS003tDI
         Mv+qtp4u+urX05z/jlg7fBArg365q/CmfUI5egCCbfJvnj7PLfRGCmmCraCe7ROnoE/w
         umAocm3ECXQ7nTe5WwJSFEWhH83n44loT9tni1vBySWVz6wsep3te82Nyn4VSqjIHqHh
         D6EjeFspl/KMlaYYj8hpo3OojZLJFTemyFwhkz99hR1TNHgUA5qdI9mZFWRcfb0F5JUm
         Uu/XUU+DlnpciOSyI+zLXvuhpt3zHl9ay5xzE6jO91Z3IuvDY4fnD7TFHKA5kyx6eQJN
         cuVg==
X-Forwarded-Encrypted: i=1; AJvYcCUifJ88GyR818TwzAIfnoYeSnNV8TeopHbn6ajOAFilJUQafyfS0b4AFCj6hdHWiA3Q56Y7uFz87SoJpGGbhszGB2A1UCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywegeh5aBYScJ0ouc7AHdPl0Nf8XQo4dGZ/dSumar4Glx1f2Obi
	Ljkwm4c27tQRs/a3LX57YRh2fyytTaIIk5g4mKhiWW1SwAzv3GQC2VYCnEtSG0NIJg==
X-Gm-Gg: ASbGncuDowpWNpZwU1a8AKLq+7rKl1JgzV3eamyJXqGMGRsIMcDGNL9Wh/f0yX1HN2w
	V2qBFkSe6HPvd7EPDaS7eqKBeUBdDD0Fk3WXLlRf5XqtD1z91GXVI518EElqnyh7XFUATgXyvTr
	6rrgdTJPOexs5PtM48OYDehVbI/NLiBHhBSkpkwOScu49kz+74VAIJ2M1BBn30MctRj7QTSrlfP
	dcPAZkW5EIr6L6vHZmxYR45c9q3ffBspU6OTmyp3e39ipQvzwelkP21Xkzemkn5GEiIPBUSEgob
	ANIYC64RpgIua4CKRpwXTvqror2wixXViksCR9p6Yaoq9hf3l795fXfpoqQMc4yHdn0viadRbi+
	87eBqEEAVHjP2JB+bqtjxKfk7E8+tdr0ZfzI=
X-Google-Smtp-Source: AGHT+IFUA0BMN/ai3dblgX7nblxDAuW0oE4xAqPZKSyFbzHuCVTxFcaKqlDAd115j7vy2b6O2zjdFQ==
X-Received: by 2002:a17:903:19e8:b0:234:d292:be7a with SMTP id d9443c01a7336-249448803e6mr30907495ad.1.1756563304324;
        Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065a8036sm54004145ad.129.2025.08.30.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:03 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:55 -0400
Message-ID: <808e70d5fe73e23bcf95bb445d2f91ef@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 2/4] LSM: security_lsmblob_to_secctx module selection
References: <20250816172859.6437-3-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-3-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 18 ++++++++++++++++--
>  5 files changed, 29 insertions(+), 10 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
