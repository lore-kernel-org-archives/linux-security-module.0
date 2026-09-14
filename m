Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D88471431
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393231; cv=none; b=E2HkH10u3XY9BRa9C1TiZ8u5bEcvv11hpDuOrkHO9Gyeo+8nLyOPit6W/2EQkgUoFEWiceOK4C7bnPLrcQ8HmQAEMvQ1RXyXBrHymxp8oQKgu564nkTKkCju0dtqePfjXX+pH/QZoZ1rvlMxuUR4/vNyVqk2KSZsl1HIp1oKnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393231; c=relaxed/simple;
	bh=mZU/fO8OtaGbBarERog6EImn3Wb4EilvuM8GJIgoyXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZprUKbIr4QLwb71meO9iosYIg+swPs//J0+bVnKrD0hdocWDsduu42Z4w7O4uZURJF3U7dY2a7XZqeTNiD4fJ+QhEtYaO78O5Q8gkbtNGGfFv0ZMvm4/oJvgOQ3qKQQtLaJYrmpVVKsO8WzBWve9r5BvRYMuzppgBHReEHTLQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=bPZBSaWo; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="bPZBSaWo"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85901984388so1396237b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1789393229; x=1789998029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFyoG+nKOe7E1GIHo4TRUP3a6TAurMs7mwR7N6d6faA=;
        b=bPZBSaWowTS0ZJvXRPKEmWtdKuRgsWC3pkGTuX8W6J03oJ+Y59GusV+oDYBuy1OJXp
         NwQMeCbtlVv7uzV0dI32O5tVCWZcCZOW+XIAqqipJigz47SzQWeNuGeQJ7ISPtUgXlC1
         T7F4RbmArBzMEoa2onRNWaDxDJVHhijJPXweJA4BKbSurI8HSBsK7Zi5YSU2lGHeM1JX
         kk/LsYPUr0NdKVV0/u8Egy7ygsp8yhhvnIa84hQjJaviPfP8LGpNTdGQKE4KlgEfnxbW
         BI/g9HXOBJ9cLKGLtPU/A2oip44eKfXNSIUJs2i4Th92p6LuXR0CZ18mu6NPFbFwB0r6
         JZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393229; x=1789998029;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFyoG+nKOe7E1GIHo4TRUP3a6TAurMs7mwR7N6d6faA=;
        b=BzL/tzinq4lgeKgn6rbI2ejQeFyP8EmOaAJscsIjinzzoP4qn87qV6w04Oq/I8VNRL
         zgUSXnZua1Ar2ctgNU/yCTvkKoj1kri6AjrFqdhtAJUxyo6OGVetWQ/q/9uEAm6dSTjs
         H1yQB+9BBdSPMwdykJqVblPhxXihm4vxHIqg348Czk9yR+yENgHWgWfQ1wMx6hygItaA
         0ClxIPg/U5DAiKPpL8e73MUj9oNKgEYNczhuJ9CeWpLp3MVebdz/u98WI9qCyI1HrhUU
         YxFpITQllKnmuMO+Fo753oY1HEA2M8ydITBU2CoZg6IyRY6jYtPfIsJGu6jgFzbM/mAb
         Uvbg==
X-Forwarded-Encrypted: i=1; AKwUvBxbE3nflh22OfmBNb8sghfNaRr7Kh+V3UvlV+qQrV7o3+WnH+D/1VWjr1VtMTLZMwQSlcVGcNUvI/H5rwioKxL1jVTXfOM=@vger.kernel.org
X-Gm-Message-State: AFuF++mmF/ovOfGx2/Bw/UTUxNwtETtt6hri4f257BaHxmh7j4Lqxnjl
	778T6v2vu2Ga4lLqODchoU3Pu7Bvi/xuJvPeQVYE4SnjgE55N4+UzTjPUTYvYkDEPLWl
X-Gm-Gg: AYBFou1ADDhnyMse/6I7KFiGbASixkMqL7KYaY1aCOdLBpDOHfIIrs05uf6zq3vvEGI
	PDThp43oPEotp+lLkPH97YNiHXm5Y09+zNdEdCzQiYW7nRsFm1hFW9dQWW4wxEhj/QFmOyb3oBc
	4TfNbI2tgY73e+SjWe7+9Gg8tiOIp7M2rMuYtxfpSpLQpViugRfhJjWkTdmTCg7R7bhPwKdcgNY
	1FvGieYGk/v8dXtRoqeBtyV1ukluSTMBbQdOPZFt8hAWs1WHERniwSUnTo3m8rvKOiZqai3Cx2M
	4nFlFGf4GAVSxEjOxydDu4M3nMFuL7nqQVVM9y8nwigioJjZDvBuTEsCvtVjFSP2ga0yHjuywLD
	AOgSMGO9cJugprop1+b6WoYxvkyDPBPyGolWaRq/Q3ISRAdbBq3XUbcoCkmylM3GyCNfVvkrlQ1
	FL0kOh5IEIwnsOwMU48LFRjzmWR6pEO47VP3fV8yWOpZgfBNmzz9VV2nUAfIT0EjB77HmUt1FWv
	xmfudYt4TCuj+Xl6dKdb4v4kjM6GJNT5UBJQ5w=
X-Received: by 2002:a05:690c:6c87:b0:861:a34b:7de6 with SMTP id 00721157ae682-88d1992ba59mr9985527b3.0.1789393228701;
        Mon, 14 Sep 2026 06:40:28 -0700 (PDT)
Received: from kelso (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488a4c120sm36807737b3.38.2026.09.14.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:40:28 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
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
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Date: Mon, 14 Sep 2026 09:40:13 -0400
Message-ID: <20260914134013.1457130-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914.b8a029f9abb8@gnoack.org>
References: <20260913221958.839429-1-clusk@northecho.dev> <20260914.b8a029f9abb8@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Günther,

Thanks for digging into this so carefully, and for the clear write-up.

Your capability framing convinces me.  Controlling who may attach to (or
open a master for) the PTY is the right layer, and the master FD is best
thought of as the capability, the same way socketpair() is.

You are also right that the series is incomplete as a fix: the same three
signals arrive through the n_tty control-character path (Ctrl-C / Ctrl-\ /
Ctrl-Z) that my patch does not touch, and PTYs additionally raise SIGWINCH,
SIGHUP and SIGCONT.  That reinforces your point rather than mine.  Chasing
individual signal-delivery paths inside the TTY layer is the wrong layer,
and a per-ioctl hook would only paper over one entry into a mechanism that
is working as designed.

One question, mostly so I have the line right in my own notes rather than
to relitigate: how do you see this relative to the SIGIO/fowner path that
4b80320ca7ed brought under SCOPE_SIGNAL?  My read of the distinction is
that in the SIGIO case the sandboxed process unilaterally selects the target
by arming the owner, whereas here the recipients have voluntarily attached
to the terminal and the TTY driver delivers job-control signals over that
attachment.  If that is the intended boundary, it is a clean one, and I am
happy to treat TTY-driven signals as outside the guarantee.

If it is useful, I would be glad to send a small documentation patch making
that explicit: a note in the SCOPE_SIGNAL / IPC-scoping section of
landlock.rst that TTY-driver signal delivery (TIOCSIG and the
control-character path) is not mediated by SCOPE_SIGNAL, with the practical
guidance to control PTY attachment instead.  I will drop the task_kill
approach.

Thanks again for the thorough look.

Christopher
