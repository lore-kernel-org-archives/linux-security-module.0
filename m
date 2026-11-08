Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168330;
	b=UzONEWi9TYR4p8UdiAB1GLpN6iQ9dEy1M3QYrtN2ZPFHh/kqeFa+AONqiTI3U/FPrG/l
	 j7/VeEXUo2XufjHBdM7G3f5YEP6eY8hZBT4fH9oeXAmSgJT31n56mumjCpurZ1yTY1SRg
	 QS0PE+gZgIHt6LtQ0CWPb1O09sutxBpyedYYGuijd1rTdw9kBqlueJKH+VN2GqYLz7ypD
	 7CeVJ7Pwk73xCu6DyFY3OArB+q/zMJRDlekjE2u7VYS5g2qlnevxVNmiOXWNT8WCzyPbl
	 y+2vtfpAq5VmX/ZBtqFv21Sv4r5qVR283qKS41ikstIb62lgDbkp5SiMNarQh8SnL6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
	b=DKNLssF00sundtfFrDMczDyhytmaZ8Bjpdj8MyBT5B/sySIdJ9Rjl4Iq4EhwBChAvKXS
	 Ju5PTG7r3/Pa1yGkQJ5UK1E5h2q0E7Bk2WHo4uL62mwR+y5iXtGy+hpOn9knNyhhtb5V4
	 Aw9BzJuczVzjAHYyRKe/Ar7F2OvGZN7qX1rF2HmF7cfGX2HW9xnbuakXkxztOtRLlA9Lr
	 yqfa2ddtt5uknEGbuguqYQjNftFVjPwyN/Vp1CxHYUn4iYIgs6CoWwUSvUIOLi6Zbs8mg
	 7kdzvj4MpPUZrmqOw+CEwIcb/o0EyXeUSv+lTsE6I5++GkJksh50e6z4xOaVJo/pWIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BEA606A326
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53BEA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so1548945e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794168329; x=1794773129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=ib7c6P66JcABRQVIYvbAfEuMzOdspSzPtZfn7p5hZaB2Rr9aWYVjAA8lHghOcTHkfP
         W1IBKWn61CtXgoJPbCEozcqCpgRPGxULcN94D7ITtmHErVGmr3isoGCQ02nfNqhbH+4n
         lUM22s4MKp/l6fyffg7/TutUQVALjesHSFnC4w+1WVPSvW0J5rknAYGDJAl4xvCRXDT5
         fBdxAtmJXU6SiF6lguNdvRiiwtq6Km8nyFGsRU6Tq+7fwVjsnnI/ZpxcJdUfsPAfNVOr
         BXFpKVyK/3a7Qj/Qjq4EwXbAdcjWWztzIsYea9a0P/MiY6n2EtEGPByGhhhA0f0X0qYJ
         P5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168329; x=1794773129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=x0M1Ipya9JW9I92HoTkq5wuCQO2v5FbsP1O21PPniNfpnjKvF+GCceDrMuQqBevK7X
         SicnC+dy3ugHNKW1SN7nWNXxN41I/QgJzWnPFlKOvhZzKdFlfcUnnJXeaaZl+woSnwr7
         y8R03B/KmvGWBQ5y0MqZ/KEZmlJvltVzNZXa/QxDVmhPXvXDOyFnuk5dkT1RZ82+QSn+
         XSOuL93kt1V/A1sK3gqQUEi1K37peh/qDPaseToQq5d1s3rfsQ5lDPMfOiXtvYbFb0IP
         l5scaNfEdOULDzA4Yxjn2R17f2JocRdsyGETouMxKu/ko4KVxtNdY1ErMZQjPgRo9sLT
         hNlw==
X-Forwarded-Encrypted: i=1; AL+hErGVXGjXTUSYXHOrb2E2ABSqSubU2hpemQL6mKxrTapzG43UxMgZwphqRdnZxyvr6gTlydJTy4QAyynkc+715g5psP4u2rw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m98xtGKi3CJZISrssGEvwf05h54wRt4CZqCzHciUuIhhe6PTD
	ejc29Bhq/j7iF575J7JotxLBQdekRy1KLeokJJF0MPPSgLcX7gfDoxvq
X-Gm-Gg: AYBFou3+HVBsveTxfek4ib3po5KOM8ZiVHnR24KP38HAtAi9f5iQSnSKkA4j6obt+Ux
	2uGv0n6ZL3y/BSTrinf9Sg1zVl3W1qQCXhYxOoTYn+VBR2UEy7u0/f1O/C1gO9zY7NVT08IrFN2
	wvQKzXIAmnMJL7Dhqc+/BbuB6fVd3+gq6BYW0SbmCxNfKUGFYM+h4LXbobNdEXmgkOL3M4o42+M
	gB09SBnl8nvtchsIL61q++4G7gKVSbLTudpiqJqckk9jLyR5bjHP57L/yKJfR85lgOYrl9Tw1yz
	LxWLRRjhAKmOHUu7O7UAxBKYwo0WqXMxp7BUWau+Z6D0bk79GEi102HUkj3NpSfSIEjnAdtUZTx
	BaoMmqKSzn77BnD/rZQ+5TkzkZneDedsQxkqaeOz7p9UfYcdZLFrqSs9wMT3mth+kMxrwtXVbfg
	YhxFIm1USfrDXXgju5LOSaPWJpbDGc4hkJGOEBpC062nl1DS8xDvJjgsA2P8LnktjMgd+A8WiSu
	7gCmkx57EcqnzkYiFMly4JS5AvUio1eZWKlhK80IVvwwjYotfp7F9u2enmgmmzEflVcw2JOVR5W
	ahThAOgK2JAncS3O6KFDJGFB5t7p8DCLsiX4zeA9KTZz94DbXvbzBr9mVjaqZXrPLtaMkZ6q4fd
	DYX15B2u1SQ==
X-Received: by 2002:a05:600c:1c0c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4b963c69d23mr43591205e9.19.1794168328561;
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186ec5sm5768522f8f.33.2026.11.08.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Date: Sun, 8 Nov 2026 20:05:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 David Howells <dhowells@redhat.com>, bpf@vger.kernel.org,
 dm-devel@lists.linux.dev, fsverity@lists.linux.dev,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Alex Shi <alexs@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 Benjamin Marzinski <bmarzins@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, James Morris <jmorris@namei.org>, Jiri Olsa
 <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Paul
 Moore <paul@paul-moore.com>, Randy Dunlap <rdunlap@infradead.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Song
 Liu <song@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Yanteng Si
 <si.yanteng@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 2/3] KEYS: Replace assoc_array with rhashtable
Message-ID: <20261108200526.43579e2a@pumpkin>
In-Reply-To: <20261106090516.GA1973@sol>
References: <20261105031401.956609-1-jarkko@kernel.org>
	<20261105031401.956609-3-jarkko@kernel.org>
	<27015846-0161-4700-b810-4643e1f7b63a@suse.de>
	<20261106090516.GA1973@sol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 01:05:16 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

> Side note: fips=1 actually has little do with security, and in some
> cases it actually decreases security.  See for example
> https://lore.kernel.org/linux-crypto/20261026183332.11402-1-ebiggers@kernel.org/
> where I'm fixing a vulnerability caused by fips=1.

Then there is the 'fips compliant' server we used for routing 911 calls between
TDM and VoIP.
Any kind of PCIe error gets routed out the the motherboard management module
which then proceeds to inform the kernel with an NMI.
At which point Linux crashes.
The NMI is too late to stop the kernel having to handle the ~0 from a read.
And even happens when there is no driver using that device.

David
