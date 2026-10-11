Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D063624C8
	for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2026 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687479; cv=none; b=Z338QWp9ixo/e+uuoNZya6hlPD0EF0dE5tX4zBBGGnjkWVgvuNoCTdJ66VqGSp56Yfz4fz1nPhm4iSHAXIPgFKCMacHib57b+C1fAnzKgzJOAwP06pBb+yh4uj01XGAoCxrfXnagKrm3xLUelsyVAZKeP95jftpSlR2MpMwoFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687479; c=relaxed/simple;
	bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu5wIJyq3QQqcuC0rGzYofOUulSYB1Grq5/KZhlwsuBUgkXa3c2fzykQIMzFPt5ee1PG4mEycw++WvTDDvRHoLvJApHW/ocYiufewTraKvvBmbvM+hL8nEEnyAUNifRuRH94t6qz3ZRNntZucXES08/5L1/MXOoUn6qJfFemw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSPY+QRy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSPY+QRy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8455755f3so4290975ad.0
        for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791687474; x=1792292274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
        b=sSPY+QRyw9X5FH5owUepnjoeDJ6iXs7R+esYpOFqh6F1/Pg/1vUYI1qd016sQPIE34
         hyRGpsikP+okyiinphx3LoXI81xyy/HyjooNgrejdF5vT2LdrZyB+kuIXNtRJPrTEHJd
         cW21tHox37a1IZDfeKDuIvizOcvq1vWF2VXEnstFQc1ZUfx+NhGQLNL+EzhEkWH/3+gy
         uX3iVRgbrvWgudfgDkM9PpARwY+xX05W42fJApNAJ0Jlf6vLJopeX+5DmmpRNsgF7klz
         fScTjsibmPbsZ8zqcQUv9SN2lOWJvrBwnqvpb2ucBLwBp21+1OnisWObLhnY3GGqMSEV
         fDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791687474; x=1792292274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sghXvtTDPEzJRg8/9muWYo5VMD1FxRyf/W4rKI9KsFU=;
        b=Xk+SpdyNAbfQf3owfpdU8v3MvzFgcQV2wq/qi0mdcywBpZRQxfdYgbbly4Kdq20dsi
         7e8etFxrOnjpojLVIyyFtMvOZReGnK9PthIkVYBU1cb1GImq4zVTkvJtkdIaP3x+B70a
         Em/9E/qTh2CmIJ9xLooaG8sbZz1LSOyFg//tNGV7yCh3gwcmESiINwbkct3DpvgZOltc
         WT69Ow3tJv1HkL+VxPO2Ifpj7+/sW3aHOUZI9h6AKxqjtLN7si1zAyITruuzdQEdwM1f
         fsDhkf7u1GUFKLvLVbF+4eDpyYlxsj8FE+/lBufV5QYgWD9hWcaKshf/WsOdlJcbodJy
         vNwA==
X-Forwarded-Encrypted: i=1; AKwUvBwk7dcdas8u0GwlXM5cNSf8PLP9MyojlmIjsaCAOha+afuoLxfeLq940BgELmMb1ZQxxrRlgixQ6HN6srjQEWyjtr/64/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX9XeQDnDjG0OjpYcdzdz4D75WlJKIJ02wOcjvrmW2EIxMB5ct
	Y+SY/W485Vl9URlXjTssRBWLq1jl9NvGtVwZlFe8f5R1mlM4d8tHxvyJ
X-Gm-Gg: AYBFou2DIVq3yautVKES2Sbk5ZWXrrUCgHVaASUVZJrDZWQXcE1767onnbw+nuky7ki
	M/Z5aWWJbfK1AOqkPazy2GBsOaAuxUTQkLVVjvExYbN738/kscRaa4mGGxS+gQlfOz1LDO/a9mG
	L3RJTAKwoV8yb9ZlEQikkck34lmpRXx+Wtkg+rPubMHAJjnDFNw0eZ5x/ZIaMU0XU807Dk0EaVQ
	kBzyWTz5m29bQF8gZtXeYVbrsTx8xYlDWLCA98gnDNA0Z+F6I4GJdGG2EelI6N2GzfaAu+LNZaS
	YeNKe6JB78CoFNVQnynwEXLG+m8a7/R2ZNieQRLJYKKfaShkzFV8qebz180Qse9FJnR8d0u/VHP
	nW0TrUWVCB80aauIcJR+14SM1VwXLBbSTdDMSB+NXxfKbcx//HMPHPVK+4GMndvDUSgWffrssSp
	JffAXyNg6J+bDOVz80CAG3eKbl0AYfnHwO2+sgaoG561VB/hh+uEjcRkxPR3qBiINEX28wFrbMd
	GzXdPxQVf4S
X-Received: by 2002:a17:90b:4fcd:b0:3a8:6b84:234e with SMTP id 98e67ed59e1d1-3ab3a7467a1mr4832096a91.28.1791687474219;
        Sat, 10 Oct 2026 19:57:54 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16c8::245:79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39392e9bsm6403592a91.2.2026.10.10.19.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 19:57:53 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sun, 11 Oct 2026 09:57:48 +0700
Message-ID: <20261011025748.8853-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010184640.GA40038@ax162>
References: <20261010184640.GA40038@ax162>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan, Alex,

Thanks for the pointers. I wasn't aware of the earlier thread, so please
disregard my patch in favor of the one from Qualcomm and the Clang
version gating of __counted_by.

To answer Alex's question: I only tested with Clang 22.1.8 (Debian
22.1.8-1~deb13u4, same as the syzbot build). I did not try Clang 23 or
later, so I can't say whether it is fixed there.

Thanks,
Nguyen
