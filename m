Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057495;
	b=1VkDrdbgSIlka5ypf3XOZqXadu/LDktKOljuQq1La/QlvKdJ0VHVGp1kdOrjwn7mKPRa
	 BOjmqX6wo5SwwDL8XETehBwng9GCBNPF9xuUiNxWntUg8+KQKbU90KOArM13MGLtmZ0Wr
	 3MDqHEH1n3x9eTcFhcW/wvXmrJAxWOmDzrSuTbWUHBgIjy+jhD7ugWUzaz1rl1QGVKDLu
	 ydY13eRX3pRse/Q7PZc08P0RKxvMnncuXh/1ZkgfflsqCs8DClPRKtU5Byia8KfFobN4L
	 1xmEh6HOFAeMbUUzwexqgB62sPNHlZQKeI9yhjkGCQYSR/DQ7RF5WZ65osy4Ac7Bm4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
	b=5UaGSCxzr0X2X03+JxHthN7VRuZfgWNlaVRor8Pwn1USzpaqTRZlbCdNsiJLArp4C3pD
	 IVW3Oby4c8qjIGHhj054CajpXNUmp/Zl6l2fZX1jTPJeS0YhJ3gQATm0FPVEjgk7uQiyF
	 O0zaUnPZExul8ILtrJSXgiYUVgvF2wB87tRgt0kOCVrFzJjRbo2X2YAkk0oNUw2VM1Bpc
	 sAyvFokytnW8VvAOxd4J5rlkEL66eFsyR5lErjI8lxFmhj+7JStNiEwhUVapwUjHXa5QX
	 ueLSoWVaVvqJFasiOz0oZLu5f0SuyB200GtWYE4/C0wQYFRAzgyY3SMmNMpKwaX9fpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="cOI/FSWY";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3A606A327
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA3A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cOI/FSWY
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e942864693so18663905ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057494; x=1793662294; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=cOI/FSWYuZ9uc4gOXFR6cODAhxfNl6YSVKkc09pTcBfcrEXfJFGza1/6vbnz79ZTNq
         zP7nQkQ4dSFo4mJF5spxHEW8N41bTbFboZmGkyJ83g4EkPU0LjRX9tQOPKtV8h5rWhDy
         efJAQFHcAAQh20lB/pC94nJY0Nf+zdtUCT7I8o2LbjitgGfv7VatsG04kfhoQMvruKw2
         B/jGLBNW2eK7hebxC20mG3rjrmCDXDA22kY09T83qLDk6uDjxDMhyY14SA4zcjYGeftL
         M98ll4rF8ZO8+bPaOrnemWmr237eiCw8i6iE3nelzsKIpA16kemuh1G6DQaGTwPB5Wl8
         9Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057494; x=1793662294;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=GI58Uhl8+BqIpHnMWXRg02rRglmY32jJZh1pfXxSHASsLIuVcfNicAyPM9fvt/uvzX
         oz4T1p28G81Yr9Of3oZxdwtOW5TE1HYn1//xDkkj50S/II3NT9YpV3XmC33je1xCOnlq
         xAYmiZMqO8A7rQNqCvBnh9C3N/m/JCPpgFNn0f6FYWe+9qW0jKS5rHZItA7RpqY0CDxW
         weHAho0uz+HfDnl2o15WqQ2LgXIsNNs3B8+shOtMAer6HKYvrjfa19EavM58AqO87s7/
         lBbbGnkF8rYTTJtZ6A74szJr/2UthqLYmTV7Xl55bp3NfHhGBSxvVyV6gWHM2j4x76e8
         DulQ==
X-Gm-Message-State: AFq9FYJ2x5a3khzCEmqytnwrJXw+AI4SA14eHNF9RtNzJN6GSZA30rJr
	spCQB+QYGqAqmgdUPHgmrNc//1RdF5E4NfW/jdzytSVNF+R/JvwRrAmv
X-Gm-Gg: AYBFou20pjlu9gyJzEl3PyQiHuO5NdMRfwzP1V1LZiHO/Ht5YpgRAz8TlT22323rmTm
	YL3jZpucEa4KptOqMr723vDOt3kSKnPLWZvpd58YSd5PsoFg3hlNKyEVydbiyI7t2moARP6l6ti
	opPiYjZ5Ho0ZkGs0xEc6pHYIEeLh8RgBvevqVzbU/tM1Q40v1mxXlCg4rBEF8f+COzeRvPCBpdY
	ze5fDySmi+oOcFu7GIPbaGH8l52d38As50uE/77ULIswXne83lUEtTr2GFAPiM7WvmzNqF+pRXB
	IphY0OWoi4NPlodnkE+1MBNuK7d4Cm1x2Zq5XLU2LY3CIY4fwmaLWV1GztI0Bl7pvD9HmFg2f09
	Pd0kEEz+T/NE4r7y+QN07b17H95jHXuf4VMGMUrD7b5ctFbq9Pb4iwxsu3DYUMkbD/yo2IzZq+f
	EKXaXNet8+mgnNgcSqsTBe5R8oJ0//obmaUHIPXPI2BdbiV/ANS2Yp0BlZL2mmzhIi9YOSPLXuv
	JKKZij8s4M6SCDgdyLEpJaRNZfn9Ub8PG8xnT7VbNeB1Rqmtn84xt1EQAHQbhZEKso2PxTxZyv/
	S6FxM5KPPzyjwJdaTL/OgM9Q2QFOm64Ta6MM6CN/cD1Up3xw5uUQtVL10Uhson+TjR/oCJNm3FC
	sV1WUd7w=
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ade9b2ee97mr7287988a91.1.1793057494026;
        Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm6631220a91.1.2026.10.26.16.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:31:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:31:32 +0000
Message-Id: <DMF5U0PAK4HE.2QQ66SZMEMQLA@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Paul Moore" <paul@paul-moore.com>,
 <netdev@vger.kernel.org>, <stable@kernel.org>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 02:57 AM Christian Brauner <brauner@kernel.org> wrote:
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

Why not the whole series?
Otherwise 7.4 will be the only release where namespace_init sees
ns_id == 0 and bpf progs that key by it will have to deal with that.
Also the test for patch 1 is in patch 8 and it needs patch 5.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
