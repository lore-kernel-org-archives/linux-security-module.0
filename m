Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066611;
	b=VfRPBptE7z3Vmpy+dhx/4YGi5O6MtNCctSxRs0I1Y1yPfN7VfO+aHUcT2R1ds9Tui+Xd
	 yv6rNSYjM9ExT85VTuga5PIBeyuAWnoCABVzJJN3tgpJA7mPW8qwLIDDy8m1QKZgoe5QU
	 uBXevbreTasgIzp1ywTEZ9xWHSn5WixYI1aBESkbC3yGsf0Y7Bke/MJDURCvYuOLST1Ug
	 2mByvaqiGVOi/Qpf/gGd6kqPOaVhYih/b7y1iJAweN0HEO9I80Msq/0MGp63tpTi5iu4C
	 MLPEhcoIA/o4O7N1ouxWmGH08CoWuLYBIzhzcia+eAjTmV4MiX1nqbaZIla3uECv0vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066611;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=aJjGWD/vfGCeNthSFGq62tpflr1wnv6PQDhbywv/vbY=;
	b=4T9QCIpWleeICFtiGj4qbNsAbK/jAJd88In/MeBlRvlxp81Sto3Ud/aK95LNGK9xsB+E
	 a7Iyd6mrudvWh5+RutXNgUJQgrbv9zXeJ+B8R8nwe11KMinP2kTwZmpdw9cKrMwNtVtS+
	 04ndqC92eSaFbxViKMmCLFRl6PEETdf4xVGSWYghqBLE2geXpqtiGCCyXX6uT/2TBDQoc
	 thnKGQZUOU1yWccouQX7SbmA6AHsWRo2ixvKi4PgB6PThcIiraxNqfykZetBJo/IhLLdR
	 n3uIdcs1vAmhScRmqf5NpXXL7bxgd3tvGY506suJxbRGSWfk/Qm60Hi+r7mFV9llfWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=GvHcgPzc;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDE606A96D;
	Sat,  7 Nov 2026 15:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7CDE606A96D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=GvHcgPzc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1794066580;
	bh=aJjGWD/vfGCeNthSFGq62tpflr1wnv6PQDhbywv/vbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GvHcgPzc4RkvD4MuMNMlSmkxn1Q+j1WO+SNbucOUUAWwhfv88xFYWrA7GGoktragP
	 +jEUDnpoUg+pj2n+W7X/2Jp3vIxsSQmRHdWiauoC9HWhPtVbzMgxmoQxvOkvktGfAo
	 l6zZ56FrPHzkFTIHBswWjCSVzJ193ZacY9IzhH4c=
X-QQ-mid: zesmtpip2t1794066575t17dc6bf4
X-QQ-Originating-IP: zQ/J0f/x/SlXcb2KzWWkP67AAd1gcp+nJr1xJQnRQww=
Received: from szdytom-matebook.sustech.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Nov 2026 23:49:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11137086329825717384
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
Subject: [RFC PATCH 1/2] apparmor: mediate file-generated signals
Date: Sat,  7 Nov 2026 23:49:27 +0800
Message-ID: <B01DC8398B429509+20261107154928.3519030-2-shilc2025@mail.sustech.edu.cn>
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
X-QQ-XMAILINFO: NcmC868q55ANhqeY2IR6i5kWK1brczVm1xMTuUpVyTOefSwQ8gD9wsTq
	j5FbW4+cMkJNb3CMUhFPNTGFb3sNTqFfLC7GAIyR0uCraN0Cd579kCFqSbWnCrtPcfYI0yM
	kU6GG9+r95fXlQqPgz/n873sk1ojM7gT2QBdO/ENBbR+yS3JDuWoriZKExDij62rwrYkHDg
	sUmUURB8++rooN40LRZ6udn6apRjGHKc1sk4dFVUcyPQa+UIgCP/KFmQzgeiYci1HvsfqXb
	Cyk+YzbbX1rChenJrOpvGmafLCCmyBcEsJKLDJGNNEjB/N+I/GhbtUdqT7W/n3dvbz1CYVD
	++3wk9lGZ48BedMlEuKK67++hSiISnPqWFZHrc6DrYBfNaPoE4LM3IvKX71JUepEwBIeV2L
	+GeTKYz1qarhtRVdbMtbeKCcuRpF/wZDZc2PfhNxi5ZPzf0vaU3Py8rMKuFFtx8Mq0F1Mez
	topDQs9tiWOhSiMQPXiSc2rWTiptojuooh4A0jDJFPP5pd3QC1zp6FvJHfnFVwf/BPfoyCJ
	LU+Ne1fxOV7M9trtvKiORwux/HQ8+NJDKxNB66EKC5rWzUn67YkThowZ6wT4A/PY2mD6u5v
	4xmz2GfV4VZcqNVU5dgXzcF05S7RHTPTiyzoR25uyfFTT7mJFmAwq+L0zRJ+Da+i9P+jCkN
	28tXHQHd9cg9h6gRXrAIKSmHC6as8OnBw2T8Vd4SkR7FLDr4cYGmrs5WZ3y5ZoIQf8ZPzSN
	pO7t49Gq+bg3fvZpKUoakdjlPKepk0GOlckPCSNiNtIOUUCkJjCI+ZJBZ2oIHmEOUpLZswZ
	AmCVrRBLp8+gT4AbwzTZUNJxEHYJglgShLJByO6WU0wEC2LJZhQLtaR491Dbz0Gpffvy5g9
	pqvwQkycgjmT91NibfuSwgXXHAlBuM5PSfTXlWLhNCl6oW6+UCBHAg0ghy6olmso+ip15eG
	+GgDGfryUnRVcDKkiaW/lAFLuHNEhJ+uEko05ezUF8GnsZFlBWHc8XM6LFYor35bepHKQ+m
	YrQHVOLp+qEkINF6RS2nxa8h+bszaCB6VOaMxb4XNtRM/qyHcYfrIezUd54fSBipEbspB7D
	WBlhUIbUNm4rf9M8FpFBy4=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

File-generated SIGIO and SIGURG notifications use file_send_sigiotask
rather than task_kill. AppArmor does not implement that hook, so its
signal send and receive rules are not enforced on this path. A profile
that denies SIGIO reception can therefore still receive an asynchronous
pipe notification even though a direct kill() is denied.

Save the credentials of the task that sets the file owner and use them
as the sender identity at delivery. Resolve the newest sender and
recipient labels, and use aa_may_signal() to enforce both send and
receive rules. Treat a zero signal argument as SIGIO.

Use the existing fown lock to protect the saved credentials. Replace
the reference when ownership is set again and drop it when the file is
destroyed. The task triggering I/O need not be the owner setter, and
delivery can run in interrupt context, so current cannot identify the
sender.

QEMU/KVM tests on v7.4-rc1 cover send/receive denials, allowed signals,
F_SETSIG, process-group and TID owners, profile transitions, ownership
replacement, unconfined senders and TCP urgent notifications. A separate
fcntl fix handles the case where queuing a configured signal fails and
delivery falls back to an unchecked SIGIO.

Fixes: cd1dbf76b23d ("apparmor: add the ability to mediate signals")
Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
---
 security/apparmor/include/file.h |  2 ++
 security/apparmor/lsm.c          | 41 +++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 1614c07fc53e..c638baf7b9c0 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -37,11 +37,13 @@ static inline struct aa_file_ctx *file_ctx(struct file *file)
 /* struct aa_file_ctx - the AppArmor context the file was opened in
  * @lock: lock to update the ctx
  * @label: label currently cached on the ctx
+ * @fown_cred: credentials of the file owner setter, protected by fown->lock
  * @perms: the permission the file was opened with
  */
 struct aa_file_ctx {
 	spinlock_t lock;
 	struct aa_label __rcu *label;
+	const struct cred *fown_cred;
 	u32 allow;
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index eaebc3c60c5a..b1c4e82463e2 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -522,8 +522,45 @@ static void apparmor_file_free_security(struct file *file)
 {
 	struct aa_file_ctx *ctx = file_ctx(file);
 
-	if (ctx)
+	if (ctx) {
 		aa_put_label(rcu_access_pointer(ctx->label));
+		put_cred(ctx->fown_cred);
+	}
+}
+
+static void apparmor_file_set_fowner(struct file *file)
+{
+	struct aa_file_ctx *ctx = file_ctx(file);
+	const struct cred *old;
+
+	lockdep_assert_held(&file_f_owner(file)->lock);
+	old = ctx->fown_cred;
+	ctx->fown_cred = get_current_cred();
+	put_cred(old);
+}
+
+static int apparmor_file_send_sigiotask(struct task_struct *target,
+					struct fown_struct *fown, int sig)
+{
+	const struct cred *cred, *tc;
+	struct aa_label *sender, *receiver;
+	int error;
+
+	/* Delivery can run in interrupt context, unrelated to the setter. */
+	lockdep_assert_held(&fown->lock);
+	cred = file_ctx(fown->file)->fown_cred;
+	if (!cred)
+		return 0;
+
+	tc = get_task_cred(target);
+	sender = aa_get_newest_cred_label(cred);
+	receiver = aa_get_newest_cred_label(tc);
+	error = aa_may_signal(cred, sender, tc, receiver, sig ? sig : SIGIO);
+	aa_put_label(receiver);
+	aa_put_label(sender);
+	put_cred(tc);
+
+	return error;
 }
 
 static int common_file_perm(const char *op, struct file *file, u32 mask)
@@ -1810,6 +1847,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_permission, apparmor_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, apparmor_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, apparmor_file_free_security),
+	LSM_HOOK_INIT(file_set_fowner, apparmor_file_set_fowner),
+	LSM_HOOK_INIT(file_send_sigiotask, apparmor_file_send_sigiotask),
 	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
 	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
 	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
-- 
2.56.0

