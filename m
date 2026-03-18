Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77138550C;
	Wed, 18 Mar 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823093; cv=none; b=f2qZCuWxkb30E3UI12/DywN4dqVCDCUFwFX1176KR2WCyA57EbhI9zMr0tfp4ChCPZNSN6ktMFpJtk/iqL1pFTzRBVCbxDz9/yMDSzJCPS9swA0OYZCQXoKcaacstYGtkrX16JQVQqv41J2KiFdjOuYiRO2noxrSiN9WHwi7Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823093; c=relaxed/simple;
	bh=Aqtuhjra1x3kacnxTbiZAwwnW20uLBWHod0eDkbpWgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fyo1MnuF98/rDIl+/PJ9+W6GejKdis+HvzLabu1HqKyNkL9hMLz3n7mWrNKD2dzjGDce/vcmOqrt5VAYTlxxlmPN0UKBQxIU8qCY/1h9Y3921QfsBzZuDTT2LKB7NYnuioMqEHAXPCDFzzvniNHgbBwMdnM0dEYUQUV84IZzmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XIi7r0b9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XIi7r0b9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wi
	dIBh4Hvd0FGVNt1fc8+/nbZDLFlukctPlpnnjW1wc=; b=XIi7r0b9iylHFjXBfd
	pR6zwyABqT9AxjfOiS/LF/WyE4kNz6q5qzsz72VIdlrv8jECBO09+Wt4trPkkJ+4
	G7WuSwRXCu/JVm51k8Tc3pXOLwn76YsfXe4DYNXXUclw3YqeWPwvZezN6IfHpgZW
	mztxOv72SXURXfQcA8kOmNwa8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3aBhHZLppy_z2BA--.145S2;
	Wed, 18 Mar 2026 16:37:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: yangfeng59949@163.com
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Wed, 18 Mar 2026 16:37:27 +0800
Message-Id: <20260318083727.177272-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260318061925.134954-1-yangfeng59949@163.com>
References: <20260318061925.134954-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3aBhHZLppy_z2BA--.145S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUUR6FDUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8g01rWm6ZE2dNwAA33

> After hooking the following BPF program:
> SEC("lsm/xfrm_decode_session")
> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> {
>     return 1; // Any non-zero value

There is an error here. Any error value between -4095 and -1 will trigger this bug,
while other values in the range [-4095, 0] will be rejected by the validator.

> }

