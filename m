Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2202547043
	for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734387; cv=none; b=h9c99waho+kVG7C/0iEGBlxEzXHksbR/u2H2Utw9x70vaSeb1q1C2TLXNDPR3PQltW3oPhGzLQuzhQ6B0DZ0Wt1KEI+9ERSXKQcFMxIfFyFJSIYTB8fzK03X3dq0F0hYWroTItPYvBxXpqGdNn1SZkKfeztpLkmPcWc5vc6KIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734387; c=relaxed/simple;
	bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnzNs0bfK6KTgXgc932FlEHJq1KqbeFssAozF9IFBjFTRYw2mYS3WZAj4cXlGiJ6VUgjBD/DaKQy3629jxMA8fg++DRCyCOFoUs5r72VRzF9CQsL3YW4dc7imD42jhMCBiBG1XxKU+GFJb3tDK9va2oCss8WhbykkNl0djCrF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQW6UiPV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQW6UiPV"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53397325663so13556031cf.1
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791734384; x=1792339184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
        b=QQW6UiPViQNiaVVI9bcr9Px9P08cEiKfxJSWdVrBMFS3VX4u9KW2iGIFzt4MDJKz4i
         t6aecBD++TMJW6V6X3G4n2yJD8eSGXDoq4cTkBPLlMwvlupO2dG0pyhvq944kPIu6M/E
         WnRB3VQu6UURGkTvGQF2NM1q1fjiQXulSMf+0AQxEYfOwuSdILooD2RQ2zfaoUWrrL38
         WUj6VE5FKmBZ9ZcbfoLNpYGPCO8AmrgxZ7ZplJmwuMb7BqHWItd5/uTK3ZZETJS19MyE
         +zYuJwj/Kngsnj4Wl54NMUd5budJ/m4jji1H1k20FPEREA2uFHQtO6KIyL7LR77qyTqH
         qIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734384; x=1792339184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tc916MmcKzeiSk4IxVqtEZOAPg8oprGZK7KktYFCscg=;
        b=OtNZT8eItoiOzq0S8KBE0s3F6Kj/kIMkl2BTKVplTk7GNXN+G37IU661HgpffgyZsu
         moKCtoMAaWzKkbZjfnDzi1E9WzoxpO2XQV1Ycx94gj/H+CP7Z8M9smcNtLXz4N5dj6BE
         5CkJHCsRj2Xng8PSQReXm1lmvNNqzfJxyVsJQP6QLu/fUInmDxKo3WhOsWl7bhZL4QVc
         p23p9WwVrbpVVe/53DLfmnwfGkUw3B9bEvM85tgel0kpQ7nx0rAPaCoH0sLrQztbPrit
         PNY/evXDPA1eXbZkBY8wnHLNtdEje63SLNLse4pD/KDtcuP8WuCMFlsh2HnoAk8RUgqW
         ldCg==
X-Forwarded-Encrypted: i=1; AKwUvBx1sYD/+v+qOT3XAtqaNTXSrz+x6f3BOBR0LfbZy8cFaN9OkooJZKj6ehLmp6O1LCqBlONEDuhSjEKTKVPCT1jHecr+X24=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvTXqcyrDOOs9qdgMsrhjzKUa14PwdPbpUAzkdJOnc1xEri22G
	T7uJz9xGlBP+fQJuBZDFWlWJWQgw4qp/OxM3fbl+WaDJxEXOtSQMMACd
X-Gm-Gg: AYBFou3Jr41lUfOkGK0cQOZECLWehuEfrwrLUTHAVnoZXV1CWvdbMxpO2iiFYhWcITV
	gx5/uuMI1MkRTB1sLaXSuYbyGVxuoSjmpj4r4ms1MrckEBXZ68vaYlUANqUGVjz9oHDTbJS7W+H
	HrQf/YNQ01SRJTPzVRoMg5QZ8XPxx9leH0CeAf34IUHqhWjoQmR+Twid4V60A4zMJRm8zt+Y9yj
	iUaphn1WnsfA5+EsTGFc/8L8mhTCAiS6QM2Uh2YPCr0qZUSvXzvAeSdfT3FxdDmOH0zl2mtdZXt
	82ng46HCbmMQ86vYgzwmG6GHmgbBzUjmiAf7irpOsyDNpm6qKggkUGMZyDlPfsaHNzElCfLHTlf
	J5lOSka0DVE4xpB4ENAYJ6GKXDyqChGa8+ptBiLG26AL/Jgb8NafG86/Lw7tinKR1Uv+thdbTQT
	m8dl08QMpbfHP4AI66u8CyXLi865HKD4ZA+gac2NxEtlGd3Dq3Bci90OITsaZTIVzY59PXXCk9
X-Received: by 2002:a05:622a:54c:b0:533:42e0:a1e3 with SMTP id d75a77b69052e-5359fb6fa39mr134548311cf.34.1791734383760;
        Sun, 11 Oct 2026 08:59:43 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:2646::3d0:17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7dba11sm59816441cf.26.2026.10.11.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:59:42 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: mic@digikod.net
Cc: gnoack3000@gmail.com,
	m@maowtm.org,
	linux-security-module@vger.kernel.org,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sun, 11 Oct 2026 22:59:36 +0700
Message-ID: <20261011155936.8033-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011.oe8teu2LahTh@digikod.net>
References: <20261011.oe8teu2LahTh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Günther,

Sounds good, no problem at all. Thanks for the quick review, and
happy for you to take your version for v7.3-rc7.

Thanks,
Thang
