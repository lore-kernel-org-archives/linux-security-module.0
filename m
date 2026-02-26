Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379A1A3164;
	Thu, 26 Feb 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070859; cv=none; b=P9dZH92pN9Y8fCK+TULKoLxGIwJNBR+dQ3dRafbbcWLE2ujmq0ie+bMlFvSH7MELritteVFKjSf4T9Dwk76BNNblPRCsnMUA/FppEUrXu0T03OmmEuZZ6SbHWLQAVNRR8wksPeqqmP7ShLyP2YO9Ah0NbL4cpg+nn7v05H8KNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070859; c=relaxed/simple;
	bh=qAolWJ+0TYq7aLvDUvrQ3HoJdfbmrN5E+Hyfgvfr5NU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PXeU1m1ztNTSY0n//Pp/TAlCQPFVLbCiesDACx2ZC2G+Y64R/Oh+x+rkC0gjApk7Kr6CgEbV6rH1aPHwahImruuEs+0jsPZ6QxZAFkxuLeyBOV43Wt9Uqv77Erf3YK8d9MixdSthBjY8oO6uLqO93Ov83EbwH6jkHN1VZ+4rB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Nx/cz9ex; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Nx/cz9ex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772070784;
	bh=jCmVgQi0CSghe/B2hscrfjT/9+ngz/JQJd90e9W5f4o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Nx/cz9exsgS4oBrXig1/W6GRDhBluR9WBSdTFLoxbhzeYwlOJlwzUR0GWadnoWkVD
	 bjpspuxBD8k3/yvmPFs1G6eztfG69GzDuVov0oQbeBp5ITwhcMcT+VI4S7YCvoaCKZ
	 XYMqctvxOq6KwRxb1s5bUx1N1ToAhNy4kVJQQxjY=
X-QQ-mid: zesmtpgz9t1772070776t146211e7
X-QQ-Originating-IP: qI+bpaLV01jXbA/s/Wx2iqAcBrBiUI4+S6dt50wT/dI=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:52:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16262708918062487763
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] landlock: Fix TSYNC deadlock and clean up error path
Date: Thu, 26 Feb 2026 09:52:48 +0800
Message-Id: <20260226015250.3157804-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OSHOCkXs35q2lIukX3J7nMKd8VYANJ+z3idJZQ4Gwa3/41hDXTp8+s4O
	J02plH+jyxNt8ia8oJg8GwoAvn/lyBgFLJ8ww9axj4NLdkUYAMAzyaSZqcwN6N/bo4t17um
	Ui+UhVestct4ZfsAQDq3YdgSKehE13D0XNOTLyUiXLBCD+yYvHFRWd4yZGRaAXZ6q+5GeDr
	0KnDwoo7CfXaR4oaTxpex36UH+7asGzE7Tm3PmRBbn4YQ9ipNMD7CXYLulmRw0wEIEEkBO5
	4rbVo9BgMf8jjM5SoOPF9hXgcK3GL7n05dJk9fI9OHl0k2szrn32NSZ3fdaAA7c51EtuRma
	VsXUXVf+9Dpr3CVvBfqZ3cHIBI20T6bzOJ23VmlPD9IjdgtPxOUgenQ6sYECunTdIru9EcS
	Gm/YLi5z82D7Jkd5GCR+uO0+fgDOD0t3vhd3MbwRGXCut5MPBzEI+LKbx3k2aYfwwu1MwYN
	HdhvYgJUUo24TQkMU55DvYeBoSwp86xDydmi08hRbl/jXTiNwR/TuyXspVhlZGL2+QPSqOG
	MEJnksCA63aEOB/KfLXz+vYSG75byTZpNx0Q9KM+CtZ227fLmKUYfohN6bMR8y/3TVDdtOH
	kqsMmYvvJMnmOSobHKnRgqCAP3d0Ad7FXFirMEP37sOf57pZnV+AZU3mM3BwfWDj2DU70hm
	f0eLm/maoD83gBU3XhzHfdn/qPLj8HMnqOOc74aQ3WvUDrRBLp75+G/gOVzA3fVpg/OWcGO
	FwggVQDD8CB5noh/TRuXm9Vgi13NWtBWBM8nd3lIP1+Xg6Vhiz5zqKijzcvTX7UO7CAmWby
	9vG4Q4sh5GccgnCvk7AhJNmrr/zo8A1EN1F2TvpTcFBqjj7LSd56/ImFcxQxoj2emUmJ//6
	ZQMvUvECO/WLFx19Cg1CLF25NU7T78sAVxJksQrXy5n9wkVW1xHPKGI++MCKrs956FwlYv7
	vrTGioTpRdJLPt6SFT4+DkHSU7Hqxowo9pUINp3Iuuz2Crs59VMVMQzd6LSx6fkXHEI9F8r
	d1H42aNynHcZKkUk/a0ETZ4L1Sq7UNI7+lfU5M/sfGPNx9kB0CY6BmrE5r4yMs8h1AeazL1
	dtbxE0pwmUCPjug5spE8/VA6KyRTafyXAnzVNamNTfFB+Vss72eG1g=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hello,

This patch series fixes a deadlock in the Landlock TSYNC multithreading 
support, originally reported by syzbot, and cleans up the associated 
interrupt recovery path.

The deadlock occurs when multiple threads concurrently call 
landlock_restrict_self() with sibling thread restriction enabled, 
causing them to mutually queue task_works on each other and block 
indefinitely.

* Patch 1 fixes the root cause by serializing the TSYNC operations 
  within the same process using the exec_update_lock.
* Patch 2 cleans up the interrupt recovery path by replacing an 
  unnecessary wait_for_completion() with a straightforward loop break, 
  avoiding Use-After-Free while unblocking remaining task_works.

Changes in v3:
- Patch 1: Changed down_write_killable() to down_write_trylock() and
  return -ERESTARTNOINTR on failure. This avoids a secondary deadlock 
  where a blocking wait prevents a sibling thread from waking up to 
  execute the requested TSYNC task_work. (Noted by Günther Noack. 
  down_write_interruptible() was also suggested but is not implemented 
  for rw_semaphores in the kernel).
- Patch 2: No changes.

Changes in v2:
- Split the changes into a 2-patch series.
- Patch 1: Adopted down_write_killable() instead of down_write().
- Patch 2: Removed wait_for_completion(&shared_ctx.all_prepared) and 
  replaced it with a `break` to prevent UAF.

Link to v2: https://lore.kernel.org/all/20260225024734.3024732-1-dingyihan@uniontech.com/
Link to v1: https://lore.kernel.org/all/20260224062729.2908692-1-dingyihan@uniontech.com/

Yihan Ding (2):
  landlock: Serialize TSYNC thread restriction
  landlock: Clean up interrupted thread logic in TSYNC

 security/landlock/tsync.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
-- 
2.51.0
