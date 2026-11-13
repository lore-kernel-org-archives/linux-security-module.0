Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=IgHHuLwFyNDUQIGu5C/PtW0TrhS3J9pXcQ+6vy/izkJyuuDToSwfrH6nGOsI5//lErOO
	 oVvz4NZle/o/qlDaCos9omKnLWLhb8nBJofzelVHORNGsqZ+YaVTDzyQof687Igwp0KoH
	 WW+z+uzA87+JnODLMv9hbE7ZnP/9WunXAz2AxZKrFufCYI8oL/Nes6bpjXRZfzOoWE1eE
	 mVn1v2st2SLdhwTiPs/Y4mjA8DxmQ5ZTwWS0VEGo+sOX8dmjUBvxqxGrZve5QIPIY9M5Y
	 agT0Go5FIyyVzIc5YZuGycvmfT1ZfzdAlaVrJrbODZCmPn4iTSsEIJAsCs7zL5cFPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=a4Y0VAizncJnlFtqWp66Ku7rtyHZaZCTtGFuiRYSzEIxgQTguNwUeWeoVLRLQRn3bBdB
	 V/b5P0zd39gRkrsS98sDbDd3MFOIKjf0oRG/74NRO4c7sdG6PVPOAk+WfWWSSEtxXqLwC
	 UBoOTbo7RpFwEd3XF6QnDjR9Oxsr6ki2MQ1Hq5Yt/NUqbUeRxuiMk1Qz5uqLY/h69X4hD
	 fjeF3wFQXfpZNTt1Am2s4VRDpFlH2WgsBS5NCgchpilaRJgEQzkfsMxvkQema6Y6TW9k4
	 /C6bQUIVzD/YcXbmq4UKHFF4eO2pmRDhdII+y+n51fuvbbEF7q/yH4Df+XwSRxjeMgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342F606A897
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D342F606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224265e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=Ie9m/88Wt1uKc0emuT20GP7qRBW9o9uppX7shcL0Zg3aDJuAeyzt4YMnkHU/ZJHe6b
         gTqj+GkQNdjV+BIozRpKNcRoTaJF2GonjIc4Cx4zDBPhBiByyspCkMp4XPHFrUUf7B/w
         4FAB1oQYsxyNC5B7vXfdDHWPgiLriZWXdHfCBwqqx9oVn8jP/2fnD6Z2pbAXPeX3gmId
         PlBTewOYGmKffwTq7pLgUIRMAjXCMo/mkVGMivts7YXYqPygcxTBp1b9uQsTuOUEl4IG
         josPjazC63KBW1FjbKTDseFNyanXKGawjW/aGmWyGufeen1RaV63vC+cEYJ/5qr78N+d
         FeNA==
X-Forwarded-Encrypted: i=1; AL+hErEZHAA77GgPwx5+fvx8KhKZgdbSlmRHuYVzddmzCVQFCh6MKtmpc3rT7OMufZYouNhgahXJWYb8o7hmbGt0adeN04RpaW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jtoiUPSWFH8LiPQgfEffemJ4qkA06mdhvORrdbJCnqNSej4vD
	K5mOoWU4PbNoX78+PGGxS/XnEjk0PhFAnXJcg6vlL1cdI+xUob1xaLwfhb9ldE4ELzIT
X-Gm-Gg: AYBFou2EdNgVzYFHrEOzgoPg521fOFTnaMKPO22hUmanuZvyi+vnIS7MEHAMq49gt/w
	lQKGByJ9qAEDhoMslQVThGOpshEBct00lta0p1nWL7p9yN44bLWb5eYXKRkEnDLE/iXsZ28kbPi
	fnwaMkp2aTgzNSn83//FZqTO+OdeIX8aT0+CbJyCGgbKCaQ1Ezo9AgwceIL0vEKImoeeIRCoql3
	FCAranlxUvwOV3ojHkd4myr4Wv08M7r672lzbq7fqi+P2f0UVF6k3yEAQ2zZWFbVKXHwJImkoXs
	k9rWc6TXGrxvvinXrjuQVUKf+6LoIclc6pHmXUS9rJGS64vHIb1bYIBWnGqIKl7bg8iMPCD10F6
	Fd7f1FPRSAuSAFQWVliiqumTIjiqUzRgSZrkGDVeI8gn4tB55VRGdCrKBg+sYy0bSbuBDxKRq79
	Xc7BbDY1c//5nkVeXzH0ml9e9mrL2b4qq6lBqR1if8vNnXeoH2MmKkm+1hyf3pxxvmmaPrE7nbT
	BuBmVWR3NlAbjIqNnT93A7WoDHqSnFggLA7OWIzMfr9++2pzzKC4CoqrQ7HP66n89Kwf/XtA/zu
	+lFPeNxZ1NLTpl8l1oodLM80Lb5ZI61/kfvO1PJ2QDO3N4+t54QlobVedg7psd0=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
