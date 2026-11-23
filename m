Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436065;
	b=SvS/eDTb46Dg3iPL9ObXIzJ5NTuwM6qgrfxiXsvQeJiIMoEY6wAKe74RnaFCIuD0Zb50
	 mWMExjok10rhCDKal0/EIE/q4y+JfDBjuI2bZlZ51Ldmj6AbH1XX2gGGlWdm9tktqlVxv
	 R4xx1lUbpIrv8QVWY2Re0mjY4Vl/+QQXoiIo9caekwA/1OJO5UqWDpORK+reV5xoTnqKr
	 leN5VFEQcIQ3o4/H67yh7xK30X/ueLQU14vxZyfp8tgQT6rRDIUEgINhfS9/pY0oYWiWi
	 VHJnyp4VciHrOCQ2spm6YtkcaRxmFbI2kfqiTXuiNor4fhFE0vEyNSZeUj93SsX/gfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436065;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8R9rIHAaFsMnWQxjknfOOfJ/h7LG3sqQ6sKXVu0+NAQ=;
	b=dw8VtX0oexMMe201h+w5eaWnt6kjOI853HBcAQx+zaie3JhWAbgXcNyS3DxQUPGOt8xB
	 +PU/h7gLlhu56wj00nFTuAu+88Nk1DWmtlOEjrdmvl0UndoscQ1VzejJorc1GolF2Vfr/
	 l7GAphrcL9qzCgJKlrpD3MZaxLFNbrvzMXFzfLDSqWjuHeBP1NS1srJzMCl8Am/cG96LO
	 bNYYn2radv0iUjxm+MR0eGAdBHLTJyJX3acuPJG6rpfdG5wTsfalHMKrz/gRfVsluSyfY
	 JW7RsAtYiej4il2thZzYdQhxS6+g/ynq/gkyC5BXRF97V8xP+7z+x0SBKsXLcdbzxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=28225ABk;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D3606A334;
	Mon, 23 Nov 2026 12:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=28225ABk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1795436035;
	bh=8R9rIHAaFsMnWQxjknfOOfJ/h7LG3sqQ6sKXVu0+NAQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=28225ABk1Kj/kDd++ThI0/cRaD8DjObloCIyrhKXk5zvu7nxmCHN88Q/wv59htwQ4
	 ou6ZAnywinLC+/5LUkCbE9e2bkgMJjkJBRDc9PnapFmGxoKVQj0M1vHUYLPworUZal
	 8VdJfjA1GVCuYn+biNVfD+20Px5IZNHJN3staQ+E=
X-QQ-mid: zesmtpip3t1795436029t3564dbb0
X-QQ-Originating-IP: EIGnwNkguwPdO7+iV1EMKMS19lW+TOqDQgtTB6ad0ac=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Nov 2026 20:13:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16777655916794046371
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
Subject: [PATCH v2 2/2] apparmor: mediate file-generated signals
Date: Mon, 23 Nov 2026 20:13:39 +0800
Message-ID: <CA5F08835E9B673D+4c9dbc21026e6b6ad4acb1f90255da95c3bbc0b1.1795434950.git.shilc2025@mail.sustech.edu.cn>
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
X-QQ-XMAILINFO: MQYXLRAkMyaeY8wpkqo7jZgOBxw+kgqczKIw9EnwJXRTVKutOVAZul2Y
	AY4XBAPeoTg5XfTFMN3FDd4yboSkRX3wPM2fqiuv6/nnze/YDxMI+tAodXAYpFPWj/eRySs
	64UK7y+W2nkYo303dohVglbi6purY+Yy/2janZ7xzWI4cv3Z626G9df5VGLb5Dv1XOKSZXP
	ABeqCduf9+RT77uvj7J4n7m2wElVjibGI4PeE+ji8H6OaqVwPoD9wh7ylt84hE3gBzgckhd
	vsBIatBAlSFe0Um9msBGcNIZVOGslfGCi61mkWuB3+pZQJyvBVhU7GjVzT/yL/Y6KXVN5Gq
	wSqtw3NkCB/LtfoPXnGF1Ssx7TUI5rGhgX+250b36uDnK06eYuYsLlKwLZcuDRTIVlPhIZQ
	QNa9Cm+XdVidml1mAZ8tWsnEjmO8qNHt5Fb3nrVlO1jBFNPbcSVoQO2KONgy8oRwgH+xHtc
	AppzWIk95QkaEFt1ifdTZqIkWBX454B2zVc/9ocwd3dCFsgtZ6x8CCbBy0QHacR2OJNRMi1
	2qIOfcZ2LtS/LE0sI/AtxgNEk9ygYa4xgv4u1+G6pQSRIJx2PupgOySSh1y63uoA9Gg08hT
	stMUUStEuwN5B3sVYqJ2YIA/ex77miGArLxQnTe5YCDpVUsDj8FpT/6O95KITtaYNQOQ57+
	gBVDXWqtqiO+0On9oxkfdmtNMN3HA8r6F46WdyUyR4YcVimTkmfMunzZsCV00mPuBoWaD94
	c3p9TOd/1V3aB+XSbK8uXl8++2i9hMpGs0qZjFht5UwwgNN71adToNSAFZBwZAR/dwy255H
	q0eGc2Vorsqo33vIE/dSJFceA/FJmEIbJWp5cGQUM1Iz7QZskZB4ZcpOyQbmcBBg/WEZXhy
	vcU0ruBHKC8t/k4JaqhmLcwvQPzLxSKZ8KOQuN92GJWyCa1ofSXcvzSytUo8iHi9BW74u+3
	8L/DrcMOVx346IBXTJLZKel9uf/W0gMD0yN8eKXYoYngtlicPx6GIwpHko6C0xtW6QT11xm
	e82kDBvAGOgq6h8Gm6rTst9GRuNSuDrVM51+DlJne9veC7YXj+7LfML2Jc1XaUS9p0buV4l
	/ounfBABtnz45AV08nKBGRXqcPMj0ThnIUbDkkiqiGL
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

File-generated SIGIO and SIGURG notifications use file_send_sigiotask
rather than task_kill. AppArmor does not implement that hook, so its
signal send and receive rules are not enforced on this path.

Implement file_send_sigiotask using the credentials of the task that
set the file owner. The VFS holds those credentials in fown->cred under
fown->lock, which is held during signal delivery. This also supplies the
sender identity when delivery runs in interrupt context.

Reuse the AppArmor signal permission check with the saved credentials
so it resolves both labels and enforces the send and receive rules.
Treat a zero signal argument as SIGIO, as specified by the hook.

Fixes: cd1dbf76b23d ("apparmor: add the ability to mediate signals")
Link: https://lore.kernel.org/all/20261120-unrentabel-bambus-genuss-0db3576a8f57@brauner/
Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
---
 security/apparmor/lsm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index eaebc3c60c5a..c5f4abc4eab8 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1031,9 +1031,6 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	tc = get_task_cred(target);
 	tl = aa_get_newest_cred_label(tc);
 	if (cred) {
-		/*
-		 * Dealing with USB IO specific behavior
-		 */
 		cl = aa_get_newest_cred_label(cred);
 		error = aa_may_signal(cred, cl, tc, tl, sig);
 		aa_put_label(cl);
@@ -1048,6 +1045,13 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	return error;
 }
 
+static int apparmor_file_send_sigiotask(struct task_struct *target,
+					struct fown_struct *fown, int sig)
+{
+	lockdep_assert_held(&fown->lock);
+	return apparmor_task_kill(target, NULL, sig ? sig : SIGIO, fown->cred);
+}
+
 static int apparmor_userns_create(const struct cred *cred)
 {
 	struct aa_label *label;
@@ -1810,6 +1814,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_permission, apparmor_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, apparmor_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, apparmor_file_free_security),
+	LSM_HOOK_INIT(file_send_sigiotask, apparmor_file_send_sigiotask),
 	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
 	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
-- 
2.56.1

