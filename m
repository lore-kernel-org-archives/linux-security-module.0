Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61C33D6C6
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174395; cv=none; b=nXpRJMwpVZAA+uMZGYwjHniJVM5zOJvKSZ8sA3SMlrVP/iyq+N9LRcfXemPKVJey/TLQO2jUEI/5D6T/LSPzYiw/wSOSH8vvTHa8CpT1N9Ur5IIMJkbqq6ddFyRu+v3ratw72da1ePz5EQYZmDXDvCqadDyTWTxoBbESbK9025g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174395; c=relaxed/simple;
	bh=jEvdo6gKY+lqSu1jKQnysC3M9EpwI1JXUVi+g/V6/N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYQUBfkrKQg5e2wSy/3+IgLR9p5VG6UyvnpimvXTWcHbWB+S5bigSLfh6QMCkmBMjXa9cbXczZb7aGycSLDVXCIQdfu5C43a7xaZ2WMce5mBH/MV1rUYBe/1fbJr1afhibDk21ep+Iz12Quo6ymeu+IZ3MmzosCDzGtDciNzFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkNxR37v; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkNxR37v"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640f88b8613so5290201d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174391; x=1764779191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWq71R8F89CBnC8WmwA1EzCTc1XCidtoDUDRx3TJSqo=;
        b=LkNxR37vLdhknii/m95/EW9gSuatnuTntyl6jquphPCK6Q6zKEE9nJy9IL808inRiO
         wBghammvZDrEXeoKsEclEHHCuoSqTzrnc3oah9dYQ9WeM+8J7mJJdgBStF+bsdv8DGF1
         3+nSiyR5uxbGgEhoiszLdfO9ZRNih6frg+olG+LMmopmfXNFUZuJRsNSaFLPmi/13sYP
         h8ihDnqUklPEWIdPbkG75QEeU8fKO0A6KaHOGW6xhC411wmgmeljDy9TtIWgXLomVWKO
         SZ07Z3Kd3PbvvoC7FAoORHHmDZytauik1wJV0HLlwE0N2kK5T9v4+LSw41n6jZawbaFq
         PGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174391; x=1764779191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JWq71R8F89CBnC8WmwA1EzCTc1XCidtoDUDRx3TJSqo=;
        b=QoP1jLL8PVbflDIF18/Jpxctxii65v7DoPh3hcZDt3l6YuYcLtUeByCHVB6SB8/+V3
         EsGP2Lt/1AI/tE/L2qWpdR7C/EqpbZpl97Iahtl+/Ebb9vikXSAocMbWkdHrAe2jxzly
         9Wc3wUoVl8elD40gt+pB35TbIjxYoih2AcbexCdGjBpach/+J1MQb7pnKhl/Nu87dwiy
         NkrFhgFR+vybKSat4DRspBdb1jRgotIBStav2l4LSfeTVDXhBhchp/s1IQglvgxqaXVk
         97BxSqo+u1QGQfrk2+NeYisBhEwEFT4f5km8JPve5L1Y3uDWIXs+eHe9yqC6IRr/ByJH
         CCrA==
X-Forwarded-Encrypted: i=1; AJvYcCVbqbeMSHtNhy9PwJCH1DKXC72mngusRV2hf6wNUZu0RDwAxx1d4q6tpx+1HSea6lUsmzIdAAsN9bKyRj/NtrIiAWSBJGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgackADkUUC4fMFEPO1gfKwU/9ntc9myLAAl9Z7Li5CAU1X0Y4
	wI173HgJpnhxCPhjakurmqMNvCZq7wjVxq3JunKOHl8T02tSiCOp+El9
X-Gm-Gg: ASbGncteLoSn6ob9wVvzB5sJ7fxfWuxUUfpxtnL7vwR5xq5kdsSbiSENvltjG1ngALo
	u+LMYsh5MdYtkrIceCqH5Gl8Ec8i8k2gpvXyXXbgaJTMfqPlFKxLfcOdVN7d/2ct+u34MiTfmC7
	cO6dJQHrtX64hcXrdOla8sCZfFDN4lI0rwOUmenBdA2U/xyhENi03AgQOFOr+Abvspsb8PUfEK8
	K1MWZvvgu4k3t12m8jo0Ocx04Uxu0TSitC+/VUJoi0nrK9pHhqdK2bdo5CFJTEFbbJIczoTZqni
	KxqKggm0N3gBTx5e9p49OoHv0+h2177gDSSt6fvHMzPugIqPeUgLnhsJdc5CrvxcN2Jyu7d0m9o
	WTvXDdaKRTNaFGozjycsx5wQE3d9iAceRxwXPmXDfMF6l6yoyqvL5tly74ljNKY9dVBy+aypc5j
	+G1Mwq4/GvoGksnzqSKnhe+uo17JtGYYeKw/NgJSHjIHoanjLql0tNOHhYTrg7
X-Google-Smtp-Source: AGHT+IHqdR1XUOjvu5ZEeUdJuA9AFEqybX3ty6k+1BTNg1oezm3beq/ek5v7gWZjmBLQZxevACo0NA==
X-Received: by 2002:a05:690e:301:b0:63f:a2ff:b1d2 with SMTP id 956f58d0204a3-64302ac1912mr10453618d50.42.1764174390800;
        Wed, 26 Nov 2025 08:26:30 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79925caasm67447217b3.29.2025.11.26.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:26:30 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: utilityemal77@gmail.com
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	xandfury@gmail.com
Subject: Re: [PATCH v3 5/5] landlock: landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed, 26 Nov 2025 11:26:17 -0500
Message-ID: <20251126162617.3848825-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126122039.3832162-7-utilityemal77@gmail.com>
References: <20251126122039.3832162-7-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Apologies. Thi is a duplicate of the above patch
v3 5/5 I sent accidentally.

I forgot to clear the old .patch file from my directory after I changed the
commit message, and didn't catch it when doing git send-email.

The contents are identical, I just changed the commit message from
a typo.

"landlock: landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT"
(typo)
to 
"landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT"
(correct commit message)

Please ignore this duplicate. I promise to be more careful in the
future.

Regards,
Justin Suess
