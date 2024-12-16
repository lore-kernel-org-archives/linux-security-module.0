Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE61CEAC3;
	Mon, 16 Dec 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337235; cv=none; b=CLDD8IMGh8Hf/Ucqj0DcaEgACfJJfEcdFjORM7sIzTcVqjY9cMGMJoiPkBgimmzJaO0K45kCbZ6zbuQFdGixWfOToPIbuG2m1VHWTMTLrZXnhzTWFfYW9xwhdeHGJ8U77w0+CuvBd/J2fxMFDZOEY/XnCUO21t9aOSC6Tn9bx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337235; c=relaxed/simple;
	bh=C0ggwz8jnAhNvdObNS6uFwAKsivdC5NXr8WVRzGiZWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiSO8f7c4JZ6Vic0rv9CqoXmeTu6zyVsKUBiMwMumnqtxiDN9qpZWPlOVuxLPY2lsEnvt3pmMo+2TUJu8sGdCNLLyI3gX9cJ8+bEVKJRYpIs5zsmsceTH+KVv/cZH1fXNDHgWpxkDYv7jWeAFT5RI5pOAeuI2lUAAGUbgVQx3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6LaBC031360;
	Mon, 16 Dec 2024 00:19:58 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43hadq1axt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Dec 2024 00:19:57 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 16 Dec 2024 00:19:57 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 16 Dec 2024 00:19:54 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
CC: <jmorris@namei.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <paul@paul-moore.com>,
        <penguin-kernel@I-love.SAKURA.ne.jp>, <serge@hallyn.com>,
        <syzkaller-bugs@googlegroups.com>, <takedakn@nttdata.co.jp>,
        <tomoyo-dev-en@lists.osdn.me>
Subject: [PATCH] tomoyo: prevent bad buffer size in tracing_cpumask_write
Date: Mon, 16 Dec 2024 16:19:53 +0800
Message-ID: <20241216081953.3566217-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
References: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: epUPU7DP5eOOwc1Ycndj4EL0cL_-kCXk
X-Authority-Analysis: v=2.4 cv=INT4ChvG c=1 sm=1 tr=0 ts=675fe2ad cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=z8QvZRE759NthNQqPukA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: epUPU7DP5eOOwc1Ycndj4EL0cL_-kCXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=544 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412160067

User input a too large buffer size 0xfffffdeful, although it is truncated to
MAX_RW_COUNT in vfs_write, its value is still too large, causing warning when
allocating memory in tomoyo_write_control.

Add a check for it to avoid this case.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Tested-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 security/tomoyo/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c7b059a332a..f63388c2fffd 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2654,6 +2654,8 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 	if (!head->write)
 		return -EINVAL;
+	if (avail_len > KMALLOC_MAX_SIZE)
+		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
 	cp0 = head->write_buf;
-- 
2.43.0

