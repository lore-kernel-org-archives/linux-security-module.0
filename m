Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5189394493
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469626; cv=none; b=RBdQVx2hvO3HV6koPSrPIHMG2/oMemFL0Z5Q0HsmmAfTXYFidPEzgd0nqkFBoacfOvtRarXkT/h3lhes2bwHKARK90BkbGM/wtpDBph8yk1vJMPHLKCDxZuEOHh0Xzl58fwGionts2Q2OHa4tEs5/w9lZgZD03WIt/NsUg45Cu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469626; c=relaxed/simple;
	bh=KsMUuPLgwYCOV9UxYIW28j71QtlkZ2rhkGNJMAEP42s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZvqSHp74XqHc/hw8Nk15nUtif4ywJPwd/odwGPc4CJeb8LNBDL/w1JVncaT2VaB4apOILDfDYNaE98VMKu9UTSrBkbHcllU7NhpP1SKna0/te2TuKZrzzIt1mDnM+iGTqX3OxO93hn856sUERJ7u/P43j3I/TWWJd2+IHbjUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrf42L33; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrf42L33"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so44653095e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469623; x=1792074423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LUqBhSOfJVHWYAUJBV+3KDwxwiS0DArsjvYAlNe814=;
        b=jrf42L33W6TSc+3pBsiR1KgnLdn1Q0Ty+QvUZjRcHLU7mvr/M8E8B1ZVt5/psUzFi8
         vGB4eGAhbsBAx4gI2ldDJi7DEFiDUQAo2vfBSTXJX8myvXbjPJe084onLzKR3Qkth/sx
         tcfpREawMEtyh/DsGFMP+mWvvyDzZ+JFHIKMtxLIJknztqAwUCPvF87LiZMwWjjebHbp
         iCDnGs7Xs0726C+zGHmT7oHPypA2sSykomX6XQMj+kzy/z2aT7qrV2C4ASxD9h2TuzEQ
         fukR4fc5fcZiYvygy/3wYI++zH+HcsFbJEgAH5MiJN4examLzssD90m5DlUcPSc4zekj
         6BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469623; x=1792074423;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LUqBhSOfJVHWYAUJBV+3KDwxwiS0DArsjvYAlNe814=;
        b=s4xCaXGxoz/SBpGK0RnpajIPvpzuDl127+QozJcHbyZ2dq/vsO6MPIMYI791RJ+M1Q
         iABJVQAh6LDq9hPRTSn3fUBJcxTB6+JYaCwZljJsBVigSJt+GWD6H8+i6pz9do0bdqkO
         wdosiVqdVIDwyDKblf+1SdKCMBKjvOLP6CV1wqoKq/wexUqUX7Gwx22wfs4BJ01CjOAj
         wGPIe8OZ8MulA+dni6FvSYJsvwr6bkWrG8iENlNC2PetvEBtl5NXqCDLPpDdfxvwzFO3
         bVsR25TIAaoSfEFQaHGl1DDUHjoRn69QGD9d/ItceYv8NKcnS4rYjZRXo+jZteAWWTuE
         bSVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLJqcAxgmvjih0eem0ib0nJgfFn3uXZQHPVuKZ2HEOB4SvU3zWVGTfMoJDuzT65Qh1xHkTwQF3wKegRc/QfN+oxMOHoPw=@vger.kernel.org
X-Gm-Message-State: AFuF++m6XOTPszTZN7YJ9Qr1KZrvaN3Ca40Sjsy+C0beRR1IMeZpOwcR
	4EYtCS4+GP7AFlg3tFTc9MwqZ3b5rcUJeN37UQPO987u2soNIHtXAF13
X-Gm-Gg: AYBFou3z5w90cVk6CgXGrqvDs8gvyq7zmSno3eUTnf/aPM33ScMkXSTPBLMqALAvfOO
	iZ/XFp9ObgcVZqLb19tDxaTxJOh/Uo4DEFP3pzZjsnS6KNzWbePoeurt7ELlr4Lt5gd+ahNHdK4
	xrMV4Dk90BntAvgq8+CYeY9RZ7lzSYEn3ctzRXVxVmVPGQUzv6LfAeg3kNOPsvmnqXUeQQQ9NIn
	xQJNM3FyGhxy/oXHh0ja2gNL31MCo8kHTH0xmf0ltB5d11dErKu/jyTdIsU4Ltj6jy7semk0E34
	gUD1SiR+Wx4xn1xIH2nZR6oFVZFIdIcUw+0XT9PCw1+AnS+dWPU93BMBic5aKgt5BZR5WPnDlBL
	iH+e/6C+bsZpGcUHQNXX8WmiHTKSI3+t8rvqxRhjRCgGNK8d12kSHZqqOWMLPEiGDvgDAQelXYm
	mCCbBRTASYSmb236db64WfQo+tglU6jQKGbdowujwBlayvAZWi6lq9HczIBYB1LmaaFhSd3rykD
	omI4Xsk+YT3d9LBEwd8pgESyHvtaC9/6Q==
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr104513565e9.29.1791469623095;
        Thu, 08 Oct 2026 07:27:03 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18360c5ebsm57526765e9.3.2026.10.08.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:02 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/27] selftests/landlock: Handle a missing control message in recv_fd()
Date: Thu,  8 Oct 2026 16:25:37 +0200
Message-ID: <20261008142604.39107-10-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CMSG_FIRSTHDR() returns NULL when recvmsg(2) did not receive any
ancillary data, e.g. when the peer closed the socket without sending an
FD.  recv_fd() dereferences the result unconditionally and crashes
instead of returning an error.

Return -EIO in that case.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index c5124de68a51..e195c0f48eb3 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -158,7 +158,7 @@ static int __maybe_unused recv_fd(int usock)
 		return -errno;
 
 	cmsg = CMSG_FIRSTHDR(&msg);
-	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
+	if (!cmsg || cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
 		return -EIO;
 
 	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
-- 
2.56.0

