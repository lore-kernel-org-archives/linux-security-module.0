Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068443812DD
	for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2026 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329028; cv=none; b=K3WjoDvtNv0dLi9MvoRb+8yHia+TND4oW0IdZcJEVoGSnDOCl1/Sws8VSa6UXG0TgqkeEAJAF4xKiuOESEFBaVwsYogWIuQ9FTN99S7T+tzAKRjI3jqDbrWdAtzs4A5qVvRZDendksS94y1zCM+Th4bEToGV236npgJfpxX4p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329028; c=relaxed/simple;
	bh=5EHl2dbMLZ3AccGJ8Fu0EBLUJpuZtxxjd0tZw966sh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSZrASBl/YdTgwfdfe7Ej0mCY6Ong6lECqFyNL6qUonvql358w5L7gbPEOL+6Ggyn/vss2oS7rR7Zsyrlde4RCAK3onybZzuk/MJ4f9alnctIB4uvGF2sfniF8oatS7FSpAX0bgg2ojtbxo4tjQcTiiboh+mhZPBXXXaqJT7tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7nZvlyx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7nZvlyx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49553515a8bso11660315e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2026 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785329018; x=1785933818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4/EsKrPykPMUjkQSazyjrWyo/mw3UZZuj2/aHPNW7Q=;
        b=o7nZvlyx+InGhsM/x/KoPpd5C/Fflnaqz+xEwzPWzpn+X0dp4Ns3u7cGJBwfVnlbBc
         5OpP2kYwugehz6/5jDfBYByVp+8P3z3a4TpwxzuJlplQAKyOi5JgEW+JX79wkwlc+npM
         dxTmSGjoLsykbD3enu446x/emTFdJ1TDR7umZ1bg9F2GViHg+MxtIS/hZ6Nq+k425Ti+
         AiXQczyQNUxnKHnxr4XfNnwSImx2W8eThp5T8Ila0sW1DIwjCs/41U0Tw3K1eRyzzt/u
         xTJbsaXiY0p50mhXLn5LrQ53NWPffL1jXfTnW5GA2uk8W8tIs4S33deNx9A2QH/YHXe1
         W1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329018; x=1785933818;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4/EsKrPykPMUjkQSazyjrWyo/mw3UZZuj2/aHPNW7Q=;
        b=gT8g4N/KHvwBq74BKOAvFqOwKh0N4gwKJpRKDg1ZD2xP1+rZF9HZGbLh1KusM44/DH
         jIpZl90T/uIjO2aApjGg97LxMO3OqjvmB/Ug/4umkrIlBL535C2aZaR270l5XmxioWdD
         XO2vo2cjqO0Hz693EAPaVUBK6UIRycf3LVANswU+o7+EWftuTYXM6g6uV9BJyTxnJz1a
         VPPtGxTaZ/FXtB+/qanAC1GhvXjqZIjGt7PkBp/fNOPmQ5ygeBM+mx9fBkzigopTUaJw
         yvEAvlIC+W3zF1vyloyivQMKn1xJLOCa87BGeiZX5VWqRgJTn8dwt2i3N5OvgGNeBbqK
         mIPg==
X-Forwarded-Encrypted: i=1; AHgh+RpzYpZPurx8kc1j6zkH9uVBKT4179BsZSqngTMlRlU/vUhr+5hJpM9RBsqCQANDG3ZotAIPChk49kUhD6RmZ4I2RLFP31k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/f5D3Ctzk1uf7WYLvYKImAi2Pj54PPDiWGJ6QVcM52Ts8mhx
	aVweWkwDAH8LRIZPPK0/kV3zwlGWbtI5ftRX4YZo2/8FMOETmlG9Vrm5
X-Gm-Gg: AR+sD130Ic42TqCXzds3t+lpSm+PZW8OTDehxtAM6LLagN3OB7cdM8nkyrDJO9RW+os
	iPxBZR63KDSlORBniEYpGFhXMiNki8vtBa8000cZPQQvZRu2I8DQ1bNOTCmY1HcBk+rG7Q8z79/
	+mwItSGBuk3ud1QYMyP60YDHzivOXg/SpRmE2sh1eXFY9ZDQ4G2yxzgjg6rWleoDG1DHbO2QXGj
	ESWdA4MUZbHENEqkC8OXBzafe2xwhqnyTnJhSH7uo2D9X4tB/rb7YM5VAVWssnhS5N3SA0WzyT1
	WKCt/6yHTQkN24mxxIljDJdjCGcoqvYMwFHDzWyk00QMpU7E/s1R6vYbQQH5tJ7hCtAyccSN+U0
	rRePw0sEgdZFQR+G6Uk1VTXEe+YYf8jn4iZbTL/czFgf18qmTX4WMsvkd9NE59e+0/STUTuuIgX
	XO3SCDKyU679oDkg6/+4X4XEkXx4fxGKEt4sVGkfRWtRVPFvlHJKU0OSc4YoGicsbAjPjWuFQq3
	/LobR0QqcQoLE1scmIoyg==
X-Received: by 2002:a05:600c:46cc:b0:492:68bc:3237 with SMTP id 5b1f17b1804b1-496c6586337mr72739245e9.32.1785329017863;
        Wed, 29 Jul 2026 05:43:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:647b:ba01:60ae:5bf3:4eae:ab18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c46160dfsm137177215e9.10.2026.07.29.05.43.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 05:43:36 -0700 (PDT)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net
Cc: brauner@kernel.org,
	gnoack@google.com,
	kernel-team@cloudflare.com,
	landlock@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	oxana@cloudflare.com,
	paul@paul-moore.com,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	wangyan01@kylinos.cn,
	webprosto@gmail.com
Subject: Re: [PATCH 0/6] landlock: Add POSIX message queue scoping
Date: Wed, 29 Jul 2026 13:43:35 +0100
Message-Id: <20260729124335.3160-1-webprosto@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260728.Heephie1tai3@digikod.net>
References: <20260728.Heephie1tai3@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 12:03 PM Mickaël Salaün <mic@digikod.net> wrote:
>
> Hi Oxana,
>
> Thanks for this patch series.  Overall it looks good but you'll find
> some feedback to improve and send a v2, following Günther's and Justin's
> ones.
>

Thank you all for the reviews!

Just a quick heads-up: I'll be on vacation for the next few weeks, but I'll continue working on this once I'm back. Also, any further communication will come from my personal email, as I've left my current job.
