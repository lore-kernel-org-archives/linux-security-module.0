Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5237DEB8
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529166; cv=none; b=FYVYra73h0jfrE0pElszovqv5oXJEaADdXMBWIBVdpvSVnB3P7YjwqFyxYXcT/rFxieicNbicYrDfNQ1feW9MwtAPhc12peLS5T2XvtK+20xao7r0FAUwYfOWKid1qaUh2gDlOFCe0+kWrgal/Pw8neR/rJ3Hm/n837iPEZ96z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529166; c=relaxed/simple;
	bh=rKxh87Y4Rj2/mJmQycKYsxIgVUIAEj71pDy+b5FX/ow=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hTI85qspiesTtp0+1qTe1Rl/cJZ115Aac1S+UPxmBYY/0lBjuayFlK/zGirkJc3fpSE5Gx7ZjsF/IIZ4gfIA1gspxcxFd6buFPedgBZqkCsL9W/5R21NnuClUnmqxMOLsG9rT6jVH3Scb6UGbu6t6UW/9iaf8dLP5UZCVff7vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E9lVJyLD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E9lVJyLD"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90ce49af8easo8597485a.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529164; x=1779133964; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=E9lVJyLD68P9mb02OeDiuxB5mMUgH5x8C9eKQQXBi/kUsedChlQRKN28FBaldSCv51
         3MwfG4uglNXTJjoQORG1jvzmokZMB1zTDwCdmAALZToHJ4jEmUDTIK77fGVGaxGuv45s
         7oMTunZMG0fStvlKBpPxoxbtA5JV8dzbkFn4dwZL57ikpdXKjn0sQTdWkkFWIbsyHNdV
         gDlQPMutxdJ1m5CVO3wiiE56/6gf9+al5sqf+QJrAf38IiPwDTdHYaKgKp1MloaCqNMj
         Vyd7gx6VEdNGfOQYiMvMcvSBvCzZBfPfVzMwkkfiJbynwNQ2tVq9KF1f304SRsmECtYN
         MeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529164; x=1779133964;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=l0EA2AuJT63Z2QN1VI1dFXAqVEb333FMB+4Rg0ZnwhEP04qyqUTRSVEISubvsBAAvT
         /CWYG+wIHyw8VpdQUKGvcSkGpfMd9uKE+nKhnJZb/AGgNs+T6FpQFPatQCYXYqjYJNq1
         LWH+hxULTtfL5oaz1sMJ+MEa2cKnUCFlNT34EWHIV1u0k9Lb48luOZgsr6xTnRTNLTpS
         v2VFkbiUwKj0krGf0dIEdsr0QtfwtxxycspzxItUTY9+oz8jxD0Y7j5ONocyo1dxAmCh
         JziatVXt8k3l65nGrdq0+QjFsDkZkydgzyPxNV+2DwoULWJYhUqG/U1gWUCXoefrInBP
         LyXg==
X-Forwarded-Encrypted: i=1; AFNElJ8ei/VLAfopGw+iH+lBcFbw6t1MBZ3nl4SkMKBnubBpb8i7Ll3FXq7RuZ5ahO5e7Ci1CcDAaUTYTeZFPv6YzfNY99/VkeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVf6JNbx3Xon02A5FLAgQ2MPqgfo2Rte4GwyPpQRw7cBuVx/w
	vDkoCBeXDTE48qGA1EzCz7ZBnE8YRiaCc0DuRjrcMv9eOQvaOdhv+os9t7ZiQVTExw==
X-Gm-Gg: Acq92OFP7zPsfg+0cvs5msPXGJWsf3cSvekK4SU8GvHfzxmmV6HLSmA7KFB9UOUaURL
	jyJa0bw8dYMsVe3zcrYugcdzBzzB6R2V/Rw/3rozGcOV8rOKqDD+Bl9C+kLy2YumOmLO4rOmq+V
	69uw9S61w+3fSC03zKHZE9gMl/WxmxDqT5IFdMoV62mBIV3lhYw1/yQEoXlCROXHRz6oLOZ0PNR
	vM4j8ghbnNVw3WunEMwgGQ4FPRS1WC0KbGrXmmoDgvc1VOB+KRvSroqWfMbELQPkk5LoToThZvg
	+mVSsP1iJf6G6gB5d435xEH1168ViGMoKkwDMK1kSi7qMvRhbtfQXt122VtVkgoxvajJFCsk4yH
	xF9HAgNbV6m+BSOkykkE0OQuSWRWGKsthTbcWrlce+dOsRxmLGtEozOA78lgI6ZmhN/8+LbmkC3
	kj60P2nVXVi+Oj7dtYSl6aTcItd+7pfCvU28Llas1jhwfFS9IrVrc4lpJz4F5BS9nI7KVZ
X-Received: by 2002:a05:620a:318d:b0:8e8:ffd2:ef90 with SMTP id af79cd13be357-907b8d9e67dmr2467034385a.3.1778529164314;
        Mon, 11 May 2026 12:52:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9286f22sm1151090885a.13.2026.05.11.12.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:43 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:42 -0400
Message-ID: <b32ee44eb833fad926f4667892f2259f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in  apparmor_sb_mount
References: <20260509015208.3853132-3-song@kernel.org>
In-Reply-To: <20260509015208.3853132-3-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> path_mount() already strips the magic number from flags before
> calling security_sb_mount(), so this check in apparmor_sb_mount()
> is a no-op. Remove it.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/lsm.c | 4 ----
>  1 file changed, 4 deletions(-)

John, Georgia, are you okay with this patch?

--
paul-moore.com
