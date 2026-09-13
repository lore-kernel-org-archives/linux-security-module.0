Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21E3DDB1D
	for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789343390; cv=none; b=aFr09ftp5PbRcSdsbd5AyRl77NZmksyPbItuEuh4iW8BX9w8MMpj+NRgyNV4YTN4ql6pZ33WD/vFwqVP4OOsocn0tOJgXGVqzUxuR8c8doGYqs9Jp1U2qB1sAlsY21vrrMnUkbzlzVqDsxArQSfBk1r5PKrQLP7V6KDewOKeHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789343390; c=relaxed/simple;
	bh=CfbJxL0seVaW2ual+KpU++Lsco1r/Gt6o8LUUyW0Vrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEPmFYQT0HFBwvDVh8Ksi5PuYIUt0oBccTzwFOQFlASovHd1eQdWoM2nqs88+QwSltNu2SzcSFp/w6qvsCim+it9WxF1tHQujdQKEe20nA9RnsCM2OByDtGXl4Wg2AwHgtIYI07YzDEhrvRYR0jJfvGUJT4ZBNvdZG1mjA3A2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=UcdT/DaL; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="UcdT/DaL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20e86cfeso141026d50.2
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789343387; x=1789948187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69rR4iPRVLq+d7o+AdolZJ1RPsh1sWljW/ZuvUgaQfs=;
        b=UcdT/DaLPgOwrJ+DoFt0LpXSokqQaFpVRtrvYH9/P8rhpbokbiSoabk0TNjP86HEik
         bkhMcFfBeWa1mtiZjjciQF3W/sAcSkA5EazLzKVT8MD4LbIOY3/xDTuQ3i8vnciJ2E8h
         vhKVKhbeCy1CtxSyeFoCBcpnJ0TxJssHF57lqWt8Q6w1MCYLk5bDvPCfN4Z8/84FLU/m
         7M8xtXt0x8DzgkrWq3Z/tHR50o/CugYfTHtUcVNfZ3tu1wvzfqx64u+6QxRNJvcaWQqB
         RSHhmpOEpFhKODXoBwhrbS8KKdlY4eiUC6CgeIyWxkUrySKQhrtKxGiNKYckFgIljR4a
         lrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789343387; x=1789948187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69rR4iPRVLq+d7o+AdolZJ1RPsh1sWljW/ZuvUgaQfs=;
        b=nz0A1e06F4DPb4l9VFr4RPT3FIHc00PWucucMIfHS9dqiW4WXROQXKCd2yAv/LYONJ
         bUoRPrKsLxDJLQt+wzdnqQJhTz/9qGETw9gzq47/kk9yf9bOYo6CX1MhaXDj6hhBvqNr
         H4OQeAou1sJO00+n8f/WlpiEpqiooCQDEiRMr/WK4pQ5L666y2i8BzhzeAjz/SNFzCjU
         4FDiZwNC8WK44OV8KGMCQZ1+8PSGE0Q3t5WqmuPFDfdHVRnGFn+1YpjbGu4LGWqAcTnY
         kpSc2asMUcMsL+taP/uY23VQiC91OxVIPsgffb/KX/DHiORTKe9LrcfAWuAKRQ1VlYsJ
         vBsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+9HlKf4xw4u4nahTtavrJ7YKUZv1LdxkxlXN7HoydEY20JdowFgUie0AR3kij7gE6AviJ6iccryIj2Gw/y3fL6N1xNkA=@vger.kernel.org
X-Gm-Message-State: AFuF++nAjJXhAM3yXv1nf2qlIYjMtDPpmKQqV2bQo9kZXHVVpCD4JEYj
	nSGTw5jqLTagcUJybO4DFi11wTqdL41W4eGEm5JAOYPZrY+cQ9ccpm+O4FvRpV0/FvC+
X-Gm-Gg: AYBFou2WTLbNp3gZk/wXlBTQ0x1My8NLRPlALmsDG5iiNKH6xDFO8ZYrcMH/Z0+wByo
	4Kdr8M12NIho/+6eMxK68Pv0x0Qt0K50Y9u+HnXDL1gsDLnF0TLi9pB09MFRnrYVAHhKP/rzyQ6
	ShNFDsDRkcTyOvNHNScasAzEmzRxoVvK/dLozEZC+yzLejpHJlnGZ/dUhjf/ucDp3KGcNwGJ5/7
	hKPCPRJx1/MMrFnsmj6Ohwq++KTwTfkIM+b/9YpiY9/sk5y4pFNzW4+0ImD7wo2G7KCMHcpiEIl
	5xpzHYYp1LqtSCBWgWRLbX04SALKARnKll3qsh3xm/MvqVnooiX80PLrAh7f3W+1Fq2PBVI8G3R
	Ko9/ouONYEVhSEXdQWuikV6c1rDqqRGkeEgvsr5EOMUOE/A3XfAX3dB1yhBhpsaLK7X5dz5sFW6
	CeMxxyjioud+s7Q7QoRumuRhPb8GpE5/l7mnLL4j0n6gi252zl2yYYu2y9uFb2JHs4VpNIJswl3
	sdgAlf5eM/ATSuf72+ffjHplVuWkHg4ElXsYFY=
X-Received: by 2002:a53:e792:0:b0:671:2093:b5ab with SMTP id 956f58d0204a3-67124801eb9mr3901527d50.5.1789343386962;
        Sun, 13 Sep 2026 16:49:46 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125db3459sm3819481d50.6.2026.09.13.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 16:49:46 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tty: mediate TIOCSIG through task_kill LSM hooks
Date: Sun, 13 Sep 2026 19:49:30 -0400
Message-ID: <20260913234930.901567-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913221958.839429-2-clusk@northecho.dev>
References: <20260913221958.839429-1-clusk@northecho.dev> <20260913221958.839429-2-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bot's finding is correct, and this is a regression this patch
introduces, so I want to flag it and the v2 direction up front.

kill_pgrp_lsm() calls security_task_kill() with __si_special(priv), i.e.
SEND_SIG_PRIV ((void *)1).  On the ordinary paths,
check_kill_permission() returns early via si_fromuser() before the hook,
so security_task_kill() never receives that sentinel.  This patch reaches
the hook directly and breaks that invariant.  The in-tree C LSMs do not
dereference info, but task_kill is a trusted BPF LSM hook.  An attached BPF
LSM program is therefore allowed to dereference info and can fault when it
receives (void *)1.

v2 will synthesize a valid kernel_siginfo for the LSM check
(user-attributed, since TIOCSIG is user-triggered) and keep the privileged
delivery unchanged, so the hook always sees a valid pointer.

This does not change the two questions the RFC is really asking (whether
TIOCSIG should be mediated at all, and task_kill versus a dedicated TTY
signal hook).  If the answer is a dedicated hook, the siginfo concern goes
away with it.
