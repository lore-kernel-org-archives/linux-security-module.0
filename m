Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436065;
	b=sllI5nQQLu6HAy7bxjclrB1V+fQnMzrJBn152VrdbbDcvrvXbCqRd6LWJYmZuTJJMZbs
	 k7G9A1LVWJYwBCzUK1Jhew+xLxTgifOEXDzzaDXyndfYUzdGwuFB4Edm+12EICENzMTNF
	 0gxxzfonVcCf3uMvCfzeBX6F+7IxbFpWs1nSnEggwBdC7AqCbWp2R4t69Qh75wHoffmdg
	 0f/Sz7aOFopi+HdX+l8R46mdH+SsZO8tQbPGQQUEq+qdIJR624l5p3ne+rSQFq5OVKAMG
	 bwg/4uxH+7KEwtTAqR9uH4yGeKzTzKfHd04y9EISqfNKcHX7Hk6rdtHua27EyDE7v4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436065;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=iuaztd9yx6VkqQ5UQ+yE4rzihO3Tu1VlOmhtEuRmI1c=;
	b=gmYYxFDdkGBJMzwkuNcOlcT475QPRTxh0nb6KZiiKAW6P0wHv9I6kxb4ekf031HbKuen
	 wOmNwi7MFPVMwblPIdamkiS2cBq3zpDfTVEr5ePIqggO8i3bRcPXNNPGxZnOlrmdc85WH
	 DjJDuuiTw25zOPIT0clsk2K/sfaD5UWYn2ZK12l92xQlo3vZHxCWOOVt+g9h6p+/8QOvX
	 5vyMUXEdne86NfBHTlWzVZ6ijNDuf5jJB28LRpdPDpPTFocQUalr6yJ0mOZDtgaNoXorH
	 XlScX6HqOxE5mOJ+V+pEM3+7XjXMtD107a+hkqQFh3xGiCuViX1aAyBG8A6YuaPB4tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=KapevXzo;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F389606A336;
	Mon, 23 Nov 2026 12:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F389606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=KapevXzo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1795436032;
	bh=iuaztd9yx6VkqQ5UQ+yE4rzihO3Tu1VlOmhtEuRmI1c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KapevXzo3JMfM8r3mQw96m7AQizBuakrPjNkI/q0a2M9vxflqhPECjl62PukDPo+E
	 VTE6EZqCfRGfbf01UUE4VNyZ3xyB9Thh4nXTiv9/U469yqmIc7LenYQiXKPp3OtNb+
	 fzrJqcGeqbKsNHKpnGKPgTBG3o6XiYjC/xLJexNc=
X-QQ-mid: zesmtpip3t1795436026t827a7a79
X-QQ-Originating-IP: cPCzjRp8BDjqQ6cKpUPcv9c0MUGUthSUFv1Vp8Qwn/4=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Nov 2026 20:13:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18281765574563463588
EX-QQ-RecipientCnt: 18
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
	Fengwei Zhang <zhangfw@sustech.edu.cn>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/2] fcntl: recheck signal permissions before falling back to SIGIO
Date: Mon, 23 Nov 2026 20:13:38 +0800
Message-ID: <54EBCABD3ACBF0A5+9d780112081161e2f99fe501c2c38f1614a68a42.1795434950.git.shilc2025@mail.sustech.edu.cn>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795434950.git.shilc2025@mail.sustech.edu.cn>
References: <cover.1795434950.git.shilc2025@mail.sustech.edu.cn>
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
X-QQ-XMAILINFO: OCFGt05vYz7Ytzp63Cg6hCiQeQi5Wd7uPvYcEpp7Mdw3flt8GdQ0ZSkZ
	TE7cErZJnJ4zJq6IiJQHPIgEatx92VBmw0+yi1PCJYM5eL5Ji3WuTeBgGQAxb+vqMPBcnCh
	PAy1GQECkgUrnsGUE0rGH33aneswyYXhcZ9cX6X8tlFqhX0iRtHXDbkRu606LXhHIchIBPk
	Cs8sn1cOUU26wVmN7U8+3h5NrK/CZl6QKMoEWCUopaaZhvDNVvNXlYdikIDT4sU/n1IA4hL
	JN1U+zFMqIApgomsMj/OhKHRLPw0EIojPrrAydOZ/DtGb9RbjpzvGtfwnJUTabtV2FfCe7b
	WfDczdFZ1cEk2yhb9y+8dmTCttKTd0pNvGrJokoTgSMNq4VX1tzxZn53Mx1d6QfMircfZas
	v15tCNcT9vn75LWslFUKovY+nY/PH7Tcpm+cgh13jpGJOsHkH5MNs1UpUOGPwUM3xm5j1no
	4fMlbJouCoNW9HdZ1bL7JxMRoKnfHq4TEEAMHYgz+D30SOFfzWeFZK3Vc/KKnVcOlyU6l+K
	CydZ9iUgX/ivtl8XzTGiiCZ+zpzPQiPnfGO63uvd2F0VlP3stvd2fc31cuyyhS0KfNRWCdE
	GUtnrE/hTCndoFtz3jaG4IPDG3enMQk4hcYhloel81T9mTgoLlHoIHlQcXTKUWOApRefNXO
	pMmHr9SIDM97K+f3CM6sZSy6wAkr7hEZ2TEaPB26m6CjlkEtMPOrJl6UHkNWZ3+2MGQXpE9
	ANcHOQbZvrdOjj3GbUHQpWcGl2Px1fJ2VPhXI1jnnGXo3UZWSfmb48qn4mN0mgPNyaxZMfM
	DkyNl5lNmNkwiRXTbZAfzz0tlgJRztjiQ/ujf9MiYkjslcls9fBmjkqDgx5QespctLaKN5y
	NKS19VIz3F/D9/Kt9GcTAPLWMq0uzqn+o9hN+jzRuf2v7xPyrYs+kUSEfkP1WqVhm3i8dIj
	Zw68Pvr6Gv8a2NX4NH9G0eV2I+o17P/YePtFo/GPz+TX0qyj0ApDyoJGDiqoqqemC1OsSTY
	tFQHFwYtrp3Ruop7D91V6Ndhw3jsNi9+uiyCBQF4d6m4c0xJ5rGo+zksWPOHQKImf8jaioN
	o+SGNZLtcVoI66Z8SBVhoBxryeQrBCBng==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

F_SETSIG allows a file owner to request a signal other than SIGIO.
send_sigio_to_task() checks permission for the configured signal, but
if queuing fails, it falls back to SIGIO without checking permission
for the fallback. An LSM can grant different permissions for the two
signals.

Recheck permission before falling back from a different signal to
SIGIO. Keep the existing behavior when SIGIO itself has already been
checked.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/all/20261120-appetit-undankbar-bankraub-d2f1994e97b3@brauner/
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 07fe32330bec..320cdb0c6780 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -905,6 +905,9 @@ static void send_sigio_to_task(struct task_struct *p,
 			si.si_fd    = fd;
 			if (!do_send_sig_info(signum, &si, p, type))
 				break;
+			/* The fallback signal may have different permissions. */
+			if (signum != SIGIO && !sigio_perm(p, fown, SIGIO))
+				break;
 		}
 			fallthrough;	/* fall back on the old plain SIGIO signal */
 		case 0:
-- 
2.56.1

