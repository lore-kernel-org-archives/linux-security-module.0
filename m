Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DC3491F5
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159192; cv=none; b=FjufyXjVx9jAtPN0zlGlVZBDAnLqJf9o4a08JOW/oplZyJf8Yd252I9l/jFGgdWX/CTEQEPiHFRMm+ytc8uHb2yovNlZ/a0Urgig3xQJxbPv9uIhnwQgPnrOmEwjARNYCipjz1lL6wn7SgpFpYLtVInK2da2eFjrrQL+s/TtZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159192; c=relaxed/simple;
	bh=+TxyiziKtAssraZX/W9BG58Rc5SRTSVNFHhEJgAI80M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yc0rK0deRYlRZjfl77B3nN9/6OBm8pFg0C7Zp/w+/V55Nn5A7QAobRgegPG3mDNh4EZcqWYsQ1A4J3au7RyUKVkP/CB38I9iK/ENJsLQAu40HLF81IdiOm4a9So/t8V/rCQx5vKTRsFo+IEjswARSN8sqCdpKNOVwBGrzZq9yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Btmm9Ian; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Btmm9Ian"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4776079ada3so15496745e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159189; x=1766763989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNejWFdtMyTjodgPbCP3MYwy/kg9I0zeQniFTuJdWnY=;
        b=Btmm9Ian9vkW2R1CmBw+4UEGFIcU19VTH1if1ZDzBv6i7+qkwK8FB/mchliyLeX7ea
         Lv3TTAaSEl6CyhgCR+GVo+O385fSiZ8SbrQyzBZqEUR/rpjDaMx/DKaQMGqWRGMwYmbI
         su6Lg1c7UP1tDmGTlM0gi4ZPnBCuLD2W78C8eggo3adVNqKxuLE9wxwaDVyiBk4InD+D
         PrPKasVfuRx8a41HcrByYZw3oCLNoOkUIIxynFHot93y8oFhIBAnXnNbxjmB4ldktlKr
         eQz8DC14OOMXKZswgtZN8/umOcDiIYb/xDa6S8yC6KraIgzXaB9Dq52KnlM6o/q4Igwo
         TKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159189; x=1766763989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNejWFdtMyTjodgPbCP3MYwy/kg9I0zeQniFTuJdWnY=;
        b=xTMfr/nFIuf6PQ4mqxLnblbvUh/4oHjRsDI52iKzOit1IiNg4rR0icdiBgwCyp1GQi
         r+T/PLGJU9tNpl1gQxd8dY25sMvpgu23m3lgjgwvu4EQRMkkm95mvdmyVohjdpXbtUln
         nZ/iNo5dbPmXinbWgqYxwdz9Px+gcPJw0kr1SNfR4BMyKaOM0IQeSr3JTcHqPtYa3spB
         iyysQOVSSCAAhuzY0imQpUxDKKyok6uE+RUM5yY3Ft3gbCC5uLkdhz3WrEtRmXJshol/
         a707V/DR5Y+8lKn6FhgW8AMUrM1rakX7mNtqzW//du26E3G+lQnDPinPGDx/U5KtxmOP
         SL2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNaIysn+FA/vfDC+BzJf8K1kn1R3BAoCsEm1q70m5iPw01RWmGnjeoht52mArklSPURhrGOZ/o207PAFAVvkcVyLk/v0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwzZ0dirlkKUZBdBFRd+w0H5Et2CigY4cWX7svsrs+c/g/G+B
	vVntJmOX1xoXf9VI+TmIyaJIxulua7EAgdGjLR9POiVKI40VMeNfPu8tNUg0L9N5WsqheCz7wyj
	vBQ==
X-Google-Smtp-Source: AGHT+IFZPg350on31b7Arj7YO65031V0YGnmFoBhddxYq3gtipYJLlSpx9LZ4+YgVEePmezOZITENNcOhw==
X-Received: from wmbdr22.prod.google.com ([2002:a05:600c:6096:b0:477:7949:c534])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:820d:b0:479:3a87:208f
 with SMTP id 5b1f17b1804b1-47d195aa085mr30273655e9.36.1766159188650; Fri, 19
 Dec 2025 07:46:28 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:05 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-17-elver@google.com>
Subject: [PATCH v5 16/36] kref: Add context-analysis annotations
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
2.52.0.322.g1dd061c0dc-goog

