Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC93590A4
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651602; cv=none; b=rkxt/vXgHAZTBXHR6mk386nVeCGBRiMJKl9LmDNrQW+fIrprprw+J5Qn+J00yvckkYvrOT/yRcgt8MtwoK5St/+6RF2CEnQtMscSvODnO4aQ0kci6Zpp4hFFp+x2mQkWqWsWLiSXVk6m50O8SRCNSSmXFlEgRqg1LLFU35ZdfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651602; c=relaxed/simple;
	bh=r7WIw2CSAQ4tWG1OZ75salml9To1eme5D14M43qpmeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+wFYATpA7kru3eRBzbQQ8L2eIT6UKRCCQunEDnpShMJjy+xjBsy9ZB9+/fdrozg35mJDmeixTQFpXAGEEHZvM4HWChSUqeMPMlYwri544mUS+tujz7noeC6jrXRMKy2qvhyt6h3qJxst+v1zWg6mEY5opOBPUUg6pSAgJ3NiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TU1wZaLk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TU1wZaLk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779da35d27so12433515e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651570; x=1764256370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nc/agqhZHpBZo5pQd3t3SIT1Qnduk/rx/3xksUJM3vo=;
        b=TU1wZaLkkk2G1q9LQREJlVbVMI6JtqLtTgFkFu3ulLlanMpcjX3GU1YkH62Y0+IN24
         XilWWeiLu5/isiU2ohDC5wyT/hVf1MykPj0KVcetQu3KgkJjZqTxGdWuCvbAfm5J0dFK
         JGg/kggFiraLVc0J7CloN+MRuC8/+RpsDNzk5vHRqQJ+KWC0b4wD0StZL62XEBl2NTeX
         jOB1kj6Was6xhvCocEUR3j1IOxvLrQqEBRweUt5h8SRKzKu7cyJAJSXcmzaKolj0u9rm
         5C3rG47FFViXAoN0wPcgpwKclKC+P64BArs43xsL/J7rnR7JPFaAOR9bPYsMgYKhFMVY
         I3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651570; x=1764256370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc/agqhZHpBZo5pQd3t3SIT1Qnduk/rx/3xksUJM3vo=;
        b=JuPezHwO/W+YOtxtoXiXWohfRR7kZJCYKxtLJX1CPE8dFOAxk9BQp4FKYuklneHsWq
         dQNhH5you+LBgDUk9alKaxZp84nsrOjVHXTgT7ILRZnOLw+MxTpfjsDRtvObqVdwNwFm
         dV2nIdAM2EIXQInbVXC5Ig+6EIoiNxkyuFoENS+QQfJcGfYVZrgjKnvJEwuT0fILJOrJ
         o9R7WkVdBEgoffoJY2M+NM9jGruNyhb30rwJRNKezYMg4dldf7rDs5SklM70sl68T4cc
         a+/voJmQ14Noyv7RRJK/N65VzgZ0nQ6b+5qqg80AEncbGtv7+2xdMgxLOtvFPrH8Sffe
         1y1w==
X-Forwarded-Encrypted: i=1; AJvYcCWEB2+4vCXZzMZ7W2ahujMafUXnq+t5n0TUA+8X2134nQxGw+HRqlNQkxLlSdRP95O+myg0XvIzq2cxJFLWX/VN8SNBcg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwe8r9NDOBZVfWQ/f0a/h05Uak+e5+nQJO4xvYHb8YFUfUTf1
	DxGH95/VOUuJ1FXjOAMkk8pHpPF5aRiPXBjJc8hjViJsLT8x1PA4aSxOkcWkw9XNmfYHOz4fGrb
	IIQ==
X-Google-Smtp-Source: AGHT+IEEaNMCstTJqOLR6fdO3p0rd5Vx9GNO1jJ07YubqwQoWR7BvLPGZfMoQILzZHDOemuyFlxyBYdKgQ==
X-Received: from wmd10.prod.google.com ([2002:a05:600c:604a:b0:477:9c68:bd6])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3590:b0:46e:761b:e7ff
 with SMTP id 5b1f17b1804b1-477b8c92773mr32595725e9.28.1763651569512; Thu, 20
 Nov 2025 07:12:49 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:41 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-17-elver@google.com>
Subject: [PATCH v4 16/35] kref: Add context-analysis annotations
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mark functions that conditionally acquire the passed lock.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index 88e82ab1367c..9bc6abe57572 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 static inline int kref_put_mutex(struct kref *kref,
 				 void (*release)(struct kref *kref),
 				 struct mutex *mutex)
+	__cond_acquires(true, mutex)
 {
 	if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
 		release(kref);
@@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	if (refcount_dec_and_lock(&kref->refcount, lock)) {
 		release(kref);
-- 
2.52.0.rc1.455.g30608eb744-goog

