Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066611;
	b=1t6ZGSTrVV3JMNU4wvMiSjim4UqgLK1aluoyuShZx+9WLQE1fBFHfJW2OZmMMQZp0+7v
	 Ymf2MHz/rWnTLbmtG0eJjyzRhCvgmVF+us97KzQTkwChkO4327MGTKL0iDTZyTDYWybft
	 UQJoMx6b+HZwDbB3DRpaK2KqTzIe3NMfwUbRWXfqar9dnrcVZSHXLJGQz2fArAStpK+Ur
	 PhaYvs3Uhhf2H+3SQ6pMzUN77HbAxNys30LcdCQOQI9hYOnqv7yq72P2Gto8b1J957kTh
	 F0TfR4SL8UCkxxFydViAwYyjBJ1GENAx2rqS3GE/c0hp+uWnM4qSkW04kjCikceH+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066611;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=a8hLGqTcUVX6jf51Hlab86lp0HBCT5hXJnicKBHy0aM=;
	b=zgg0jSqWGndtPn53jbbBciegVL/wMHw0eJjOkNFk0r66p3lQeb5Nveh7LBVpQuoxZHiF
	 mS5rg/BmzyRUbiOlrI1zcE2+l4U8zmXbbnn9Ldq3gMfCqKFXrTHl/i0gIhc+V3SRzTyIS
	 dVkSOtgRQnTXFf3D1avxZCxqYxkuQNgWrt3lJM1x8v+MKEQqKwn0JGAJAleb7/5KO8F60
	 fmt/sDtl+kcET8lwo/WZeuaE8DFUwjv+E4ien/pIzp3EAvKnCn6MVgrUZ03EnoDpmrxGo
	 5hKHtXW4mV9agAWLubQ891xX6NJK8Y/dmkPMRD9sLU/KGvT20iPKqIuYiwozOw+scqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b="ZTT5wO/b";
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F6606A968;
	Sat,  7 Nov 2026 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2F6606A968
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=ZTT5wO/b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1794066577;
	bh=a8hLGqTcUVX6jf51Hlab86lp0HBCT5hXJnicKBHy0aM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZTT5wO/bIPc+vIw5+t8fAvP8FldQKcsRY+z/oGh2WZd+tBgRDZRzel+wgAlQoVbAQ
	 N4QNoTF+KfBWWCfxOk60/KbuYjb32sKZ5Vp2SG7/LbxIZL/jn28VgK1DYq+jxi6ewI
	 l2I0ptK73X1FHrBICo1svdMOmHJndDoQ1769Xhr0=
X-QQ-mid: zesmtpip2t1794066571td3ea9cc1
X-QQ-Originating-IP: phDs/DuMalRpEh7BGea5/Jd9R2EiCeUZTAG7Z7cEtck=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Nov 2026 23:49:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4737263774154648393
EX-QQ-RecipientCnt: 17
From: Shi Lecun <shilc2025@mail.sustech.edu.cn>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Seth Arnold <seth.arnold@canonical.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Jan Kara <jack@suse.cz>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fengwei Zhang <zhangfw@sustech.edu.cn>
Subject: [RFC PATCH 0/2] apparmor: mediate asynchronous file signals
Date: Sat,  7 Nov 2026 23:49:26 +0800
Message-ID: <9F545A02F22B16BB+20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:mail.sustech.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NcYDFsAPVUmh+IyD8tJ8wkZhDAXElkM/69TOc1LfqXZnMUCMkXG9w6n+
	OwLibIsQGhbHCE2eT2E8d+jNQraNYnJmtyN8JlznReiohANOdQLdx3ch7IcFrX5srYaCXC9
	7t0xgkSOAXYTMV+5vpbPC5peWJNAfGVEuidAV2AOzXvTUo0AyMMav2PuaBkMAYyTyj8XrXA
	tVvV/sTTaqM3d+Eokx5rt4RO3mZ8kCcHcS1hEBfz6MpAw2x2d6jmeE7RY5Ms6psED2rDkeN
	RBKAI0laINyWE5+U0KwxDb6PHQeM8qQLgH74w4DPs6RMUtU0+457wdG3lmTsAg0uPfYo33a
	075dxgOntHAXkQhLaYLSTZJ4Xkp0gI/anulQkgYB2vkXDGGatxeDaYmn2VGZv32gr079wKu
	dkthTHEbuRI6mXmgmv30IbaSNZ0b1MMkQE+fbZ1YKs2I0bTIJej0rc7VbEe8G/9lor6K+5g
	IGDQOzptSXZ75L/IeUYaSLQnLVdOwAGXigyitKT/01GvLeD/Q2OcU6cnE1prEjonyUe9bUv
	0LIP+9WQv5S01UMXXTPDBqAzjVH7/Aki8CkDwJ9Tw+PzSGT/1SH9Bi8cnxWu4bppCVKrMWF
	dZH2mIEaegoQwQmnd/gyIQAd79a73v7MqQrjdULkdbMzHluNKpLnizYgVogzaEUBMjDMOZ5
	8ULNrDHNTCi29vqfO1yja7YkdcLzrxiHU5+WQe+CloOEZIfsK5o1c7XqloQJ7cBk8xQiFf2
	EebeZm85b9DOe9mRCkLuoMGv7CFp57pFKT+cOyWRR2ZqvVywGu9T2CCmxNn+fdn8skG5a1P
	hfHoK8njp3h/I0DrKi3/Us47ulPDp1ymLGSxbkO+dibJ/1odwR7pprlSLg6hh6Ab93Uqeym
	HiVwey8lRToE/MgSJ50wm67h2s+zJ8Iwc0QVGytbqVwoGYaCVB++5WRmzh7ZIeDcCRwpBJe
	61nv47F2p65bEJ3ZRTKZfYFrX+Crj6VuO8jT/TGmGSS1ytbVcaDBgufu9VyuBThWT+MbZ8u
	w3MJYsb18zCjAradSFY8sDsYBm0EtxFer1sQZW5h+2S869vq8jTO9Tlv9NW+XQTdmuLcHi3
	otkiuA8y6z7D5XjZ9vw/vo=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

This series extends AppArmor's signal send/receive mediation to
file-generated SIGIO and SIGURG notifications and fixes a separate
missing permission check in the SIGIO fallback path. It is based on
v7.4-rc1.

On the unmodified kernel, a direct kill() to a task in an enforcing
profile that denies SIGIO reception fails with EACCES, but the task can
still receive an asynchronous pipe notification.

File-generated signals use file_send_sigiotask rather than task_kill,
and AppArmor does not implement file_send_sigiotask. The same gap
affects sender-side rules and SIGURG. Should AppArmor's signal
send/receive rules cover this path, or are file-generated notifications
intentionally outside its signal mediation model?

Patch 1 records the credentials of the task that sets the file owner
and uses them as the sender identity at delivery. It resolves the
newest sender and recipient labels and checks both send and receive
permissions. The existing fown lock protects the saved credentials;
the task triggering I/O is not treated as the signal sender.

Under this model, policy replacement is followed through newest-label
lookup, but a later change_profile by the owner setter does not change
the sender label until ownership is set again. Is retaining the setter's
credentials for the lifetime of the owner registration the intended
sender model? If not, should an existing registration instead follow
the setter's profile changes? This is the main question I would like to
settle before posting a non-RFC version.

Patch 2 fixes a separate issue exposed by this mediation: if queuing
the signal configured with F_SETSIG fails, fcntl falls back to SIGIO
without checking permission for SIGIO. The patch adds the fallback
check only when the configured signal differs from SIGIO. It is not
AppArmor-specific, although runtime testing used AppArmor with patch 1.
Is rechecking permission for SIGIO immediately before fallback the
appropriate generic behavior, independent of the LSM enforcing the
policy?

I found this issue using kemcat, a tool I am developing as part of my
research. kemcat is a harness that checks whether every security-relevant
effect is actually mediated by LSM hooks, combining static
hook/implementation census, ftrace shadow observation, and generated
effect-class inputs judged by an independent effect oracle.

The 19-case reproducer checks the proposed mediated behavior and
produced these results on x86-64 QEMU/KVM with AppArmor 4.1.8,
UID/GID 1000 tasks, PROVE_LOCKING and DEBUG_ATOMIC_SLEEP:

  v7.4-rc1:           7/19 passed
  with patch 1:      18/19 passed (SIGIO fallback)
  with both patches: 19/19 passed

Tests cover send/receive denials, allowed signals, F_SETSIG,
process-group and TID owners, profile transitions, owner replacement,
unconfined senders, TCP urgent notifications and queued-signal fallback.
Builds produced no compiler warnings, and the final guest log contained
no lockdep or atomic-sleep warnings. The reproducer and complete logs
are available on request.

I have not run the full AppArmor regression suite or separately tested
policy reload, stacked profiles, concurrent owner updates, or hardware
hard-IRQ delivery. Patch 2 has not been runtime-tested with SELinux or
Smack policies.

This series was developed with LLM assistance.

Shi Lecun (2):
  apparmor: mediate file-generated signals
  fcntl: recheck signal permissions before falling back to SIGIO

 fs/fcntl.c                       |  3 +++
 security/apparmor/include/file.h |  2 ++
 security/apparmor/lsm.c          | 41 +++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

