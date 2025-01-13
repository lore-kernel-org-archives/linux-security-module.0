Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FD20AF7B
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784694; cv=none; b=dUwcGQ0zBpJObWHmFKTU7qsWOe7Eogv2eMn/JHTyT80ebm/eTJ5dGLuC3Mkp58vimnqBuCjiO8JTMHcgIxC+O5qXNw53xwC8F0WzSuS7tACA0uJUjYn8o8z80pXqocpW2olVXv2X0quMpP/y6snFs90iUTf4MbsnqngpQ7BoA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784694; c=relaxed/simple;
	bh=UZgvM03awjIpbC4H/Wvaz6VduSHZQVPdX396iCrQ+Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfFMz6hwehJW7emt2tkuiaurf78RoqVbBgsbyDy67+6cq3FN5Z1te7Ljes6VFsedICOPWmNjZGH1NS6WUXTWZtQhQWzbm6tcy8NFv/a2M1/5D1rel1kCXUClHVh0eZIMp6ymBg1cowTjXhl+XrFdM8MMWWH6KTvU17FF4TTZ8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Tzngh41M; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Tzngh41M"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWy1R0DFqz14fy;
	Mon, 13 Jan 2025 17:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736784682;
	bh=eZeZ251GTZimYXCS1aJ9UsfNnMVgf5Hun1kwh684OzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tzngh41Msv9tKwGuk48vYjlEHtWCLYQVZEwx2O0ImwxbA7cRMoUTcvgZDQXTXhK2W
	 Nm9BIxXZJ2QnDypbdxGXOO2uMZVJpxCJcABRjqOXfFQV5e60O9J3t/CyUUzXXVU4jN
	 o6uA2fdpD6yXTkGdvuN6KTsk0go+wOIvTTOR7PMI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWy1Q3qZqz2Fn;
	Mon, 13 Jan 2025 17:11:22 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shervin Oloumi <enlightened@chromium.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 3/4] locking/mutex: Add mutex_nest_1() scoped guard
Date: Mon, 13 Jan 2025 17:11:11 +0100
Message-ID: <20250113161112.452505-4-mic@digikod.net>
In-Reply-To: <20250113161112.452505-1-mic@digikod.net>
References: <20250113161112.452505-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Several places use a mutex with SINGLE_DEPTH_NESTING, but there is no
proper way to use a scoped guard with that.

Add a mutex_nest_1() scoped guard that call metex_lock() with
SINGLE_DEPTH_NESTING (defined in lockdep.h).

This will initially by used by Landlock in a following commit.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250113161112.452505-4-mic@digikod.net
---
 include/linux/mutex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2bf91b57591b..dfd128a3f365 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -199,6 +199,8 @@ extern void mutex_unlock(struct mutex *lock);
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+DEFINE_GUARD(mutex_nest_1, struct mutex *,
+	     mutex_lock_nested(_T, SINGLE_DEPTH_NESTING), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
-- 
2.47.1

