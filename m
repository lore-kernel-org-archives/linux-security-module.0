Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792592814;
	b=Lwud5VT8njEmeytt/2cJvEWWI6VELuCmwwKLV6pYF/OkIwzNKQ84fsoAwpisaxvGZ5sc
	 b9ivo6z8fV07RONtaB4C0alW5Hj7RXjreB9Hsdq8Af2QZaVLqb5HWWJSA+QNu7zfiOHtF
	 fWw0D99IPoUF6XheA7Nl7DSgzP2+/hsH5LG5lKklz83/ug24HaHQRJE6YZNL8c9QnjuOP
	 9rFNcZi3KoWO+dDvGpdDDdceHEaWlu/6OopnsQXfNuqIjYudDvb799GLjjoPjo1lgxzjO
	 vGjVQN3+o2Eh5zv9vsV6a7/ueLQ69QQ7CV/+k7T4SM6i/np2C7S30cgXl00O4gKx4cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=zXuiGNwi/wTv7axdOLMiOn129BQ50XGSSg/lUiCCcJqGcF/YCCYpFoTfTsIJdoxyYQkD
	 HGRqICVO60WB8uaSgs3oYJoEv9c8kNvFnlm32Q3ZNgTVRpuJzOaigjs0a/ZIs6oUbiEsK
	 iAORqLG4NJ0Q2oFeo+u2x/4JER6knuNPO/zGDVC8p5fl/b5BNaxdI1RZYQujiXpvwbTvi
	 lVl9qGNp687t4mSRn2zEM8kWXwsaRE9rfPAbvDjvo7CiA/4b+QHAZGWNz04yRbj4HDO0Z
	 D3+dgS6Zen881TCyMYf9D5JTbYEOaNnsdfJOrUv/qaHtghFtpX1UJPivri1UCJwjMkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=fail smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A737606A320
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A737606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c423b145922so98413466b.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=AekwikkQaKQ05pnjdzSDZAS/JkydASFpxKzWwbAf6NOW1pDLS6qWv4FbgRH7xgpT97
         vcsD4vWrMSxzhOgiuWnlZa6haB5JLNcVzisxpfJrjkd92a1u989WxRVzOJrhv7IWMl75
         etqbFfrIYwQSuFGsy+hI+gMssv6X7kkxTC9fXtGlJRNTma2JDnkSCD4cCIHaFTUVeCrx
         fyvu+/fvgqWCC3ICaCToY9/sRfilp0ra+TaSwBG3tIRUYUN5APNAcHDmWpmr8IS4ncH/
         25HnS9YckhsiW+O/QuMwiUQIiQ0aNoxUhYsdyhfSwUhfZ0UlnBNMQSXyqxzjamFbb+LZ
         QDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=e2+o3agjez0QFTkhov8O/BL+O8VEa+0lF1CDaEXundw=;
        b=V8Qxq8Ha0IHOFs/G9vZSwfpwIPvJM7frz5fERLJ44Vs4jC9Hbk/QC+UbfesHCoInuU
         BlWdtB9ai+w/911L0wKH6JdQf9v+XUa5JcQQSYK768+e1BODUCzW9OGUw0qEsoAMDvie
         ffpuxtxpinK2G6BhDVNua4khIThNr9/xKlGkOxIheotoQJY5M5Oo2wN2J0WRmWsZ06Zx
         6uPddMLc6UdA6fESaFS1eeY+HWzk6jiGHsaztj3V9Uix6yi2MF18rdsLepl4DIp+u/Ye
         JKH8mQ+y/l9Zzdq23t0BOuxj6i5U1xaBP+RdS9l7WjUfHBaN4zdiRf0zlymLzD5V12f7
         qSUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=bxtMPai9lx17aM3sEpPPf8dUEvklEZ+PF2Q2hdR75VJeItBlXgf83ucTnodwxG4Zjl
         O2Wna5+F6oSElMaqsheCTWkKTGGCFnPKPLcfPx7TlltISuHbJUgMNw0MeUFpPWNwg5oU
         U4BKZrTWcIL8fimVzHxVTRtIYzIiaHMla+bzqe96ZSGI8wVdmAHwa56ESPigUwC5TXKs
         dLB/0vTx5/XKKlXJqCJBMkRfGMb/ZgTgvQhbNhhpNebZ2zTrRSHKMCoq6K5Uvspi1x9Y
         Mo9hO1CHd1+3PsQ4ggwz1PDl2aIVJmBEFkcUoCDkJZ/346KH1L1+RQ9+Ib1y0eDr20Lc
         kjGw==
X-Forwarded-Encrypted: i=1; AKwUvByIV8YDuQA8ra62Cf/6Pv1ytnD6W7fR/h2x/mnH+PnWCuP4jhZq4msQIIQHYoHRIW+bAq1JcsexDhPD6cRkouqWP2XLfXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPwcQ9Qq4n/3hrFmqCwA2XaVqges9zf3FtixJ1sxpCEo1Eusdh
	dcgLDLScZngWgbSbVnZM4PXQQtD1r89Qysd8yBJkcfVlBreXytj8SDg299CUqZ0YuSeoLYT9oIV
	lLqyvOYi+7xCYegllyIxygg4ZD6EQWnc=
X-Gm-Gg: AYBFou1rRLf/VcPonQ/nTWhyZrKebGsaW+ssRKJGzIyCf6ZNfxZfcuS0vnmO/889/+H
	9BYuGvgubpPycdy5qOdItwDQofVtkDcfTf9H4PpXvYMcgKxA1+fb9u2QIfZoMLkHYVmFBdiAyc7
	ZuOfB49uEkv/AHvBhL0YVfEI1pJRdaF5BXdGCM2fTdcVEkRFngN+hLsOdsfZ2/SlVZeSEKu5f9p
	LZJIfauva1juGurUgpJoyT3o/CFHr97fV0cTsyABhzh9x4YvcWx/Z8KDe89bCAJCEbsKdbV3/vj
	+JjThWTR/8JjRTbyYGBTHCgvdcyvCUxSJJJQQPFE2HF47Jj/XAcaTXyR6x9BGMnqDw2tlF7oOd9
	j+65Pob+PaoLSLykvgrnH/C5T2ky/9ixwQAck
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
