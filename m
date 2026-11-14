Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=U/HZsh84bCDiAvnf0KK9kD2vz4GNyHKhZyuEGJ1G41hK2Zf5/QciyZ2+twucYtMWicR8
	 BgF606gBXaGhgYL7rh5kx8qFtA7eDTvPf0MslgHBXlyFINTRgwG42OrBaLZnnenFnA02Z
	 BuBb5jeogoFkoRv8XkICWJahf+jnxtqDSRLkGvMMXKLsKFb3D0GolYp6oBbwOwLL76InG
	 BHd+OqWV6+Q9iX5Q9uey0gjmXQqDOb2qLZ58nbCnsKLFooGK7pm0Gly6JEkPnHRM3vLe8
	 T+EXA3mN7d1dOBjLmk7FlpAP6RdwGiY8rlPHPETpkt+1aEp6ELqHeS4flRy3reFZZGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=Tiyk2x8AP7B3WUlj0uRm5HrBhyCjQODyzOEb/nfZoGqukUHIihu2rgjAY2/j6vtBhhbA
	 83KpLoXZeaTnJ77AVS/Hi/79CS4cUFW5siRls1SPLr7y3yREOJ5K7aDP0n62T+Km/RGTn
	 9p5yIiuUEpAtHuWZ4sxNmV97675sUxJ3aoOHoP2393h7YddupdwScROCHTs1exYGNYP5g
	 VA5liYJfeamadwGsosTjEnpnzy8twcAEPtzYuFOkAvMb35kksQmogzAIqRz8LA972KIbv
	 v4/tcnJKd85gWf29fDPYTAXtTRDNOYo8UpVcrmg1rTObjS7fl/KIaujAQWbhn09xTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DB606A330
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4DB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1463744b3a.1
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=OYMGmEotdcrZv4RwMNsFkuiHzHyYQYocz06BLgARn1oiQ9c816AZZHjQg/TPEBW7vY
         /bmYrTnsTFAqNmnRd7ZzGIcpv5U0VGIw7hcCrQr8XLxzK+g3KwmouEUenlrcHkQ7sBTN
         fZ+kKMISl7Ds2m/RioFmZsEw+KXCGWczo2pXD1uwLT/8Y3FFw6qQWVXa0k0GL4bvgfLI
         iTTTCvufV6+J7MBz6vqJqCJhNG93hi16YvL5Sd/gFH6njSDwrN8dcRpBHqTe+l0R7Rh8
         V/g218HHGt0VhWtGwP7vDcQ+bWQpEKPOb8cVeP9Qq3uROmfHPHJNSBlxw+O5xbFHMg+4
         aiHg==
X-Forwarded-Encrypted: i=1; AL+hErFWDe45JpzSUvQwby5afMyxSGCPxqPppiwiCR1UynuLMOJ6rQaKRF00ag7hvTVdMfsCvIVF2+r+P/TJOE9zEfvKphh6/IE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lXTPIqCOOG5fZ2ttEnLOm8l/BjcVXgp6X/QYdG5YT6pjAl5R1
	Zkx1BO4+gfwOq4unDvS5jXuZimHuT4s0tNTTTX7k/6ETTrurmi+SpqYR/Eh6mR8FJpM=
X-Gm-Gg: AYBFou0/UbDfU9zXFPzovIT+WC7PqubKa4PXFcmKrvm3Ffj1fayShCRGcY+sVaZOWng
	aWC2HMhVAU4X1h+IQMhWOlIthdySpaueB+3bG7mSP0zykWBEArXIMbK3BTRy/A/zQq/IXJmQNZ1
	DREKU21Tw+URsC7f+r6sm/nZQSOZkBmma5M4N8s+us+2vytG+6eqABoCGGjECk0BNDYtZEeO9WG
	lcCKuJbE0jfLYunKVIvjmI/vTD4YEuhz3KQWH+3Zugyr052XVg10CGK0HmRZX5Y2c6CekrXaQaX
	TyXPrto2viVMgZv5xV3BWqj4MzZCnixKAGr8f0vEmJMnYNOuK1Hoqiv7ufLDGxh+yh/bFIhSLbA
	57Bw+avxwug0hnkiVU6+E3RMpjZvQfuVeqMrOJz7fEe60hv8mYyHawsFcsjEzp5CIGP40XMAMN9
	u0MUZ6pRXCajWAt7JCT496jyABwPCAXtpw8dB3rVDEJDh46IfZg38azjtZgbb3dZ23TBT86rkKS
	Ay0eTNzbVtFHwVkxph+YBYUMSbpOmzJJEPK1kYIMZjkBG9LK4lhROffquItL0i6DybWJd5Fsnjp
	+nlyBHcTteq0IIL8toIZ9riaJLbbwPPOW/mXKZyrsIqwRWq/HFLrzWnST3xpWJNZXyhEePQFvrv
	fpfVHmqDVs/JVdoBBXxQgtnsSvOOpW/Ge54uvd2nGhyD8McjYBgJ+kD2Vsa2iEtATkQt/0IJeYl
	z71Wr9jMPawe+hn1NjDH2+bJxEU0dWdHmEa3xwdlihiWGCAGuuvCRujtKq
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
