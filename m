Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500051;
	b=AJnVt4bJUXYL9khVtVsypUncqCFdzDf3ScYNofcryrxhsrudQRUekgKv6oKBSgO+0lg7
	 nC3/cYtXKLgK6Avt2xolMtISqQ5UySX5J4i6uF+VeuAfslr5Ggua1AVr3UGlDDrOk46/m
	 RmRo7bGSdik12PyrlD8gBjC+KYpN+kVRvpXR3TsUEIwhlhKvH7QJLHxg2ijmFf+Mjl4FA
	 hcepfaetNhHonxPp3LE7ahvBTudt4ZN7gLRvfmTi4hED9ExuuT2j4su8fmVUkmotVaFdU
	 6/iQ+s0BhY27Gk2aJJt8MlP/cY7oJjXcI//8mLve35vpA/E7Ds92Dyx0ruHdsjxFxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
	b=rld+WWUyTdqw1+rqXbtbebkrN3RCFRZk8emgk/26Ov4sVxSFmzqShjNhr+6g9Z73QPfN
	 RfSijnM1Pd/dXmm15VwvmqKzk9QaQ31vVfHJGDMRyx98Anyb/ujQcIzaND/dxZTpZ1E2d
	 CU2jdcCJw15b7fu2rAu/1xUGyJGB8NaIG8yK+FGObEo1c1wYKUhHr4D6SMBBdkCllC7vI
	 VGOq/E8ufDfNgJpqsre6m2hKT/54de1ZDcYJwM5Bm5b+yG1w+fJy8GCPru+EdFdTjUvE8
	 Hzr8C3HMl2LW7KrRn+v4Os9TitQwSHlxd3cUVGmscJcz2JDkmjLE/8vvL7T/uHM/58g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3267606A327
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 06:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3267606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so3032306b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500050; x=1796104850; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=q1+Zpv7vRdLuNryjubIcK9p1C6hYtJyM8s4Ya+V8PgQONvpdTC7Ua853SGJTsIUcXQ
         M0pFVL8Do2Ry2wiXUj3cxeKtoqtmO0eJBjUj9twM08oj3aaj/1mWJSU3N4CXDAYxBpCK
         on+bdLfyiTexuyK1b6zmgwGoqKXFL4GeCN4DTr+jWK4djxI0BL1/DadGxeBp6DK7jASk
         tRKgLLfGrF8S9KN1UlG+krPmugZz0AWnplxbg1kncJbcJLBXntvKA8UjrUbEBTdBxIUf
         JruoLYhZMGVzT+PZrzx9sT1rk+fc369T12hC6PaBt2ez90GghipDT83vmsUcG8y9Od5P
         M7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500050; x=1796104850;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=fpqFQrHn4fFJwo5wRezs+19OKcXvPC4nq8ef5IZSsXAuyBYNzwVQt+7DmCwXNpM2LM
         Xb48dj41XX/z0uiDiypKRFpnDqBW34OgBjYDJWtyl23lMhENm0naP2eGtuyUzrlMF6Xk
         CR/S2TIMQ9ICc+eM8OwyeXJQuibsrZIwQe/3PN4gHer+QJknfX/01hMctpZQpeS6xxOK
         F0isfZiYxMkpFI3GYFwqzQQ68QB6h4gQbHNUh4/STvCK5l4G40AXNQ/y9qTrDk3HTYcF
         AND8qfdT9NDayiibq1+oq23U6FKriLB/w3wkOqS0nEOdnodITWsfGlP7MG04JnESlzcf
         E+Qw==
X-Forwarded-Encrypted: i=1; AL+hErFOSeiU+v/TxWAQkCPgYajw2twOg9PBktibsW8PA5bHgtvM/dVsPpEtYD9Tl7DTzdEAuSsuhksJuT0s1PJCrcGCh5Ag2uE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kG6wjbtWVoJVb7gBJDL44GIRJPtpNF8qB03OVTlqfNvFI2/mk
	wm+Hc7In4t/VxGsSHNLc5386vnT9cZX5jqrd1wSD1dA0nO5FzR/MNG5+
X-Gm-Gg: AZFdTZfH2ztKrVCOLZzlJvRCiuZB14nrSiLdQo8HtJipmx6kbsxqV7GNuDDEbYikynX
	jQmf9J0XEAJFxQN9Loo4gKVTF+FE2zBKcuJJK3FKzvtkLRu9wkG1GNpKk0yC4do311ImEdVa9tL
	fn1u/4WJYJaEDbyTMe2l0QhRfxOJlfcnV7MWTooQQz//SG550gYv71jjR3J8e7tg5p8c3lskUQI
	WbOpQpeBqVx7TIRZ+l1GlBNMq3M/j/DvzB1cWwsP/Bl9dbSq2HnjoZVjuwi/fQ3gM9Txzid9Vj5
	bTfNDy7d5t344B09ALX/MCmw117tyGsv7omB+03Ql+tHfwC18wWXou8flfD0yrkbu2Eb+EA00ji
	P0RtB4Pj4RV6+KfN8Oikph/57Sqh+gpp4KGXi4DqbqE3wTU/CX71erQCUW4ZEgEopj+XCs6kac6
	3EXiBLEzZukeKydfGdwIXGC7rS8nZF/NiDjcyAMV3ob4MA7QPbWrVvdwd4LzN80ItlEtyCnNcmR
	nMv0/UqKUZsQuPAtvL4TAd9S64Eq6HDoiRku5hOPfNeqK70YGNEgSgGlUnmUqioSsDs2uJTM601
	mip5IWlULNth6McKwDtJiQzaojTYkcczOAVCtCo3KMMHQzeO5JwrEqwchjxxrCN1Zxgwa6GfZ3M
	OQgcIvu7371CHSFumZuJb3nxGU0Vf3rGeaa8=
X-Received: by 2002:a05:6a21:780a:b0:3e2:8b64:2ca0 with SMTP id adf61e73a8af0-4014d35f1bamr11982201637.49.1795500050075;
        Mon, 23 Nov 2026 22:00:50 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm6596544a12.23.2026.11.23.22.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:00:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:00:49 +0000
Message-Id: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "syzbot" <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>,
 <akpm@linux-foundation.org>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <brauner@kernel.org>, <daniel@iogearbox.net>, <jack@suse.cz>,
 <jmorris@namei.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
 <paul@paul-moore.com>, <penguin-kernel@I-love.SAKURA.ne.jp>,
 <serge@hallyn.com>, <syzkaller-bugs@googlegroups.com>,
 <takedakn@nttdata.co.jp>, <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
 <tomoyo-users_en@lists.sourceforge.net>, <viro@zeniv.linux.org.uk>
Subject: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu detected
 stall in security_file_ioctl (9)
In-Reply-To: <6b051681.58b41460.7037.0590.GAE@google.com>
References: <6b051681.58b41460.7037.0590.GAE@google.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com> wrote:
> rcu: 	         hardirqs   softirqs   csw/system
> rcu: 	 number:     5264          0            0
> rcu: 	cputime:      138      52351           25   ==> 52490(ms)

It's not tomoyo, mm or bpf. Looks like act_gate.
Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.

> RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a

The registers with lockdep struct sizes:

  reg       value             points to
  --------  ----------------  --------------------------------------
  R14       ffff8880b8228600  cpu_base
  R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
  RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer

act_gate has the only soft hrtimer that can be on CLOCK_TAI.
bpf_timer_init() rejects that clock.

TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():

  n = div64_u64(ktime_sub_ns(now, base), cycle);
  close_time = ktime_add_ns(base, (n + 1) * cycle);

With base = 0 and cycle = U64_MAX, n is 0 and close_time is -1.
The timer restarts in the past and __hrtimer_run_queues() runs it again.
It's there since
commit a51c328df310 ("net: qos: introduce a gate control flow action").

Jamal,
taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
The diff saturates the sum instead.
Here is a potential fix:

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 711cf24..5422d60 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 				const struct tcf_gate_params *param,
 				ktime_t *start)
 {
-	ktime_t now, base, cycle;
-	u64 n;
+	u64 cycle = param->tcfg_cycletime;
+	ktime_t now, base;
+	u64 rem;
 
 	base = ns_to_ktime(param->tcfg_basetime);
 	now = gate_get_time(gact);
@@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 		return;
 	}
 
-	cycle = param->tcfg_cycletime;
-
-	n = div64_u64(ktime_sub_ns(now, base), cycle);
-	*start = ktime_add_ns(base, (n + 1) * cycle);
+	/* cycle is an unchecked u64, the sum must not wrap into the past */
+	div64_u64_rem(ktime_sub(now, base), cycle, &rem);
+	*start = ktime_add_safe(now, cycle - rem);
 }
 
 static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
@@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 
 	now = gate_get_time(gact);
 
-	if (ktime_after(now, close_time)) {
-		ktime_t cycle, base;
-		u64 n;
-
-		cycle = p->tcfg_cycletime;
-		base = ns_to_ktime(p->tcfg_basetime);
-		n = div64_u64(ktime_sub_ns(now, base), cycle);
-		close_time = ktime_add_ns(base, (n + 1) * cycle);
-	}
+	if (ktime_after(now, close_time))
+		gate_get_start_time(gact, p, &close_time);
 
 	gact->next_entry = next;
 
