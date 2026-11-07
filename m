Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066617;
	b=5D2eA5tzXsuwxG9MPJ8eUnokn408FBfzCUbPcdZZAdKxt2l7T85o2LPY9MckqfOedz0j
	 LZ8aXUKyytmPIHDyM9m17kGitctKwrQxrdwb293RwEEZo7cAnj5IBOaQNYgY2litISkE1
	 DF7lcmLboKB9LpPu1wTgudjNz9BqVuyI0mWELAO6wIwi2lZea0oyCNUMWms3sCVFIMVn8
	 5mGRna3WJOc2flxzZuh/SJd9M4iUZnvDjd8rK3uNCIHBJo6bjMN5t4qY1K0Yo90ihv/bn
	 rcYcQkdNoIj9GbyvlETIF/oIFO9eTQEgc0y5JxTzwlBlSInifLFnyg93HjCfWVHiXVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066617;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=PxDKAlr3pjVMRmZhgIjYRL8aFDbvpp1VwQppzcfLAic=;
	b=iQ0BSUiZTZJTq8a1YnZgQS+/8y6d76/HGuVFuDjiN9S2aGyeVtfxBfTIVgEm2K/NAqwD
	 ZzVdymlMaucZt936UW/UU7o0LJYmRPhcS3QWwYmP8kzidgrF3sFPSIflRXJFwPgUh3+i0
	 DHxbRKkKxyMoVPHc0kmew0XiJiSDrgnqAXwrxms6eHWfAI6T2XO3gAGX/nUXsOPjtmZ6+
	 V05RZ/NMn87qfMf7cFfVD/7BX3SOhI77QymKkxTAozSlP80dNr8QVkCci9DabimltOXPV
	 s21Uip5LFXU9cGEGNUY7PE7xSorzx0nk9ZFMylWHeBIAnyj9+sUyj3JYr4lPYtdYM8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=rWgptGe2;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFA606A958;
	Sat,  7 Nov 2026 15:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEFA606A958
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=rWgptGe2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1794066584;
	bh=PxDKAlr3pjVMRmZhgIjYRL8aFDbvpp1VwQppzcfLAic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rWgptGe20uHKZKMhsZWoV4ftXgrTOmUKxWP2FeEV3uaUKlysT3Z0bJDzDjRC8o8Rl
	 p6T7shK2IfGBmHo5wUx+cgeZjV7xO61A+trCehVsiIfkO7npWWtnro7TAp2ULFnMEO
	 sDuX7C6pzGe2DvQeNIxkCk/3IfpjLuEz/kvygiTM=
X-QQ-mid: zesmtpip2t1794066579tb52f8897
X-QQ-Originating-IP: E0ayHV238RN0bFS1v7Gf/MBATEwc+WmOvszSt1bKJIQ=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Nov 2026 23:49:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1414680298667499598
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
Subject: [RFC PATCH 2/2] fcntl: recheck signal permissions before falling back to SIGIO
Date: Sat,  7 Nov 2026 23:49:28 +0800
Message-ID: <4C916018FDDAFB60+20261107154928.3519030-3-shilc2025@mail.sustech.edu.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
References: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
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
X-QQ-XMAILINFO: M94I2jolx1v3zXNHjlJ/VCgQVaXLtKVGaSZ2p9lCFewi4/4/zvVBsNSg
	fZmnSFe6+GWMNUBrYSjyV20zUrHy14HWMuSfO05yF7xzV0LRI5WF0wGo2NQxsjO/LlsNbY6
	iV5oaMQZJDdO5DKlH196UcGc8WAjx1ffjBXim/HrAS+GGf5q1otenpbtOj66HGFEtNIoU9Y
	k6PnwA3DAUj1u4ofP51fJczvLF8OysKIWukBplbqHfTGZGwdFFpsO0yc7VmLvor2M19eRmW
	u9t6i8UjPLZ+tBL7U+XAdW7bx1xjZWKvoxQmL/OtLq/0DmbVTF3rGb+aKKssJiAnr43EhTH
	Y8vFHlCFa2xd/LyPULCnEdriiMhRnn+sFi1mmRxlxm3VpI5LJUJaa7VC0ch9X0DE9Blffdv
	XSd3q/iR924f3ih6jlqEcvrft5APWC2yZlfGZooEIrcfZvmPCcSPsrQuSH2Wk3Qqi0iXYj1
	Lb+k4u8W8k0yOtDV1RRaz2K53lL2tv9suqBzXecAoidl8xgoamttRPuicjS5bW54bi2aoNf
	qc1yFEb/XCt7TYdcDaNlYzF7bPTNTFfwjLW1czijSxwbXjWNLvJY6SDPFWRlJEi4vXE+SyM
	xhgruZodko9orHR5JadU6W5GKvfa6EnLJMrcT1jWU19MMymUnRv7pWYsjuXEg47vlFZYwZF
	+t+UU3u6EC2GGqi8Gl9vq2ViThaQvIw4IYmyvoPHm87Edh9RGsNMP/uNugI/soThgxz8Xqm
	IczJ2JYYZdr55K7LVrccBt5h6WRUYr3z3JbbdiySwVmJ/fF25P4tAjpDdnShiR23MoSz+er
	/NKfMa0ncG/VxnARyfC7eezhQ4ZTUrjKHVUNPsqwPwA7uOjN7pJ7xr1Vu/XwjBLyz/NZt2d
	+a5n9vCNqUHKdF4p0qH9bgs4XiTwPQW6WLaEmfu2tKycRlGPC+PR+guhfrp3WpqUm5l1Qjz
	8mUTbV0OKxmHZ3td1AcUstTXXucnMqojWzE7bSwDO+A4PNsuVlVtsD9jT5B8otyY+fY3alQ
	yguY9+0WzMea21Y0blbdCHaJFLKu8WfhBdjoaMnLBW4Hhsg6dzFQ21Cn/W8IXoO2IXJzt8v
	HknrfyiMhW1
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

F_SETSIG allows a file owner to request a signal other than SIGIO.
send_sigio_to_task() checks permission for the configured signal, but
if queuing fails, it falls back to SIGIO without checking permission
for the fallback. Permission for the configured signal does not imply
permission for SIGIO.

Recheck permission before falling back from a different signal to
SIGIO. Keep the existing behavior when SIGIO itself has already been
checked.

This was reproduced on x86-64 QEMU/KVM with AppArmor file signal
mediation added: a recipient allowed a real-time signal but denied
SIGIO reception and set RLIMIT_SIGPENDING to zero. Queuing the
real-time signal failed, and the denied SIGIO was delivered. With this
change, the fallback SIGIO is blocked; allowing SIGIO still permits
fallback.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9b71bc9d71d1..5b0c912264ca 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -904,6 +904,9 @@ static void send_sigio_to_task(struct task_struct *p,
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
2.56.0

