Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8035FF76
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651588; cv=none; b=nieL4xvZawTJVrrP08r0rMfEfWxpFlYm/3l63bfzfRMUnUDffI6yTOxZLtlbsh0DziNDKaBpQOnF2eI9XmOYbKTJVOx1nbu3vLQ3/LuSEaCQidu9KLGjw48oIKnZq/YjWbTyuzU4PjfgjwE6cBAuurIxPF/cUjk/G8ZFPlDq1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651588; c=relaxed/simple;
	bh=07zfwwibr87pzthwGbH+0Y0kGO/abbdb5ZEhTTNkhyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LPv+Cjcr7cc+N4+0DH5BB0/Eedi2HvIO2EYTQFvVgqKtHbZjzTMxlSsnKzbfDlh8o53cHpQiWEiOjXI9GaaxSfE4W08W6jo08pG8+A2RcgEtTm5k5PRXCtlgKKGNPDSfW6vyHFSt3DSIjjpjYbUkh1H6205Jr7gkc81a+Da1bDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltyF7FvA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltyF7FvA"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so8950675e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651580; x=1764256380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTo30xRtk3dNAYk+WcMlGzrXIDi8Fd3AcvMY0oMy4/o=;
        b=ltyF7FvAG6OgN0LcS78W84ax541CxFrE8utJs/0/ke8m5aqrP3352ZUx86FV0kzR7V
         fw1zF84Bl+Svig7h1nusl1SdfpLU8dcT+sRfvUGgdusSVeBhup9jElD6ai63ieXyS/n6
         OLNtDua3PdYcVbaGxA3XV/RfRMPjGWoeGj8Pyh5p3WcHL7kU0g2WigB1evg/biaKQURV
         58WrJ+g7zffVX05xtUxITBZgThTY3tQeyFl3E+XlBQMfjPCOUw5SbPfxuduIMD2JITqn
         5g3M5vRFEXx5FZABV6HGefW8grmNTWyoV11BAaOHracqUN4DkX2/tEwrEzMlAJocRn8b
         JyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651580; x=1764256380;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LTo30xRtk3dNAYk+WcMlGzrXIDi8Fd3AcvMY0oMy4/o=;
        b=pEg44aH0x78nwnpvlZPLcDsO0Z2FWCQFyGlx8p0LyzD73J0+c2zz40PluyORuLsZhh
         qAsc0YBvBAROT/307oG0tjqjjzxOshz26iSmO53srmWS3aC0NUxVbU41okPEh9PA7iam
         tt9jaQgVTT+eXMjECuE9Mg+ObflhBJpRG+1DV8ReoQcjm3XhWAztBgrrrwd/RdssZiHn
         a1Lx/FnkWUaNgQgJrCH4e7sF2r37V6IJzjqEW75UTEJonkgIckSex7nj7E+VjywdXX/S
         pICybub2ZCrm91rRVZ0Ov5PqvnwJo7SseGmT8i0lzMTLnsp44ftyk5c6eyihIl8nogiO
         e26Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBBnyX+KgfK3a5X7AQ/oix8iGIIYXCEOVvtz1eCALopkjni/YpUHfJbvxkHtkvAMZ/OKE6V4nvzoVe9q3wcG2vAxXWSWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZyUFGNHI3+QVYEAWTNs0Ek/sQwg+ucSfoMMNmKeBnVaI5M2c
	wznFxi/9WlIGF3ag1Dkzl6YCRbJs3A9qOAyGe0PoMJtgcj6jfztDoggjURoZhxswwaTHxJVeL83
	r9Q==
X-Google-Smtp-Source: AGHT+IFrGgNPktKG3H23bhC9w6XQyJEAaYXs0SazZ2yQkYIVJL1b09kjJ5fLN+jez2xgS5LZ8SbpXS+XSg==
X-Received: from wmqo14.prod.google.com ([2002:a05:600c:4fce:b0:46e:1e57:dbd6])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ec6:b0:46e:32dd:1b1a
 with SMTP id 5b1f17b1804b1-477babc1fcfmr26767175e9.7.1763651580311; Thu, 20
 Nov 2025 07:13:00 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:43 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-19-elver@google.com>
Subject: [PATCH v4 18/35] locking/local_lock: Include missing headers
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
Content-Transfer-Encoding: quoted-printable

Including <linux/local_lock.h> into an empty TU will result in the
compiler complaining:

./include/linux/local_lock.h: In function =E2=80=98class_local_lock_irqsave=
_constructor=E2=80=99:
./include/linux/local_lock_internal.h:95:17: error: implicit declaration of=
 function =E2=80=98local_irq_save=E2=80=99; <...>
   95 |                 local_irq_save(flags);                          \
      |                 ^~~~~~~~~~~~~~

As well as (some architectures only, such as 'sh'):

./include/linux/local_lock_internal.h: In function =E2=80=98local_lock_acqu=
ire=E2=80=99:
./include/linux/local_lock_internal.h:33:20: error: =E2=80=98current=E2=80=
=99 undeclared (first use in this function)
   33 |         l->owner =3D current;

Include missing headers to allow including local_lock.h where the
required headers are not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/local_lock_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index a4dc479157b5..9f6cb32f04b0 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -4,7 +4,9 @@
 #endif
=20
 #include <linux/percpu-defs.h>
+#include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <asm/current.h>
=20
 #ifndef CONFIG_PREEMPT_RT
=20
--=20
2.52.0.rc1.455.g30608eb744-goog

