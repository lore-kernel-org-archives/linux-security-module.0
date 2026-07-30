Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DE37187F
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446169; cv=none; b=WCagmhCZOzqj0kW3Wr1Cp2VRhq2vuYZAwHoLbFkhSG6bW4GGmke3VoShYylFYjhVKUaGJdCYIWmNh7MNeORuZCIQATdnFdGeG7r5hy4UaV7ydR2wQpiHXG892YQRt5qHQG+Pzr+M2dRtHFHDVik/sRG2PAfkHNHBCf8vM1Gr33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446169; c=relaxed/simple;
	bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2VDNzJiOLihg0/7gIyDoccy4fs6h5BvZ9PaEhR8cEndSVii73WwFVZ83WWrqXg9dLpSgTvTyyYqtzKXaOuQsI7+mehI9412JwZiPkMQV5jS+qhBGkhg2mxrfrCNLKcdUSqC6Z5L7C2J84/oPh4MwtvyCoAicmkkEQkFxoRTop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdANWppI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdANWppI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so238096a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785446156; x=1786050956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=gdANWppIZaHHVrO4NaZ0vAnYOeETJRqHszRJALyTxCLTqgXFXrtYSNK//frvSJEA1M
         3XJJ9haOTo6G6TFEVFdIkZaz52Q8g5dIQV2bVosoXWU/WWUFW/93r52sljYl22mpBKl/
         2MLJqA4PXP/ZhvSSifBMiJxZWjtupSytErT1RK1s73DP0GXqpIkcM5CzcKqA+eoYZkU1
         8HpTUNx7+9bcYo5oBcQR8sogLak4n13pvrOpuY+MEVc05W3e9bhnbfFlWDdj5mvoouCI
         HnAYRTRyxcZIqKGWZbU3wEQlEpc7dIhx8SWOIQw7iUrd9xDOnXw6dWZtVg/1OHfI5+BD
         2i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446156; x=1786050956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=K9UN5731SdoWIu1+AeNwxqvuVDcrlHKLqcjL2qISdybaGgocJwqa0cY3IMxHL0J3dO
         8FGqilv5yYlfme765U1D5amniPhzeYuRjWqBGbUlWJ0RmetqZHfLnOeuBeSy/pXGDKC6
         /WAjE7OrmgzNfVr39d96wIt2MHZ1/7ze79ULJtXVYuGZjQB50FFY0rFzJ8ffM1W5C4Cl
         uU5K44qPaASoa/VqP90qijZWXhksCG99bs3XQw8I8RpemKkJff4IOs6fwltyv46ywleK
         /48own/GPtSw9Ue6mLWZ5c9fQFjIssY3JVeLMNgZcC5uC3zqVQUYuveQWNLnsede2joW
         /RNw==
X-Forwarded-Encrypted: i=1; AHgh+RrX4BTlpkhVmEmTuAzr6mgm8MmEtOh6n2+Ae9iuGND+/R3kY+oj29o0TFqsvxCdKivKenXQw4HS3tnUzuCVmTzdgG3RJ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAuvDsvzDtwgiVN2iZ18effcNFGHSGUEzlmAgbsZxBEXTw750
	+E1T9ortvMiIEA8MZ8z3nOpzSGVO/nZL0coLBmG2GNxOY+HHollvk6Y=
X-Gm-Gg: AR+sD12TrwF4rZhjsQAJPjgFdJH+0RwfA/9iHS/HfM5maYAZGpKlZom5XMexbhAt7M/
	7Z3aqXrotqeI+Xw+TBz4jJKQbb6ZMUl/1or2RqM5v5kvkYJ+J8wjwe6x99sjEd2yx6eHvjxAhpO
	guZNLT2skd99BFkq372SFmixLH9YMIqQldUim0VWS+RSY7IsnAB4krv1YexTA8y5UL7ZNsCY2R+
	7B+rfi54QpCbTSTb31v5/26/WJHkmM0qj3XWHce8VuRNWQLH98cGDA/GedE258eV5jcNDTYFJuQ
	6x463EpQBz+tNatoakjhFEWRLtUS2b5C46rjb9BpVr/0+v/z0Tapy1qmfwrTcOV90HssgAm9YXG
	0G/8yXYGorTfH5wGr1lFPc4ePhj2xlOuyL1UbKX1hu2g1cO98kWsk7s4KasrLD/L7zCAZMvCWGq
	SN4ERC84OdcjG9U+qY1Vka/DHaa2CW9OKAO85CT+6Q0rzedtRX7UvLLPvwaIv2Tk8zlwCpQOsNm
	M6BLaWW3tzNzOlMCO4CgY3gtwO+WFRvGziT6A==
X-Received: by 2002:a17:90b:380b:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f9c0abaecmr3050277a91.40.1785446155807;
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.221.78.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7263cfd9sm36251186c88.4.2026.07.30.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mingo@redhat.com,
	paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	tglx@kernel.org,
	westeri@kernel.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Thu, 30 Jul 2026 17:15:42 -0400
Message-ID: <20260730211542.1422-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113209.GF20844@black.igk.intel.com>
References: <20260730113209.GF20844@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Agree. It should be preparatory patch for the series.

I think ur ideas should be implimeneted AFTER the patch, because this
patch adds a kind-of important feature to T2 macs, and well ur ideas
are for code quality, and well it takes time for patches to upstream
